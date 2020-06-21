<?php
    class ModelExtensionModuleCategory extends Model{
        public function getProductParams($product_id){
            $query = $this->db->query("select * from product_param_values where product_id=".(int)$product_id);
            return $query->rows;
        }
        public function getListParamsByCategory($category_id){    
            //echo "!"."SELECT * from category_params where category_id=".(int)$category_id." order by sort_order"."!";
            $query = $this->db->query("SELECT * from category_params where category_id=".(int)$category_id." order by sort_order");
            return $query->rows;
        }

        public function allRecCategory($category_id,$data){
            $data[]=$category_id;
            $query = $this->db->query("SELECT category_id, isfinal from oc_category where isseo=0 AND parent_id=".(int)$category_id);
            foreach ($query->rows as $result) {
                $data[]=$result["category_id"];
                if(!$result['isfinal']){
                    $data=$this->allRecCategory($result['category_id'], $data);
                }
            }
            return $data;
        }

        //public function getParamsValues($used_products, $param_id, $sql_type, $type_param){
        public function getParamsValues($used_products, $param_id, $sql_type){
            //type1
            //echo $param_id."|".$sql_type."<br/>";
            $used_products_list=implode(",",$used_products);
            $param_list=[];
            if($used_products_list){
                switch ($sql_type) {
                    case 0: //Список, сортировка по релевантности
                        $sql="SELECT value1, count(op.product_id), cv.param_value 
                        FROM `product_param_values` pv 
                        INNER JOIN category_param_values cv ON cv.id=pv.value1 
                        INNER JOIN oc_product op ON op.product_id=pv.product_id
                        WHERE op.product_id in (".$used_products_list.") AND pv.param_id=".(int)$param_id." and op.status=1
                        group by value1 order by count(op.product_id) DESC";

                        $query = $this->db->query($sql);
                        foreach ($query->rows as $result) {

                            $param_list[$result["value1"]]=$result["param_value"];
                        }
                    break;
                    
                    case 1: //Список, сортировка по алфавиту
                        $sql="SELECT value1, count(op.product_id), cv.param_value 
                        FROM `product_param_values` pv 
                        INNER JOIN category_param_values cv ON cv.id=pv.value1 
                        INNER JOIN oc_product op ON op.product_id=pv.product_id
                        WHERE op.product_id in (".$used_products_list.") AND pv.param_id=".(int)$param_id." and op.status=1
                        group by value1 order by CAST(cv.param_value AS SIGNED) , cv.param_value";
                        

                        $query = $this->db->query($sql);
                        foreach ($query->rows as $result) {
                            $param_list[$result["value1"]]=$result["param_value"];
                        }
                    break;
                    

                    case 2: //Диапазон
                        $sql="SELECT min(value1) as min,max(value2) as max FROM `product_param_values` pv WHERE product_id in (".$used_products_list.") AND pv.param_id=".(int)$param_id;

                        $sql="SELECT min(value1*1) as min, max(value2*1) as max 
                        FROM `product_param_values` pv 
                        INNER JOIN oc_product op ON pv.product_id=op.product_id
                        WHERE op.product_id in (".$used_products_list.") AND op.status=1 AND pv.param_id=".(int)$param_id;

                        $query = $this->db->query($sql);
                        $result=$query->row;
                        $param_list["min"]=$result["min"];
                        $param_list["max"]=$result["max"];
                    break;
                        
                    case 3: //Цены
                        $sql="SELECT min(price_wholesale*1) as min, max(price_wholesale*1) as max FROM oc_product op WHERE product_id in (".$used_products_list.") AND op.status=1";
                        $query = $this->db->query($sql);
                        $result=$query->row;
                        $param_list["min"]=floor($result["min"]);
                        $param_list["max"]=ceil($result["max"]);
                    break;
                    
                    case 4: //Наличие
                        $sql="SELECT count(product_id) as count_sale FROM oc_product op WHERE product_id in (".$used_products_list.") AND op.status=1 and (quantity*1)>0";
                        $query = $this->db->query($sql);
                        $result=$query->row;
                        $param_list["count"]=$result["count_sale"];
                    break;

                    case 5: //Скидки
                        $d_now=date("Y-m-d");

                        $sql="SELECT count(product_id) as count_sale FROM oc_product op WHERE product_id in (".$used_products_list.") AND op.status=1 AND (discount_percent>0 or product_id in (SELECT ap.product_id FROM accia_products ap LEFT JOIN accia a ON ap.accia_id=a.accia_id where status=1 AND (DATE(date_start) <= '".$d_now."' or date_start is null) AND (DATE(date_end) >= '".$d_now."' or date_end is null)))";
                        $query = $this->db->query($sql);
                        $result=$query->row;
                        $param_list["count"]=$result["count_sale"];
                    break;
                    
                }
                

            }
            return $param_list;

        }
        public function getAvailProductsByCategory($cat_list){
            
            $used_products=[];
            $sql_products="SELECT oc.product_id from oc_product_to_category oc 
            where oc.category_id in (".$cat_list.") group by oc.product_id";
            $query = $this->db->query($sql_products);
            foreach ($query->rows as $result) {
                $used_products[]=$result["product_id"];
            }
            return $used_products;
            
        }
        public function availParamsByProducts($used_products){            
            $sql="SELECT cp.id,cp.translit,cp.type_param,cp.param_sort_type from product_param_values pv
            INNER JOIN category_params cp ON pv.param_id=cp.id
            where product_id in (".implode(",",$used_products).") group by cp.id";
            $query = $this->db->query($sql);
            return $query->rows;
        }
        /*
        public function availAvailibleByProducts($used_products){            
            $sql="SELECT product_id from oc_product
            where product_id in (".implode(",",$used_products).") group by cp.id";
            $query = $this->db->query($sql);
            return $query->rows;
        }*/
        public function getParamsByCategory($category_id){
            $categories=[];
            $categories=$this->allRecCategory($category_id,$categories);
            $out=[];
            if($categories){
                $cat_list=implode(",",$categories);
                $used_products=$this->getAvailProductsByCategory($cat_list);

                if(count($used_products)){
                    //Цена
                    $out[]=[
                        "id"=>"price_id",
                        "name"=>"Цена",
                        "translit"=>"price",
                        "unit"=>html_entity_decode('<div class="rur">i</div>'),
                        "type_param"=>1,
                        "param_sort_type"=>0,
                        "avail_params"=>$this->getParamsValues($used_products,null,3),
                        "step"=>1
                    ];
                    
                    $avail_avail=$this->getParamsValues($used_products,null,4);
                    
                    //Наличие
                    if($avail_avail["count"]>0){
                        $out[]=[
                            "id"=>"availible_id",
                            "name"=>"Наличие",
                            "translit"=>"availible",
                            "unit"=>"",
                            "type_param"=>4,
                            "param_sort_type"=>0,
                            "avail_params"=>[1=>"только в наличии"]
                        ];
                    }
                    //print_r($avail_avail);
                    $avail_sale=$this->getParamsValues($used_products,null,5);
                    if($avail_sale["count"]>0){
                        $out[]=[
                            "id"=>"sale_id",
                            "name"=>"Скидки",
                            "translit"=>"sale",
                            "unit"=>"",
                            "type_param"=>5,
                            "param_sort_type"=>0,
                            "avail_params"=>[1=>"скидки и акции"]
                        ];
                    }

                    //Доступные параметры по категории
                    $sql="SELECT cp.* from oc_product_to_category oc 
                    INNER JOIN product_param_values pv ON oc.product_id=pv.product_id 
                    INNER JOIN category_params cp ON pv.param_id=cp.id 
                    where oc.category_id in (".$cat_list.") group by cp.id ORDER BY cp.sort_order";
                    $query = $this->db->query($sql);
                    foreach ($query->rows as $result) {
                        //echo $result[""]."<br/>";
                        $avail_params=[];
                        
                        //echo $result["id"]."|".$result["type_param"]."|<br/>";

                        if($result["type_param"]==1){  //Дипазон
                            $avail_params=$this->getParamsValues($used_products,$result["id"],2);
                        }else{                      //Список
                            //echo $result["id"]."|".$result["param_sort_type"]."<br/>";
                            $avail_params=$this->getParamsValues($used_products,$result["id"],$result["param_sort_type"]);
                        }

                        $out[]=[
                            "id"=>$result["id"],
                            "name"=>html_entity_decode($result["name"]),
                            "translit"=>$result["translit"],
                            "unit"=>html_entity_decode($result["unit"]),
                            "type_param"=>$result["type_param"],
                            "param_sort_type"=>$result["param_sort_type"],
                            "avail_params"=>$avail_params,
                            "step"=>$result["step"]*1,
                        ];
                    }
                }
                
            }
            return $out;
        }
    }
?>