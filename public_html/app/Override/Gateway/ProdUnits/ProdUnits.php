<?php
namespace WS\Override\Gateway\ProdUnits;

use Exception;
use WS\Patch\Helper\QueryHelper;

/**
 * Каждый продукт может исчисляться в разных единицах измерения.
 * Для присвоения продукту единиц - к нему устанавливается шаблон единиц измерения;
 * шаблон содержит текстовые характеристики едениц и словарь для генерации строк упаковок
 * данный класс для CRUD единиц внутри шаблона и ряд use case методов, используемых по всей системе
 *
 * @version    1.0, May 9, 2018  7:39:20 AM
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin)
 */
class ProdUnits extends \Model
{
    const MAX_UNITS_IN_PRICE_SWITCH = 2;

    private static $unitsCache = [];

    /**
     * Допустимые имена полей-флагов в бд, характеризующие единицу измерения
     * isPriceBase - в этой еденице ведется учет в 1С и осуществляется продажа
     * isSaleBase - в этой еденице расчитывается кратность продажи (упаковки)
     * isPackageBase - в этой еденице расчитывается загрузка в машину
     */
    public static $ALLOWED_BASES = [
        'isPriceBase', 'isSaleBase' /* @deprecated, 'isPackageBase'*/
    ];
    
    /**
     * Возвращает массив продуктов с информацией по некоторой базовой еденице
     *
     * @param [] $product_id - массив id продуктов
     * @param $unitType - тип единицы измерения которую необходимо вытащить
     */
    public function getProductsWithUnit($product_id, $unitType)
    {
        $res = array();
        if (!in_array($unitType, static::$ALLOWED_BASES)) {
            return $res;
        }

        $product_id = QueryHelper::paramToArray($product_id);

        $sql = "SELECT 
               p.product_id, 
               pd.name as product_name,
               u.produnit_template_id,
               u.name,
               u.switchSortOrder,
               u.loadingSortOrder,
               u.isPriceBase,
               u.isSaleBase,
               u.isPackageBase,
               u.name_price,
               u.name_plural,
               u.name_in_package, 
               u.calcKoef, 
               u.calcRel,
               u2.name as to_name,
               u2.name_price as to_name_price,
               u2.name_plural as to_name_plural,
               u2.name_in_package as to_name_in_package,
               u2.name_package_dimension as to_name_genitive,  
               u.weight,
               u.package_width,
               u.package_length,
               u.package_height
        FROM `" . DB_PREFIX . "product` p
            LEFT JOIN " . DB_PREFIX . "product_description pd 
                ON (p.product_id = pd.product_id) 
            LEFT JOIN `produnit_unit` u
                ON p.produnit_template_id = u.produnit_template_id
            LEFT JOIN `produnit_unit` u2
                ON u2.unit_id = u.calcRel
        WHERE " . QueryHelper::paramToEqualSqlCondition('p.product_id', $product_id) . " AND u." . $unitType . "=1";

        $result = $this->db->query($sql)->rows;

        foreach ($result as $row) {
            $res[$row['product_id']] = $row;

            /** немного говнокода, чтобы <sup>м2</sup> сразу отображались разметкой */
            $res[$row['product_id']]['name'] = html_entity_decode($res[$row['product_id']]['name']);
            $res[$row['product_id']]['name_price'] = html_entity_decode($res[$row['product_id']]['name_price']);
            $res[$row['product_id']]['name_plural'] = html_entity_decode($res[$row['product_id']]['name_plural']);
            $res[$row['product_id']]['name_in_package'] = html_entity_decode($res[$row['product_id']]['name_in_package']);
            
            $res[$row['product_id']]['to_name'] = html_entity_decode($res[$row['product_id']]['to_name']);
            $res[$row['product_id']]['to_name_price'] = html_entity_decode($res[$row['product_id']]['to_name_price']);
            $res[$row['product_id']]['to_name_plural'] = html_entity_decode($res[$row['product_id']]['to_name_plural']);
            $res[$row['product_id']]['to_name_in_package'] = html_entity_decode($res[$row['product_id']]['to_name_in_package']);
            $res[$row['product_id']]['to_name_genitive'] = html_entity_decode($res[$row['product_id']]['to_name_genitive']);
        }
        return $res;
    }

    /**
     * Получить список едениц измерения по шаблону единиц
     * @param type $templateId
     * @param type $order
     * @return type
     */
    public function getUnitsByTemplate($templateId, $order = null)
    {
        $sql = 'SELECT u.unit_id as id, u.*  FROM produnit_unit as u ' .
            'where u.produnit_template_id = :tplid ';
        if (null !== $order) {
            $sql .= " " . $order;
        }
        $res = $this->db->query($sql, [':tplid' => $templateId]);
        

        return $res->rows;
    }

