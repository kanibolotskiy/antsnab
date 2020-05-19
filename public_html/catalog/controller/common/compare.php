<?php
use Phospr\Fraction;
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;
use WS\Override\Gateway\ProdProperties; 
use WS\Patch\Helper\QueryHelper;

class ControllerCommonCompare extends Controller {
	public function index() {
        $this->document->setNoindex(true);
        $this->load->model('catalog/information');
        $this->load->model('catalog/product');
        $this->load->model('catalog/category');
        $this->load->model('tool/image');
        $this->load->model('extension/module/category');
        
        $this->load->language('product/product');
        
        /*
        <meta name="robots" content="noindex, nofollow"/>
        */
        //$this->document->setMeta('');
        $data['noindex'] = true;

        //Сравнение товаров
        $favorite_page=$this->model_catalog_product->getDocsData(7);
        $ttl=$favorite_page["name"];
        $data=[];
        
		$this->load->language('common/favorite');
        $this->document->setTitle($ttl);
        $data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/compare'),
			'text' => $ttl
        );
        

        $this->document->setNoindex(true);
        //$data['heading_title'] = $this->language->get('heading_title');
        
        $data['heading_title'] = $ttl;
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $products_arr=[];
        $comp_items_str="";
        if(isset($_GET["comp_items"])){
            $products_arr=explode(",",$_GET["comp_items"]);
            $comp_items_str=$_GET["comp_items"];
        }else{
            if(isset($_COOKIE["compare"])){
                $products_arr=json_decode($_COOKIE["compare"]);
                if(is_array($products_arr)){
                    $comp_items_str=implode(",",$products_arr);
                }
            }
        }
        
        $data['comp_items']=$comp_items_str;
        $data['favorite_content']=$this->model_catalog_information->cleanText($favorite_page["description"]);
        
        //Значения параметров
        $param_values_result=$this->model_catalog_product->getCategoryParamsValues();        
        //print_r($param_values_result);
        $list_properties=[];
        foreach($products_arr as $product_item){
            
            $product=$this->model_catalog_product->getProduct($product_item);

            if ($product['image']) {
                $image = $this->model_tool_image->myResize($product['image'], 400, 400,2);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', 400, 400);
            }

            $main_category_id=$this->model_catalog_product->getMainCategory($product["category_id"]);
            //$category_info = $this->model_catalog_category->getCategory($product["category_id"]);
            
            //$data['quantity_stock']=$product['quantity'];
            if ($product['quantity'] > 0) {
                $data_stock = "В наличии";
            }else{
                $data_stock = "Под заказ";
            }

            //produnits - единицы измерения
            $produnitsGateway = new ProdUnits($this->registry);
            $produnitsCalcGateway = new ProdUnitsCalc($this->registry);
            $prodUnits = $produnitsGateway->getUnitsByProduct($product['product_id']);
            $weight=1;
            foreach ($prodUnits as $unit_id => $unit) {
                if (0 != $unit['switchSortOrder']) {
                    if($unit["isPackageBase"]){
                        $weight=$unit["weight"];
                    }
                }
            }
            //print_r($prodUnits);

            //Доставка//
            $delivery_info = $this->model_catalog_product->getDelivery($product['product_id'],$weight);
            //print_r($delivery_info);
            $delivery_str=$delivery_info["date_delivery"].", ".$delivery_info["price_delivery"];
            /*
            print_r($product);
            print_r($delivery_info["date_delivery"]);
            print_r($delivery_info["price_delivery"]);
            */
            
            $prodPropertiesGateway = new ProdProperties($this->registry);
            $properties = $prodPropertiesGateway->getPropertiesWithProductValues($product['product_id'], 'order by sortOrder ASC');
            
            $item_properties=[];
            foreach($properties as $property){
                if(!$property["prod_hide"]){
                    //$list_properties[$main_category_id][$property["cat_name"]]=$property["cat_name"];
                    $list_properties[$main_category_id][$property["cat_name"]]=$property["cat_name"];
                    $item_properties[$property["cat_name"]]=htmlspecialchars_decode($property['val'],ENT_QUOTES).($property['cat_unit']?" (".$property['cat_unit'].")":"");
                }
            }
            //print_r($item_properties);
            
            
            
            $fav_product[$main_category_id][$product['product_id']]=Array(
                "product_id"=>$product['product_id'],
                "produnit_template_id"=>$product["produnit_template_id"],
                "name"=>$product["name"],
                "price"=>number_format($product["price_wholesale"],0,".", " "),
                "image"=>$image,
                "href"=>$this->url->link('product/product', '&product_id=' . $product['product_id']),
                "data_stock"=>$data_stock,
                "properties"=>$item_properties,
                "delivery"=>$delivery_str
            );
            //echo $product["product_id"]."<br/>";
            //$price = number_format($price_val,0,".", " ");
        }
        
