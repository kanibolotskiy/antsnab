<?php

use WS\Override\Gateway\ProdTabs;

class ModelCatalogProduct extends Model
{
    public function getProductLinks($product_id){
        $data=[];

        /*Цвета */
        $sql="select * from analog_products where type=1 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
        $query=$this->db->query($sql);
        if($row=$query->row){
            $f_product_id=$row['product_id'];
        }else{
            $f_product_id=$product_id;
        }
        $sql_final="select * from analog_products where type=1 and (product_id='".$f_product_id."' OR link_product_id='".$f_product_id."')";

        $query_final=$this->db->query($sql_final);
        foreach ($query_final->rows as $result) {
            $data[$result['link_product_id']][1]=Array('name'=>$result['name'],'code'=>$result['code'],'type'=>$result['type']);
        }

        $sql="select * from analog_products where type=2 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
        $query=$this->db->query($sql);
        if($row=$query->row){
            $f_product_id=$row['product_id'];
        }else{
            $f_product_id=$product_id;
        }
        $sql_final="select * from analog_products where type=2 and (product_id='".$f_product_id."' OR link_product_id='".$f_product_id."')";

        $query_final=$this->db->query($sql_final);
        foreach ($query_final->rows as $result) {
            $data[$result['link_product_id']][2]=Array('name'=>$result['name'],'type'=>$result['type']);
        }

        $sql="select * from analog_products where type=3 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
        $query=$this->db->query($sql);
        if($row=$query->row){
            $f_product_id=$row['product_id'];
        }else{
            $f_product_id=$product_id;
        }
        $sql_final="select * from analog_products where type=3 and (product_id='".$f_product_id."' OR link_product_id='".$f_product_id."')";

        $query_final=$this->db->query($sql_final);
        foreach ($query_final->rows as $result) {
            $data[$result['link_product_id']][3]=Array('name'=>$result['name'],'type'=>$result['type']);
        }
        
        $sql="select * from analog_products where type=4 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
        $query=$this->db->query($sql);
        if($row=$query->row){
            $f_product_id=$row['product_id'];
        }else{
            $f_product_id=$product_id;
        }
        $sql_final="select * from analog_products where type=4 and (product_id='".$f_product_id."' OR link_product_id='".$f_product_id."')";

        $query_final=$this->db->query($sql_final);
        foreach ($query_final->rows as $result) {
            $data[$result['link_product_id']][4]=Array('name'=>$result['name'],'type'=>$result['type']);
        }


        /*
        $sql="select * from analog_products where product_id='".$product_id."' OR link_product_id='".$product_id."'";
        $query=$this->db->query($sql);
        if($row=$query->row){
            $f_product_id=$row['product_id'];
        }else{
            $f_product_id=$product_id;
        }

        $sql_final="select * from analog_products where product_id='".$f_product_id."' OR link_product_id='".$f_product_id."'";

        $query_final=$this->db->query($sql_final);
        foreach ($query_final->rows as $result) {
            $data[$result['link_product_id']][$result['type']]=Array('name'=>$result['name'],'code'=>$result['code'],'type'=>$result['type']);
        }
        */
        //print_r($data);
        return $data;
    }
    public function getGrandParentCategories($product_id){
       
        $sql="SELECT oc.parent_id FROM oc_product_to_category opc LEFT JOIN oc_category oc 
        ON opc.category_id=oc.category_id where product_id='".$product_id."' and main_category=1";
        $query=$this->db->query($sql);
        
        $temp_cat_id=$query->row["parent_id"];
        
        
        //$data[]=;
        $cats[]=$temp_cat_id;
        $sql_cats="SELECT od.category_id,od.name FROM oc_category oc LEFT JOIN oc_category_description od ON oc.category_id=od.category_id WHERE oc.parent_id='".$temp_cat_id."' AND isseo=0  order by sort_order";
        $query_cats=$this->db->query($sql_cats);
        $data["categories"]=[];
        $data["products"]=[];
        foreach ($query_cats->rows as $result) {
            $cats[]=$result['category_id'];
            $data["categories"][$result['category_id']]=$result['name'];
        }
        
        if(is_array($cats)){
            $cats_str=implode(",",$cats);
            $sql_products="SELECT od.product_id, od.name, oc.category_id, op.status from oc_product_to_category oc 
            LEFT JOIN oc_product op ON oc.product_id=op.product_id
            LEFT JOIN oc_product_description od ON oc.product_id=od.product_id 
            where category_id IN (".$cats_str.")
            order by op.sort_order";

            $query_products=$this->db->query($sql_products);

            foreach ($query_products->rows as $result_prods) {
                $data["products"][$result_prods['category_id']][]=$result_prods;
            }

        }
        
        return $data;
        
    }
    public function setParamValues($product_id,$data){
        
        if($data["change_params"]){
            $this->db->query("delete from product_param_values where product_id=".$product_id);

            foreach($data["param_value"] as $key=>$value){
                //print_r($value);
                foreach($value as $key_val=>$value_item){
                    //print_r($value_item);
                    if($value_item){
                        $this->db->query("insert into product_param_values (product_id, param_id, value1) values (".(int)$product_id.", ".(int)$key.",'".$key_val."')");
                    }
                }
            }

            foreach($data["param_value_d"] as $key=>$value){
                if($value["value1"] or $value["value2"]){
                    $this->db->query("insert into product_param_values (product_id, param_id, value1, value2) values (".(int)$product_id.", ".(int)$key.",'".$value["value1"]."','".$value["value2"]."')");
                }
            }
        }
    }

    public function getFilterParamValues($param_id, $tp, $product_id){
        $data=[];
        if($tp==1){
            $sql="SELECT value1, value2 from product_param_values where product_id=".(int)$product_id." and param_id=".$param_id;
            $query=$this->db->query($sql);
            $data=$query->row;            
        }else{
            $sql="SELECT value1 from product_param_values where product_id=".(int)$product_id." and param_id=".(int)$param_id;
            $query=$this->db->query($sql);
            
            foreach ($query->rows as $result) {
                $data[]=$result["value1"];
            }

        }
        return $data;
    }
    public function getFilterParamList($param_id){
        $sql="SELECT * from category_param_values where param_id=".(int)$param_id." order by CAST(param_value AS SIGNED) , param_value";
        $query=$this->db->query($sql);
        return $query->rows;
    }

