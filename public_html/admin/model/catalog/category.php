<?php

class ModelCatalogCategory extends Model
{
    function rus2translit($string) {
		$converter = array(
			'а' => 'a',   'б' => 'b',   'в' => 'v',
			'г' => 'g',   'д' => 'd',   'е' => 'e',
			'ё' => 'e',   'ж' => 'zh',  'з' => 'z',
			'и' => 'i',   'й' => 'y',   'к' => 'k',
			'л' => 'l',   'м' => 'm',   'н' => 'n',
			'о' => 'o',   'п' => 'p',   'р' => 'r',
			'с' => 's',   'т' => 't',   'у' => 'u',
			'ф' => 'f',   'х' => 'h',   'ц' => 'c',
			'ч' => 'ch',  'ш' => 'sh',  'щ' => 'sch',
			'ь' => '\'',  'ы' => 'y',   'ъ' => '\'',
			'э' => 'e',   'ю' => 'yu',  'я' => 'ya',
			'А' => 'A',   'Б' => 'B',   'В' => 'V',
			'Г' => 'G',   'Д' => 'D',   'Е' => 'E',
			'Ё' => 'E',   'Ж' => 'Zh',  'З' => 'Z',
			'И' => 'I',   'Й' => 'Y',   'К' => 'K',
			'Л' => 'L',   'М' => 'M',   'Н' => 'N',
			'О' => 'O',   'П' => 'P',   'Р' => 'R',
			'С' => 'S',   'Т' => 'T',   'У' => 'U',
			'Ф' => 'F',   'Х' => 'H',   'Ц' => 'C',
			'Ч' => 'Ch',  'Ш' => 'Sh',  'Щ' => 'Sch',
			'Ь' => '\'',  'Ы' => 'Y',   'Ъ' => '\'',
            'Э' => 'E',   'Ю' => 'Yu',  'Я' => 'Ya',
            ' '=>'_'
		);
		return strtr($string, $converter);
    }
    