    /**
     * Получить список единиц измерения продукта
     * @param type $productId
     * @return type
     */
    public function getUnitsByProduct($productId)
    {
        if (!isset(static::$unitsCache[$productId])) {
            $sql = "select 
                    p.price, 
                    p.price_wholesale, 
                    p.wholesale_threshold, 
                    u.*,
                    u2.name as to_name,
                    u2.name_price as to_name_price,
                    u2.name_plural as to_name_plural,
                    u2.name_in_package as to_name_in_package   
                    from oc_product as p
                    left join produnit_unit as u on u.produnit_template_id = p.produnit_template_id 
                    left join produnit_unit as u2 on u2.unit_id = u.calcRel 
                    where p.product_id = :id order by u.switchSortOrder";

        
            $res = $this->db->query($sql, [':id' => $productId]);
            $units = [];
            foreach($res->rows as $row) {
                $units[$row['unit_id']] = $row;

                /** немного говнокода, чтобы <sup>м2</sup> сразу отображались разметкой */
                $units[$row['unit_id']]['name'] = html_entity_decode($units[$row['unit_id']]['name']);
                $units[$row['unit_id']]['name_price'] = html_entity_decode($units[$row['unit_id']]['name_price']);
                $units[$row['unit_id']]['name_plural'] = html_entity_decode($units[$row['unit_id']]['name_plural']);
                $units[$row['unit_id']]['name_package_dimension'] = html_entity_decode($units[$row['unit_id']]['name_package_dimension']);
                $units[$row['unit_id']]['name_in_package'] = html_entity_decode($units[$row['unit_id']]['name_in_package']);

                $units[$row['unit_id']]['to_name'] = html_entity_decode($units[$row['unit_id']]['to_name']);
                $units[$row['unit_id']]['to_name_price'] = html_entity_decode($units[$row['unit_id']]['to_name_price']);
                $units[$row['unit_id']]['to_name_plural'] = html_entity_decode($units[$row['unit_id']]['to_name_plural']);
                $units[$row['unit_id']]['to_name_in_package'] = html_entity_decode($units[$row['unit_id']]['to_name_in_package']);
            }
            static::$unitsCache[$productId] = $units;
        }

        return static::$unitsCache[$productId];
    }


    /****UNITS CRUD*****/

    public function saveUnit($data)
    {
        //print_r($data);
        
        $calcKoef = ($data['calcKoef'] === '') ? null : (float) str_replace(',', '.', $data['calcKoef']);
        $weight = ($data['weight'] === '') ? null : (float) str_replace(',', '.', $data['weight']);
        $calcRel = ($data['calcRel'] === '') ? null : (int) $data['calcRel'];
        
        //echo "!".$data["force_step_by_one"]."!";
        //echo "*".($data["force_step_by_one"]=="false")."*";
        if($data["force_step_by_one"]=="true"){
            $force_step_by_one=1;
            //echo "ok1";
        }else{
            $force_step_by_one=0;
            //echo "ok2";
        }
        
        //echo "force_step_by_one=".$force_step_by_one;

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
                    package_height = :package_height,
                    force_step_by_one = :force_step_by_one
                 WHERE unit_id = :unit_id";
        //echo $query;
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
            ':unit_id' => $data['id'],
            ':force_step_by_one' => $force_step_by_one
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

    public function getUnit($id)
    {
        $query = 'SELECT u.unit_id as id, u.*  FROM produnit_unit as u ' .
            'where u.unit_id = :id limit 1';
        $res = $this->db->query($query, [':id' => $id]);
        return $res->row;
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

        return ($this->db->countAffected() == 1) ? true : false;
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

   
    /***************** DEPRECATED  */

    /**
     * Возвращает массив единиц измерения для продукта, содержащий всю информацию по
     * единице измерения касаемо пересчитанных относительно нее цен, коэффициентов пересчета в
     * другие единицы, данные для логики js - шаги покупки и пр..
     * @deprecated
     * @param type $productId
     * @return type
     */
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
                    $howMuchThisUnitInSalePackage = $this->getKoef($units, $unit['unit_id'], 'SaleBase', false);
                    $toSaleUnitsKoef =$this->getKoef($units, $unit['unit_id'], 'SaleBase');
                    $visualStep = ($howMuchThisUnitInSalePackage >= 1)?$howMuchThisUnitInSalePackage:1;
                    $salePackageStep = ($howMuchThisUnitInSalePackage >=1)?1:$toSaleUnitsKoef;
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
            if ($meta[$unitName]['calcRel'] != null) {
                foreach ($units as $_unit) {
                    if ($_unit['unit_id'] == $meta[$unitName]['calcRel']) {
                        $plural = (empty($_unit['name_plural']))? $_unit['name']:$_unit['name_plural'];
                        $meta[$unitName]['calcRelString'] = $plural;
                    }
                }
            }
        }

        return $meta;
    }
}
