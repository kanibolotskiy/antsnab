<?php

/**
 * ProdUnitStrings Description
 *
 * @version    0.1, May 21, 2018  12:14:17 PM
 * @copyright  Copyright (c) 2018 pinstudio. (https://www.pinstudio.ru)
 * @author     Sergey Rapshin (http://vk.com/wslapshin)
 */

namespace WS\Override\Gateway\ProdUnits;

/**
 * Каждый продукт может исчисляться в разных единицах измерения.
 * Для присвоения продукту единиц - к нему устанавливается шаблон единиц измерения;
 * шаблон содержит текстовые характеристики едениц и словарь для генерации строк упаковок
 * т.е. на основе словаря - система помогает сформулировать строки для фронтенда
 * и сохраняет эти строки в отдельную таблицу (в привязке к шаблону)
 * данный класс для CRUD сгенерированных строк внутри шаблона едениц измерения
 *
 * @version    1.0, May 9, 2018  7:39:20 AM
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin)
 */

class ProdUnitStrings extends \Model
{
    /** Строки упаковок */
    public function generate($templateId)
    {
        $query = "select L.name as lname, L.isSaleBase as lsalebase, L.switchSortOrder as lswitchSortOrder, L.name_plural as lname_plural, L.name_package_dimension as lname_package_dimension, L.name_in_package as lname_in_package, L.calcKoef as quant, L.weight as weight, L.package_length as lpackage_length, L.package_width as lpackage_width, L.package_height as lpackage_height, "
           . " R.name as rname, R.name_plural as rname_plural, R.name_package_dimension as rname_package_dimension, R.name_in_package as rname_in_package"
           . " from produnit_unit as L "
           . "left join produnit_unit as R on R.unit_id = L.calcRel "
           . "where L.produnit_template_id = :id order by lsalebase desc, lswitchSortOrder";
        $res = $this->db->query($query, [':id'=>$templateId]);
        $pairs = $res->rows;


        $strings = [];
        $sortorder = 1;
        //@task delete hardcoded language strings
        foreach ($pairs as $pair) {
            if ($pair['quant']) {

                $packageStr = static::packageString($pair['quant'], [
                  'pluralGenitive' => $pair['rname_plural'],
                  'single'=> $pair['rname'],
                  'genitive' => $pair['rname_package_dimension']
                ]);
              
                /** Упаковка ... */
                $strings[] = [
                 'description' => 'Упаковка:',
                 'value' => $pair['lname'] . ', ' . $packageStr,
                 'sortOrder'=> $sortorder
                ];
                $sortorder++;

                /** В ... */
                $strings[] = [
                 'description' => $pair['lname_in_package'] . ': ',
                 'value' =>  $packageStr,
                 'sortOrder'=> $sortorder
                ];
                $sortorder++;
            }

            if ($pair['weight']) {
                $strings[] = [
                     'description' => 'Вес' . ' ' . $pair['lname_package_dimension'] . ': ',
                     'value' =>  (float)$pair['weight']. ' кг',
                     'sortOrder'=> $sortorder
              ];
                $sortorder++;
            }

            if ($pair['lpackage_width'] || $pair['lpackage_length']) {
                $strings[] = [
                     'description' => 'Размер' . ' ' . $pair['lname_package_dimension'] . ': ',
                     'value' =>  $pair['lpackage_width'] . ' x ' . $pair['lpackage_length'],
                     'sortOrder'=> $sortorder
              ];
                $sortorder++;
            }

            if ($pair['lpackage_height']) {
                $strings[] = [
                     'description' => 'Толщина' . ' ' . $pair['lname_package_dimension'] . ': ',
                     'value' =>  $pair['lpackage_height'],
                     'sortOrder'=> $sortorder
              ];
                $sortorder++;
            }
        }

        return $strings;
    }

    public function saveAll($templateId, $data)
    {
        $delQuery = "delete from produnit_packagestr where produnit_template_id = :id";
        $this->db->query($delQuery, [':id'=>$templateId]);

        $insQuery = "insert into produnit_packagestr (produnit_template_id, description, `value`, sortOrder) values ";

        $dataStr = '';
        foreach ($data as $row) {
            $dataStr .= '(' . (int)$templateId . ",'" . $this->db->escape($row['description']) . "','" .                $this->db->escape($row['value']) . "'," . (int)$row['sortOrder'] . '),';
        }
        $dataStr = substr($dataStr, 0, -1);
        $insQuery .= $dataStr;

        return $this->db->query($insQuery);
    }

    public function getAll($templateId, $order = null)
    {
        $sql = 'SELECT  u.*  FROM produnit_packagestr as u ' .
               'where u.produnit_template_id = :tplid ';
        if (null !== $order) {
            $sql .= " " . $order;
        }

        $res =  $this->db->query($sql, [':tplid'=>$templateId]);

        return $res->rows;
    }

    /**
     * Helper для строки вида <количество> <чего>
     * напр. 44 листа
     *
     * @param  mixed $quantity - количество
     * @param  array $words - массив слов склонений: single=>, genitive=>, pluralGenitive=>
     *               индекс pluralGenitive - обязательный
     * @return void
     */
    public static function packageString($quantity, $words)
    {
        if (!isset($words['pluralGenitive'])) {
            return '';
        }
        $pluralGenitive = $words['pluralGenitive'];
        $genitive = $words['genitive']??$words['pluralGenitive'];
        $single = $words['single']??$words['pluralGenitive'];
        $word = static::plural($quantity, $single, $genitive, $pluralGenitive);

        return (float)$quantity . ' ' . $word;
    }

    /**
     * Helper для склонения слов после числительного
     *
     * @param  mixed $quantity - количество
     * @param  string $pluralGenitive - мн. число род. падеж
     * @param  string $single - ед. число
     * @param  string $genitive - ед. число род. падеж
     *
     * @return string - возвращает верное существительное
     */
    public static function plural($quantity, $single, $genitive, $pluralGenitive)
    {
        $absQnt = abs((int)$quantity);
        $lastDigit = substr($absQnt, -1, 1);
        $beforeLastDigit = substr($absQnt, -2, 1);

        if ($beforeLastDigit == '1' && strlen($absQnt) > 1 ) {
            return $pluralGenitive;
        } elseif ($lastDigit == '1') {
            return $single;
        } elseif (in_array($lastDigit, ['2','3','4'])) {
            return $genitive;
        } else {
            return $pluralGenitive;
        }
    }
}
