<?php
use WS\Override\Gateway\ProdTabs;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;
use WS\Override\Gateway\ProdProperties;
class ControllerLandingProduct extends Controller {
    public function index(){
        $this->load->model('landing/landing');
        $this->load->model('module/referrer');
        $this->load->model('tool/image');
        $this->load->model('catalog/product');
        

        $contact_data_referrer=$this->model_module_referrer->getContactsReferrer();
        
 
        if (isset($this->request->get['landing_id'])) {
			$landing_id = (int)$this->request->get['landing_id'];
		} else {
			$landing_id = 0;
		}
        
        $url = ((!empty($_SERVER['HTTPS'])) ? 'https' : 'http') . '://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
        $url = explode('?', $url);
        $url = rtrim($url[0],"/");
        $path_arr=explode("/",$url);
        $alias=$path_arr[count($path_arr)-1];
        $m_alias=str_replace("lp-","",$alias);
        $product_id_str=$this->model_landing_landing->landingProductID($m_alias);
        $product_id=0;
        if($product_id_str){
            $product_id=str_replace("product_id=","",$product_id_str);
        }

        
        
        $landing_alias=$this->model_landing_landing->getLandingAlias($landing_id);
        
        $product_data=$this->model_landing_landing->getProductFullInfo($product_id);
        $landing_data=$this->model_landing_landing->getLandingInfo($landing_id);
        
        $contact_data_referrer['url']=$landing_alias."/".$alias;
        $contact_data_referrer['image']=$product_data['image'];
        $contact_data_referrer['logotext']=$landing_data['logotext'];
        
        $data['product_id']=$product_id;
        $data['sku']=$product_data['sku'];

        $data['landing_alias']=$landing_alias;

        if(isset($product_data['data_lp'])){
            $data_lp=json_decode(str_replace(array("\r\n", "\n", "\r"),'',$product_data['data_lp']),JSON_UNESCAPED_UNICODE);
        }else{
            $data_lp=[];
        }
        if(isset($data_lp['product_lp_title']) and $data_lp['product_lp_title']){
            $contact_data_referrer['meta_title']=$data_lp['product_lp_title'];
        }else{
            $contact_data_referrer['meta_title']=$product_data['meta_title'];
        }
        if(isset($data_lp['product_lp_desc']) and $data_lp['product_lp_desc']){
            $contact_data_referrer['meta_description']=$data_lp['product_lp_desc'];
        }else{
            $contact_data_referrer['meta_description']=$product_data['meta_description'];
        }

        $contact_data_referrer['landing_id']=$landing_id;
        $contact_data_referrer['title']=$landing_data['title'];
        $contact_data_referrer['mailthanks']=$landing_data['mailthanks'];
        $contact_data_referrer['mailthanks_modal']=$landing_data['mailthanks_modal'];
        $contact_data_referrer['mailthanks_full']=$landing_data['mailthanks_full'];

        $contact_data_referrer['type']='prod';
        $data['head']=$this->load->controller('landing/head',$contact_data_referrer);
        $data['header']=$this->load->controller('landing/header',$contact_data_referrer);
        $data['footer']=$this->load->controller('landing/footer',$contact_data_referrer);

        
        if(isset($data_lp['product_lp_name']) and $data_lp['product_lp_name']){
            $data['name'] = $data_lp['product_lp_name'];
        }else{
            $data['name'] = $product_data['name'];
        }
        
        if(isset($data_lp['product_lp_text']) and $data_lp['product_lp_text']){
            $data['text']=$data_lp['product_lp_text'];
        }else{
            $data['text']=$product_data['description'];
        }

        $video=[];
        if(isset($data_lp['product_lp_video'])){
            foreach($data_lp['product_lp_video'] as $video_item){
                $video[]=Array(
                    'video'=>$video_item['url'],
                    'image'=>$this->model_tool_image->resize('../image/'.$video_item['image'], 580, 325),
                    'video_caption'=>$video_item['text']
                );
            }
            $data['product_lp_video']=$data_lp['product_lp_video'];
        }
        $data['video']=$video;
        //$data['video'] = $data_lp['product_lp_video'];

        $data['block1_form_status']=$landing_data['block1_form_status'];
        $data['block1_form_caption']=$landing_data['block1_form_caption'];
        $data['block1_form_text']=$landing_data['block1_form_text'];

        $data['block_benefit_pr_status']=isset($landing_data['block_benefit_pr_status'])?$landing_data['block_benefit_pr_status']:0;
        $data['block_benefit_pr']=isset($landing_data['block_benefit_pr'])?$landing_data['block_benefit_pr']:[];
        
        $files=isset($data_lp['product_lp_doc'])?$data_lp['product_lp_doc']:[];
        
        if($files){
            foreach($files as $file){
                $data['product_lp_docs'][]=Array(
                    "text"=>$file['text'],
                    "file"=>'files/landing/'.$file['file']
                );
            }
            //$data['product_lp_docs']=$files;
        }else{
            $files=$this->model_landing_landing->productFiles($product_id);
            foreach($files as $file){
                $data['product_lp_docs'][]=Array(
                    "text"=>$file['name'],
                    "file"=>'files/'.$file['file']
                );
            }
            //$data['product_lp_docs']=$files;
        }
        
         
        $data['block_bform_caption']=$landing_data['block_bform_caption'];
        $data['block_bform_perc']=$landing_data['block_bform_perc'];        

        
        
        /*
        $data['block1_form_status']=$data_lp['block1_form_status'];
        $data['block1_form_caption']=$data_lp['block1_form_caption'];
        */

        if($landing_data['landprice']){
            $type_price=$landing_data['landprice'];
        }else{
            $type_price=$data_lp['product_lp_price'];
        }

        //switch ($data_lp['product_lp_price']){
        switch ($type_price){

            case 0: //Не показывать цену
                $data['price_str']="";
                break;
            case 1: //Розничная
                $data['price_str']="от ".number_format($product_data['price'], 0, ',', ' ').' ₽';
                break;
            case 2: //Оптовая
                $data['price_str']="от ".number_format($product_data['price_wholesale'], 0, ',', ' ').' ₽';
                break;
            case 3: //С1
                $data['price_str']="от ".number_format($product_data['price_c1'], 0, ',', ' ').' ₽';
                break;
            case 4: //С2
                $data['price_str']="от ".number_format($product_data['price_c2'], 0, ',', ' ').' ₽';
                break;
            case 5: //С3
                $data['price_str']="от ".number_format($product_data['price_c3'], 0, ',', ' ').' ₽';
                break;                
        }
        //$data['thumb']=$this->model_tool_image->resize($product_data['image'], 560, 560);
        if (isset($product_data['image'])){
            $data['images'][]=Array(
                'mini'=>$this->model_tool_image->resize($product_data['image'], 160, 160),
                'big'=>$this->model_tool_image->resize($product_data['image'], 600, 600),
                'image'=>'image/'.$product_data['image']
            );
        }
        $images=$this->model_landing_landing->getProductImages($product_id);
        foreach($images as $image){
            $data['images'][]=Array(
                'mini'=>$this->model_tool_image->resize($image['image'], 160, 160),
                'big'=>$this->model_tool_image->resize($image['image'], 600, 600),
                'image'=>'image/'.$image['image']
            );
        }
        
        //prodtabs - кастомные вкладки продукта, наследуемые из категории
        $prodTabsGateway = new ProdTabs($this->registry);
        $tabs = $prodTabsGateway->getTabsWithProductTexts($product_id, 'order by sortOrder');
        $data['tabs'] = [];
        foreach ($tabs as $t) {
            if (!$t['prod_hide']) {
                $tab_name='';
                /*
                switch ($t['cat_name']){
                    case 'Применение';
                        $tab_name="tab-use";
                        break;
                    case 'Хранение';
                        $tab_name="tab-save";
                        break;
                    case 'Скидки';
                        $tab_name="tab-sale";
                        break;
                    case 'Подробнее';
                        $tab_name="tab-more";
                        break;
                }
                */
                if($t['cat_name']=="Применение"){
                    $data['tabs'][] = [
                        'id'   => $t['category_prodtab_id'],
                        'name' => $t['cat_name'],
                        'text' => html_entity_decode($t['val']),
                        'tab_name'=>$tab_name
                    ];
                }
            }
        }
        $stringsGateway = new ProdUnitStrings($this->registry);
        $data['packageStrings'] = $stringsGateway->getAll($product_data['produnit_template_id'], 'order by sortOrder');

        //$data['pack']=$this->model_landing_landing->getProductPack($product_id);

        
        //produnits - единицы измерения
        $produnitsGateway = new ProdUnits($this->registry);
        $produnitsCalcGateway = new ProdUnitsCalc($this->registry);
        $prodUnits = $produnitsGateway->getUnitsByProduct($product_id);

        $pUnits = [];
        $pUnitsErrors = null;
        $priceUnit = null;
        $saleUnit = null;
        $saleToPriceKoef = null;
        
        try {
            foreach ($prodUnits as $unit_id => $unit) {
                
                // единицы измерения с sortorder <> 0 участвуют в отображении в шаблоне 
                if (0 != $unit['switchSortOrder']) {
                    
                    $key = (int)$unit['switchSortOrder'];
                    $pUnits[ $key ] = $unit;
                    
                    //print_r($unit);
                    //коэффициент пересчета из базовой еденицы продажи в данную отображаемую еденицу
                    //echo $product_id."|'isSaleBase'!".$unit_id;
                    
                    $saleToUIKoef = $produnitsCalcGateway->getBaseToUnitKoef($product_id, 'isSaleBase', $unit_id);
                    
                    $pUnits[$key]['sale_to_ui_koef'] = $saleToUIKoef;
                    
                    //$pUnits[$key]['ui_step']=15;

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
                    if($product_data['quantity']>0){
                        $pUnits[$key]['mincount']=ceil(1*$koef_d);
                    }else{
                        $pUnits[$key]['mincount']=ceil($product_data['mincount']*$koef_d);
                    }
                    //echo "!".$pUnits[$key]['mincount']."!";

                    //print_r($pUnits[$key]);
                    //текстовые строки
                    $pUnits[$key]['showName'] = ($unit['name_price'])?$unit['name_price']:$unit['name'];
                    $pUnits[$key]['name_plural'] =($unit['name_plural'])?$unit['name_plural']:$unit['name'];

                    //строка описания цен. Например: "ведро, 16 кг"
                    if ($unit['calcKoef'] &&
                        $unit['calcRel'] &&
                        $unit['to_name_plural']) {
                        if ($unit['calcRel'] > 1) {
                            $relStr = $unit['name'] . ', ' . (float)$unit['calcKoef'] . ' ' . $unit['to_name_plural'];
                        }
                    } else {
                        $relStr = $unit['name'];
                    }
                        
                    $pUnits[$key]['relStr'] = $relStr;
                    
                }

                //параллельно ищем $priceUnit (базовая единица цен) - нужна как отдельная переменная
                //для передачи стоимостей в корзину
                if ($unit['isPriceBase'] == 1 && !$priceUnit) {
                    $priceUnit = $unit; 
                    //коэффициент пересчета из базовой еденицы продажи (кратности) в еденицы учета (цены)
                    $saleToPriceKoef = $produnitsCalcGateway->getBaseToUnitKoef($product_id, 'isSaleBase', $unit_id);

                } elseif ($unit['isPriceBase'] == 1) {
                    throw new \Exception('Too many price bases for product ' . $product_id);
                }

                if ($unit['isSaleBase'] == 1 && !$saleUnit) {
                    $saleUnit = $unit; 

                } elseif ($unit['isSaleBase'] == 1) {
                    throw new \Exception('Too many price bases for product ' . $product_id);
                }
                
            }

            if (!isset($pUnits[1])) {
                throw new \Exception('No one unit wasnt set for product');
            }
            
            if (!$priceUnit) {
                throw new \Exception('Price base wasnt found for product ' . $product_id);
            }

            if (!$saleUnit) {
                throw new \Exception('Sale base wasnt found for product ' . $product_id);
            }

        } catch (\Exception $e) {
            $pUnitsErrors = $e->getMessage();
        }
        $data['pUnits']=$pUnits;

        
        //$couriers=$this->registry->get('model_catalog_product')->getDeliveryDocs();
        $couriers=$this->model_catalog_product->getDeliveryDocs();
        
        foreach($couriers as $courier){
            if($courier[3]<99999999){
                $data["couriers"][]=Array("name"=>$courier[4],"weight"=>$courier[3]);
            }
        }
        $base_weight=0;
        $base_vol=0;
        foreach($data['pUnits'] as $unit){
            if($unit['isPackageBase']){
                $base_weight=$unit['weight'];
                $base_vol=$unit['calcKoef'];
                
            }
        }

        $data['baseWeight']=$base_weight;
        $data['baseVol']=$base_vol;
        
        $main_category_id=$this->model_catalog_product->getMainCategory($product_id);
        $filter_params_data=$this->model_catalog_product->getMainCategoryFilter($main_category_id);
        
        foreach($filter_params_data as $f_data){
			$list=[];
			$list_param_value=$this->model_catalog_product->getFilterParamValues($f_data["id"],$f_data["type_param"],$product_id);
			if($f_data["type_param"]==1){
				$list["value1"]=isset($list_param_value["value1"])?$list_param_value["value1"]:"";
				$list["value2"]=isset($list_param_value["value2"])?$list_param_value["value2"]:"";
			}else{
				$list_data=$this->model_catalog_product->getFilterParamList($f_data["id"]);

				foreach($list_data as $list_item){
					$list[]=[
						"id"=>$list_item["id"],
						"param_id"=>$list_item["param_id"],
						"param_value"=>$list_item["param_value"],
						"selected"=>in_array ($list_item["id"], $list_param_value)
					];
				}
				

			}
			
			$filter_params[]=Array(
				"id"=>$f_data["id"],
                "translit"=>$f_data["translit"],
				"name"=>$f_data["name"],
				"unit"=>html_entity_decode($f_data["unit"]),
				"type_param"=>$f_data["type_param"],
				"list"=>$list
			);
		}
        
        $products_links=$this->model_catalog_product->getProductLinks($product_id);
        $product_data['products_links']=[];

        //echo "product_lp_notavail=".$data_lp['product_lp_notavail'];
        
        $flags=[];
        $color_product=[];
        $data['products_links']=[];
        $data_lp['product_lp_notavail']=isset($data_lp['product_lp_notavail'])?$data_lp['product_lp_notavail']:0;
        if(!$data_lp['product_lp_notavail']){
            foreach($products_links as $key1=>$products_link){
                unset($data_temp);
                foreach($products_links[$key1] as $itm1){
                    if($itm1['product_id']==$product_id){
                        $flags[$key1]=true;
                        if($key1==1){
                            $color_product=Array("name"=>$itm1['name'],"code"=>$itm1['code']);
                        }
                    }
                    $data_temp[$key1][]=Array(
                        "name"=>$itm1['name'],
                        "code"=>$itm1['code'],
                        "product_id"=>$itm1['product_id'],
                        "link"=>$landing_alias."/lp-".$this->model_landing_landing->getProductAlias($itm1['product_id'])."/"
                    );
                }
            }
            foreach($flags as $key1=>$flag){
                $data['products_links'][$key1]=$data_temp[$key1];
            }
        }

        $data['filter_params']=$filter_params;

        $prodPropertiesGateway = new ProdProperties($this->registry);
        
        $properties = $prodPropertiesGateway->getPropertiesWithProductValues($product_id, 'order by sortOrder ASC');
        $data['properties'] = [];

        foreach ($properties as $p) {
            if (!$p['prod_hide']) {
                $data['properties'][] = [
                   'name' => $p['cat_name'],
                   'val' => htmlspecialchars_decode($p['val'],ENT_QUOTES),
                   'unit' => htmlspecialchars_decode($p['cat_unit'])
               ];
            }
        }
        $data['bform']=$this->load->controller('landing/bform',[
            "title"=>$landing_data['title'],
            "landing_id"=>$landing_id,
            "block_bform_caption"=>$landing_data["block_bform_caption"],
            "block_bform_perc"=>$landing_data["block_bform_perc"],
            "mailthanks"=>$landing_data["mailthanks"],
            "mailthanks_full"=>$landing_data["mailthanks_full"],
            "product_name"=>$data['name']
        ]);
        
        $this->response->setOutput($this->load->view('landing/product.tpl', $data));
    }
}
?>