    public function getMainCategoryFilter($category_id){
        $sql="SELECT * from category_params where category_id=".(int)$category_id." order by sort_order";
        $query=$this->db->query($sql);
        return $query->rows;
    }
    public function getMainCategory($product_id){
        $temp_cat_id=0;
        $fin_cat_id=0;
        $step=1;
        $sql="SELECT category_id from oc_product_to_category where main_category=1 and product_id=".(int)$product_id;
        $query=$this->db->query($sql);
        $temp_cat_id=$query->row["category_id"];
        
        while($temp_cat_id!=71 and $step<5){
            $fin_cat_id=$temp_cat_id;
            $sql_cat="SELECT parent_id from oc_category where category_id=".(int)$temp_cat_id;
            $query_cat=$this->db->query($sql_cat);
            $temp_cat_id=$query_cat->row["parent_id"];
            $step++;
        }
        return $fin_cat_id;
    }
    public function afterAddProduct($data, $product_id)
    {
        $this->setIsShowInSummary($product_id, $data);
        $this->updateCustomFields($product_id, $data);
    }

    //@task move to override 
    public function afterEditProduct($product_id, $data)
    {
        $this->setIsShowInSummary($product_id, $data);
        $this->updateCustomFields($product_id, $data);
        $this->updateProperties($product_id, $data);


        if (isset($data['prodtabs'])) {
            $sql = "delete from product_prodtab where product_id = :id";
            $this->db->query($sql, [':id' => $product_id]);

            foreach ($data['prodtabs'] as $k => $p) {
                if ('' !== ProdTabs::trimHelper($p['val']) || '' !== trim($p['sortOrder']) || isset($p['hide'])) {
                    $sql = "insert into product_prodtab  (category_prodtab_id, product_id, val, sortOrder, hide) values "
                        . "(:category_prodtab_id, :product_id, :val, :sortOrder, :hide) ";

                    $this->db->query($sql, [
                        ':category_prodtab_id' => $k,
                        ':product_id' => $product_id,
                        ':val' => ( '' === trim($p['val']) ) ? null : $p['val'],
                        ':sortOrder' => ( '' === trim($p['sortOrder']) ) ? null : (int) $p['sortOrder'],
                        ':hide' => ( isset($p['hide']) ) ? $p['hide'] : 0
                    ]);
                }
            }
        }
    }

    public function updateProperties($product_id, $data)
    {
        if (isset($data['prodproperties'])) {
            $sql = "delete from product_prodproperty where product_id = :id";
            $this->db->query($sql, [':id' => $product_id]);

            foreach ($data['prodproperties'] as $k => $p) {
                if ('' !== trim($p['val']) || '' !== trim($p['sortOrder']) || isset($p['hide'])) {
                    $sql = "insert into product_prodproperty  (category_prodproperty_id, product_id, val, sortOrder, hide) values "
                        . "(:category_prodproperty_id, :product_id, :val, :sortOrder, :hide) ";

                    $this->db->query($sql, [
                        ':category_prodproperty_id' => $k,
                        ':product_id' => $product_id,
                        ':val' => ( '' === trim($p['val']) ) ? null : $p['val'],
                        ':sortOrder' => ( '' === trim($p['sortOrder']) ) ? null : (int) $p['sortOrder'],
                        ':hide' => ( isset($p['hide']) ) ? $p['hide'] : 0
                    ]);
                }
            }
        }
    }

    private function setIsShowInSummary($product_id, $data)
    {
        $isShowInSummary = false;
        if (isset($data['showInSummary'])) {
            $isShowInSummary = (boolean) $data['showInSummary'];
        }
        $sql = "update " . DB_PREFIX . "product set showInSummary = :isShowInSummary where product_id = :id";
        $res = $this->db->query($sql, [':id' => $product_id, ':isShowInSummary' => $isShowInSummary]);
        return $res;
    }

    private function updateCustomFields($product_id, $data)
    {

        $disseo=0;
        if (!empty($data['disseo'])) {
            $disseo = (float) $data['disseo'];
        }
        $altvideo=0;
        if (!empty($data['altvideo'])) {
            $altvideo = (float) $data['altvideo'];
        }
        $discount=0;
        if (!empty($data['discount'])) {
            $discount = (float) $data['discount'];
        }
        
        $consumption=0;
        if (!empty($data['consumption'])) {
            $consumption = (float) $data['consumption'];
        }
        $calc_data1=0;
        $calc_data2=0;
        $calc_data3=0;
        $calc_data4=0;
        if (!empty($data['calc_data1'])) {
            $calc_data1 = (float) $data['calc_data1'];
        }
        if (!empty($data['calc_data2'])) {
            $calc_data2 = (float) $data['calc_data2'];
        }
        if (!empty($data['calc_data3'])) {
            $calc_data3 = (float) $data['calc_data3'];
        }
        if (!empty($data['calc_data4'])) {
            $calc_data4 = (float) $data['calc_data4'];
        }

        $price_wholesale = 0.0000;
        if (!empty($data['price_wholesale'])) {
            $price_wholesale = (float) $data['price_wholesale'];
        }

        $priceold = 0.0000;
        if (!empty($data['priceold'])) {
            $priceold = (float) $data['priceold'];
        }

        $price_wholesaleold = 0.0000;
        if (!empty($data['price_wholesaleold'])) {
            $price_wholesaleold = (float) $data['price_wholesaleold'];
        }


        $wholesale_threshold = 0.0000;
        if (!empty($data['wholesale_threshold'])) {
            $wholesale_threshold = (float) $data['wholesale_threshold'];
        }

        $produnit_template_id = null;
        if (!empty($data['produnit_template_id'])) {
            $produnit_template_id = (int) $data['produnit_template_id'];
        }

        $description_mini = '';
        if (isset($data['description_mini'])) {
            $description_mini = $this->db->escape($data['description_mini']);
        }


        $sql = "update " . DB_PREFIX . "product set consumption = :consumption, calc_data1 = :calc_data1, calc_data2 = :calc_data2, calc_data3 = :calc_data3, calc_data4 = :calc_data4, disseo = :disseo, altvideo = :altvideo, discount = :discount, price_wholesale = :price_wholesale, priceold = :priceold, price_wholesaleold = :price_wholesaleold, wholesale_threshold=:wholesale_threshold, produnit_template_id=:produnit_template_id where product_id = :id";
        $res = $this->db->query($sql, [
            ':discount' => $discount,
            ':disseo' => $disseo,
            ':altvideo' => $altvideo,
            ':consumption' => $consumption,
            ':calc_data1' => $calc_data1,
            ':calc_data2' => $calc_data2,
            ':calc_data3' => $calc_data3,
            ':calc_data4' => $calc_data4,
            ':price_wholesale' => $price_wholesale,
            ':priceold' => $priceold,
            ':price_wholesaleold' => $price_wholesaleold,
            ':wholesale_threshold' => $wholesale_threshold,
            ':produnit_template_id' => $produnit_template_id,
            ':id' => $product_id
        ]);

        foreach ($data['product_description_mini'] as $language_id => $value) {
            $sql = "update " . DB_PREFIX . "product_description set description_mini = :description_mini where product_id = :id and language_id = :language_id";
            $res = $this->db->query($sql, [
                ':description_mini' => $value,
                ':id' => $product_id,
                ':language_id' => $language_id
            ]);
        }

        return true; //@task - что возвращать то?
    }

