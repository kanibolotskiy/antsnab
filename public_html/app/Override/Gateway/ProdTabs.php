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
class ProdTabs extends \Model
{
    public static function trimHelper($val)
    {
        //xdebug_break();
        $val = trim($val);
        //CKEditor and summernote give dirty value, when it is empty
        if ( html_entity_decode($val) == '<p><br></p>' ) $val = '';
        return $val;
    }

    public function getTabs($category_id, $order = null)
    {
        $sql = 'SELECT p.* FROM category_prodtab as p where category_id = :id';
        if ( null !== $order ) {
            $sql .= " " . $order;
        }

        $res =  $this->db->query($sql, [':id'=>$category_id] );

        return $res->rows;
    }

    public function deleteTab($tab_id)
    {
        $sql = "DELETE FROM category_prodtab where category_prodtab_id = :id";
        $this->db->query($sql, [':id'=>$tab_id] );

        if( $this->db->countAffected() > 0 ) {
            $sql2 = "DELETE FROM product_prodtab where category_prodtab_id = :id"; 
            $this->db->query($sql2, [':id' => $tab_id] );
        }
    }

    public function getTab($id)
    {
        $sql = "SELECT * FROM category_prodtab where category_prodtab_id = :id limit 1";
        $res = $this->db->query($sql, [':id'=>$id]);
        return $res->row;
    }

    public function addTab($data)
    {
        $sql = "INSERT into category_prodtab (category_id, `name`,`default`, sortorder ) values (:category_id, :name, :default, :sortorder )";
        $res = $this->db->query($sql, [
            ':category_id' => $data['category_id'],
            ':name' => $data['name'],
            ':default' => $data['default'],
            ':sortorder' => $data['sortOrder']
        ]);
        $lastId = false;
        if( $res->num_rows == 1 ) {
            $lastId = $this->db->getLastId();
        }

        return $lastId;
    }

    public function updateTab($data,$id)
    {
        $sql = "update category_prodtab set category_id=:category_id, `name`=:name, `default`=:default, sortorder=:sortorder where category_prodtab_id=:id";
        $res = $this->db->query($sql, [
            ':id' => $id,
            ':category_id' => $data['category_id'],
            ':name' => $data['name'],
            ':default' => $data['default'],
            ':sortorder' => $data['sortOrder']
        ]);

        return true;
    }

    public function getTabsWithProductTexts($product_id, $order)
    {
        $sql ="select 
                cattab.category_prodtab_id, cattab.category_id, cattab.`name` as cat_name, 
                cattab.`default` as cat_default, 
                cattab.sortOrder as cat_sortOrder,  
                prodval.sortOrder as prod_sortOrder, prodval.val as prod_val, prodval.hide as prod_hide,
                (if (prodval.sortOrder is null, cattab.sortOrder, prodval.sortOrder) ) as sortOrder,
                (if (prodval.val is null, cattab.`default`, prodval.val) ) as val 
                from oc_product_to_category as p2c
                left join category_prodtab as cattab on cattab.category_id = p2c.category_id
                left join (select * from product_prodtab where product_id = :id ) as prodval on prodval.category_prodtab_id = cattab.category_prodtab_id 
                where p2c.product_id = :id and p2c.main_category = 1 and cattab.category_prodtab_id is not null";
        if ( null !== $order ) {
            $sql .= " " . $order;
        }
        $res =  $this->db->query($sql, [':id' => $product_id] );

        return $res->rows;
    }

}