        $favorite_products=[];
        $pack_list=[];
        foreach($fav_product as $key_catalog=>$fav_product_catalog){
            //Все параметры для категории
            $category_params=$this->model_extension_module_category->getListParamsByCategory($key_catalog);

            $avail_params_by_cat=[];
            foreach($category_params as $category_param){
                $avail_params_by_cat[$category_param["id"]]=$category_param;
                $avail_params_by_cat[$category_param["id"]]["used"]=false;
                
            }
            
            $final_fav_product_catalog=[];
            
            foreach($fav_product_catalog as $favorite_product){
                $product_params=$this->model_extension_module_category->getProductParams($favorite_product['product_id']);

                //print_r($favorite_product);
                //echo "!".$favorite_product['produnit_template_id']."!";
                $stringsGateway = new ProdUnitStrings($this->registry);
                $data_packageStrings = $stringsGateway->getAll($favorite_product['produnit_template_id'], 'order by sortOrder');
                $params_pack=[];    
                foreach($data_packageStrings as $pack_item){
                    $unit_desc=trim($pack_item["description"]);
                    $pack_list[$key_catalog][$unit_desc]=1;
                    $params_pack[$unit_desc]=$pack_item["value"];
                }

                //print_r($data_packageStrings);
                
                $params=[];
                $str_param="";
                foreach($product_params as $product_param){
                    if(isset($avail_params_by_cat[$product_param["param_id"]])){
                        $avail_params_by_cat[$product_param["param_id"]]["used"]=true;

                        $type_param=$avail_params_by_cat[$product_param["param_id"]]["type_param"];

                        switch ($type_param){
                            case 0: //Список       
                                $str_param=$param_values_result[$product_param["value1"]];
                                //$str_param=$product_param["value1"];
                            break;

                            case 1: //Диапазон
                                $str_param="от ".$product_param["value1"]." до ".$product_param["value2"];
                            break;

                            case 2: //Список(тип2)
                                $str_param=$param_values_result[$product_param["value1"]];
                            break;
                        }
                        $params[$product_param["param_id"]][]=$str_param;
                    }
                }
                $params_final=[];
                foreach($params as $key=>$param){
                    if($param){
                        //sort($param);
                        $params_final[$key]=implode(", ",$param);
                    }
                }
                
                $favorite_product["compare_filter"]=$params_final;
                $favorite_product["params_pack"]=$params_pack;

                $final_fav_product_catalog[]=$favorite_product;
            }
            //print_r($pack_list);
            $category_info = $this->model_catalog_category->getCategory($key_catalog);
            
            $favorite_products[]=Array(
                "name"=>$category_info["name"],
                "catalog_id"=>$key_catalog,//$main_category_id,
                "category_params"=>$avail_params_by_cat,
                "pack_list"=>$pack_list,
                "properties"=>$list_properties,
                "products"=>$final_fav_product_catalog,
                //"compare_filter"=>$compare_filter,
            );
        }
        
        

        $data['favorite_products']=$favorite_products;
        

        $this->load->language('catalog/product');

