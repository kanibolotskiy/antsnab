<?php
namespace WS\Override\Controller\Site\Extension\Module;
use BlueM\Tree\Node as Node;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CategoryController extends \Controller
{
    private static $openedItems;

    private function parseUrlParams($data_url){
        //print_r($data_url);
        $this->load->model('extension/module/category');
        //print_r($data_url);
        $catalog_id=$data_url["catalog_id"];
        
        $categories=$this->model_extension_module_category->allRecCategory($catalog_id,[]);
        
        $cat_list=implode(",",$categories);

        $avail_products=$this->model_extension_module_category->getAvailProductsByCategory($cat_list);
        //print_r($avail_products);
        $sql_add="";
        //echo "!catalog_id=".$catalog_id."!";

        $filter_param_sql=[];
        $join_tables=[];
        $result_params=[];
        if($catalog_id and isset($data_url["param"])){
            $avail_params=Array(
                ["id"=>0,"translit"=>"price","type_param"=>1],
            );
            $avail_params_data=$this->model_extension_module_category->availParamsByProducts($avail_products);
            foreach($avail_params_data as $itm){
                $avail_params[]=[
                    "id"=>$itm["id"],
                    "translit"=>$itm["translit"],
                    "type_param"=>$itm["type_param"],
                    "param_sort_type"=>$itm["param_sort_type"]
                ];
            }
            //print_r($avail_params);
            foreach($avail_params as $param){
                $key=$param["translit"];
                $sql_add="";
                $join_table="";
                $param_id=0;
                
                //$data_url_item=$data_url["param"][$key];

                switch ($key){
                    case "price":
                        if(isset($data_url["param"][$key]["min"])){
                            $sql_add.= " AND op.price>=".$data_url["param"][$key]["min"];
                        }
                        if(isset($data_url["param"][$key]["max"])){
                            $sql_add.=" AND op.price<=".$data_url["param"][$key]["max"];
                        }
                        $type_sql=3;
                    break;
                    case "manufacturer":

                    break;
                    default:
                    //определить тип, создать запрос
                    //$join_tables["product_param_values"]=1;//" INNER JOIN product_param_values pv ON ";
                    
                    $sql="select id, type_param, param_sort_type from category_params where translit='".$key."'";
                    $query = $this->db->query($sql);
                    $result = $query->row;
                    $param_id=$result["id"];

                    $join_table=" INNER JOIN product_param_values pv".$result["id"]." ON op.product_id=pv".$result["id"].".product_id";
                    
                    if($result["type_param"]){
                        if(isset($data_url["param"][$key]["min"])){
                            $sql_add.= " AND pv".$result["id"].".value1>=".$data_url["param"][$key]["min"];
                        }
                        if(isset($data_url["param"][$key]["max"])){
                            $sql_add.=" AND pv".$result["id"].".value2<=".$data_url["param"][$key]["max"];
                        }
                        $type_sql=2;
                    }else{
                        if(isset($data_url["param"][$key])){
                            $sql_add.= " AND pv".$result["id"].".param_id=".$result["id"]." AND pv".$result["id"].".value1 IN (".implode(",",$data_url["param"][$key]).")";
                        }
                        $type_sql=$result["param_sort_type"];
                        //pv1.param_id=1 and pv1.value1 in (19,20,21)
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
            
            foreach($avail_params as $param){
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
                    }
                }

                $sql="SELECT op.product_id from oc_product op ".$table_a." WHERE
                op.status=1 ".$sql_a." group by op.product_id";
                $query = $this->db->query($sql);
                $avail_products=[];
                foreach ($query->rows as $result) {
                    $avail_products[]=$result["product_id"];
                }
                $rez=$this->model_extension_module_category->getParamsValues($avail_products, $param_id, $sql_type);
                $result_params[$key]=Array("type"=>$param["type_param"],"result"=>$rez);
            }
        }
        return $result_params;
    }
    public function ajaxRefreshParams(){ 
        $json["avail"]=$this->parseUrlParams($this->request->post);
        $json["success"]=true;
        $this->response->setOutput(json_encode($json));
    }
    public function getFilterParams($category_id, $data_filter){
        $this->load->model('extension/module/category');
        $params=$this->model_extension_module_category->getParamsByCategory($category_id);        
        //print_r($params);
        return $params;
    }

    public function index()
    {
        
        $this->load->language('extension/module/category');
		$data['heading_title'] = $this->language->get('heading_title');

		$parts = array();
        $data['category_id'] = ROOT_CATEGORY_ID;
        $data['root'] = $this->url->link('product/category', 'path=' . ROOT_CATEGORY_ID);

        if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
			$data['category_id'] = array_pop($parts); 
		}

        $data['openeditems'] = self::$openedItems = $parts;
        $data['openeditems'][] = $data['category_id'];
       
        $data['categories'] = [];
        foreach(  $this->hierarhy->getRootNodes() as $node ) {
            $item = $node->toArray();
            $item['href'] = $this->url->link('product/category', 'path=' . $this->hierarhy->getPath($node->getId())); 
            $item['child'] = $this->recursiveGetItems($node);
            
            if(!$item['isseo']){
                $data['categories'][] = $item;
            }
        }
        //print_r($data['categories']);
        $data["catalog_info"]=[
            'category_id'=>$data['category_id'],
            'category_url'=>$this->url->link('product/category', 'path=' . $data['category_id']),
        ];
        $data["params"]=$this->getFilterParams($data['category_id'],[]);;        
        return $this->load->view('extension/module/app/category', $data);
    }

    private function recursiveGetItems(Node $rootNode)
    {
        $categories = [];
        foreach( $rootNode->getChildren() as $node ) {
            $item = $node->toArray();
            if(!$item['isseo']){
                $item['href'] = $this->url->link('product/category', 'path=' . $this->hierarhy->getPath($node->getId()));
                if( in_array($node->getId(), self::$openedItems) ) {
                    $item['child'] = $this->recursiveGetItems($node);    
                }
                
                $categories[] = $item;
            }
        }
                
        return $categories;
    }

}
