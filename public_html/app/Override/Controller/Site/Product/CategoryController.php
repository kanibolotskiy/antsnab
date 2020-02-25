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
    public function ajaxRefreshParams(){ 
        /*
        $data=$this->parseUrlParams($this->request->post);
        $json["avail"]=$data["avail"];
        $json["products"]=$data["products"];
        //$paginationModel = PaginationHelper::getPaginationModel($product_total, (int)$limit, (int)$page);
        //$this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
        //$this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl, $paginationModel);
        
        //$this->data['products'] = $productsHelper->getProducts($filter_data);
        $json["success"]=true;
        $this->response->setOutput(json_encode($json));
*/
        

        $post_data=$this->request->post;
        $param_data=$this->parseUrlParams($post_data);
        //print_r($post_data);
        $added_url_str="";
        $added_url="";
        $added_url_lazy="";
        $limit=9;
        if(isset($post_data["param"])){
            if($post_data["param"]){
                $show_filter=true;
                foreach($post_data["param"] as $key=>$value) {
                    foreach($value as $item_key=>$item){
                        $added_url_str.="param[".$key."][".$item_key."]=".$item."&";
                    }
                }
            }
        }
        if(isset($post_data["?param"])){
            if($post_data["?param"]){
                $show_filter=true;
                foreach($post_data["?param"] as $key=>$value) {
                    foreach($value as $item_key=>$item){
                        $added_url_str.="param[".$key."][".$item_key."]=".$item."&";
                    }
                }
            }
        }
        
        $added_url="?".substr($added_url_str,0,-1);
        $added_url_lazy="&".substr($added_url_str,0,-1);

        //echo "!".$added_url."!";
        $json["total"]=$param_data["products_count"];
        $json["itemsPerPage"]=$limit;
        
        $catalog_id=$post_data["catalog_id"];
        $queryString=$this->hierarhy->getPath($catalog_id);

        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

        $paginationModel = PaginationHelper::getPaginationModel($param_data["products_count"], (int)$limit, 1);
        $json["pagination"] = PaginationHelper::render($this->registry, $paginationBaseUrl.$added_url, $paginationModel);
        $json["showMore"] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl.$added_url_lazy."&category_id=".$catalog_id, $paginationModel);

        //print_r($post_data);
        //$queryString=$this->hierarhy->getPath($category_id);
        
        /*
        $data["result"]["page"]=$page;
        //$data["result"]["paginationBaseUrl"] = $paginationBaseUrl;
        //$data["result"]["lazyLoadBaseUrl"] = $lazyLoadBaseUrl;
    
        $queryString = $this->request->get['cat_path'];//$this->hierarhy->getPath($category_id);
        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

        $paginationModel = PaginationHelper::getPaginationModel($param_data["products_count"], (int)$limit, (int)$page);
        $data["result"]["pagination"] = PaginationHelper::render($this->registry, $paginationBaseUrl.$added_url, $paginationModel);
        $data["result"]["showMore"] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl.$added_url_lazy."&category_id=".$category_id, $paginationModel);
        */
        $json["avail"]=$param_data["avail"];
        $json["products"]=$param_data["products"];
        $json["success"]=true;
        $this->response->setOutput(json_encode($json));

        
    }
    public function getFilterParams($category_id, $data_filter){
        $this->load->model('extension/module/category');
        $params=$this->model_extension_module_category->getParamsByCategory($category_id);        
        return $params;
    }

    private function parseUrlParams($data_url){
        
        $this->load->model('extension/module/category');
        //print_r($data_url);
        $catalog_id=$data_url["catalog_id"];
        
        $categories=$this->model_extension_module_category->allRecCategory($catalog_id,[]);
        
        $cat_list=implode(",",$categories);

        $avail_products=$this->model_extension_module_category->getAvailProductsByCategory($cat_list);
        $avail_products_list=implode(",",$avail_products);
        $sql_add="";
       

        $filter_param_sql=[];
        $join_tables=[];
        $result_params=[];

        $avail_params_data=$this->model_extension_module_category->availParamsByProducts($avail_products);
        $avail_params_data[]=["id"=>0,"translit"=>"price","type_param"=>1];

        foreach($avail_params_data as $param){
            $key=$param["translit"];
            $sql_add="";
            $join_table="";
            $param_id=0;
            switch ($key){
                case "price":
                    if(isset($data_url["param"][$key]["min"])){
                        $sql_add.= " AND op.price_wholesale>=".$data_url["param"][$key]["min"];
                    }
                    if(isset($data_url["?param"][$key]["min"])){
                        $sql_add.= " AND op.price_wholesale>=".$data_url["?param"][$key]["min"];
                    }

                    if(isset($data_url["param"][$key]["max"])){
                        $sql_add.=" AND op.price_wholesale<=".$data_url["param"][$key]["max"];
                    }
                    if(isset($data_url["?param"][$key]["max"])){
                        $sql_add.=" AND op.price_wholesale<=".$data_url["?param"][$key]["max"];
                    }
                    $type_sql=3;
                break;
                default:
                //определить тип, создать запрос
                    //$join_tables["product_param_values"]=1;//" INNER JOIN product_param_values pv ON ";
                    
                    $sql="select id, type_param, param_sort_type from category_params where translit='".$key."'";
                    $query = $this->db->query($sql);
                    $result = $query->row;
                    $param_id=$result["id"];

                    $join_table=" LEFT JOIN product_param_values pv".$result["id"]." ON op.product_id=pv".$result["id"].".product_id";
                    
                    if($result["type_param"]){
                        if(isset($data_url["param"][$key]["min"])){
                            $sql_add.= " AND pv".$result["id"].".param_id=".$result["id"]." AND pv".$result["id"].".value1>=".$data_url["param"][$key]["min"];
                        }
                        if(isset($data_url["?param"][$key]["min"])){
                            $sql_add.= " AND pv".$result["id"].".param_id=".$result["id"]." AND pv".$result["id"].".value1>=".$data_url["?param"][$key]["min"];
                        }

                        if(isset($data_url["param"][$key]["max"])){
                            $sql_add.=" AND pv".$result["id"].".param_id=".$result["id"]." AND pv".$result["id"].".value2<=".$data_url["param"][$key]["max"];
                        }
                        if(isset($data_url["?param"][$key]["max"])){
                            $sql_add.=" AND pv".$result["id"].".param_id=".$result["id"]." AND pv".$result["id"].".value2<=".$data_url["?param"][$key]["max"];
                        }

                        $type_sql=2;
                    }else{
                        $arr_temp_str="";
                        if(isset($data_url["param"][$key])){
                            //$arr_temp=$data_url["param"][$key];
                            $arr_temp_str=implode(",",$data_url["param"][$key]);

                            //$sql_add.= " AND pv".$result["id"].".param_id=".$result["id"]." AND pv".$result["id"].".value1 IN (".implode(",",$data_url["param"][$key]).")";
                        }
                        if(isset($data_url["?param"][$key])){
                            $arr_temp_str=($arr_temp_str?$arr_temp_str.",":"").implode(",",$data_url["?param"][$key]);
                            //array_push ($arr_temp, $data_url["?param"][$key]);
                            //$sql_add.= " AND pv".$result["id"].".param_id=".$result["id"]." AND pv".$result["id"].".value1 IN (".implode(",",$data_url["?param"][$key]).")";
                        }
                        //print_r($arr_temp);
                        if($arr_temp_str){
                            $sql_add.= " AND pv".$result["id"].".param_id=".$result["id"]." AND pv".$result["id"].".value1 IN (".$arr_temp_str.")";
                        }
                        //echo $sql_add;
                        $type_sql=$result["param_sort_type"];
                    }
                    
                    
                break;
            }

            $filter_param_sql[$key]=[
                "sql"=>$sql_add,
                "table"=>$join_table,
                "type_sql"=>$type_sql,
                "param_id"=>$param_id
            ];

        }
        
        $final_sql="";
        $final_table="";
        foreach($avail_params_data as $param){
            $key=$param["translit"];
            $sql_add="";
            $join_table="";
            //$param_id=0;

            $sql_a="";
            $table_a="";
    
            foreach($filter_param_sql as $sql_key=>$sql_item){
                if($sql_key!=$key){
                    $sql_a.=$sql_item["sql"];
                    $table_a.=$sql_item["table"];
                }
                else{
                    $sql_type=$sql_item["type_sql"];
                    $param_id=$sql_item["param_id"];

                    $final_sql.=$sql_item["sql"];
                    $final_table.=$sql_item["table"];
                    
                }
            }
            
            $sql="SELECT op.product_id from oc_product op ".$table_a." WHERE
            op.status=1 ".$sql_a." and op.product_id in (".$avail_products_list.") group by op.product_id";
            

            $query = $this->db->query($sql);
            $avail_products=[];
            foreach ($query->rows as $result) {
                $avail_products[]=$result["product_id"];
            }
            $rez=$this->model_extension_module_category->getParamsValues($avail_products, $param_id, $sql_type);
            $result_params[$key]=Array("type"=>$param["type_param"],"result"=>$rez);
        }
        $sql_final_products="SELECT op.product_id from oc_product op ".$final_table." WHERE
        op.status=1 ".$final_sql." and op.product_id in (".$avail_products_list.") group by op.product_id";
        //echo $sql_final_products;
        $query = $this->db->query($sql_final_products);
        $avail_products_final=[];
        

        foreach ($query->rows as $result) {
            $avail_products_final[]=$result["product_id"];
        }
        if($avail_products_final){
            $avail_products_final_list=implode(",",$avail_products_final);
        }else{
            $avail_products_final_list="-1";
        }
        //print_r($avail_products_final_list);

        $data["avail"]=$result_params;
        $productsHelper = new ProductListHelper($this->registry);
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
        
        $limit=(int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        $filter_data['start'] = ($page - 1) * $limit;
        $filter_data["limit"] = $limit;
        $filter_data["filter_sub_category"]=1;
        
        //$data_products
        //print_r($filter_data);
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
        $data["products_count"]=count($avail_products_final);
        
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

            if((isset($category_final_info["bottom_text"]))and($catalog_page==1)){
                $this->data['bottom_text'] = $this->model_catalog_information->cleanText($category_final_info["bottom_text"]);
                $this->data['description'] = html_entity_decode($category_final_info['description'], ENT_QUOTES, 'UTF-8');
            }else{
                $this->data['bottom_text'] = '';
                $this->data['description'] = '';
            }
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
            $image_brand = $this->model_tool_image->resize($category_final_info["image"], 100, 100);
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

        
        if($flag_is_seo){
            $this->showProducts($category_id,true,null);
            return;
        }
        if ($isCategoryFinal) {
            $parent_category_info = $this->model_catalog_category->getCategory($category_info["parent_id"]);
            $this->showProducts($category_id,false,$parent_category_info);
            return;
        }
        /*
        if($data['category_id']==ROOT_CATEGORY_ID){
            $this->data["params"]=[];
        }else{
            $this->data["params"]=$this->getFilterParams($data['category_id'],[]);
        }
        */
        

        $this->showCategories($category_id);
    }
   
    public function showmore()
    {   
        
        /*
        if (isset($this->request->get['cat_path'])) {
            $parts = explode('_', (string) $this->request->get['cat_path']);
            $category_id = (int) array_pop($parts);
        } else {
            $category_id = 0;
        }
        */
        $limit=9;
        if (isset($this->request->get['page'])) {
            //$parts = explode('_', (string) $this->request->get['cat_path']);
            //$category_id = (int) array_pop($parts);
            $page=$this->request->get['page'];
        } else {
            $page = 1;
        }
        if (isset($this->request->get['category_id'])) {
            //$parts = explode('_', (string) $this->request->get['cat_path']);
            //$category_id = (int) array_pop($parts);
            $category_id=$this->request->get['category_id'];
        } else {
            $category_id = 0;
        }

        $this->load->model('catalog/product');

        $get_data=$this->request->get;
        $get_data["catalog_id"]=$category_id;
        $param_data=$this->parseUrlParams($get_data);

        //print_r($param_data);
        //$this->data["products"]=$param_data["products"];
        //$lazyLoadResponse=$param_data["products"];
        
        $added_url_str="";
        $added_url="";
        $added_url_lazy="";
        if(isset($get_data["param"])){
            if($get_data["param"]){
                $show_filter=true;
                foreach($get_data["param"] as $key=>$value) {
                    foreach($value as $item_key=>$item){
                        $added_url_str.="param[".$key."][".$item_key."]=".$item."&";
                    }
                }
                $added_url="?".substr($added_url_str,0,-1);
                $added_url_lazy="&".substr($added_url_str,0,-1);
            }
        }

        $data["result"]["tp"]=1;
        $data["result"]["items"]=$param_data["products"];
        $data["result"]["total"]=$param_data["products_count"];
        $data["result"]["itemsPerPage"]=$limit;
        $data["result"]["page"]=$page;
        //$data["result"]["paginationBaseUrl"] = $paginationBaseUrl;
        //$data["result"]["lazyLoadBaseUrl"] = $lazyLoadBaseUrl;

        
        $queryString = $this->request->get['cat_path'];//$this->hierarhy->getPath($category_id);
        
        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

        $paginationModel = PaginationHelper::getPaginationModel($param_data["products_count"], (int)$limit, (int)$page);
        $data["result"]["pagination"] = PaginationHelper::render($this->registry, $paginationBaseUrl.$added_url, $paginationModel);
        $data["result"]["showMore"] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl.$added_url_lazy."&category_id=".$category_id, $paginationModel);
/**/
        //    'total' => (int)$products_total,
        //    'itemsPerPage' => (int)$limit,
        //    'page' => (int)$page,
        //    'paginationBaseUrl' => $paginationBaseUrl,
        //    'lazyLoadBaseUrl' => $lazyLoadBaseUrl,

        /*
        $paginationModel = PaginationHelper::getPaginationModel($product_total_filter, (int)$limit, (int)$page);
        $this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl.$added_url, $paginationModel);
        //$this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $paginationBaseUrl.$added_url."&category_id=".$category_id, $paginationModel);
        $this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl.$added_url_lazy."&category_id=".$category_id, $paginationModel);
        */

        $lazyLoadResponse=json_encode($data);

        /*
        $filter_data = $this->getFilter($category_id, $limit, $page, $sort_selected, true);
        //$filter_data = $this->getFilter($category_id, $limit, $page, 0, true);
        $products_total = $this->model_catalog_product->getTotalProducts($filter_data)
        $productsHelper = new ProductListHelper($this->registry);
        /**
        $products = $productsHelper->getProducts($filter_data,true);
        /*


        $queryString = $this->hierarhy->getPath($category_id);
        if (isset($this->request->get['filter'])) {
            $queryString .= '&filter=' . $this->request->get['filter'];
        }
        if (isset($this->request->get['sort'])) {
            $queryString .= '&sort=' . $this->request->get['sort'];
        }
        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

        $items = [];
        foreach( $products as $p ){
            $items[] = $this->load->view("partial/product_item", ['p'=>$p]);
        }

        $lazyLoadResponse = PaginationHelper::getLazyLoadResponse($this->registry, [
            'items' => $items, 
            'total' => (int)$products_total,
            'itemsPerPage' => (int)$limit,
            'page' => (int)$page,
            'paginationBaseUrl' => $paginationBaseUrl,
            'lazyLoadBaseUrl' => $lazyLoadBaseUrl,
        ]); 

        /*
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
        $added_url="";
        if(isset($get_data["param"])){
            if($get_data["param"]){
                $show_filter=true;
                //$added_url="?".http_build_query($get_data["param"]);
                //$querystring = '?'
                foreach($get_data["param"] as $key=>$value) {
                    //echo "!".$key."!";
                    foreach($value as $item_key=>$item){
                        //echo "*".$item."*";
                        $added_url.="param[".$key."][".$item_key."]=".$item."&";
                    }
                }
                $added_url="?".substr($added_url,0,-1);
            }
        }

        $this->data["show_filter"]=$show_filter;
        $this->data["avail"]=$param_data["avail"];
        $this->data["products"]=$param_data["products"];

        /** */

        $this->response->setOutput($lazyLoadResponse);
        
    }

    private function setFilterCategories($categories_seo, $current_id){
        $url="";
        foreach($categories_seo as $category){
            if((!$category['notshowisseo']) or ($current_id==$category["category_id"])){
                $this->data['categories_isseo'][] = array(
                    'category_id'   => $category['category_id'],
                    'name' => $category['name'],
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $category['category_id'] . $url)
                );
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
                $image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
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
            

            $this->data['categories'][] = array(
                'name' => $result['name'],
                'thumb' => $image,
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
            
            /*
            $queryString = $this->hierarhy->getPath($category_id);
            if (isset($this->request->get['filter'])) {
                $queryString .= '&filter=' . $this->request->get['filter'];
            }
            if (isset($this->request->get['sort'])) {
                $queryString .= '&sort=' . $this->request->get['sort'];
            }
            $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
            $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

            $paginationModel = PaginationHelper::getPaginationModel($product_total, (int)$limit, (int)$page);
            $this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
            $this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl, $paginationModel);
            */

            /** */
            $queryString = $this->hierarhy->getPath($category_id);
            if (isset($this->request->get['filter'])) {
                $queryString .= '&filter=' . $this->request->get['filter'];
            }
            if (isset($this->request->get['sort'])) {
                $queryString .= '&sort=' . $this->request->get['sort'];
            }
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
                    //echo "!".$key."!";
                    foreach($value as $item_key=>$item){
                        //echo "*".$item."*";
                        $added_url_str.="param[".$key."][".$item_key."]=".$item."&";
                    }
                }
                $added_url="?".substr($added_url_str,0,-1);
                $added_url_lazy="&".substr($added_url_str,0,-1);
            }
        }

        $this->data["show_filter"]=$show_filter;
        $this->data["avail"]=$param_data["avail"];
        $this->data["products"]=$param_data["products"];
        

        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);
        
        $product_total_filter=$param_data["products_count"];
        //$product_total_filter=14;

        //$paginationBaseUrl=$paginationBaseUrl.$added_url;
        $paginationModel = PaginationHelper::getPaginationModel($product_total_filter, (int)$limit, (int)$page);
        $this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl.$added_url, $paginationModel);
        //$this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $paginationBaseUrl.$added_url."&category_id=".$category_id, $paginationModel);
        $this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl.$added_url_lazy."&category_id=".$category_id, $paginationModel);

        /** */
            $this->setPartials();
            
            if ($page == 1) {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_id, true), 'canonical');
            } elseif ($page == 2) {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_id, true), 'prev');
            } else {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_id . '?page='. ($page - 1), true), 'prev');
            }
            
            if ($limit && ceil($product_total / $limit) > $page) {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_id . '?page='. ($page + 1), true), 'next');
            }
            
            
            //$catalog_info["category_url"]=$this->url->link('product/category', 'path=' . $category_id);
            //$catalog_info["category_id"]=$category_id;
            //$this->data["catalog_info"]=$catalog_info;
            //$this->data["params"]=$this->getFilterParams($category_id,[]);
            //$this->data['products'] = $productsHelper->getProducts($filter_data);
        }
        $this->response->setOutput($this->load->view($template_catalog, $this->data));
    }

    private function showProducts($category_id, $showPropertyTable=false, $parent_category=null)
    {

        $filter_data = $this->getFilter($category_id, $limit, $page, $sort_selected, true);
        
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

        //print_r($filter_data);
        
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
                    //echo "!".$key."!";
                    foreach($value as $item_key=>$item){
                        //echo "*".$item."*";
                        $added_url_str.="param[".$key."][".$item_key."]=".$item."&";
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
        $this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl.$added_url, $paginationModel);
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

        if (isset($this->request->get['limit'])) {
            $limit = (int) $this->request->get['limit'];
        } else {
            $limit = (int) $this->config->get($this->config->get('config_theme') . '_product_limit');
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