        //$data["catalog_captions"]=Array(name:"");
        /*
        $produnitsGateway = new ProdUnits($this->registry);
        $produnitsCalcGateway = new ProdUnitsCalc($this->registry);
        $propGateway = new ProdProperties($this->registry);
        $data['products']=[];
        
        if($products_arr){
            foreach($products_arr as $itm){
                
                $product=$this->model_catalog_product->getProduct($itm);
                //print_r($product);
                $properties = $propGateway->getPropertiesWithProductValues($product['product_id'], 'order by sortOrder ASC');
                $previewProperties = array();
                foreach ($properties as $p) {
                    if ($p['showInProdPreview']) {
                        $previewProperties[] = array(
                            'name' => $p['cat_name'],
                            'val' => htmlspecialchars_decode($p['val'],ENT_QUOTES),
                            'unit' => $p['cat_unit']
                        );
                    }
                }

                //$step=1;
                //$mincount=1;
                $produnitsGateway = new ProdUnits($this->registry);
                $produnitsCalcGateway = new ProdUnitsCalc($this->registry);
                $propGateway = new ProdProperties($this->registry);
                $prodUnits = $produnitsGateway->getUnitsByProduct($product['product_id']);
                $priceUnit = null;
                
                foreach ($prodUnits as $unit_id => $unit) {
                    if ($unit['isPriceBase'] == 1 && !$priceUnit) {
                        $priceUnit = $unit;
                        //коэффициент пересчета из базовой еденицы продажи (кратности) в еденицы учета (цены)
                        $saleToPriceKoef = $produnitsCalcGateway->getBaseToUnitKoef($product['product_id'], 'isSaleBase', $unit_id);
                    } elseif ($unit['isPriceBase'] == 1) {
                        throw new \Exception('Too many price bases for product ' . $product['product_id']);
                    }
                    if (0 != $unit['switchSortOrder']) {
                        $key = (int)$unit['switchSortOrder'];

                        
                        $saleToUIKoef = $produnitsCalcGateway->getBaseToUnitKoef($product['product_id'], 'isSaleBase', $unit_id);
                        $array_koef = (array) $saleToUIKoef;
                        $z=0;
                        $koef_numerator=1;
                        $koef_denomirator=1;
                        foreach($array_koef as $koef_item){
                            if($z){
                                $koef_denomirator=$koef_item;
                            }else{
                                $koef_numerator=$koef_item;
                            }
                            $z++;
                        }
                        $pUnits[$key]['nom']=$koef_numerator;
                        $pUnits[$key]['denom']=$koef_denomirator;

                        $koef_d=$koef_numerator/$koef_denomirator;
                        if($product['quantity']>0){
                            $pUnits[$key]['mincount']=ceil(1*$koef_d);
                        }else{
                            $pUnits[$key]['mincount']=ceil($product['mincount']*$koef_d);
                        }

                    }                    
                }
    
                $step=1;
                $mincount=1;
        
                
                if (isset($pUnits[2])){
                
                    if (( $product['quantity']<=0) and ($pUnits[2]['denom']>$pUnits[2]['nom']) ){
                        $step = $pUnits[2]['denom'];
                        
                        if($pUnits[1]['mincount']<$pUnits[2]['denom']){
                            $mincount = $pUnits[2]['denom'];
                        }else{
                            $mincount = $pUnits[1]['mincount'];
                        }
                    }else{
                        $mincount = $pUnits[1]['mincount'];
                    }

                }else{
                    $mincount = $pUnits[1]['mincount'];
                }

                

                if (!$priceUnit) {
                    throw new \Exception('Price base wasnt found for product ' . $product['product_id']);
                }

                $wholesale_threshold_in_saleUnits = Fraction::fromFloat((float)$product['wholesale_threshold']); 
                $wholesale_threshold = $wholesale_threshold_in_saleUnits->multiply($saleToPriceKoef)->toFloat(); 

                if ($product['image']) {
                    //$image = $this->model_tool_image->resize($product['image'], 120,120);
                    $image = $this->model_tool_image->resize($product['image'], 240,240);
                } else {
                    $image = '';
                }
                
                $saleUnit_price = (float)$this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
                $price = $this->currency->format($saleUnit_price, $this->session->data['currency']);

                $saleUnit_price_wholesale = (float)$this->tax->calculate($product['price_wholesale'], $product['tax_class_id'], $this->config->get('config_tax'));
                $price_wholesale = $this->currency->format($saleUnit_price_wholesale, $this->session->data['currency']);

                
                //@added @task
                $prodQuantity =(float)$product['quantity'];
                if ($prodQuantity >= $wholesale_threshold) {
                    $rowTotal = $saleUnit_price_wholesale * $prodQuantity; 
                    $isWholesale = true;
                    $total = $this->currency->format($rowTotal, $this->session->data['currency']);
                } else {
                    $rowTotal = $saleUnit_price * $prodQuantity; 
                    $isWholesale = false;
                    $total = $this->currency->format($rowTotal, $this->session->data['currency']);
                }

                
                //$price = $product['price'];

                $data['products'][] = array(
                    'product_id' => $itm,
                    'thumb' => $image,
                    'name' => $product['name'],

                    
                    'meta_h1' => $product['meta_h1'],
                    'model' => $product['model'],
                    'quantity' => $mincount,
                    
                    'price_val'=>$product['price'],
                    'price_wholesale_val'=>$product['price_wholesale'],
                    'price' => $price,
                    'price_wholesale' => $price_wholesale,
                    'priceold' => $product['priceold'],
                    'price_wholesaleold' => $product['price_wholesaleold'],

                    'isWholesale' => $isWholesale,
                    'wholesale_threshold' => $product['wholesale_threshold'],
                    'total' => number_format($mincount*$saleUnit_price,0,"."," "),
                    'priceUnit'=> $priceUnit,
                    'saleToPriceKoef' => $saleToPriceKoef,
                    'location' => html_entity_decode($product['description_mini']),
                    'properties' => $previewProperties,
                    'href' => $this->url->link('product/product', 'product_id=' . $product['product_id']),
                    'mincount'=>$mincount,
                    'step'=>$step
                );

            }
        }
        //
        */
        echo $this->load->view('common/compare', $data);
        //return $this->load->view('common/favorite', $data);
        
	}

	public function info() {
        $this->response->setOutput($this->index());
	}
}
