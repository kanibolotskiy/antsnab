<?php

namespace WS\Override\Gateway;
use Exception;

/**
 * Описание класса 
 * 
 * @version    1.0, May 9, 2018  7:39:20 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ProdUnits extends \Model
{

    const MAX_UNITS_IN_PRICE_SWITCH = 2;

    public function rollProducts()
    {
        $res = array();

        $sql = 'SELECT ps.product_id, ps.product_id, ps.price, ps.price_wholesale, p.calcKoef, p.calcRel, p.name FROM `oc_product` ps
                INNER JOIN `produnit_unit` p
                ON ps.produnit_template_id = p.produnit_template_id and p.isPackageBase = 1';

        $result = $this->db->query($sql);

        foreach ($result->rows as $k => $v) {

            $sql = 'SELECT meta_h1 FROM oc_product_description WHERE product_id = ' . $v['product_id'];
            $sqlUnit = 'SELECT * FROM produnit_unit WHERE unit_id = ' . $v['calcRel'];

            $datas = $this->db->query($sql);
            $dataUnit = $this->db->query($sqlUnit);

            foreach ($datas->rows as $data) {

                foreach ($dataUnit->rows as $dataU) {

                    $res[] = array('id' => $v['product_id'],
                        'name' => $data['meta_h1'], 'price' => $v['price'],
                        'price_wholesale' => $v['price_wholesale'], 'calcKoef' => $v['calcKoef'],
                        'nameI' => $v['name'], 'nameR' => $dataU['name'],
                    );
                }

            }


        }
        return $res;

    }

    public function getUnits($templateId, $order = null)
    {
        $sql = 'SELECT u.unit_id as id, u.*  FROM produnit_unit as u ' .
            'where u.produnit_template_id = :tplid ';
        if (null !== $order) {
            $sql .= " " . $order;
        }

        $res = $this->db->query($sql, [':tplid' => $templateId]);


        return $res->rows;
    }

    public function getUnitsByProduct($productId)
    {
        $sql = "select p.price, p.price_wholesale, p.wholesale_threshold, u.* from oc_product as p
    left join produnit_unit as u on u.produnit_template_id = p.produnit_template_id 
where p.product_id = :id order by u.switchSortOrder";

        $res = $this->db->query($sql, [':id' => $productId]);
        return $res->rows;
    }

    public function getPriceMetaForProduct($productId)
    {
        $meta = [];

        $units = $this->getUnitsByProduct($productId); 

        //параметры взятые из продукта. Можем взять первую строку
        $priceBase = $units[0]['price'];
        $priceWholesaleBase = $units[0]['price_wholesale'];
        $thresholdBase = $units[0]['wholesale_threshold'];

        $count = 0;
        foreach ($units as $unit) {
            $unitName = $unit['name'];
            $meta[$unitName] = $unit;
            $meta[$unitName]['calcKoef'] = (float)$meta[$unitName]['calcKoef'];

            $name_price = (empty($unit['name_price']))?$unit['name']:$unit['name_price'];
            $meta[$unitName]['name_price'] = $name_price; 

            try {
                //fill prices
                if ($unit['isPriceBase'] == 1) {
                    $priceKoef = 1;                
                } else {
                    $priceKoef = $this->getKoef($units, $unit['unit_id'], 'PriceBase'); 
                }
                $meta[$unitName]['price'] = $priceBase*$priceKoef;
                $meta[$unitName]['price_wholesale'] = $priceWholesaleBase*$priceKoef;
                $meta[$unitName]['wholesale_threshold'] = $thresholdBase/$priceKoef;
                $meta[$unitName]['toPriceUnitsKoef'] = $priceKoef;

                //fill sale step (кратность покупки)
                if ($unit['isSaleBase'] == 1) {
                    $visualStep = 1; //шаг увеличения кол-ва в визуальном блоке + -

                    //сколько данной единицы в упаковке (которую продают, не путать с isPackageBase)
                    $salePackageStep = 1; //шаг фактического увеличения в модели блока + -

                    $toSaleUnitsKoef = 1; //на что умножить эти единицы,чтобы получить кол-во в кратных упаковках (кратность продаже)
                } else {
                    $howMuchThisUnitInSalePackage = $this->getKoef($units, $unit['unit_id'], 'SaleBase',false);
                    $toSaleUnitsKoef =$this->getKoef($units, $unit['unit_id'], 'SaleBase'); 
                    $visualStep = ( $howMuchThisUnitInSalePackage >= 1 )?$howMuchThisUnitInSalePackage:1;
                    $salePackageStep = ( $howMuchThisUnitInSalePackage >=1 )?1:$toSaleUnitsKoef;
                }

                $meta[$unitName]['visualStep'] = $visualStep;
                $meta[$unitName]['salePackageStep'] = $salePackageStep;
                $meta[$unitName]['toSaleUnitsKoef'] = $toSaleUnitsKoef;
            } catch (Exception $e) {
                echo $e->getMessage();//to variable
                return [];
            }

            //fill relation string
            $meta[$unitName]['calcRelString'] = null;
            if( $meta[$unitName]['calcRel'] != null ) {
               foreach($units as $_unit) {
                   if( $_unit['unit_id'] == $meta[$unitName]['calcRel'] ) {
                      $plural = ( empty($_unit['name_plural']) )? $_unit['name']:$_unit['name_plural'];
                      $meta[$unitName]['calcRelString'] = $plural; 
                           
                   }
               } 
            }
        }

        return $meta;
    }

    /**
     * Возвращает коэффициент пересчета (множитель) для пересчета еденицы $from в базовую
     * или в обратную сторону 
     * @param array $units - набор едениц для анализа. Элементы: ['unit_id'=>, 'calcKoef'=>, 'calcRel'=>]
     * @param int $fromId - id переводимой единицы измерения
     * @param string $base  'PriceBase' || 'SaleBase' || 'PackageBase'
     * @param boolean $direction 
     *          true - вернет множитель пересчета $from в $base
     *          false - вернет множитель пересчета $base в $from (полезно для базы кратности) 
     * 
     * @task - переосмыслить. и не нравятся названия баз. Package - как будто это кратность.
     */
    public function getKoef( $units, $fromId, $base, $direction = true) 
    {
       $allowedBases = ['PriceBase', 'SaleBase', 'PackageBase']; 
       if( !in_array($base, $allowedBases) ) {
           throw new Exception('Unknow base');
       }


       //check for base unit was set and transform units for fast access
       $unitsAccess = [];
       $baseUnitId = null;
       foreach ($units as $unit) {
            if( $unit['is' . $base] == 1) {
                $baseUnitId = $unit['unit_id'];
            }
            $unitsAccess[ $unit['unit_id'] ] = $unit;
       }

       if( null === $baseUnitId ) {
           throw new Exception('Base unit "' . $base . '" was not set');
       }

       if( $fromId == $baseUnitId ) {
           return 1;
       }

       /* Поиск возможного пересчета. Преимущество отдается пересчету по множителям (введеным пользователям в админке)
        * перед обратным расчетом (когда вынуждены делить)
        * 
        * @task понятнее объяснить и переосмыслить
        */
       if ($direction) {
           $koef = $this->unitToUnitForward( $unitsAccess, $fromId, $baseUnitId);
           if( null === $koef ) {
               $koef = $this->unitToUnitBackward( $unitsAccess, $fromId, $baseUnitId);
           }
       } else {
          $koef = $this->unitToUnitForward( $unitsAccess, $baseUnitId, $fromId );
          if( null === $koef ) {
               $koef = $this->unitToUnitBackward( $unitsAccess, $baseUnitId, $fromId);
          } 
       }

       //@task - обработать вариант выше - в методе - клиенте и вывести в браузер в шаблон
       if( null === $koef) {
           throw new Exception('cant calculate koefficient from ' . $fromId . ' to ' . $base . ' direction ' . (int)$direction );
       }

       return $koef;
    }

    /*try to find koef value while forward search*/
    private function unitToUnitForward($units, $fromId, $toId)
    {
        $checkedIds = [];
        $continue = true;
        $koef = 1;
        $entryId = $fromId;
        while( $continue ) {

            $entryUnit = $units[$entryId];

            if( $entryUnit['calcKoef'] == null || $entryUnit['calcRel'] == null ) {
                return null;
            }

            $koef = $koef*$entryUnit['calcKoef'];
            if ( $entryUnit['calcRel'] == $toId ) {
                return $koef;
            }

            $checkedIds[] = $entryId;
            $entryId = $entryUnit['calcRel']; 
            $continue = (in_array($entryId, $checkedIds))?false:true;
        }

        return null;
    }

    /*try to find koef value while backward search*/
    private function unitToUnitBackward($units, $fromId, $toId)
    {
        $checkedIds = [];
        $continue = true;
        $koef = 1;
        $entryId = $toId;
        while( $continue ) {

            $entryUnit = $units[$entryId];

            if( $entryUnit['calcKoef'] == null || $entryUnit['calcRel'] == null ) {
                return null;
            }

            $koef = $koef/$entryUnit['calcKoef'];
            if ( $entryUnit['calcRel'] == $fromId ) {
                return $koef;
            }

            $checkedIds[] = $entryId;
            $entryId = $entryUnit['calcRel']; 
            $continue = (in_array($entryId, $checkedIds))?false:true;
        }

        return null; 
    }

    public function saveUnit($data)
    {
        $calcKoef = ($data['calcKoef'] === '') ? null : (float) str_replace(',', '.', $data['calcKoef']);
        $weight = ($data['weight'] === '') ? null : (float) str_replace(',', '.', $data['weight']);
        $calcRel = ($data['calcRel'] === '') ? null : (int) $data['calcRel'];

        $query = "UPDATE produnit_unit set 
                    name = :name,
                    name_price = :name_price,
                    name_plural = :name_plural,
                    name_package_dimension = :name_package_dimension,
                    name_in_package = :name_in_package,
                    calcKoef = :calcKoef,
                    calcRel = :calcRel,
                    switchSortOrder = :switchSortOrder,
                    loadingSortOrder = :loadingSortOrder,
                    weight = :weight,
                    package_width = :package_width,
                    package_length = :package_length,
                    package_height = :package_height
                 WHERE unit_id = :unit_id";

        $res = $this->db->query($query, [
            ':name' => $data['name'],
            ':name_price' => $data['name_price'],
            ':name_plural' => $data['name_plural'],
            ':name_package_dimension' => $data['name_package_dimension'],
            ':name_in_package' => $data['name_in_package'],
            ':calcKoef' => $calcKoef,
            ':calcRel' => $calcRel,
            ':switchSortOrder' => $data['switchSortOrder'],
            ':loadingSortOrder' => $data['loadingSortOrder'],
            ':weight' => $weight,
            ':package_width' => $data['package_width'],
            ':package_length' => $data['package_length'],
            ':package_height' => $data['package_height'],
            ':unit_id' => $data['id']
            ]);

        return $data['id'];
    }

    public function addUnit($data)
    {
        $calcKoef = ($data['calcKoef'] === '') ? null : (float) str_replace(',', '.', $data['calcKoef']);
        $weight = ($data['weight'] === '') ? null : (float) str_replace(',', '.', $data['weight']);
        $calcRel = ($data['calcRel'] === '') ? null : (int) $data['calcRel'];

        $query = "insert into produnit_unit 
                    (produnit_template_id, name, name_price, name_plural, name_package_dimension,
                     name_in_package, calcKoef, calcRel, switchSortOrder, loadingSortOrder, weight,
                     package_width, package_length, package_height) values 
                    (:produnit_template_id, :name, :name_price, :name_plural, :name_package_dimension,
                     :name_in_package, :calcKoef, :calcRel, :switchSortOrder, :loadingSortOrder, :weight,
                     :package_width, :package_length, :package_height);";

        $res = $this->db->query($query, [
            ':produnit_template_id' => $data['templateId'],
            ':name' => $data['name'],
            ':name_price' => $data['name_price'],
            ':name_plural' => $data['name_plural'],
            ':name_package_dimension' => $data['name_package_dimension'],
            ':name_in_package' => $data['name_in_package'],
            ':calcKoef' => $calcKoef,
            ':calcRel' => $calcRel,
            ':switchSortOrder' => $data['switchSortOrder'],
            ':loadingSortOrder' => $data['loadingSortOrder'],
            ':weight' => $weight,
            ':package_width' => $data['package_width'],
            ':package_length' => $data['package_length'],
            ':package_height' => $data['package_height']
            ]);

        return $this->db->getLastId();
    }

    public function deleteUnit($id)
    {
        $sql = "delete from produnit_unit where unit_id = :id";
        return ($this->db->query($sql, [':id' => $id])) ? true : false;
    }

    /**
     * 
     * @param string $name - имя поля базового флага
     * @param int $value - id единицы, которую установить базовой в ее шаблоне. 
     */
    public function setBase($name, $value)
    {
        $sql = "SELECT produnit_template_id as tplid from produnit_unit where unit_id = :id limit 1";
        $res = $this->db->query($sql, [':id' => $value]);
        $tplid = $res->row['tplid'];

        $this->resetBase($name, $tplid);

        $sql = "UPDATE produnit_unit set " . $name . " = 1 where unit_id = :id ";
        $this->db->query($sql, [':id' => $value]);

        return ( $this->db->countAffected() == 1 ) ? true : false;
    }

    /**
     * Сбросить базу в шаблоне с именем $name 
     */
    public function resetBase($name, $templateId)
    {
        $sql = "UPDATE produnit_unit set " . $name . " = 0 where produnit_template_id = :tplid";
        $this->db->query($sql, [':tplid' => $templateId]);
        return true;
    }

    public function getBase($name, $templateId)
    {
        $sql = "SELECT * FROM produnit_unit where produnit_template_id = :tplid and " . $name . " = 1 order by unit_id ASC limit 1";
        $res = $this->db->query($sql, [':tplid' => $templateId]);
        return ($res->num_rows === 1) ? $res->row : null;
    }

    public function getUnit($id)
    {
        $query = 'SELECT u.unit_id as id, u.*  FROM produnit_unit as u ' .
            'where u.unit_id = :id limit 1';
        $res = $this->db->query($query, [':id' => $id]);
        return $res->row;
    }

}
