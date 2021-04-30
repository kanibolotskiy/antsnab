<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Product
 * @added Выводится либо список категорий либо список продуктов в зависимости от типа категории (isfinal)
 */

namespace WS\Override\Controller\Site\Product;

use WS\Override\Gateway\FinalCategory;
use WS\Patch\Helper\ProductListHelper;
use WS\Override\Gateway\ProdProperties;
use WS\Patch\Helper\PaginationHelper;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 23, 2018  9:17:39 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CategoryController extends \Controller
{

    private $data;
    public function showmore()
    {   
        
        
        if (isset($this->request->get['cat_path'])) {
            $parts = explode('_', (string) $this->request->get['cat_path']);
            $category_id = (int) array_pop($parts);
        } else {
            $category_id = 0;
        }
      
        if(isset($this->request->get["limit"])){
            if($this->request->get["limit"]=="all"){
                $limit=999999;
            }else{
                $limit=$this->request->get["limit"]*1;
            }            
        }else{
            $limit=(int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        }
        
        if (isset($this->request->get['page'])) {
            $page=$this->request->get['page'];
        } else {
            $page = 1;
        }
        if (isset($this->request->get['category_id'])) {
            $category_id=$this->request->get['category_id'];
        } else {
            $category_id = 0;
        }

        $this->load->model('catalog/product');

        $get_data=$this->request->get;
        $get_data["catalog_id"]=$category_id;
        $param_data=$this->parseUrlParams($get_data);

        $added_url_str="";
        if(isset($get_data["param"])){
            if($get_data["param"]){
                $show_filter=true;
                foreach($get_data["param"] as $key=>$value) {
                    if(($key=="availible")or($key=="sale")){
                        $added_url_str.="&param[".$key."]=1";
                    }else{
                        foreach($value as $item_key=>$item){
                            $added_url_str.="&param[".$key."][".$item_key."]=".$item;
                        }
                    }   
                }
            }
        }
        
        $data["result"]["tp"]=1;
        $data["result"]["items"]=$param_data["products"];
        $data["result"]["total"]=$param_data["products_count"];
        $data["result"]["itemsPerPage"]=$limit;
        $data["result"]["page"]=$page;
        
        $queryString = $this->request->get['cat_path'];//$this->hierarhy->getPath($category_id);
        if (isset($get_data['sort'])) {
            $queryString .= '&sort=' . $get_data['sort'];
        }
        $queryString.=$added_url_str;



        if($limit!=18){
            $queryString.='&limit='.$limit;
        }

        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

        $paginationModel = PaginationHelper::getPaginationModel($param_data["products_count"], (int)$limit, (int)$page);
        $data["result"]["pagination"] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
        $data["result"]["showMore"] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl."&category_id=".$category_id, $paginationModel);
       
        
        $lazyLoadResponse=json_encode($data);
        $this->response->setOutput($lazyLoadResponse);
        
    }
    public function ajaxRefreshParams(){ 

        $post_data=$this->request->post;
        $param_data=$this->parseUrlParams($post_data);
        $added_url_str="";
        $added_url="";
        $added_url_lazy="";
        
        //print_r($post_data);
        //$limit=(int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        if(isset($post_data["limit"])){
            if($post_data["limit"]=="all"){
                $limit=999999;
            }else{
                $limit=$post_data["limit"]*1;
            }            
        }else{
            $limit=(int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        }
        
        if(isset($post_data["param"])){
            if($post_data["param"]){
                $show_filter=true;
               
                foreach($post_data["param"] as $key=>$value) {
                    if(($key=="availible")or($key=="sale")){
                        $added_url_str.="&param[".$key."]=1";
                    }else{
                        foreach($value as $item_key=>$item){
                            $added_url_str.="&param[".$key."][".$item_key."]=".$item;
                        }
                    }   
                }
            }
        }
        
        
        $json["total"]=$param_data["products_count"];
        $json["itemsPerPage"]=$limit;
        
        $catalog_id=$post_data["catalog_id"];
        $queryString=$this->hierarhy->getPath($catalog_id);

        //$queryString = $this->request->get['cat_path'];//$this->hierarhy->getPath($category_id);
        if (isset($post_data['sort'])) {
            $queryString .= '&sort=' . $post_data['sort'];
        }
        $queryString.=$added_url_str;
        
        if($limit!=18){
            $queryString.='&limit='.$limit;
        }
        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

        
        
        $paginationModel = PaginationHelper::getPaginationModel($param_data["products_count"], (int)$limit, 1);
        $json["pagination"] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
        $json["showMore"] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl."&category_id=".$catalog_id, $paginationModel);

        $json["avail"]=$param_data["avail"];
        $json["products"]=$param_data["products"];
        $json["success"]=true;
        $this->response->setOutput(json_encode($json));

        
    }
    public function getFilterParams($category_id, $data_filter){
        $this->load->model('extension/module/category');
        $params=$this->model_extension_module_category->getParamsByCategory($category_id);
        //print_r($params);
        return $params;
    }

    private function parseUrlParams($data_url){
        
        $this->load->model('extension/module/category');
        //print_r($data_url);
        $catalog_id=$data_url["catalog_id"];
        
        $categories=$this->model_extension_module_category->allRecCategory($catalog_id,[]);
        
        $cat_list=implode(",",$categories);

        $avail_products=$this->model_extension_module_category->getAvailProductsByCategory($cat_list);
        
        //$this->model_extension_module_category->getAvailProductsByCategory($cat_list);
        $avail_products_list=implode(",",$avail_products);
        $sql_add="";
       

        $filter_param_sql=[];
        $join_tables=[];
        $result_params=[];

        $avail_params_data=$this->model_extension_module_category->availParamsByProducts($avail_products);        
        //print_r($avail_params_data);
        $avail_params_data[]=["id"=>"price","translit"=>"price","type_param"=>1];

        $avail_params_data[]=["id"=>"availible","translit"=>"availible","type_param"=>4];
        $avail_params_data[]=["id"=>"sale","translit"=>"sale","type_param"=>5];

        
        $sql_param_where=[];
        foreach($avail_params_data as $param){
            $key=$param["translit"];
            $sql_add="";
            $join_table="";
            $param_id=0;

            switch ($key){
                case "price":
                    if(isset($data_url["param"][$key]["min"])){
                        $sql_param_where[$key]["sql"][]=" AND op.price_wholesale>=".$data_url["param"][$key]["min"];
                    }
                   
                    if(isset($data_url["param"][$key]["max"])){
                        $sql_param_where[$key]["sql"][]=" AND op.price_wholesale<=".$data_url["param"][$key]["max"];
                    }
                   
                    $sql_param_where[$key]["type"]=3;
                break;
                case "availible":
                    if((isset($data_url["param"][$key]))or(isset($data_url["?param"][$key]))){
                        $sql_param_where[$key]["sql"][]=" AND quantity>0";
                    }
                    $sql_param_where[$key]["type"]=4;
                break;
                case "sale":
                    if((isset($data_url["param"][$key]))or(isset($data_url["?param"][$key]))){
                        //$sql_param_where[$key]["sql"][]=" AND price_wholesaleold>0";
                        $d_now=date("Y-m-d");
                        $sql_param_where[$key]["sql"][]=" AND (discount_percent>0 or product_id in (SELECT ap.product_id 
FROM accia_products ap LEFT JOIN accia a ON ap.accia_id=a.accia_id
where status=1 AND (DATE(date_start) <= '".$d_now."' or date_start is null) AND (DATE(date_end) >= '".$d_now."' or date_end is null)))";

                    }
                    $sql_param_where[$key]["type"]=5;
                break;
                default:
                //определить тип, создать запрос
                    //$join_tables["product_param_values"]=1;//" INNER JOIN product_param_values pv ON ";
                    $param_type=0;
                    $param_id=0;
                    $param_sort_type=0;
                    
                    foreach($avail_params_data as $avail_p){
                        if($avail_p["translit"]==$key){
                            $param_id=$avail_p["id"];
                            $param_type=$avail_p["type_param"];
                            $param_sort_type=$avail_p["param_sort_type"];
                        }
                    }
                    
                    if($param_type==1){
                        //echo "tut=".$key."<br/>";
                        $sql_param_where[$key]["type"]=1;
                        $sql_param_where[$key]["param_id"]=$param_id;
                        if(isset($data_url["param"][$key."_start"]["min"])){
                            if($param_sort_type){
                                $sql_param_where[$key]["sql"][]=" AND pv0.value1!='' AND (pv0.value1*1)>=".$data_url["param"][$key."_start"]["min"];
                            }else{
                                $sql_param_where[$key]["sql"][]=" AND pv0.value1!='' AND (pv0.value1*1)<=".$data_url["param"][$key."_start"]["min"];
                            }
                        }
                        if(isset($data_url["param"][$key."_start"]["max"])){
                            if($param_sort_type){
                                $sql_param_where[$key]["sql"][]=" AND pv0.value1!='' AND (pv0.value1*1)<=".$data_url["param"][$key."_start"]["max"];
                            }else{
                                $sql_param_where[$key]["sql"][]=" AND pv0.value1!='' AND (pv0.value1*1)<=".$data_url["param"][$key."_start"]["max"];
                            }
                        }

                        if(isset($data_url["param"][$key."_end"]["min"])){
                            if($param_sort_type){
                                $sql_param_where[$key]["sql"][]=" AND pv0.value2!='' AND (pv0.value2*1)>=".$data_url["param"][$key."_end"]["min"];
                            }else{
                                $sql_param_where[$key]["sql"][]=" AND pv0.value2!='' AND (pv0.value2*1)<=".$data_url["param"][$key."_end"]["min"];
                            }
                        }
                        if(isset($data_url["param"][$key."_end"]["max"])){
                            if($param_sort_type){
                                $sql_param_where[$key]["sql"][]=" AND pv0.value2!='' AND (pv0.value2*1)<=".$data_url["param"][$key."_end"]["max"];
                            }else{
                                $sql_param_where[$key]["sql"][]=" AND pv0.value2!='' AND (pv0.value2*1)<=".$data_url["param"][$key."_end"]["max"];
                            }
                        }

                        /*
                        if(isset($data_url["param"][$key]["min"])){
                            //echo "!".$param_sort_type."!";
                            //echo "!".$data_url["param"][$key]["min"]."!";

                            if($param_sort_type){
                                $sql_param_where[$key]["sql"][]=" AND pv0.value1!='' AND (pv0.value1*1)>=".$data_url["param"][$key]["min"];
                            }else{
                                $sql_param_where[$key]["sql"][]=" AND pv0.value1!='' AND (pv0.value1*1)<=".$data_url["param"][$key]["min"];
                            }
                        }
                       
                        if(isset($data_url["param"][$key]["max"])){
                            if($param_sort_type){
                                $sql_param_where[$key]["sql"][]=" AND pv0.value2!='' AND (pv0.value2*1)<=".$data_url["param"][$key]["max"];
                            }else{
                                $sql_param_where[$key]["sql"][]=" AND pv0.value2!='' AND (pv0.value2*1)>=".$data_url["param"][$key]["max"];
                            }
                        }
                        */
                       
                    }else{
                       
                        if($param_type==0){
                            $sql_param_where[$key]["type"]=2;
                        }else{
                            $sql_param_where[$key]["type"]=22;
                        }

                        $sql_param_where[$key]["param_id"]=$param_id;
                        
                        
                        if(isset($data_url["param"][$key])){
                            $sql_param_where[$key]["sql"][]=implode(",",$data_url["param"][$key]);
                        }

                    }
                    
                    
                break;
            }
        }

        $array_result=$avail_products;
        //print_r($sql_param_where);
        $array_by_params_product=[];
        //print_r($sql_param_where);
        foreach($sql_param_where as $key=>$param){
            //echo "!".$key."!";;
            //print_r($param);
            $products_by_param=[];
            switch ($key){
                case "price":
                    if(isset($param["sql"])){
                        
                        $sql_temp="SELECT op.product_id from oc_product op WHERE op.status=1 and op.product_id in (".$avail_products_list.") ".implode(" ", $param["sql"])." group by op.product_id";
                        $query = $this->db->query($sql_temp);
                        foreach ($query->rows as $result) {
                            $products_by_param[]=$result["product_id"];
                        }
                        $array_result=array_intersect($array_result,$products_by_param);
                        $array_by_params_product[$key]["products"]=$products_by_param;
                        $array_by_params_product[$key]["type"]=3;
                        $array_by_params_product[$key]["param_id"]=0;
                    }
                break;
                case "availible":
                    if(isset($param["sql"])){                        
                        $sql_temp="SELECT op.product_id from oc_product op WHERE op.status=1 and op.product_id in (".$avail_products_list.") ".implode(" ", $param["sql"])." group by op.product_id";
                        $query = $this->db->query($sql_temp);
                        foreach ($query->rows as $result) {
                            $products_by_param[]=$result["product_id"];
                        }
                        $array_result=array_intersect($array_result,$products_by_param);
                        $array_by_params_product[$key]["products"]=$products_by_param;
                        $array_by_params_product[$key]["type"]=4;
                        $array_by_params_product[$key]["param_id"]=0;
                    }
                break;
                case "sale":
                    if(isset($param["sql"])){
                        
                        /*Вывод товаров со скидкой */
                        $sql_temp="SELECT op.product_id from oc_product op WHERE op.status=1 and op.product_id in (".$avail_products_list.") ".implode(" ", $param["sql"])." group by op.product_id";
                        //echo $sql_temp;
                        $query = $this->db->query($sql_temp);
                        foreach ($query->rows as $result) {
                            $products_by_param[]=$result["product_id"];
                        }
                        
                        /*Вывод товаров по акциям 
                        $d_now=date("Y-m-d");
                        $sql_temp="SELECT ap.product_id FROM accia_products ap LEFT JOIN accia a ON ap.accia_id=a.accia_id where status=1 AND (DATE(date_start) <= '".$d_now."' or date_start is null) AND (DATE(date_end) >= '".$d_now."' or date_end is null)";
                        $query = $this->db->query($sql_temp);
                        foreach ($query->rows as $result) {
                            $products_by_param[]=$result["product_id"];
                        }
                        */
                        
                        $array_result=array_intersect($array_result,$products_by_param);
                        $array_by_params_product[$key]["products"]=$products_by_param;
                        $array_by_params_product[$key]["type"]=5;
                        $array_by_params_product[$key]["param_id"]=0;
                    }
                break;
                
                default:
                    //echo "key=".$key."|".$param["type"];

                    if(isset($param["sql"])){
                        if ($param["type"]==2){
                            
                            $sql_temp="SELECT op.product_id from oc_product op LEFT JOIN product_param_values pv0 ON op.product_id=pv0.product_id 
                            WHERE op.status=1 and pv0.param_id=".$param["param_id"]." AND op.product_id in (".$avail_products_list.") AND pv0.value1 IN (".implode(",",$param["sql"]).") group by op.product_id";
                            //echo "!".$sql_temp."!";
                            $query = $this->db->query($sql_temp);
                            foreach ($query->rows as $result) {
                                $products_by_param[]=$result["product_id"];
                            }
                            $array_result=array_intersect($array_result,$products_by_param);
                            $array_by_params_product[$key]["products"]=$products_by_param;
                            $array_by_params_product[$key]["type"]=$param["type"];
                            $array_by_params_product[$key]["param_id"]=$param["param_id"];
                        }
                        if ($param["type"]==22){
                                $z=0;
                                $tbls="";
                                $and="";
                                //print_r();
                                $f_array=explode(",",implode(",",$param["sql"]));
                                if($f_array){
                                    foreach($f_array as $row_sql_item){
                                        $tbls.=" LEFT JOIN product_param_values pv".$z." ON op.product_id=pv".$z.".product_id ";
                                        $and.=" AND pv".$z.".param_id=".$param["param_id"]." and pv".$z.".value1=".$row_sql_item;
                                        $z++;
                                    }
                                    $sql_temp="SELECT op.product_id from oc_product op ".$tbls." WHERE
                                    op.status=1 and op.product_id in (".$avail_products_list.") ".$and." group by op.product_id";
                                    //echo $sql_temp;
                                    $query = $this->db->query($sql_temp);
                                    foreach ($query->rows as $result) {
                                        $products_by_param[]=$result["product_id"];
                                    }
                                    $array_result=array_intersect($array_result,$products_by_param);
                                    $array_by_params_product[$key]["products"]=$products_by_param;
                                    $array_by_params_product[$key]["type"]=$param["type"];
                                    $array_by_params_product[$key]["param_id"]=$param["param_id"];    
                                }
                        }
                        if ($param["type"]==1){
                                $sql_temp="SELECT op.product_id from oc_product op 
                                LEFT JOIN product_param_values pv0 ON op.product_id=pv0.product_id 
                                LEFT JOIN category_params cp ON cp.id=pv0.param_id 
                                WHERE op.status=1 and cp.translit='".$key."' and op.product_id in (".$avail_products_list.") ".implode(" ", $param["sql"])."  group by op.product_id";
                                //echo $sql_temp;
                                $query = $this->db->query($sql_temp);
                                foreach ($query->rows as $result) {
                                    $products_by_param[]=$result["product_id"];
                                }
                                $array_result=array_intersect($array_result,$products_by_param);
                                $array_by_params_product[$key]["products"]=$products_by_param;
                                $array_by_params_product[$key]["type"]=$param["type"];
                                $array_by_params_product[$key]["param_id"]=$param["param_id"];
                        }
                        
                    }
                    
                break;
            }
        }
     
        
        foreach($avail_params_data as $param){
            $key=$param["translit"];
            $avail_pr=$avail_products;
            
            foreach($array_by_params_product as $key_compare=>$avail_param_compare){
                
                if($avail_param_compare["type"]==2){
                    if($key!=$key_compare){
                        $avail_pr=array_intersect($avail_pr,$avail_param_compare["products"]);
                    }
                }else{
                    $avail_pr=array_intersect($avail_pr,$avail_param_compare["products"]);
                }
            }

            if($param["type_param"]==2){
                $tp=0;
            }else{
                $tp=$param["type_param"];
            }
            $rez=$this->model_extension_module_category->getParamsValues($avail_pr, $param["id"], $tp);

            $result_params[$key]=Array("type"=>$param["type_param"],"result"=>$rez);
        }
       
        
        $data["avail"]=$result_params;
        $productsHelper = new ProductListHelper($this->registry);
        //print_r($array_result);
        if($array_result){
            $avail_products_final_list=implode(",",$array_result);
        }else{
            $avail_products_final_list="-1";
        }

        $filter_data=[
            "filter_category_id"=>$catalog_id,
            "product_ids"=>$avail_products_final_list,
        ];
        
        if(isset($data_url['sort'])){
            $sort_arr=explode("|",$data_url['sort']);
            if(isset($sort_arr[0])){
                $filter_data["sort"]=$sort_arr[0];
            }
            if(isset($sort_arr[1])){
                $filter_data["order"]=$sort_arr[1];
            }
        }
        if(isset($data_url["page"])){
            $page=$data_url["page"];
        }else{
            $page=1;
        }
        
        //$limit=(int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        
        if(isset($data_url["limit"])){
            if($data_url["limit"]=="all"){
                $limit=999999;
            }else{
                $limit=$data_url["limit"]*1;
            }            
        }else{
            $limit=(int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        }

        if(isset($_GET["load_pages"])){
            $limit=$limit*$_GET["load_pages"];
        }
        $filter_data['start'] = ($page - 1) * $limit;
        
        $filter_data["limit"] = $limit;
        $filter_data["filter_sub_category"]=1;

        $data_products=$productsHelper->getProducts($filter_data);
        $products_str="";
        foreach($data_products as $p){
            $data["p"]=$p;
            $products_str.=$this->load->view('partial/product_item.tpl', $data);
        }
        if($products_str){
            $data["products"] = $products_str;
        }else{
            $data["products"] = "<li class='empty_list'>Товаров по заданному критерию не найдено</li>";
        }
        //print_r($array_result);
        //echo "!".count($array_result)."!";
        $data["products_count"]=count($array_result);

        return $data;
    }
    public function index()
    {
        //echo "@ok!";
        $this->load->language('product/category');
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        $this->load->model('catalog/information');

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );
        
        if (isset($this->request->get['path'])) {
            //@removed
            $url = '';
            $path = '';
            $parts = explode('_', (string) $this->request->get['path']);
            $category_id = (int) array_pop($parts);

            
            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = (int) $path_id;
                } else {
                    $path .= '_' . (int) $path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $this->data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('product/category', 'path=' . $path . $url)
                    );
                }
                
                
            }
            
            $category_final_info = $this->model_catalog_category->getCategory($category_id);

            $catalog_page=1;
            if(isset($_GET["page"])){
                $catalog_page=$_GET["page"];
            }
            
            /*
            if(isset($_GET["limit"])){
                $limit=$_GET["limit"];
            }else{
                $limit=9;
            }
            */
            if(isset($_GET["limit"])){
                if($_GET["limit"]=="all"){
                    $limit=999999;
                }else{
                    $limit=$_GET["limit"]*1;
                }            
            }else{
                $limit=(int) $this->config->get($this->config->get('config_theme') . '_product_limit');                
            }

            $this->data['showby_9']='';
            $this->data['showby_18']='';
            $this->data['showby_all']='';

            if($limit==9){
                $this->data['showby_9']='active';
            }
            if($limit==18){
                $this->data['showby_18']='active';
            }
            if($limit=="all"){
                $this->data['showby_all']='active';
            }
            //echo "!".$limit."!";

            $bottom_text = '';
            $description = '';
            $catalogpage_notfirst=true;

            if($catalog_page==1){
                $catalogpage_notfirst=false;
                if(isset($category_final_info["bottom_text"])){
                    $bottom_text = $this->model_catalog_information->cleanText($category_final_info["bottom_text"]);
                }
                $description = $this->model_catalog_information->cleanText($category_final_info['description']);
            }
            $this->data['bottom_text'] = $bottom_text;
            $this->data['description'] = $description;
            $this->data["catalogpage_notfirst"]=$catalogpage_notfirst;

            /*
            if((isset($category_final_info["bottom_text"]))and($catalog_page==1)){
                $this->data['bottom_text'] = $this->model_catalog_information->cleanText($category_final_info["bottom_text"]);
                $this->data['description'] = html_entity_decode($category_final_info['description'], ENT_QUOTES, 'UTF-8');
            }else{
                $this->data['bottom_text'] = '';
                $this->data['description'] = '';
            }
            */
        } else {
            $category_id = 0;
        }

        $cat_view1="active";
        $cat_view2="";
        $cat_view_class="tab-block2";
        if(isset($_COOKIE["cat_view"])){
            if($_COOKIE["cat_view"]=="view2"){
                $cat_view1="";                
                $cat_view2="active";
                $cat_view_class="";
            }
        }
        $this->data["cat_view1"]=$cat_view1;
        $this->data["cat_view2"]=$cat_view2;
        $this->data["cat_view_class"]=$cat_view_class;
            
        $this->data['catalog_brand_img']='';
        if($category_final_info["isbrand"]){
            $image_brand = $this->model_tool_image->resize($category_final_info["image"], 200, 200);
            $this->data['catalog_brand_img'] = $image_brand;
        }
        
        //echo $catalog_brand

        $gateway = new FinalCategory($this->registry);
        $isCategoryFinal = $gateway->isCategoryFinal($category_id);
        $flag_is_seo=$gateway->isCategorySeo($category_id);

        $category_info = $this->model_catalog_category->getCategory($category_id);
        
        //print_r($category_info);
        if($category_info["isseo"]){
            $categories_seo = $this->model_catalog_category->getCategoresSeo($category_info["parent_id"]);
        }else{
            $categories_seo = $this->model_catalog_category->getCategoresSeo($category_id);
        }
        $this->data["category_id"]=$category_id;

        
        if (!$category_info) {
            $this->showNotFound();
            return;
        }

        $this->setCommons($category_info);
        
        $this->setFilterCategories($categories_seo,$category_id);


        /**Добавляем баннеры из акций */
        $banners=[];
        $this->load->model('catalog/sale');
		$this->data['banners'] = array();
		$activeAccias=$this->model_catalog_sale->activeAccias();
		foreach($activeAccias as $accia){
			$accia_url=$this->url->link('sale/sale', 'sale_id=' . $accia["accia_id"]);
			if($accia['banner']){
                $image=$this->model_tool_image->cropsize($accia['banner'], 1100,210);
                $img_webp=str_replace(".jpg",".webp",$image);
                $img_webp=str_replace(".png",".webp",$img_webp);
                $banners[]=array(
					'title' => $accia["title"],
					'link'  => $accia_url,
                    'image' => $image,
                    'image_webp' => $img_webp,
				);
			}
        }

        $activeAcciasDiscount=$this->model_catalog_sale->activeAcciaDiscount();
        if($activeAcciasDiscount){
            if($activeAcciasDiscount["banner"]){
                $image=$this->model_tool_image->cropsize($activeAcciasDiscount["banner"], 1100,210);
                $img_webp=str_replace(".jpg",".webp",$image);
                $img_webp=str_replace(".png",".webp",$img_webp);
                $banners[]=array(
                    'title' => $activeAcciasDiscount["title"],
                    'link'  => "sales/".$activeAcciasDiscount["keyword"]."/",
                    'image' => $image,
                    'image_webp' => $img_webp,
                );
            }
        }
        shuffle($banners);
        $this->data['banners']=$banners;
        
        if($flag_is_seo){
            $this->showProducts($category_id,true,null);
            return;
        }
        if ($isCategoryFinal) {
            $parent_category_info = $this->model_catalog_category->getCategory($category_info["parent_id"]);
            $this->showProducts($category_id,false,$parent_category_info);
            return;
        }
        $this->showCategories($category_id);
    }
   
    

    private function setFilterCategories($categories_seo, $current_id){
        $url="";
        foreach($categories_seo as $category){
            if($current_id==$category["category_id"]){
                $this->data['categories_isseo'][] = array(
                    'category_id'   => $category['category_id'],
                    'name' => $category['name'],
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $category['category_id'] . $url),
                );
            }
        }
        $this->data['categories_isseo_hidden']=[];
        
        foreach($categories_seo as $category){
            if($current_id!=$category["category_id"]){
                if(!$category['notshowisseo']){
                    $this->data['categories_isseo'][] = array(
                        'category_id'   => $category['category_id'],
                        'name' => $category['name'],
                        'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $category['category_id'] . $url),
                    );
                }else{
                    $this->data['categories_isseo_hidden'][] = array(
                        'category_id'   => $category['category_id'],
                        'name' => $category['name'],
                        'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $category['category_id'] . $url),
                    );
                }
            }
            
        }
        

    }

    private function showCategories($category_id)
    {
        $this->data['categories'] = array();
        $results = $this->model_catalog_category->getCategories($category_id);
        //@removed
        $url = '';

        foreach ($results as $result) {
            if ($result['image']) {
                //$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
                $image = $this->model_tool_image->resize($result['image'], 320, 400);
            } else {
                //$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
                $image = $this->model_tool_image->resize('placeholder.png', 320, 400);
            }

            $sub = array();
            $path = $this->hierarhy->getPath($result['category_id']);
            if( $result['isfinal'] ) {
                try {
                    $subRes = $this->hierarhy->getNodeById($result['category_id'])->get('products');
                    foreach ($subRes as $p) {
                        $sub[] = array(
                            'name' => $p['name'],
                            'href' => $this->url->link('product/product', 'path=' . $path .  '&product_id=' . $p['product_id'])
                        );
                    }
                } catch (\Exception $e ) {}
            } else {
                $subRes = $this->hierarhy->getNodeById($result['category_id'])->getChildren(); 
                
                foreach ($subRes as $c) {
                    if(!$c->get('isseo')){
                        $sub[] = array (
                            'name' => $c->get('name'),
                            'href' => $this->url->link('product/category', 'path=' . $path . '_' . $c->get('category_id') . $url)
                        );
                    }
                }
            }
            
            //$image=$this->model_tool_image->cropsize($activeAcciasDiscount["banner"], 1100,210);
            $img_webp=str_replace(".jpg",".webp",$image);
            $img_webp=str_replace(".png",".webp",$img_webp);

            $this->data['categories'][] = array(
                'name' => $result['name'],
                'thumb' => $image,
                'thumb_webp' => $img_webp,
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '...',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url),
                'sub' => $sub
            );
        }
        //$this->setPartials();
        if($category_id==71){
            $this->setPartials();
            $template_catalog='product/category_main';
        }else{
            $template_catalog='product/category';

            //$category_id=264;
            $filter_data = $this->getFilter($category_id, $limit, $page, $sort_selected, true);
            
            $this->data['sort_selected']=$sort_selected;
            $product_total = $this->model_catalog_product->getTotalProducts($filter_data);
            

            $productsHelper = new ProductListHelper($this->registry);
            
            
            $catalog_info["category_url"]=$this->url->link('product/category', 'path=' . $category_id);
            $catalog_info["category_id"]=$category_id;
            $this->data["catalog_info"]=$catalog_info;
            $this->data["params"]["items"]=$this->getFilterParams($category_id,[]);
            if(isset($this->request->get["param"])){
                $this->data["params"]["selected"]=$this->request->get["param"];
            }else{
                $this->data["params"]["selected"]=[];
            }

            $get_data=$this->request->get;
            $get_data["catalog_id"]=$category_id;
            $param_data=$this->parseUrlParams($get_data);
            //print_r($param_data);
            //print_r($get_data["param"]);
            $show_filter=false;

            $added_url_str="";
            if(isset($get_data["param"])){
                if($get_data["param"]){
                    $show_filter=true;
                    foreach($get_data["param"] as $key=>$value) {
                        if(($key=="availible")or($key=="sale")){
                            $added_url_str.="&param[".$key."]=1";
                        }else{
                            foreach($value as $item_key=>$item){
                                $added_url_str.="&param[".$key."][".$item_key."]=".$item;
                            }
                        }   
                    }
                }
            }

            $queryString = $this->hierarhy->getPath($category_id);
            if (isset($this->request->get['sort'])) {
                $queryString .= '&sort=' . $this->request->get['sort'];
            }
            $queryString.=$added_url_str;

            $this->data["show_filter"]=$show_filter;
            $this->data["avail"]=$param_data["avail"];
            $this->data["products"]=$param_data["products"];
            
            if($limit!=18){
                $queryString.='&limit='.$limit;
            }
            $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
            $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);
            
            $product_total_filter=$param_data["products_count"];
            
            $paginationModel = PaginationHelper::getPaginationModel($product_total_filter, (int)$limit, (int)$page);
            $this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
            $this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl."&category_id=".$category_id, $paginationModel);

        
            $this->setPartials();
        
        }
        $this->response->setOutput($this->load->view($template_catalog, $this->data));
    }

    private function showProducts($category_id, $showPropertyTable=false, $parent_category=null)
    {

        
        $filter_data = $this->getFilter($category_id, $limit, $page, $sort_selected, true);
        //print_r($filter_data);
        $this->data['sort_selected']=$sort_selected;
        $product_total = $this->model_catalog_product->getTotalProducts($filter_data);
        $productsHelper = new ProductListHelper($this->registry);


        $products_add=[];
        $parent_category_name='';

        if(($product_total<5) and $parent_category) {
            $filter_data_add = array(
                'filter_category_id' => $parent_category["category_id"],
                'sort' => 'viewed',
                'order' => 'DESC',
                'start' => 0,
                'limit' => 4,
                'filter_sub_category'=>1
            );
            $parent_category_name=$parent_category["name"];
            $products_add=$productsHelper->getProducts($filter_data_add);
        }
        $this->data["parent_name"]=$parent_category_name;
        $this->data["products_add"]=$products_add;

        
        
        //$this->data['products'] = $productsHelper->getProducts($filter_data);

        /** */
        $catalog_info["category_url"]=$this->url->link('product/category', 'path=' . $category_id);
        $catalog_info["category_id"]=$category_id;
        $this->data["catalog_info"]=$catalog_info;
        $this->data["params"]["items"]=$this->getFilterParams($category_id,[]);
        if(isset($this->request->get["param"])){
            $this->data["params"]["selected"]=$this->request->get["param"];
        }else{
            $this->data["params"]["selected"]=[];
        }

        $get_data=$this->request->get;
        $get_data["catalog_id"]=$category_id;
        $param_data=$this->parseUrlParams($get_data);
        //print_r($get_data["param"]);
        $show_filter=false;
        $added_url_str="";
        $added_url="";
        $added_url_lazy="";
        if(isset($get_data["param"])){
            if($get_data["param"]){
                $show_filter=true;
                //$added_url="?".http_build_query($get_data["param"]);
                //$querystring = '?'
                foreach($get_data["param"] as $key=>$value) {
                    if(($key=="availible")or($key=="sale")){
                        $added_url_str.="param[".$key."]=1&";
                    }else{
                        foreach($value as $item_key=>$item){
                            $added_url_str.="param[".$key."][".$item_key."]=".$item."&";
                        }
                    }
                }


                $added_url="?".substr($added_url_str,0,-1);
                $added_url_lazy="&".substr($added_url_str,0,-1);
            }
        }

        $this->data["show_filter"]=$show_filter;
        $this->data["avail"]=$param_data["avail"];
        $this->data["products"]=$param_data["products"];
        /** */
        
        if(!$showPropertyTable){
            //summary table
            $propGateway = new ProdProperties($this->registry);
            $this->data['summary'] = $propGateway->getSummaryTableRows($category_id);
        }

        /** Pagination */
        $queryString = $this->hierarhy->getPath($category_id);
        if (isset($this->request->get['filter'])) {
            $queryString .= '&filter=' . $this->request->get['filter'];
        }
        if (isset($this->request->get['sort'])) {
            $queryString .= '&sort=' . $this->request->get['sort'];
        }
        

        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);
        
        $product_total_filter=$param_data["products_count"];
        //$product_total_filter=14;
        //$paginationBaseUrl=$paginationBaseUrl.$added_url;
        $paginationModel = PaginationHelper::getPaginationModel($product_total_filter, (int)$limit, (int)$page);
        //$this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl.$added_url, $paginationModel);
        $this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
        //$this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $paginationBaseUrl.$added_url."&category_id=".$category_id, $paginationModel);
        $this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl.$added_url_lazy."&category_id=".$category_id, $paginationModel);

        $this->setPartials();
        //print_r($this->getFilterParams($category_id,[]));
        $this->response->setOutput($this->load->view('product/category_final', $this->data));
    }

    private function showNotFound()
    {
        $url = '';

        if (isset($this->request->get['path'])) {
            $url .= '&path=' . $this->request->get['path'];
        }

        if (isset($this->request->get['filter'])) {
            $url .= '&filter=' . $this->request->get['filter'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_error'),
            'href' => $this->url->link('product/category', $url)
        );

        $this->document->setTitle($this->language->get('text_error'));

        $this->data['heading_title'] = $this->language->get('text_error');

        $this->data['text_error'] = $this->language->get('text_error');

        $this->data['button_continue'] = $this->language->get('button_continue');

        $this->data['continue'] = $this->url->link('common/home');

        $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

        $this->setPartials();

        $this->response->setOutput($this->load->view('error/not_found', $this->data));

        exit();
    }

    private function setPartials()
    {
        $this->data['column_left'] = $this->load->controller('common/column_left');
        $this->data['column_right'] = $this->load->controller('common/column_right');
        $this->data['content_top'] = $this->load->controller('common/content_top');
        $this->data['content_bottom'] = $this->load->controller('common/content_bottom');
        $this->data['footer'] = $this->load->controller('common/footer');
        $this->data['header'] = $this->load->controller('common/header');
    }

    private function setCommons($category_info)
    {
        if ($category_info['meta_title']) {
            $this->document->setTitle($category_info['meta_title']);
        } else {
            $this->document->setTitle($category_info['name']);
        }
        $this->document->setDescription($category_info['meta_description']);
        if($category_info['meta_keyword']){
            $this->document->setKeywords($category_info['meta_keyword']);
        }else{
            $this->document->setKeywords($category_info['meta_h1']);
        }

        $catalog_page=1;
        
        if(isset($_GET["page"])){
            $catalog_page=$_GET["page"]*1;
        }
        
        if ($category_info['meta_h1']) {
            $this->data['heading_title'] = $category_info['meta_h1'];
        } else {
            $this->data['heading_title'] = $category_info['name'];
        }
        if($catalog_page>1){
            $this->data['heading_title']=$this->data['heading_title'].". Страница ".$catalog_page;
        }
        
        

        $this->data['text_refine'] = $this->language->get('text_refine');
        $this->data['text_empty'] = $this->language->get('text_empty');
        $this->data['text_quantity'] = $this->language->get('text_quantity');
        $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $this->data['text_model'] = $this->language->get('text_model');
        $this->data['text_price'] = $this->language->get('text_price');
        $this->data['text_tax'] = $this->language->get('text_tax');
        $this->data['text_points'] = $this->language->get('text_points');
        $this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
        $this->data['text_sort'] = $this->language->get('text_sort');
        $this->data['text_limit'] = $this->language->get('text_limit');

        $this->data['button_cart'] = $this->language->get('button_cart');
        $this->data['button_wishlist'] = $this->language->get('button_wishlist');
        $this->data['button_compare'] = $this->language->get('button_compare');
        $this->data['button_continue'] = $this->language->get('button_continue');
        $this->data['button_list'] = $this->language->get('button_list');
        $this->data['button_grid'] = $this->language->get('button_grid');

        // Set the last category breadcrumb
        $this->data['breadcrumbs'][] = array(
            'text' => $category_info['name'],
            'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'])
        );

        if ($category_info['image']) {
            $this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            $this->document->setOgImage($this->data['thumb']);
        } else {
            $this->data['thumb'] = '';
        }

        //$this->data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
        //$this->data['compare'] = $this->url->link('product/compare');
    }

    private function getFilter($category_id, &$limit, &$page = 1 , &$sort_selected = 0, $filter_sub_category=0)
    {
        if (isset($this->request->get['filter'])) {
            $filter = $this->request->get['filter'];
        } else {
            $filter = '';
        }

    
        $sort = '';
        $order = '';
        $sort_selected="";
        if (isset($this->request->get['sort'])) {
            $sort_selected=$this->request->get['sort'];

            $sort_arr=explode("|",$this->request->get['sort']);
            if((isset($sort_arr[0]))and(isset($sort_arr[1]))){
                $sort=$sort_arr[0];
                $order=$sort_arr[1];
            }
        }
        
        if (isset($this->request->get['page'])) {
            if($this->request->get['page']){
                $page = ($this->request->get['page'])*1;
            }else{
                $page=1;
            }
        } else {
            $page = 1;
        }

        /*
        if (isset($this->request->get['limit'])) {
            $limit = (int) $this->request->get['limit'];
        } else {
            $limit = (int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        }
        */
        if(isset($this->request->get["limit"])){
            if($this->request->get["limit"]=="all"){
                $limit=999999;
            }else{
                $limit=$this->request->get["limit"]*1;
            }            
        }else{
            $limit=(int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        }
        
        
        if (isset($this->request->get['load_pages'])) {
            $end = (int) $this->request->get['load_pages'];
        }else{
            $end = 1;
        }
        
        $filter_data = array(
            'filter_category_id' => $category_id,
            'filter_filter' => $filter,
            'sort' => $sort,
            'order' => $order,
            'start' => ($page - 1) * $limit,
            'limit' => $end*$limit,
            'filter_sub_category'=>$filter_sub_category
        );
        
        return $filter_data;
    }
}
