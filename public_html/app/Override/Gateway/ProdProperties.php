<?php
namespace WS\Override\Gateway;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 19, 2018  4:38:22 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 * @task Проверить где используются showInProdTab и type_id и убрать их нафиг 
 */
class ProdProperties extends \Model
{
    public function getProperties($category_id, $order = null)
    {
        $sql = 'SELECT p.*, pt.name as typestr FROM category_prodproperty as p left join category_prodproperty_type as pt on pt.category_prodproperty_type_id = p.type_id where category_id = :id';
        if ( null !== $order ) {
            $sql .= " " . $order;
        }

        $res =  $this->db->query($sql, [':id'=>$category_id] );

        return $res->rows;
    }

    public function deleteProperty($property_id)
    {
        $sql = "DELETE FROM category_prodproperty where category_prodproperty_id = :id";
        $this->db->query($sql, [':id'=>$property_id] );

        if( $this->db->countAffected() > 0 ) {
            $sql2 = "DELETE FROM product_prodpoperty where category_prodproperty_id = :id"; 
            $this->db->query($sql2, [':id' => $property_id] );
        }
    }

    public function getProperty($id)
    {
        $sql = "SELECT * FROM category_prodproperty where category_prodproperty_id = :id limit 1";
        $res = $this->db->query($sql, [':id'=>$id]);
        return $res->row;
    }

    public function addProperty($data)
    {
        $sql = "INSERT into category_prodproperty (category_id, `name`, unit, `default`, type_id, showInProdPreview, showInSummary, showInProdTab, sortorder ) values (:category_id, :name, :unit, :default, :type_id, :showInProdPreview, :showInSummary, :showInProdTab, :sortorder )";
        $res = $this->db->query($sql, [
            ':category_id' => $data['category_id'],
            ':name' => $data['name'],
            ':unit' => $data['unit'],
            ':default' => $data['default'],
            ':type_id' => $data['type_id'],
            ':showInProdPreview' => $data['showInProdPreview'],
            ':showInSummary' => $data['showInSummary'],
            ':showInProdTab' => $data['showInProdTab'],
            ':sortorder' => $data['sortOrder']
        ]);
        $lastId = false;
        if( $res->num_rows == 1 ) {
            $lastId = $this->db->getLastId();
        }

        return $lastId;
    }

    public function updateProperty($data,$id)
    {
        $sql = "update category_prodproperty set category_id=:category_id, `name`=:name, unit=:unit, `default`=:default, type_id=:type_id, showInProdPreview=:showInProdPreview, showInSummary=:showInSummary, showInProdTab=:showInProdTab, sortorder=:sortorder where category_prodproperty_id=:id";
        $res = $this->db->query($sql, [
            ':id' => $id,
            ':category_id' => $data['category_id'],
            ':name' => $data['name'],
            ':unit' => $data['unit'],
            ':default' => $data['default'],
            ':type_id' => $data['type_id'],
            ':showInProdPreview' => $data['showInProdPreview'],
            ':showInSummary' => $data['showInSummary'],
            ':showInProdTab' => $data['showInProdTab'],
            ':sortorder' => $data['sortOrder']
        ]);
       
        return true;
    }

    public function getPropertiesWithProductValues($product_id, $order)
    {
        $sql ="select 
                catprop.category_prodproperty_id, catprop.`name` as cat_name, catprop.unit as cat_unit, 
                catprop.`default` as cat_default, catprop.showInProdPreview, catprop.showInProdTab, catprop.showInSummary,
                catprop.sortOrder as cat_sortOrder,  
                prodval.sortOrder  as prod_sortOrder, prodval.val as prod_val, prodval.hide as prod_hide,
                (if (prodval.sortOrder is null, catprop.sortOrder, prodval.sortOrder) ) as sortOrder,
                (if (prodval.val is null, catprop.`default`, prodval.val) ) as val 
                from oc_product_to_category as p2c
                left join category_prodproperty as catprop on catprop.category_id = p2c.category_id
                left join (select * from product_prodproperty where product_id = :id ) as prodval on prodval.category_prodproperty_id = catprop.category_prodproperty_id 
                where p2c.product_id = :id and p2c.main_category = 1 and catprop.category_prodproperty_id is not null";
        if ( null !== $order ) {
            $sql .= " " . $order;
        }
        $res =  $this->db->query($sql, [':id' => $product_id] );

        return $res->rows;
    }

    /**
     * @param type $category_id
     * @return boolean | null 
     */
    public function isCategoryFinal($category_id)
    {
       $query = "select isfinal from " . DB_PREFIX . "category where category_id = :id limit 1";
        $res = $this->db->query($query, [':id' => $category_id] );
        if( $res->num_rows == 0 ) {
            return null;
        } 

        return (boolean)$res->row['isfinal'];
    }

    /**
     * @return boolean | null 
     */
    public function isProductShowInSummary($product_id)
    {
$query = "select showInSummary from " . DB_PREFIX . "product where product_id = :id limit 1";
        $res = $this->db->query($query, [':id' => $product_id]);
        if ($res->num_rows == 0) {
            return null;
        }

        return (boolean) $res->row['showInSummary'];
    }

    public function getSummaryTableRows($category_id)
    {
        $summaryRows = array();
        $summaryHeader = array();

        //use following products:
        $sql = "SELECT p.product_id, p.model, p2d.name FROM oc_product as p
left join oc_product_description p2d on p2d.product_id = p.product_id
left join oc_product_to_category as p2c on p2c.product_id = p.product_id
where p2c.category_id = :id and p2c.main_category = 1 and p.showInSummary = 1
and p2d.language_id = '" . (int)$this->config->get('config_language_id') . "'
order by p.sort_order ASC";

        $products = $this->db->query($sql, [':id'=>$category_id])->rows;
        foreach( $products as $product ) {
            $properties = $this->getPropertiesWithProductValues($product['product_id'], 'order by cat_sortOrder ASC');

            foreach ( $properties as $propertyRow ) {
                if( 0 == $propertyRow['showInSummary'] ) {
                    continue;
                }
                
                $propertyIndex = 'prop' . $propertyRow['category_prodproperty_id']; 
                if ( empty( $summaryRows[ $propertyIndex ] ) ) {
                   $summaryRows[ $propertyIndex ] = array(
                      'category_prodproperty_id' => $propertyRow['category_prodproperty_id'],
                      'name' => $propertyRow['cat_name'],
                      'unit' => $propertyRow['cat_unit'],
                      'sortOrder' => $propertyRow['cat_sortOrder'],
                      'products' => array()
                   ); 
                }

                $productIndex = 'p' . $product['product_id'];
                if( !$propertyRow['prod_hide'] ) {
                    $summaryRows[ $propertyIndex ]['products'][$productIndex] = [
                        'model' => $product['model'],
                        'name'  => $product['name'],
                        'product_id' => $product['product_id'],
                        'val' =>$propertyRow['val']
                    ]; 
                }
                $summaryHeader[ $productIndex ] = [
                        'model' => $product['model'],
                        'name'  => $product['name'],
                        'product_id' => $product['product_id'],
                 ];
            }
        }
        return ['header'=> $summaryHeader,  'rows'=> $summaryRows];
    }
}