    public function setParamValues($category_id,$data){
        
        if($data["change_params"]){
            
            //print_r($data["cat_filter"]);
            //Обновление общих данных
            $sql = "select id from category_params where category_id='".(int)$category_id."'";
            $query = $this->db->query($sql);
            $cat_filters=[];
            if ($query->rows) {
                foreach ($query->rows as $category_filter) {
                    $cat_filters[]=$category_filter["id"];
                }
            }
            
            foreach($data["cat_filter"] as $key=>$data_itm){
                //print_r($data_itm);
                unset($cat_filters[array_search($key,$cat_filters)]);
                
                if(!trim($data_itm["translit"])){
                    $tr_translit=strtolower($this->rus2translit(trim($data_itm["name"])));
                }else{
                    $tr_translit=trim($data_itm["translit"]);
                }
                $sql="update category_params set name='".trim($data_itm["name"])."', step=".$data_itm["step"].", translit='".$tr_translit."', unit='".trim($data_itm["unit"])."', type_param='".(int)$data_itm["type_param"]."',  sort_order='".(int)$data_itm["sort_order"]."', param_sort_type='".(int)$data_itm["param_sort_type"]."' where id='".(int)$key."'";
                $this->db->query($sql);
            }
            foreach($cat_filters as $del_item){
                $this->db->query("DELETE FROM category_param_values where param_id='".(int)$del_item."'");
                $this->db->query("DELETE FROM category_params where id='".(int)$del_item."'");
            }

            foreach($data["param_value"] as $key=>$param_item){
                foreach($param_item as $key_value=>$param_value){
                    if($key_value=="new"){
                        foreach($param_value as $item_new){
                            if($item_new!="remove"){
                                $sql_upd="insert into category_param_values (param_id, param_value) values ('".(int)$key."', '".trim($item_new)."')";
                                $this->db->query($sql_upd);
                            }
                        }
                    }else{
                        if($param_value=="remove"){
                            $sql_upd="delete from category_param_values where param_id='".(int)$key."' and id='".(int)$key_value."'";
                        }else{
                            $sql_upd="update category_param_values set param_value='".trim($param_value)."' where param_id='".(int)$key."' and id='".(int)$key_value."'";
                        }
                        $this->db->query($sql_upd);
                    }
                }
            }
            if(isset($data["cat_filter_new"])){
                foreach($data["cat_filter_new"] as $key=>$data_itm){
                    if(!trim($data_itm["translit"])){
                        $tr_translit=strtolower($this->rus2translit(trim($data_itm["name"])));
                    }else{
                        $tr_translit=trim($data_itm["translit"]);
                    }
                    if(isset($data_itm["step"])){
                        $step=$data_itm["step"];
                    }else{
                        $step=1;
                    }
                    //$sql="update category_params set name='".trim($data_itm["name"])."', translit='".$tr_translit."', unit='".trim($data_itm["unit"])."', type_param='".(int)$data_itm["type_param"]."',  sort_order='".(int)$data_itm["sort_order"]."', param_sort_type='".(int)$data_itm["param_sort_type"]."' where id='".(int)$key."'";
                    $sql="insert into category_params (category_id, step,  name, translit, unit, type_param, sort_order, param_sort_type) 
                    values (".(int)$category_id.", '".$step."', '".trim($data_itm["name"])."', '".trim($tr_translit)."', '".trim($data_itm["unit"])."', '".$data_itm["type_param"]."', '".$data_itm["sort_order"]."', '".$data_itm["param_sort_type"]."') ";
                    //echo $sql;
                    $this->db->query($sql);
                    $new_filter_id = $this->db->getLastId();

                    if($data_itm["type_param"]==0){
                        //print_r($data["param_value_new"][$key]);
                        if(isset($data["param_value_new"])){
                            foreach($data["param_value_new"][$key] as $itm){
                                if($itm!="remove"){
                                    $sql="INSERT INTO category_param_values (param_id, param_value) values (".(int)$new_filter_id.",'".trim($itm)."')";
                                    $this->db->query($sql);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    public function addCategory($data)
    {
        if(!isset($data['isseo'])){
            $data['isseo']=0;
        }
        if(!isset($data['isbrand'])){
            $data['isbrand']=0;
        }
        if(!isset($data['notshowisseo'])){
            $data['notshowisseo']=0;
        }
        if(!isset($data['bottom_text'])){
            $data['bottom_text']='';
        }

        $this->db->query("INSERT INTO " . DB_PREFIX . "category SET parent_id = '" . (int) $data['parent_id'] . "', `top` = '" . (isset($data['top']) ? (int) $data['top'] : 0) . "', `column` = '" . (int) $data['column'] . "', sort_order = '" . (int) $data['sort_order'] . "', status = '" . (int) $data['status'] . "', isseo = '" . (int) $data['isseo'] . "',isbrand = '" . (int) $data['isbrand'] . "', discount = '" . (int) $data['discount'] . "', notshowisseo = '" . (int) $data['notshowisseo'] . "', calc = '" . (int) $data['calc'] . "', date_modified = NOW(), date_added = NOW()");

        $category_id = $this->db->getLastId();

        if (isset($data['image'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "category SET image = '" . $this->db->escape($data['image']) . "' WHERE category_id = '" . (int) $category_id . "'");
        }
        
        foreach ($data['category_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "category_description SET category_id = '" . (int) $category_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', bottom_text = '" . $this->db->escape($value['bottom_text']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
        }

        // MySQL Hierarchical Data Closure Table Pattern
        $level = 0;

        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $data['parent_id'] . "' ORDER BY `level` ASC");

        foreach ($query->rows as $result) {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET `category_id` = '" . (int) $category_id . "', `path_id` = '" . (int) $result['path_id'] . "', `level` = '" . (int) $level . "'");

            $level++;
        }

        $this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET `category_id` = '" . (int) $category_id . "', `path_id` = '" . (int) $category_id . "', `level` = '" . (int) $level . "'");

        if (isset($data['category_filter'])) {
            foreach ($data['category_filter'] as $filter_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "category_filter SET category_id = '" . (int) $category_id . "', filter_id = '" . (int) $filter_id . "'");
            }
        }

        if (isset($data['category_store'])) {
            foreach ($data['category_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int) $category_id . "', store_id = '" . (int) $store_id . "'");
            }
        }

        // Set which layout to use with this category
        if (isset($data['category_layout'])) {
            foreach ($data['category_layout'] as $store_id => $layout_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "category_to_layout SET category_id = '" . (int) $category_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout_id . "'");
            }
        }

        if (isset($data['keyword'])) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int) $category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
        }
        $this->setParamValues($category_id,$data);


        $this->cache->delete('category');
        return $category_id;
    }

    public function editCategory($category_id, $data)
    {
        //print_r($data);
        if(!isset($data['isseo'])){
            $data['isseo']=0;
        }
        if(!isset($data['isbrand'])){
            $data['isbrand']=0;
        }
        if(!isset($data['notshowisseo'])){
            $data['notshowisseo']=0;
        }

        if(!isset($data['discount'])){
            $data['discount']=0;
        }
        if(!isset($data['calc'])){
            $data['calc']=0;
        }

        if(!isset($data['bottom_text'])){
            $data['bottom_text']='';
        }
        $this->db->query("UPDATE " . DB_PREFIX . "category SET parent_id = '" . (int) $data['parent_id'] . "', `top` = '" . (isset($data['top']) ? (int) $data['top'] : 0) . "', `column` = '" . (int) $data['column'] . "', sort_order = '" . (int) $data['sort_order'] . "', status = '" . (int) $data['status'] . "', isseo = '" . (int) $data['isseo'] . "', isbrand = '" . (int) $data['isbrand'] . "', discount = '" . (int) $data['discount'] . "', notshowisseo = '" . (int) $data['notshowisseo'] . "', calc = '" . (int) $data['calc'] . "', date_modified = NOW() WHERE category_id = '" . (int) $category_id . "'");

        if (isset($data['image'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "category SET image = '" . $this->db->escape($data['image']) . "' WHERE category_id = '" . (int) $category_id . "'");
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int) $category_id . "'");

        foreach ($data['category_description'] as $language_id => $value) {
            //$this->db->query("INSERT INTO " . DB_PREFIX . "category_description SET category_id = '" . (int) $category_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
            $this->db->query("INSERT INTO " . DB_PREFIX . "category_description SET category_id = '" . (int) $category_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', bottom_text = '" . $this->db->escape($value['bottom_text']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
        }
        if(isset($data['product_search_update'])){
            foreach($data['product_search_update'] as $key=>$product_search_flag){
                if($product_search_flag){
                    //echo "product_id=".$key."=".$data["product_search"][$key];
                    $sql_search_update="UPDATE " . DB_PREFIX . "product_description set search='".$data["product_search"][$key]."' where product_id=".$key;
                    //echo $sql_search_update;
                    $this->db->query($sql_search_update);
                    //$this->db->query("UPDATE " . DB_PREFIX . "oc_product_description where pru ");

                }
            }
        }

        /*
        if($data['change_search']){
            foreach($data['product_search'] as $product_search_id){
                
            }
        }
        */

        // MySQL Hierarchical Data Closure Table Pattern
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE path_id = '" . (int) $category_id . "' ORDER BY level ASC");

        if ($query->rows) {
            foreach ($query->rows as $category_path) {
                // Delete the path below the current one
                $this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $category_path['category_id'] . "' AND level < '" . (int) $category_path['level'] . "'");

                $path = array();

                // Get the nodes new parents
                $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $data['parent_id'] . "' ORDER BY level ASC");

                foreach ($query->rows as $result) {
                    $path[] = $result['path_id'];
                }

                // Get whats left of the nodes current path
                $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $category_path['category_id'] . "' ORDER BY level ASC");

                foreach ($query->rows as $result) {
                    $path[] = $result['path_id'];
                }

                // Combine the paths with a new level
                $level = 0;

                foreach ($path as $path_id) {
                    $this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int) $category_path['category_id'] . "', `path_id` = '" . (int) $path_id . "', level = '" . (int) $level . "'");

                    $level++;
                }
            }
        } else {
            // Delete the path below the current one
            $this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $category_id . "'");

            // Fix for records with no paths
            $level = 0;

            $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $data['parent_id'] . "' ORDER BY level ASC");

            foreach ($query->rows as $result) {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int) $category_id . "', `path_id` = '" . (int) $result['path_id'] . "', level = '" . (int) $level . "'");

                $level++;
            }

            $this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int) $category_id . "', `path_id` = '" . (int) $category_id . "', level = '" . (int) $level . "'");
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int) $category_id . "'");

        if (isset($data['category_filter'])) {
            foreach ($data['category_filter'] as $filter_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "category_filter SET category_id = '" . (int) $category_id . "', filter_id = '" . (int) $filter_id . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int) $category_id . "'");

        if (isset($data['category_store'])) {
            foreach ($data['category_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int) $category_id . "', store_id = '" . (int) $store_id . "'");
            }
        }

        /**Преимущества */
        $this->db->query("DELETE FROM dopinfo_benefits_to_product WHERE product_id = '" . (int) $category_id . "'");
        //print_r($data);
        if (isset($data['product_benefit'])) {
            foreach ($data['product_benefit'] as $benefit_id) {
                $this->db->query("INSERT INTO dopinfo_benefits_to_product SET product_id = '" . (int) $category_id . "', benefit_id = '" . (int) $benefit_id . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int) $category_id . "'");

        if (isset($data['category_layout'])) {
            foreach ($data['category_layout'] as $store_id => $layout_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "category_to_layout SET category_id = '" . (int) $category_id . "', store_id = '" . (int) $store_id . "', layout_id = '" . (int) $layout_id . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int) $category_id . "'");

        if ($data['keyword']) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int) $category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
        }
        $this->setParamValues($category_id,$data);
        

        if($data['products_change']){
            //print_r($data['products']);
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE main_category=0 and category_id ='" . (int) $category_id . "'");
            //echo "DELETE FROM " . DB_PREFIX . "product_to_category WHERE main_category=0 and category_id ='" . (int) $category_id . "'";
            $cats_str=$data['products'];
            $cats=explode(",",$cats_str);
            foreach($cats as $cat){
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category 
                (category_id,product_id,main_category) 
                values ('".$category_id."','".($cat*1)."','0')"); 
            }
        }


        $this->cache->delete('category');
    }
    public function productsByCategory($category_id){
        $query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product_to_category WHERE category_id = '" . (int) $category_id . "'");        
        return $query->rows;
    }
    public function deleteCategory($category_id)
    {
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "category_path WHERE category_id = '" . (int) $category_id . "'");

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int) $category_id . "'");

        foreach ($query->rows as $result) {
            $this->deleteCategory($result['category_id']);
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "category WHERE category_id = '" . (int) $category_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int) $category_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int) $category_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int) $category_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int) $category_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE category_id = '" . (int) $category_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int) $category_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "coupon_category WHERE category_id = '" . (int) $category_id . "'");

        $this->cache->delete('category');
       
    }

    public function repairCategories($parent_id = 0)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category WHERE parent_id = '" . (int) $parent_id . "'");

        foreach ($query->rows as $category) {
            // Delete the path below the current one
            $this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $category['category_id'] . "'");

            // Fix for records with no paths
            $level = 0;

            $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $parent_id . "' ORDER BY level ASC");

            foreach ($query->rows as $result) {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int) $category['category_id'] . "', `path_id` = '" . (int) $result['path_id'] . "', level = '" . (int) $level . "'");

                $level++;
            }

            $this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int) $category['category_id'] . "', `path_id` = '" . (int) $category['category_id'] . "', level = '" . (int) $level . "'");

            $this->repairCategories($category['category_id']);
        }
    }

    public function getCategory($category_id)
    {
        $query = $this->db->query("SELECT DISTINCT *, (SELECT GROUP_CONCAT(cd1.name ORDER BY level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (cp.path_id = cd1.category_id AND cp.category_id != cp.path_id) WHERE cp.category_id = c.category_id AND cd1.language_id = '" . (int) $this->config->get('config_language_id') . "' GROUP BY cp.category_id) AS path, (SELECT DISTINCT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int) $category_id . "') AS keyword FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (c.category_id = cd2.category_id) WHERE c.category_id = '" . (int) $category_id . "' AND cd2.language_id = '" . (int) $this->config->get('config_language_id') . "'");

        return $query->row;
    }

    //@task move to override??? а по кэшу у меня в конфиге событие,может в конфиге лучше?
  
    public function afterAddCategory($data, $category_id)
    {
        $this->setIsFinal($category_id, $data);   
    }
 
    public function afterEditCategory($category_id, $data)
    {
        $this->setIsFinal($category_id, $data);    
    }

    private function setIsFinal($category_id, $data)
    {
        $isfinal = false;
        if( isset( $data['isfinal'] ) ) {
            $isfinal = (boolean)$data['isfinal'];
        }
        $sql = "update " . DB_PREFIX . "category set isfinal = :isfinal where category_id = :id"; 
        $res = $this->db->query($sql, [':id'=>$category_id, ':isfinal'=>$isfinal]);

        return $res;
    }

    public function getCategoriesByParentId($parent_id = 0)
    {

        $query = $this->db->query("SELECT *, (SELECT COUNT(parent_id) FROM " . DB_PREFIX . "category WHERE parent_id = c.category_id) AS children FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.parent_id = '" . (int) $parent_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name");
        return $query->rows;
    }

    //@task move to override, isfinal added, pathname filter, isfinal filter added
    public function getCategories($data = array())
    {
        $sql = "SELECT c1.isseo, c1.isbrand, c1.isfinal, cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') AS name, c1.parent_id, c1.sort_order, c1.status,(select count(product_id) as product_count from " . DB_PREFIX . "product_to_category pc where pc.category_id = c1.category_id) as product_count FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c1 ON (cp.category_id = c1.category_id) LEFT JOIN " . DB_PREFIX . "category c2 ON (cp.path_id = c2.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (cp.path_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (cp.category_id = cd2.category_id) WHERE cd1.language_id = '" . (int) $this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int) $this->config->get('config_language_id') . "'";

        if (!empty($data['filter_name'])) {
            $sql .= " AND cd2.name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
        }

        if ( isset($data['filter_isfinal']) && true === $data['filter_isfinal'] ) {
            $sql .= " AND c1.isfinal = 1 "; 
        }

        $sql .= " GROUP BY cp.category_id";

        if (!empty($data['filter_path_name'])) {
            $sql .= " HAVING name LIKE '%" . $this->db->escape($data['filter_path_name']) . "%'";
        }

        $sort_data = array(
            'product_count',
            'name',
            'sort_order'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY sort_order";
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

    public function getCategoryDescriptions($category_id)
    {
        $category_description_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int) $category_id . "'");

        foreach ($query->rows as $result) {
            $category_description_data[$result['language_id']] = array(
                'name' => $result['name'],
                'meta_title' => $result['meta_title'],
                'meta_h1' => $result['meta_h1'],
                'meta_description' => $result['meta_description'],
                'meta_keyword' => $result['meta_keyword'],
                'description' => $result['description'],
                'bottom_text' => $result['bottom_text']
            );
        }

        return $category_description_data;
    }

    public function getCategoryPath($category_id)
    {
        $query = $this->db->query("SELECT category_id, path_id, level FROM " . DB_PREFIX . "category_path WHERE category_id = '" . (int) $category_id . "'");

        return $query->rows;
    }

    public function getCategoryFilters($category_id)
    {
        $category_filter_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int) $category_id . "'");

        foreach ($query->rows as $result) {
            $category_filter_data[] = $result['filter_id'];
        }

        return $category_filter_data;
    }

    public function getCategoryStores($category_id)
    {
        $category_store_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int) $category_id . "'");

        foreach ($query->rows as $result) {
            $category_store_data[] = $result['store_id'];
        }

        return $category_store_data;
    }

    public function getCategoryLayouts($category_id)
    {
        $category_layout_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int) $category_id . "'");

        foreach ($query->rows as $result) {
            $category_layout_data[$result['store_id']] = $result['layout_id'];
        }

        return $category_layout_data;
    }

    public function getTotalCategories()
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category");

        return $query->row['total'];
    }

    public function getAllCategories()
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "'  ORDER BY c.parent_id, c.sort_order, cd.name");

        $category_data = array();
        foreach ($query->rows as $row) {
            $category_data[$row['parent_id']][$row['category_id']] = $row;
        }

        return $category_data;
    }

    public function getTotalCategoriesByLayoutId($layout_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category_to_layout WHERE layout_id = '" . (int) $layout_id . "'");

        return $query->row['total'];
    }
    public function listCatalog(){
		$sql="SELECT oc.category_id, oc.parent_id, oc.top, od.name
		FROM oc_category oc
		LEFT JOIN oc_category_description od ON oc.category_id=od.category_id
		where oc.isseo=0 order by oc.sort_order";
		$query = $this->db->query($sql);
		return $query->rows;
	}
    public function listProducts(){
        $results=[];
		$sql="select op.product_id, op.sort_order, od.name, od.search, oc.category_id, op.status 
        from oc_product op LEFT JOIN oc_product_description od ON op.product_id=od.product_id
        LEFT JOIN oc_product_to_category oc ON op.product_id=oc.product_id
        where oc.main_category=1 order by op.sort_order ASC";
        $query = $this->db->query($sql);
        foreach($query->rows as $row){
            $results[$row['category_id']][]=$row;
        }
        return $results;
	}
}