    /* @task move to override added description_mini */

    public function getProductDescriptions($product_id)
    {
        $product_description_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int) $product_id . "'");

        foreach ($query->rows as $result) {
            $product_description_data[$result['language_id']] = array(
                'name' => $result['name'],
                'description' => $result['description'],
                'description_mini' => $result['description_mini'],
                'meta_title' => $result['meta_title'],
                'meta_h1' => $result['meta_h1'],
                'meta_description' => $result['meta_description'],
                'meta_keyword' => $result['meta_keyword'],
                'tag' => $result['tag'],
                'video' => $result['video']

            );
        }

        return $product_description_data;
    }

    public function addProduct($data)
    {
        /*, location = '" . $this->db->escape($data['location']) . "' */
        $this->db->query("INSERT INTO " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', jan = '" . $this->db->escape($data['jan']) . "', isbn = '" . $this->db->escape($data['isbn']) . "', mpn = '" . $this->db->escape($data['mpn']) . "', quantity = '" . (int) $data['quantity'] . "', minimum = '" . (int) $data['minimum'] . "', subtract = '" . (int) $data['subtract'] . "', stock_status_id = '" . (int) $data['stock_status_id'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int) $data['manufacturer_id'] . "', shipping = '" . (int) $data['shipping'] . "', price = '" . (float) $data['price'] . "', points = '" . (int) $data['points'] . "', weight = '" . (float) $data['weight'] . "', weight_class_id = '" . (int) $data['weight_class_id'] . "', length = '" . (float) $data['length'] . "', width = '" . (float) $data['width'] . "', height = '" . (float) $data['height'] . "', length_class_id = '" . (int) $data['length_class_id'] . "', status = '" . (int) $data['status'] . "', tax_class_id = '" . (int) $data['tax_class_id'] . "', calc='".(int) $data['calc']."', sort_order = '" . (int) $data['sort_order'] . "', date_added = NOW()");

        $product_id = $this->db->getLastId();

        if (isset($data['image'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape($data['image']) . "' WHERE product_id = '" . (int) $product_id . "'");
        }

        foreach ($data['product_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int) $product_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', video = '" . $this->db->escape($value['video']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
        }

        /*
        if (isset($data['product_store'])) {
            foreach ($data['product_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int) $product_id . "', store_id = '" . (int) $store_id . "'");
            }
        }
        */
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int) $product_id . "', store_id = '0'");

        if (isset($data['product_attribute'])) {
            foreach ($data['product_attribute'] as $product_attribute) {
                if ($product_attribute['attribute_id']) {
                    // Removes duplicates
                    $this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int) $product_id . "' AND attribute_id = '" . (int) $product_attribute['attribute_id'] . "'");

                    foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {
                        $this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE  = '" . (int) $product_id . "' AND attribute_id = '" . (int) $product_attribute['attribute_id'] . "' AND language_id = '" . (int) $language_id . "'");

                        $this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int) $product_id . "', attribute_id = '" . (int) $product_attribute['attribute_id'] . "', language_id = '" . (int) $language_id . "', text = '" . $this->db->escape($product_attribute_description['text']) . "'");
                    }
                }
            }
        }

        if (isset($data['product_option'])) {
            foreach ($data['product_option'] as $product_option) {
                if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
                    if (isset($product_option['product_option_value'])) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int) $product_id . "', option_id = '" . (int) $product_option['option_id'] . "', required = '" . (int) $product_option['required'] . "'");

                        $product_option_id = $this->db->getLastId();

                        foreach ($product_option['product_option_value'] as $product_option_value) {
                            $this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int) $product_option_id . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $product_option['option_id'] . "', option_value_id = '" . (int) $product_option_value['option_value_id'] . "', quantity = '" . (int) $product_option_value['quantity'] . "', subtract = '" . (int) $product_option_value['subtract'] . "', price = '" . (float) $product_option_value['price'] . "', price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', points = '" . (int) $product_option_value['points'] . "', points_prefix = '" . $this->db->escape($product_option_value['points_prefix']) . "', weight = '" . (float) $product_option_value['weight'] . "', weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'");
                        }
                    }
                } else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int) $product_id . "', option_id = '" . (int) $product_option['option_id'] . "', value = '" . $this->db->escape($product_option['value']) . "', required = '" . (int) $product_option['required'] . "'");
                }
            }
        }

        if (isset($data['product_discount'])) {
            foreach ($data['product_discount'] as $product_discount) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int) $product_id . "', customer_group_id = '" . (int) $product_discount['customer_group_id'] . "', quantity = '" . (int) $product_discount['quantity'] . "', priority = '" . (int) $product_discount['priority'] . "', price = '" . (float) $product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
            }
        }

        if (isset($data['product_special'])) {
            foreach ($data['product_special'] as $product_special) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int) $product_id . "', customer_group_id = '" . (int) $product_special['customer_group_id'] . "', priority = '" . (int) $product_special['priority'] . "', price = '" . (float) $product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
            }
        }

        if (isset($data['product_image'])) {
            foreach ($data['product_image'] as $product_image) {
                //@task move to override
                $alt = isset($product_image['alt']) ? $product_image['alt'] : '';
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int) $product_id . "', image = '" . $this->db->escape($product_image['image']) . "', sort_order = '" . (int) $product_image['sort_order'] . "', alt='" . $this->db->escape($alt) . "'");
                /* $this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int) $product_id . "', image = '" . $this->db->escape($product_image['image']) . "', sort_order = '" . (int) $product_image['sort_order'] . "'"); */
            }
        }

        if (isset($data['product_download'])) {
            foreach ($data['product_download'] as $download_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int) $product_id . "', download_id = '" . (int) $download_id . "'");
            }
        }

        if (isset($data['product_category'])) {
            foreach ($data['product_category'] as $category_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int) $product_id . "', category_id = '" . (int) $category_id . "'");
            }
        }

        if (isset($data['main_category_id']) && $data['main_category_id'] > 0) {
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "' AND category_id = '" . (int) $data['main_category_id'] . "'");
            $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int) $product_id . "', category_id = '" . (int) $data['main_category_id'] . "', main_category = 1");
        } elseif (isset($data['product_category'][0])) {
            $this->db->query("UPDATE " . DB_PREFIX . "product_to_category SET main_category = 1 WHERE product_id = '" . (int) $product_id . "' AND category_id = '" . (int) $data['product_category'][0] . "'");
        }

        if (isset($data['product_filter'])) {
            foreach ($data['product_filter'] as $filter_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int) $product_id . "', filter_id = '" . (int) $filter_id . "'");
            }
        }

        /*
        if (isset($data['product_related'])) {
            //@task move to override
            foreach ($data['product_related'] as $related_id) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $product_id . "' AND related_id = '" . (int) $related_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");
                //$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $related_id . "' AND related_id = '" . (int) $product_id . "'");
                //$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int) $related_id . "', related_id = '" . (int) $product_id . "'"); 
            }
        }
        */
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $product_id . "'");
        if($data['products_change']){
            //echo "related_change";
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $product_id . "' AND related_id = '" . (int) $related_id . "'");
            $product_relateds_str=$data['products'];
            $product_relateds=explode(",",$product_relateds_str);
            foreach ($product_relateds as $related_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");    
            }    
        }

        if (isset($data['product_reward'])) {
            foreach ($data['product_reward'] as $customer_group_id => $product_reward) {
                if ((int) $product_reward['points'] > 0) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int) $product_id . "', customer_group_id = '" . (int) $customer_group_id . "', points = '" . (int) $product_reward['points'] . "'");
                }
            }
        }
        
        if (isset($data['product_layout'])) {
            foreach ($data['product_layout'] as $store_id => $layout_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int) $product_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout_id . "'");
            }
        }

        if ($data['keyword']) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int) $product_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
        }

        if (isset($data['product_recurring'])) {
            foreach ($data['product_recurring'] as $recurring) {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "product_recurring` SET `product_id` = " . (int) $product_id . ", customer_group_id = " . (int) $recurring['customer_group_id'] . ", `recurring_id` = " . (int) $recurring['recurring_id']);
            }
        }
        $this->setParamValues($product_id, $data);

        $this->cache->delete('product');

        return $product_id;
    }

    public function editProduct($product_id, $data)
    {
        /*, location = '" . $this->db->escape($data['location']) . "'*/
        $this->db->query("UPDATE " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', jan = '" . $this->db->escape($data['jan']) . "', isbn = '" . $this->db->escape($data['isbn']) . "', mpn = '" . $this->db->escape($data['mpn']) . "', quantity = '" . (int) $data['quantity'] . "', minimum = '" . (int) $data['minimum'] . "', subtract = '" . (int) $data['subtract'] . "', stock_status_id = '" . (int) $data['stock_status_id'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int) $data['manufacturer_id'] . "', shipping = '" . (int) $data['shipping'] . "', price = '" . (float) $data['price'] . "', points = '" . (int) $data['points'] . "', weight = '" . (float) $data['weight'] . "', weight_class_id = '" . (int) $data['weight_class_id'] . "', length = '" . (float) $data['length'] . "', width = '" . (float) $data['width'] . "', height = '" . (float) $data['height'] . "', length_class_id = '" . (int) $data['length_class_id'] . "', status = '" . (int) $data['status'] . "', tax_class_id = '" . (int) $data['tax_class_id'] . "', sort_order = '" . (int) $data['sort_order'] . "', mincount='".(int) $data['mincount']."',calc='".(int) $data['calc']."', date_modified = NOW() WHERE product_id = '" . (int) $product_id . "'");

        if (isset($data['image'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape($data['image']) . "' WHERE product_id = '" . (int) $product_id . "'");
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int) $product_id . "'");

        foreach ($data['product_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int) $product_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', video = '" . $this->db->escape($value['video']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int) $product_id . "'");
        /*
        if (isset($data['product_store'])) {
            foreach ($data['product_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int) $product_id . "', store_id = '" . (int) $store_id . "'");
            }
        }
        */
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int) $product_id . "', store_id = '0'");


        $this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int) $product_id . "'");

        if (!empty($data['product_attribute'])) {
            foreach ($data['product_attribute'] as $product_attribute) {
                if ($product_attribute['attribute_id']) {
                    // Removes duplicates
                    $this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int) $product_id . "' AND attribute_id = '" . (int) $product_attribute['attribute_id'] . "'");

                    foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int) $product_id . "', attribute_id = '" . (int) $product_attribute['attribute_id'] . "', language_id = '" . (int) $language_id . "', text = '" . $this->db->escape($product_attribute_description['text']) . "'");
                    }
                }
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int) $product_id . "'");

        if (isset($data['product_option'])) {
            foreach ($data['product_option'] as $product_option) {
                if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
                    if (isset($product_option['product_option_value'])) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_option_id = '" . (int) $product_option['product_option_id'] . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $product_option['option_id'] . "', required = '" . (int) $product_option['required'] . "'");

                        $product_option_id = $this->db->getLastId();

                        foreach ($product_option['product_option_value'] as $product_option_value) {
                            $this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_value_id = '" . (int) $product_option_value['product_option_value_id'] . "', product_option_id = '" . (int) $product_option_id . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $product_option['option_id'] . "', option_value_id = '" . (int) $product_option_value['option_value_id'] . "', quantity = '" . (int) $product_option_value['quantity'] . "', subtract = '" . (int) $product_option_value['subtract'] . "', price = '" . (float) $product_option_value['price'] . "', price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', points = '" . (int) $product_option_value['points'] . "', points_prefix = '" . $this->db->escape($product_option_value['points_prefix']) . "', weight = '" . (float) $product_option_value['weight'] . "', weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'");
                        }
                    }
                } else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_option_id = '" . (int) $product_option['product_option_id'] . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $product_option['option_id'] . "', value = '" . $this->db->escape($product_option['value']) . "', required = '" . (int) $product_option['required'] . "'");
                }
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int) $product_id . "'");

        if (isset($data['product_discount'])) {
            foreach ($data['product_discount'] as $product_discount) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int) $product_id . "', customer_group_id = '" . (int) $product_discount['customer_group_id'] . "', quantity = '" . (int) $product_discount['quantity'] . "', priority = '" . (int) $product_discount['priority'] . "', price = '" . (float) $product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int) $product_id . "'");

        if (isset($data['product_special'])) {
            foreach ($data['product_special'] as $product_special) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int) $product_id . "', customer_group_id = '" . (int) $product_special['customer_group_id'] . "', priority = '" . (int) $product_special['priority'] . "', price = '" . (float) $product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int) $product_id . "'");

        if (isset($data['product_image'])) {
            foreach ($data['product_image'] as $product_image) {
                //@task move to override
                $alt = isset($product_image['alt']) ? $product_image['alt'] : '';
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int) $product_id . "', image = '" . $this->db->escape($product_image['image']) . "', sort_order = '" . (int) $product_image['sort_order'] . "', alt='" . $this->db->escape($alt) . "'");

                /* $this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int) $product_id . "', image = '" . $this->db->escape($product_image['image']) . "', sort_order = '" . (int) $product_image['sort_order'] . "'"); */
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int) $product_id . "'");

        if (isset($data['product_download'])) {
            foreach ($data['product_download'] as $download_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int) $product_id . "', download_id = '" . (int) $download_id . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "'");

        if (isset($data['product_category'])) {
            foreach ($data['product_category'] as $category_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int) $product_id . "', category_id = '" . (int) $category_id . "'");
            }
        }

        if (isset($data['main_category_id']) && $data['main_category_id'] > 0) {
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "' AND category_id = '" . (int) $data['main_category_id'] . "'");
            $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int) $product_id . "', category_id = '" . (int) $data['main_category_id'] . "', main_category = 1");
        } elseif (isset($data['product_category'][0])) {
            $this->db->query("UPDATE " . DB_PREFIX . "product_to_category SET main_category = 1 WHERE product_id = '" . (int) $product_id . "' AND category_id = '" . (int) $data['product_category'][0] . "'");
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int) $product_id . "'");

        if (isset($data['product_filter'])) {
            foreach ($data['product_filter'] as $filter_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int) $product_id . "', filter_id = '" . (int) $filter_id . "'");
            }
        }
        
        /**Преимущества */
        $this->db->query("DELETE FROM dopinfo_benefits_to_product WHERE product_id = '" . (int) $product_id . "'");
        //print_r($data);
        if (isset($data['product_benefit'])) {
            foreach ($data['product_benefit'] as $benefit_id) {
                $this->db->query("INSERT INTO dopinfo_benefits_to_product SET product_id = '" . (int) $product_id . "', benefit_id = '" . (int) $benefit_id . "'");
            }
        }

    
        /**Аналоги товаров 
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_analogs WHERE product_id = '" . (int) $product_id . "'");
        //$this->db->query("DELETE FROM " . DB_PREFIX . "product_analogs WHERE related_id = '" . (int) $product_id . "'");
        //@task move to override
        if (isset($data['product_analog'])) {
            foreach ($data['product_analog'] as $related_id) {
                //$this->db->query("DELETE FROM " . DB_PREFIX . "product_analogs WHERE product_id = '" . (int) $product_id . "' AND related_id = '" . (int) $related_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_analogs SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");
                //$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $related_id . "' AND related_id = '" . (int) $product_id . "'");
                //$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int) $related_id . "', related_id = '" . (int) $product_id . "'"); 
            }
        }
        */

        /**Аналоги товаров */
        if($data['products_change_analog']){
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_analogs WHERE product_id = '" . (int) $product_id . "'");

            $product_relateds_str=$data['products_analog'];
            $product_relateds=explode(",",$product_relateds_str);
            foreach ($product_relateds as $related_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_analogs SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");    
            }    
        }

        /**Сопутствующие товары */
        if($data['products_change']){
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $product_id . "'");
            //$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int) $product_id . "'");
            $product_relateds_str=$data['products'];
            $product_relateds=explode(",",$product_relateds_str);
            foreach ($product_relateds as $related_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");    
            }    
        }

        /**Идентичные товары */
        if($data['iden_change1']){
            $sql="select * from analog_products where type=1 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
            $query=$this->db->query($sql);
            if($row=$query->row){
                $f_product_id=$row['product_id'];
            }else{
                $f_product_id=$product_id;
            }
            $this->db->query("DELETE FROM analog_products WHERE type=1 and (link_product_idproduct_id = '" .$product_id . "'");

            foreach($data["iden"] as $key=>$iden){
                if($iden[1]['name']){
                    $this->db->query('INSERT INTO analog_products (product_id,link_product_id,type,name,code) 
                    VALUES ("'.$f_product_id.'","'.$key.'","1","'.$iden[1]['name'].'","'.$iden[1]['code'].'")');
                }
            }
        }
        if($data['iden_change2']){
            $sql="select * from analog_products where type=2 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
            $query=$this->db->query($sql);
            if($row=$query->row){
                $f_product_id=$row['product_id'];
            }else{
                $f_product_id=$product_id;
            }
            $this->db->query("DELETE FROM analog_products WHERE type=2 and product_id = '" . (int) $f_product_id . "'");
            //print_r($data["iden"]);
            foreach($data["iden"] as $key=>$iden){
                if($iden[2]['name']){
                    $this->db->query('INSERT INTO analog_products (product_id,link_product_id,type,name,code) 
                    VALUES ("'.$f_product_id.'","'.$key.'","2","'.$iden[2]['name'].'","")');
                    //echo 'INSERT INTO analog_products (product_id,link_product_id,type,name,code) 
                    //VALUES ("'.$f_product_id.'","'.$key.'","2","'.$iden[2]['name'].'","")';
                }
            }
        }
        if($data['iden_change3']){
            $sql="select * from analog_products where type=3 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
            $query=$this->db->query($sql);
            if($row=$query->row){
                $f_product_id=$row['product_id'];
            }else{
                $f_product_id=$product_id;
            }
            $this->db->query("DELETE FROM analog_products WHERE type=3 and product_id = '" . (int) $f_product_id . "'");

            foreach($data["iden"] as $key=>$iden){
                if($iden[3]['name']){
                    $this->db->query('INSERT INTO analog_products (product_id,link_product_id,type,name,code) 
                    VALUES ("'.$f_product_id.'","'.$key.'","3","'.$iden[3]['name'].'","")');
                }
            }
        }
        if($data['iden_change4']){
            $sql="select * from analog_products where type=4 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
            $query=$this->db->query($sql);
            if($row=$query->row){
                $f_product_id=$row['product_id'];
            }else{
                $f_product_id=$product_id;
            }
            $this->db->query("DELETE FROM analog_products WHERE type=4 and product_id = '" . (int) $f_product_id . "'");

            foreach($data["iden"] as $key=>$iden){
                if($iden[4]['name']){
                    $this->db->query('INSERT INTO analog_products (product_id,link_product_id,type,name,code) 
                    VALUES ("'.$f_product_id.'","'.$key.'","4","'.$iden[4]['name'].'","")');
                }
            }
        }
        
            /*
            foreach($data["iden"] as $key=>$iden){
                if(isset($iden[1]['name'])){
                    $sql="select * from analog_products where type=1 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
                    $query=$this->db->query($sql);
                    if($row=$query->row){
                        $f_product_id=$row['product_id'];
                    }else{
                        $f_product_id=$product_id;
                    }
                    
                    $this->db->query("DELETE FROM analog_products WHERE type=1 and product_id = '" . (int) $f_product_id . "'");
                    if($iden[1]['code'] or $iden[1]['name']){
                        $this->db->query('INSERT INTO analog_products (product_id,link_product_id,type,name,code) 
                        VALUES ("'.$f_product_id.'","'.$key.'","1","'.$iden[1]['name'].'","'.$iden[1]['code'].'")');
                        //echo 'INSERT INTO analog_products (product_id,link_product_id,type,name,code) 
                        //VALUES ("'.$product_id.'","'.$key.'","1","'.$iden[1]['name'].'","'.$iden[1]['code'].'")';
                    }
                }
                if(isset($iden[2]['name'])){
                    $sql="select * from analog_products where type=2 and (product_id='".$product_id."' OR link_product_id='".$product_id."')";
                    $query=$this->db->query($sql);
                    if($row=$query->row){
                        $f_product_id=$row['product_id'];
                    }else{
                        $f_product_id=$product_id;
                    }
                    $this->db->query("DELETE FROM analog_products WHERE type=1 and product_id = '" . (int) $f_product_id . "'");
                    if($iden[2]['name']){
                        $this->db->query('INSERT INTO analog_products (product_id,link_product_id,type,name) 
                        VALUES ("'.$f_product_id.'","'.$key.'","2","'.$iden[2]['name'].'")');
                        //echo 'INSERT INTO analog_products (product_id,link_product_id,type,name) 
                        //VALUES ("'.$product_id.'","'.$key.'","2","'.$iden[2]['name'].'")';
                    }
                }
                if(isset($iden[3]['name'])){
                    if($iden[3]['name']){
                        $this->db->query('INSERT INTO analog_products (product_id,link_product_id,type,name) 
                        VALUES ("'.$f_product_id.'","'.$key.'","3","'.$iden[3]['name'].'")');
                        //echo 'INSERT INTO analog_products (product_id,link_product_id,type,name) 
                        //VALUES ("'.$product_id.'","'.$key.'","3","'.$iden[3]['name'].'")';
                    }
                }
                if(isset($iden[4]['name'])){
                    if($iden[4]['name']){
                        $this->db->query('INSERT INTO analog_products (product_id,link_product_id,type,name) 
                        VALUES ("'.$f_product_id.'","'.$key.'","4","'.$iden[4]['name'].'")');
                        //echo 'INSERT INTO analog_products (product_id,link_product_id,type,name) 
                        //VALUES ("'.$product_id.'","'.$key.'","4","'.$iden[4]['name'].'")';
                    }
                }
                //echo $iden[1]['code']."<br/>";
            }
           

            //$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $product_id . "'");
            //$this->db->query("DELETE FROM analog_products where");
            //foreach(){

            //}
        }
         */
        /*
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int) $product_id . "'");
        if (isset($data['product_reward'])) {
            foreach ($data['product_reward'] as $customer_group_id => $value) {
                if ((int) $value['points'] > 0) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int) $product_id . "', customer_group_id = '" . (int) $customer_group_id . "', points = '" . (int) $value['points'] . "'");
                }
            }
        }
        */
        /*
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int) $product_id . "'");

        if (isset($data['product_layout'])) {
            foreach ($data['product_layout'] as $store_id => $layout_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int) $product_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout_id . "'");
            }
        }
        */
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int) $product_id . "'");

        if ($data['keyword']) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int) $product_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
        }

        $this->db->query("DELETE FROM `" . DB_PREFIX . "product_recurring` WHERE product_id = " . (int) $product_id);

        if (isset($data['product_recurring'])) {
            foreach ($data['product_recurring'] as $product_recurring) {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "product_recurring` SET `product_id` = " . (int) $product_id . ", customer_group_id = " . (int) $product_recurring['customer_group_id'] . ", `recurring_id` = " . (int) $product_recurring['recurring_id']);
            }
        }
        $this->setParamValues($product_id, $data);
        $this->cache->delete('product');
    }

    public function copyProduct($product_id)
    {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "product p WHERE p.product_id = '" . (int) $product_id . "'");

        if ($query->num_rows) {
            $data = $query->row;

            $data['sku'] = '';
            $data['upc'] = '';
            $data['viewed'] = '0';
            $data['keyword'] = '';
            $data['status'] = '0';

            $data['product_attribute'] = $this->getProductAttributes($product_id);
            $data['product_description'] = $this->getProductDescriptions($product_id);
            $data['product_discount'] = $this->getProductDiscounts($product_id);
            $data['product_filter'] = $this->getProductFilters($product_id);
            $data['product_image'] = $this->getProductImages($product_id);
            $data['product_option'] = $this->getProductOptions($product_id);
            $data['product_related'] = $this->getProductRelated($product_id);
            $data['product_benefits'] = $this->getProductBenefits($product_id);
            
            $data['product_reward'] = $this->getProductRewards($product_id);
            $data['product_special'] = $this->getProductSpecials($product_id);
            $data['product_category'] = $this->getProductCategories($product_id);
            $data['product_download'] = $this->getProductDownloads($product_id);
            $data['product_layout'] = $this->getProductLayouts($product_id);
            $data['product_store'] = $this->getProductStores($product_id);
            $data['product_recurrings'] = $this->getRecurrings($product_id);

            $data['main_category_id'] = $this->getProductMainCategoryId($product_id);
            
            $data['product_benefits'] = $this->getProductBenefits($product_id);
            
            $data['product_reward'] = $this->getProductRewards($product_id);
            $data['product_special'] = $this->getProductSpecials($product_id);
            $data['product_category'] = $this->getProductCategories($product_id);
            $data['product_download'] = $this->getProductDownloads($product_id);
            $data['product_layout'] = $this->getProductLayouts($product_id);
            $data['product_store'] = $this->getProductStores($product_id);
            $data['product_recurrings'] = $this->getRecurrings($product_id);

            $data['main_category_id'] = $this->getProductMainCategoryId($product_id);

            $this->addProduct($data);
        }
    }

    public function deleteProduct($product_id)
    {
        $this->db->query("DELETE FROM " . DB_PREFIX . "product WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_recurring WHERE product_id = " . (int) $product_id);
        $this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE product_id = '" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int) $product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "coupon_product WHERE product_id = '" . (int) $product_id . "'");

        $this->cache->delete('product');
    }

    public function getProduct($product_id)
    {
        $query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int) $product_id . "' LIMIT 1) AS keyword FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int) $product_id . "' AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "'");

        return $query->row;
    }

    public function getProducts($data = array())
    {

        $sql = "SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

        if (!empty($data['filter_category'])) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
        }

        $sql .= " WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "'";


        if (!empty($data['filter_name'])) {
            $sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
        }

        if (!empty($data['filter_model'])) {
            $sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
        }

        if (isset($data['filter_price']) && !is_null($data['filter_price'])) {
            $sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
        }

        if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
            $sql .= " AND p.quantity = '" . (int) $data['filter_quantity'] . "'";
        }

        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND p.status = '" . (int) $data['filter_status'] . "'";
        }

        if (isset($data['filter_image']) && !is_null($data['filter_image'])) {
            if ($data['filter_image'] == 1) {
                $sql .= " AND (p.image IS NOT NULL AND p.image <> '' AND p.image <> 'no_image.png')";
            } else {
                $sql .= " AND (p.image IS NULL OR p.image = '' OR p.image = 'no_image.png')";
            }
        }

        if (!empty($data['filter_category'])) {
            $sql .= " AND p2c.category_id = '" . (int) $data['filter_category'] . "'";
        }
        $sql .= " GROUP BY p.product_id";

        $sort_data = array(
            'pd.name',
            'p.model',
            'p.price',
            'p.quantity',
            'p.status',
            'p.sort_order'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY pd.name";
        }

        if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC";
        } else {
            $sql .= " ASC";
        }

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getProductsByCategoryId($category_id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p2c.category_id = '" . (int) $category_id . "' ORDER BY pd.name ASC");

        return $query->rows;
    }

    public function getProductCategories($product_id)
    {
        $product_category_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "'");

        foreach ($query->rows as $result) {
            $product_category_data[] = $result['category_id'];
        }

        return $product_category_data;
    }

    public function getProductFilters($product_id)
    {
        $product_filter_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int) $product_id . "'");

        foreach ($query->rows as $result) {
            $product_filter_data[] = $result['filter_id'];
        }

        return $product_filter_data;
    }

    public function getProductAttributes($product_id)
    {
        $product_attribute_data = array();

        $product_attribute_query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int) $product_id . "' GROUP BY attribute_id");

        foreach ($product_attribute_query->rows as $product_attribute) {
            $product_attribute_description_data = array();

            $product_attribute_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int) $product_id . "' AND attribute_id = '" . (int) $product_attribute['attribute_id'] . "'");

            foreach ($product_attribute_description_query->rows as $product_attribute_description) {
                $product_attribute_description_data[$product_attribute_description['language_id']] = array('text' => $product_attribute_description['text']);
            }

            $product_attribute_data[] = array(
                'attribute_id' => $product_attribute['attribute_id'],
                'product_attribute_description' => $product_attribute_description_data
            );
        }

        return $product_attribute_data;
    }

    public function getProductOptions($product_id)
    {
        $product_option_data = array();

        $product_option_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_option` po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN `" . DB_PREFIX . "option_description` od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int) $product_id . "' AND od.language_id = '" . (int) $this->config->get('config_language_id') . "'");

        foreach ($product_option_query->rows as $product_option) {
            $product_option_value_data = array();

            $product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON(pov.option_value_id = ov.option_value_id) WHERE pov.product_option_id = '" . (int) $product_option['product_option_id'] . "' ORDER BY ov.sort_order ASC");

            foreach ($product_option_value_query->rows as $product_option_value) {
                $product_option_value_data[] = array(
                    'product_option_value_id' => $product_option_value['product_option_value_id'],
                    'option_value_id' => $product_option_value['option_value_id'],
                    'quantity' => $product_option_value['quantity'],
                    'subtract' => $product_option_value['subtract'],
                    'price' => $product_option_value['price'],
                    'price_prefix' => $product_option_value['price_prefix'],
                    'points' => $product_option_value['points'],
                    'points_prefix' => $product_option_value['points_prefix'],
                    'weight' => $product_option_value['weight'],
                    'weight_prefix' => $product_option_value['weight_prefix']
                );
            }

            $product_option_data[] = array(
                'product_option_id' => $product_option['product_option_id'],
                'product_option_value' => $product_option_value_data,
                'option_id' => $product_option['option_id'],
                'name' => $product_option['name'],
                'type' => $product_option['type'],
                'value' => $product_option['value'],
                'required' => $product_option['required']
            );
        }

        return $product_option_data;
    }

    public function getProductOptionValue($product_id, $product_option_value_id)
    {
        $query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_id = '" . (int) $product_id . "' AND pov.product_option_value_id = '" . (int) $product_option_value_id . "' AND ovd.language_id = '" . (int) $this->config->get('config_language_id') . "'");

        return $query->row;
    }

    public function getProductImages($product_id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int) $product_id . "' ORDER BY sort_order ASC");

        return $query->rows;
    }

    public function getProductDiscounts($product_id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int) $product_id . "' ORDER BY quantity, priority, price");

        return $query->rows;
    }

    public function getProductSpecials($product_id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int) $product_id . "' ORDER BY priority, price");

        return $query->rows;
    }

    public function getProductRewards($product_id)
    {
        $product_reward_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int) $product_id . "'");

        foreach ($query->rows as $result) {
            $product_reward_data[$result['customer_group_id']] = array('points' => $result['points']);
        }

        return $product_reward_data;
    }
 
    public function getProductDownloads($product_id)
    {
        $product_download_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int) $product_id . "'");

        foreach ($query->rows as $result) {
            $product_download_data[] = $result['download_id'];
        }

        return $product_download_data;
    }

    public function getProductStores($product_id)
    {
        $product_store_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int) $product_id . "'");

        foreach ($query->rows as $result) {
            $product_store_data[] = $result['store_id'];
        }

        return $product_store_data;
    }

    public function getProductLayouts($product_id)
    {
        $product_layout_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int) $product_id . "'");

        foreach ($query->rows as $result) {
            $product_layout_data[$result['store_id']] = $result['layout_id'];
        }

        return $product_layout_data;
    }

    public function getProductMainCategoryId($product_id)
    {
        $query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "' AND main_category = '1' LIMIT 1");

        return ($query->num_rows ? (int) $query->row['category_id'] : 0);
    }

    public function getProductRelated($product_id, $table='product_related')
    {
        $product_related_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . $table." WHERE product_id = '" . (int) $product_id . "'");

        foreach ($query->rows as $result) {
            $product_related_data[] = $result['related_id'];
        }

        return $product_related_data;
    }


    /**Преимущества товара*/
    public function getProductBenefits($product_id)
    {
        $product_related_data = array();
        $query = $this->db->query("SELECT dbp.product_id,db.benefit_id,db.name,db.name_admin FROM `dopinfo_benefits_to_product` dbp left join dopinfo_benefits db ON dbp.benefit_id=db.benefit_id WHERE dbp.product_id='" . (int) $product_id . "'");
        return $query->rows;
    }
    
    
    


    public function getRecurrings($product_id)
    {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_recurring` WHERE product_id = '" . (int) $product_id . "'");

        return $query->rows;
    }

    public function getTotalProducts($data = array())
    {
        $sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";

        $sql .= " WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "'";

        if (!empty($data['filter_name'])) {
            $sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
        }

        if (!empty($data['filter_model'])) {
            $sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
        }

        if (isset($data['filter_price']) && !is_null($data['filter_price'])) {
            $sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
        }

        if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
            $sql .= " AND p.quantity = '" . (int) $data['filter_quantity'] . "'";
        }

        if (isset($data['filter_category']) && !is_null($data['filter_category'])) {
            $sql .= " AND p2c.category_id = '" . (int) $data['filter_category'] . "'";
        }

        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND p.status = '" . (int) $data['filter_status'] . "'";
        }

        if (isset($data['filter_image']) && !is_null($data['filter_image'])) {
            if ($data['filter_image'] == 1) {
                $sql .= " AND (p.image IS NOT NULL AND p.image <> '' AND p.image <> 'no_image.png')";
            } else {
                $sql .= " AND (p.image IS NULL OR p.image = '' OR p.image = 'no_image.png')";
            }
        }

        $query = $this->db->query($sql);

        return $query->row['total'];
    }

    public function getTotalProductsByTaxClassId($tax_class_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE tax_class_id = '" . (int) $tax_class_id . "'");

        return $query->row['total'];
    }

    public function getTotalProductsByStockStatusId($stock_status_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE stock_status_id = '" . (int) $stock_status_id . "'");

        return $query->row['total'];
    }

    public function getTotalProductsByWeightClassId($weight_class_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE weight_class_id = '" . (int) $weight_class_id . "'");

        return $query->row['total'];
    }

    public function getTotalProductsByLengthClassId($length_class_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE length_class_id = '" . (int) $length_class_id . "'");

        return $query->row['total'];
    }

    public function getTotalProductsByDownloadId($download_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_download WHERE download_id = '" . (int) $download_id . "'");

        return $query->row['total'];
    }

    public function getTotalProductsByManufacturerId($manufacturer_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE manufacturer_id = '" . (int) $manufacturer_id . "'");

        return $query->row['total'];
    }

    public function getTotalProductsByAttributeId($attribute_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_attribute WHERE attribute_id = '" . (int) $attribute_id . "'");

        return $query->row['total'];
    }

    public function getTotalProductsByOptionId($option_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_option WHERE option_id = '" . (int) $option_id . "'");

        return $query->row['total'];
    }

    public function getTotalProductsByProfileId($recurring_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_recurring WHERE recurring_id = '" . (int) $recurring_id . "'");

        return $query->row['total'];
    }

    public function getTotalProductsByLayoutId($layout_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_layout WHERE layout_id = '" . (int) $layout_id . "'");

        return $query->row['total'];
    }

}
