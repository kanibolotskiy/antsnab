<?php
use Phospr\Fraction;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;
use WS\Override\Gateway\ProdProperties; 
use WS\Patch\Helper\QueryHelper;
class ControllerProductProduct extends Controller {
	private $error = array();

	public function getFastInfo(){
		$this->load->model('catalog/product');
		$this->load->language('product/product');
		
		$registry=$this->registry;

		$product_id=$this->request->post['product_id'];
		$product_info = $this->model_catalog_product->getProduct($product_id);
	
		if ($product_info) {
			if ($product_info['meta_h1']) {
				$meta_h1 = $product_info['meta_h1'];
			} else {
				$meta_h1 = $product_info['name'];
			}
			$data['heading_title'] = $meta_h1;
		}
		$data['product_id'] = $product_id;
		$data['discount_percent'] = $product_info['discount_percent'];
		$data['sku'] = $product_info['sku'];
		$data['manufacturer'] = $product_info['manufacturer'];
		$data['description_mini'] = html_entity_decode($product_info['description_mini']);
		$data['description'] = html_entity_decode($product_info['description']);
		$data['price_wholesale'] = $product_info['price_wholesale'];
		//print_r($product_info);

		if($product_info['discount_percent']){
			//Цена = Цена + Цена*(%скидки)/(100-%скидки)
			$price_old = $product_info['price']+$product_info['price']*$product_info['discount_percent']/(100-$product_info['discount_percent']);
			$price_wholesale_old = $product_info['price_wholesale']+$product_info['price_wholesale']*$product_info['discount_percent']/(100-$product_info['discount_percent']);
		}else{
			$price_old=0;
			$price_wholesale_old=0;
		}
		$data['priceold'] = number_format($price_old,0,"."," ");
		$data['price_wholesaleold'] = number_format($price_wholesale_old,0,"."," ");
		/*
		if($product_info['priceold']){
			$data['priceold'] = number_format($product_info['priceold'],0,"."," ");
		}
		
		if($product_info['price_wholesaleold']){
			$data['price_wholesaleold'] = number_format($product_info['price_wholesaleold'],0,"."," ");
		}
		*/

		$data['quantity_stock']=$product_info['quantity'];
		if ($product_info['quantity'] > 0) {
			$data['stock'] = $this->language->get('stock_avail');
		}else{
			$data['stock'] = $this->language->get('stock_byorder');
		}
		$data['rating'] = round($product_info['rating'],1);

		$this->load->model('tool/image'); 
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$b_patch=$this->config->get('config_ssl').'image/';
		} else {
			$b_patch=$this->config->get('config_url').'image/';
		}
		
		$data['images'] = array();

		if ($product_info['image']) {
			//$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
			//$data['thumb'] = $this->model_tool_image->resize($product_info['image'], 728, 668);
			//$data['thumb'] = $this->model_tool_image->myResize($product_info['image'], 1000, 750,1,'watermark.png');
			//$data['thumb'] = $this->model_tool_image->myResize($product_info['image'], 728, 668);
			$data['thumb'] = $this->model_tool_image->myResize($product_info['image'], 750, 560);
			$this->document->setOgImage($data['thumb']);
		} else {
			$data['thumb'] = '';
		}
		
		$data['images'][] = array(
			//'popup' => $this->model_tool_image->myResize($product_info['image'],$this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height')),
			'popup' => $this->model_tool_image->myResize($product_info['image'], 728, 668),
			//'thumb' => $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'))
			'thumb' => $this->model_tool_image->resize($product_info['image'], 164, 150)
		);		

		
		
		$results = $this->model_catalog_product->getProductImages($product_id);
		foreach ($results as $result) {
			$data['images'][] = array(
				//'popup' => $this->model_tool_image->myResize($result['image'],$this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height')),
				'popup' => $this->model_tool_image->myResize($result['image'], 728, 668),
				//'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'))
				'thumb' => $this->model_tool_image->resize($result['image'], 164, 150)
			);
		}
		
		$discount=0;
        $discount_val1=0;
        $discount_val2=0;

        if ($registry->get('customer')->isLogged() || !$registry->get('config')->get('config_customer_price')) {
            $data['price_wholesale'] = $registry->get('tax')->calculate($product_info['price_wholesale'], $product_info['tax_class_id'], $registry->get('config')->get('config_tax'));
            $data['price_wholesale_val']=$registry->get('currency')->format((float)$data['price_wholesale'] ? $data['price_wholesale'] : $product_info['price_wholesale'], $registry->get('session')->data['currency']);
            $data['price'] = $registry->get('tax')->calculate($product_info['price'], $product_info['tax_class_id'], $registry->get('config')->get('config_tax'));
            $data['price_val']=$registry->get('currency')->format((float)$data['price'] ? $data['price'] : $product_info['price'], $registry->get('session')->data['currency']);
			/*
            if($product_info['price_wholesaleold']*1){
                $discount_val1=(($product_info['price_wholesale']/$product_info['price_wholesaleold']-1)*100);
                $discount_val2=(($product_info['price']/$product_info['priceold']-1)*100);

                $discount = (int)$discount_val1;
			}
			*/

        } else {
            $data['price_wholesale'] = false;
            $data['price_wholesale_val'] = false;
            $data['price'] = false;
            $data['price_val'] = false;
        }
        
		$data['labels']=$this->model_catalog_product->getProductLabels($product_info);
		
		/*
        $data['discount_val1'] = $discount_val1;
        $data['discount_val2'] = $discount_val2;
        */
		
		if(isset($_COOKIE["favorite"])){
            $favorite_arr=json_decode($_COOKIE["favorite"]);
        }else{
            $favorite_arr=[];
		}
		if(isset($_COOKIE["compare"])){
            $compare_arr=json_decode($_COOKIE["compare"]);
        }else{
            $compare_arr=[];
        }
        
        if(in_array($product_id, $favorite_arr)){
            $fav_active=' active';
        }else{
            $fav_active='';
		}
		if(in_array($product_id, $compare_arr)){
            $compare_active=' active';
        }else{
            $compare_active='';
		}

        $data['favorite'] = $fav_active;
		$data['compare'] = $compare_active;

        $data['currencySymb'] = $registry->get('currency')->getSymbolRight($registry->get('session')->data['currency']);
		$data['wholesale_threshold'] = (int)$product_info['wholesale_threshold'];
		
		//produnits - единицы измерения
        $produnitsGateway = new ProdUnits($registry);
        $produnitsCalcGateway = new ProdUnitsCalc($registry);
        $prodUnits = $produnitsGateway->getUnitsByProduct($product_id);
        
        $pUnits = [];
        $pUnitsErrors = null;
        $priceUnit = null;
        $saleUnit = null;
		$saleToPriceKoef = null;
		
        $base_weight=0;
        $base_vol=0;

        try {
            foreach ($prodUnits as $unit_id => $unit) {
				if($unit['isPackageBase']){
					$base_weight=$unit['weight'];
					$base_vol=$unit['calcKoef'];
					
				}
                if (0 != $unit['switchSortOrder']) {
                    $key = (int)$unit['switchSortOrder'];
                    $pUnits[ $key ] = $unit;
                    
                    //print_r($unit);
                    //коэффициент пересчета из базовой единицы продажи в данную отображаемую единицу
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
                    if($product_info['quantity']>0){
                        $pUnits[$key]['mincount']=ceil(1*$koef_d);
                    }else{
                        $pUnits[$key]['mincount']=ceil($product_info['mincount']*$koef_d);
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
		
		$dataui_min=1;
        if($product_info['sale1']){
            $dataui_min = 1;
            $pUnits[1]['force_step_by_one']=1;
        }else{
            if (isset($pUnits[2])){
                if (( $product_info["quantity"]<=0) and ($pUnits[2]['denom']>$pUnits[2]['nom']) ){
                    $dataui_min=$pUnits[2]['denom'];
                    if($pUnits[1]['mincount']<$pUnits[2]['denom']){
                        $dataui_min = $pUnits[2]['denom'];
                    }else{
                        $dataui_min = $pUnits[1]['mincount'];
                    }
                }else{
                    $dataui_min = $pUnits[1]['mincount'];
                }
            }else{
                $dataui_min = $pUnits[1]['mincount'];
            }
        }

		$delivery_info = $this->model_catalog_product->getDelivery($product_id,$base_weight);
		
		if(is_numeric($delivery_info["price_delivery"])){
			$del_price="от ".number_format($delivery_info["price_delivery"],0,"."," ").' ₽';
		}else{
			$del_price=$delivery_info["price_delivery"];
		}
		
		$data["delivery_text"]='<span class="nowrap">'.$delivery_info['date_delivery'].'</span><br/>'.$del_price;

		$data['baseWeight']=$base_weight;
		$data['baseVol']=$base_vol;

        $data['pUnits'] = $pUnits;
		$data['dataui_min'] = $dataui_min;
		

        $data['pUnitsErrors'] = $pUnitsErrors;
        $data['priceUnit'] = $priceUnit;
        $data['saleUnit'] = $saleUnit;
        $data['sale_to_price_koef'] = $saleToPriceKoef;
		
        
        $data['optLimit']=$product_info['wholesale_threshold'];
        $data['mincount']=$product_info['mincount'];
		$this->response->setOutput($this->load->view('partial/product_info', $data));

	}
	
	public function ajaxDelivery(){
		
		$json = array();
		
		$this->load->model('catalog/product');
		$this->load->model('catalog/information');

		$weight=$this->request->post['weight'];
		$product_id=$this->request->post['product_id'];
		$delivery_info = $this->model_catalog_product->getDelivery($product_id,$weight);
	
		$json['date_delivery']=$delivery_info['date_delivery'];
		
		//echo "!".$delivery_info['price_delivery']."!".is_numeric($delivery_info['price_delivery']);
		if(is_numeric($delivery_info['price_delivery'])){
			$price_del="от ".number_format($delivery_info['price_delivery'],0,"."," ").' ₽';
		}else{
			$price_del=$delivery_info['price_delivery'];
		}
		//echo "!".$delivery_info['price_delivery']."!";
		$json['price_delivery']=$price_del;//$delivery_info['price_delivery'];
		/**/
		//$json['price_delivery']=$delivery_info['price_delivery'];
		$json['caption_delivery']=$delivery_info['caption_delivery'];
		
		
		$json['text_delivery']=$this->model_catalog_information->cleanText($delivery_info['text_delivery']);
		$json['success']=true;
		$this->response->setOutput(json_encode($json));
	}
	
	public function addtocart() {
		
		
        $product_id = $this->request->get['id'];
        $quantity = (isset($this->request->get['quantity']) ? $this->request->get['quantity'] : 1);
        $option = array();
        $recurring_id = 0;
    
        // Check if product exist
        $this->load->model('catalog/product');
    
        $product_info = $this->model_catalog_product->getProduct($product_id);
    
        if ($product_info) {
          $product_options = $this->model_catalog_product->getProductOptions($product_id);
    
          foreach ($product_options as $product_option) {
            if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
              $this->response->redirect($this->url->link('product/product', 'product_id=' . $product_id));
              exit;
            }
          }
		  
		  /**Добавляем учет минимального количества*/
		$produnitsGateway = new ProdUnits($this->registry);
		
		$produnitsCalcGateway = new ProdUnitsCalc($this->registry);
		$propGateway = new ProdProperties($this->registry);
		$prodUnits = $produnitsGateway->getUnitsByProduct($product_id);
		$priceUnit = null;
		$koef_d=1;

		 
		foreach ($prodUnits as $unit_id => $unit) {
			if ($unit['isPriceBase'] == 1 && !$priceUnit) {
				$priceUnit = $unit;
				//print_r($unit);
				//коэффициент пересчета из базовой еденицы продажи (кратности) в еденицы учета (цены)
				$saleToPriceKoef = $produnitsCalcGateway->getBaseToUnitKoef($product_id, 'isSaleBase', $unit_id);

				$array_koef = (array) $saleToPriceKoef;
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
				

				$koef_d=$koef_numerator/$koef_denomirator;
				
				
			} elseif ($unit['isPriceBase'] == 1) {
				throw new \Exception('Too many price bases for product ' . $product_id);
			}
			
			
		}
		
		if(($product_info['mincount']*$koef_d)>$quantity){
			$quantity=$product_info['mincount']*$koef_d;
		}
			

          $this->cart->add($product_id, $quantity, $option, $recurring_id);
    
          unset($this->session->data['shipping_method']);
          unset($this->session->data['shipping_methods']);
          unset($this->session->data['payment_method']);
          unset($this->session->data['payment_methods']);
    
          $this->response->redirect($this->url->link('checkout/cart'));
    
        } else {
          $this->response->redirect($this->url->link('common/home'));
        }
        
	}
	
	public function index() {
		
		$this->load->language('product/product');
		$this->load->language('catalog/review');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$this->load->model('catalog/category');
		$this->load->model('catalog/review');

		if (isset($this->request->get['path'])) {
			
			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => html_entity_decode($category_info['name']),
						'href' => $this->url->link('product/category', 'path=' . $path)
					);
				}
			}

			// Set the last category breadcrumb
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info) {
				$url = '';

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

				$data['breadcrumbs'][] = array(
					'text' => html_entity_decode($category_info['name']),
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
				);
			}
		}

		
		$this->load->model('file/file');
		$files_data = $this->model_file_file->getProductFiles($this->request->get['product_id']);
		foreach ($files_data as $file) {
			if ($file['image'] && $file['image'] != 'no_image.jpg' ) {
				$image = $this->model_tool_image->resize($file['image'], ($this->config->get('config_file_default_image_size_width'))?$this->config->get('config_file_default_image_size_width'):50, ($this->config->get('config_file_default_image_size_height'))?$this->config->get('config_file_default_image_size_height'):50);
			} else {
				$image = false;
			}
			
			if(file_exists(str_replace("system/storage/download", "files", DIR_DOWNLOAD) . $file['file'])) {
				$file_link = HTTP_SERVER . 'files/' . $file['file']; 
			}else{
				$file_link = false;
			}
			
			if($file_link){
				$data['files'][] = array(
					'file_id' 	=> $file['file_id'],
					'href'    	=> $file_link, 
					'image'   	=> $image,
					'name' 		=> $file['name'],
					'title' 	=> $file['title'],
				);
			}
		}
		
		$this->load->model('catalog/manufacturer');

		if (isset($this->request->get['manufacturer_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => html_entity_decode($this->language->get('text_brand')),
				'href' => $this->url->link('product/manufacturer')
			);

			$url = '';

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

			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

			if ($manufacturer_info) {
				$data['breadcrumbs'][] = array(
					'text' => html_entity_decode($manufacturer_info['name']),
					'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
				);
			}
		}
		
		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$url = '';
 
			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
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

			
			$data['breadcrumbs'][] = array(
				'text' => html_entity_decode($this->language->get('text_search')),
				'href' => $this->url->link('product/search', $url)
			);
		}
		
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);
		
		if ($product_info) {
			
			$url = '';
			
			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
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

			$data['breadcrumbs'][] = array(
				'text' => html_entity_decode($product_info['name']),
				'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id'])
			);

			if ($product_info['meta_title']) {
				$seoTitle=$product_info['meta_title'];
			} else {
				$seoTitle=$product_info['name'];
			}

			//price_wholesale
			//Подставляем оптовую цену в Title
			//$seoTitlePrice=$this->currency->format((float)$product_info['price_wholesale'] ? $product_info['price_wholesale'] : $product_info['price'], $this->session->data['currency']);
			
			$seoTitlePrice = number_format((float)$product_info['price_wholesale'] ? $product_info['price_wholesale'] : $product_info['price'],0,"."," ")." р.";

			$seoTitle=str_replace('[+price]',$seoTitlePrice ,$seoTitle);

			if ($product_info['meta_h1']) {
				$meta_h1 = $product_info['meta_h1'];
			} else {
				$meta_h1 = $product_info['name'];
			}

			$this->document->setTitle($seoTitle);

			$this->document->setDescription($product_info['meta_description']);
			if($product_info['meta_keyword']){
				$this->document->setKeywords($product_info['meta_keyword']);
			}else{
				$this->document->setKeywords($meta_h1);
			}
			
			$data['heading_title'] = $meta_h1;

			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
			//$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');

			//$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
			//$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
			//$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/locale/'.$this->session->data['language'].'.js');
			//$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			//$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');
			
			

			
			
			$data['text_select'] = $this->language->get('text_select');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_reward'] = $this->language->get('text_reward');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_stock'] = $this->language->get('text_stock');
			$data['text_discount'] = $this->language->get('text_discount');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_option'] = $this->language->get('text_option');
			$data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
			$data['text_write'] = $this->language->get('text_write');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));
			$data['text_note'] = $this->language->get('text_note');
			$data['text_tags'] = $this->language->get('text_tags');
			$data['text_related'] = $this->language->get('text_related');
			$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
			$data['text_loading'] = $this->language->get('text_loading');

			$data['entry_qty'] = $this->language->get('entry_qty');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_review'] = $this->language->get('entry_review');
			$data['entry_rating'] = $this->language->get('entry_rating');
			$data['entry_good'] = $this->language->get('entry_good');
			$data['entry_bad'] = $this->language->get('entry_bad');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_upload'] = $this->language->get('button_upload');
			$data['button_continue'] = $this->language->get('button_continue');

			$this->load->model('catalog/review');

			$data['tab_description'] = $this->language->get('tab_description');
			$data['tab_attribute'] = $this->language->get('tab_attribute');
			$data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);

			$data['product_id'] = (int)$this->request->get['product_id'];
			$data['manufacturer'] = $product_info['manufacturer'];
			$data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
			$data['model'] = $product_info['model'];
			$data['reward'] = $product_info['reward'];
			$data['points'] = $product_info['points'];
			$data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');

			$data['product_link'] = $this->url->link('product/product', 'product_id=' . $this->request->get['product_id']);


			$data['quantity_stock']=$product_info['quantity'];
			if ($product_info['quantity'] > 0) {
				$data['stock'] = $this->language->get('stock_avail');
			}else{
				$data['stock'] = $this->language->get('stock_byorder');
			}
			$data['rating'] = round($product_info['rating'],1);
			
			$this->load->model('tool/image');

			if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
				$b_patch=$this->config->get('config_ssl').'image/';
			} else {
				$b_patch=$this->config->get('config_url').'image/';
			}
		

			if ($product_info['image']) {
				 
				
				$img_filename = $this->model_tool_image->myResize($product_info['image'], 1000,750,14,'watermark.png');
				$data['popup'] = $img_filename;

				$img_webp=str_replace(".jpg",".webp",$img_filename);
				$img_webp=str_replace(".png",".webp",$img_webp);
				$data['popup_webp'] = $img_webp;

			} else {
				$data['popup'] = '';
			}

			if ($product_info['image']) {
				$img_filename=$this->model_tool_image->myResize($product_info['image'], 750, 560);
				$img_webp=str_replace(".jpg",".webp",$img_filename);
				$img_webp=str_replace(".png",".webp",$img_webp);

				$data['thumb'] = $img_filename;
				$data['thumb_webp']=$img_webp;
				

				$this->document->setOgImage($data['thumb']);
			} else {
				$data['thumb'] = '';
			}

			$data['images'] = array();

			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

			//$count_images=0;
			foreach ($results as $result) {
				//if($count_images<4){
					$img_filename=$this->model_tool_image->resize($result['image'], 176,150);
					//echo $img_filename."<br/>!";
					$img_webp=str_replace(".jpg",".webp",$img_filename);
					$img_webp=str_replace(".png",".webp",$img_webp);
					
					$data['images'][] = array(
						'popup' => $this->model_tool_image->myResize($result['image'],1000,750,13,'watermark.png'),
						'thumb' => $img_filename,
						'thumb_webp' => $img_webp
					);
				//}
				//$count_images++;
			}
			
			
			$data['video_link']='';
			$data['video_img']='';
			$data['labels']=$this->model_catalog_product->getProductLabels($product_info);
			
			/*
			if($product_info['video']){
				preg_match("#(?<=v=)[a-zA-Z0-9-]+(?=&)|(?<=v\/)[^&\n]+(?=\?)|(?<=v=)[^&\n]+|(?<=youtu.be/)[^&\n]+#", $product_info['video'], $matches);
				if(isset($matches[0])){
					$video_id=$matches[0];
					
					$data['video_link'] = $product_info['video'];
					
					//$data['video_img']='//img.youtube.com/vi/'.$video_id.'/sddefault.jpg';
					if($product_info['altvideo']){
						$data['video_img']='//img.youtube.com/vi/'.$video_id.'/sddefault.jpg';
					}else{
						$data['video_img']='//img.youtube.com/vi/'.$video_id.'/maxresdefault.jpg';
					}
				}
			}
			*/
			$data['video_link'] = $product_info['video'];
			if($product_info['video_preview']){
				$data['video_img']="../image/".$product_info['video_preview'];
			}else{
				preg_match("#(?<=v=)[a-zA-Z0-9-]+(?=&)|(?<=v\/)[^&\n]+(?=\?)|(?<=v=)[^&\n]+|(?<=youtu.be/)[^&\n]+#", $product_info['video'], $matches);
				if(isset($matches[0])){
					$video_id=$matches[0];
					$data['video_img']='//img.youtube.com/vi/'.$video_id.'/maxresdefault.jpg';
				}
			}


			$data['price_wholesale'] = $product_info['price_wholesale'];
			/*
			if($product_info['priceold']){
				$data['priceold'] = number_format($product_info['priceold'],0,"."," ");
			}
			
			if($product_info['price_wholesaleold']){
				$data['price_wholesaleold'] = number_format($product_info['price_wholesaleold'],0,"."," ");
			}
			*/
			if($product_info['discount_percent']){
				//Цена = Цена + Цена*(%скидки)/(100-%скидки)
				$price_old = $product_info['price']+$product_info['price']*$product_info['discount_percent']/(100-$product_info['discount_percent']);
				$price_wholesale_old = $product_info['price_wholesale']+$product_info['price_wholesale']*$product_info['discount_percent']/(100-$product_info['discount_percent']);
			}else{
				$price_old=0;
				$price_wholesale_old=0;
			}
			$data['priceold'] = number_format($price_old,0,"."," ");
			$data['price_wholesaleold'] = number_format($price_wholesale_old,0,"."," ");
			


			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$data['price'] = false;
			}

			if ((float)$product_info['special']) {
				$data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$data['special'] = false;
			}

			if ($this->config->get('config_tax')) {
				$data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
			} else {
				$data['tax'] = false;
			}

			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

			$data['discounts'] = array();

			foreach ($discounts as $discount) {
				$data['discounts'][] = array(
					'quantity' => $discount['quantity'],
					'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'])
				);
			}

			$data['options'] = array();

			foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
						} else {
							$price = false;
						}

						$product_option_value_data[] = array(
							'product_option_value_id' => $option_value['product_option_value_id'],
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}

				$data['options'][] = array(
					'product_option_id'    => $option['product_option_id'],
					'product_option_value' => $product_option_value_data,
					'option_id'            => $option['option_id'],
					'name'                 => $option['name'],
					'type'                 => $option['type'],
					'value'                => $option['value'],
					'required'             => $option['required']
				);
			}

			if ($product_info['minimum']) {
				$data['minimum'] = $product_info['minimum'];
			} else {
				$data['minimum'] = 1;
			}

			$data['review_status'] = $this->config->get('config_review_status');

			if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
				$data['review_guest'] = true;
			} else {
				$data['review_guest'] = false;
			}

			if ($this->customer->isLogged()) {
				$data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
			} else {
				$data['customer_name'] = '';
			}
			

			$data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
			

			//$ratingValue
			//echo "!".$data['rating']."!";

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'));
			} else {
				$data['captcha'] = '';
			}
			
			//Отзывы
			$results=$this->model_catalog_review->getReviewsByProductId($data['product_id']);
			$review_total=$this->model_catalog_review->getTotalReviewsByProductId($data['product_id']);
			$data['captcha_key'] = $this->config->get('google_captcha_key');
			
			$def_reviews[1]=[];
			$def_reviews[2]=[];
			
			$data['reviews']=$def_reviews;
			//$data['reviews'][1]=[];
			//$data['reviews'][2]=[];
			
			$summary_reviews=0;
			$this->load->model('catalog/information');
			$count_revs=count($results);
			$data['count_revs']=$count_revs;
			foreach ($results as $result) {
				if($result['answer']){
					$tp=2;
				}else{
					$tp=1;
				}

				$data['reviews'][$tp][] = array(
					'review_id'  => $result['review_id'],
					'name'       => $result['name'],
					'text'       => $this->model_catalog_information->cleanText($result['text']),
					'about'      => $result['name'],
					'about_txt'  => $result['name'],
					'date'       => $result['date_added'],
					'answer'     => $this->model_catalog_information->cleanText($result['answer']),
					'author'     => $result['author'],
					'moderator'  => $result['moderator'],
					'rating'     => $result['rating'],
					'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					//'edit'       => $this->url->link('catalog/review/edit',  '&review_id=' . $result['review_id'] . $url, true)
				);
				
				$summary_reviews+=$result['rating'];
			}

			//$data['rating'] = (int)$product_info['rating'];
			$count_reviews=count($data['reviews']);
			$data['ratingSum']=$summary_reviews;
			if($count_reviews){
				$data['ratingValue']=round($summary_reviews/$count_reviews,2);
			}else{
				$data['ratingValue']=5;
			}



			//current page
			if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else {
				$page = 1;
			}
			//$reviewsLimit = (int)$this->config->get(AdminModule::CONFIG_KEY_COUNT);
			//$defaultRaiting = (int)$this->config->get(AdminModule::CONFIG_KEY_RAITING);
		
			$limit = 10;
			$start = ($page - 1) * $limit;
	
			// new review
			$p = ( $page == 1 ) ? '' : '&page=' . $page;

			$data['action'] = $url . $p; 


			
			$data['entry_author'] = $this->language->get('entry_author');
			$data['entry_email'] = $this->language->get('entry_email');
			$data['entry_company'] = $this->language->get('entry_company');
			$data['entry_text'] = $this->language->get('entry_text');
			
			

			$pagination = new Pagination();
			$pagination->total = $review_total;
			$pagination->page = $page;
			$pagination->limit = $this->config->get('config_limit_admin');
			$pagination->url = $this->url->link('catalog/review',  $url . '&page={page}', true);
	
			$data['pagination'] = $pagination->render();

			//Отзывы
			$data['text_thankyou_header'] = $this->language->get('text_thankyou_header');
        	$data['text_thankyou'] = $this->language->get('text_thankyou');
			$data['share'] = $this->url->link('product/product', 'product_id=' . (int)$this->request->get['product_id']);

			$data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);

			$data['products'] = array();
			
			
			//unset($exclude_ids);
			

			$results_rls[0] = $this->model_catalog_product->getProductRelated($this->request->get['product_id'],true,0,'product_analogs',$this->request->get['product_id']);
			$results_rls[1] = $this->model_catalog_product->getProductRelated($this->request->get['product_id'],true,0,'product_related',$this->request->get['product_id']);

			$data['products'][0]=[];
			$data['products'][1]=[];
			foreach($results_rls as $key=>$results_rl){
				$result_temp=[];
				foreach($results_rl as $result){
					//$result_temp
					if ($result['image']) {
						$image = $this->model_tool_image->myResize($result['image'], 400,400,1);
						$img_webp=str_replace(".jpg",".webp",$image);
						$img_webp=str_replace(".png",".webp",$img_webp);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', 400,400);
						$img_webp='';
					}
					
	
					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price_val=$this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax'));
						//$price = $this->currency->format($price_val, );
						$price = number_format($price_val,0,".", " ");
	
		
					} else {
						$price = false;
						$price_val=0;
					}
	
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}
	
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}
	
					if ($this->config->get('config_review_status')) {
						//$rating = (int)$result['rating'];
						$rating = round($result['rating'],1);
					} else {
						$rating = false;
					}

					//$discount=0;
					if($result['discount_percent']*1){
						$discount = $result['discount_percent'];
					}else{
						$discount=0;
					}
					
					
					$labels = $this->model_catalog_product->getProductLabels($result);
	
					$data['products'][$key][] = array(
						'product_id'  => $result['product_id'],
						'thumb'       => $image,
						'thumb_webp'  => $img_webp,
						'name'        => html_entity_decode($result['name']),
						'meta_h1'     => $result['meta_h1'],
						'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'price_val'	  => $price_val,
						'special'     => $special,
						'tax'         => $tax,
						'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id']),
						'labels'	  => $labels,
						'discount'	  => $discount
					);
				}
			}
			
			$data['tags'] = array();
			if ($product_info['tag']) {
				$tags = explode(',', $product_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('product/search', 'tag=' . trim($tag))
					);
				}
			}
			$benefits_array=$this->model_catalog_product->getProductBenefits($product_id);
			//print_r($benefits_array);
			$data['benefits']=[];
			foreach($benefits_array as $benefit){
				$data['benefits'][]=Array(
					"name"=>$benefit['name'],
					"description"=>html_entity_decode($benefit['description']),
					"goal"=>$benefit['goal'],
					"filename"=>"files/".$benefit['filename']
				);
			}
			

			$show_discount_form=$this->model_catalog_product->showDiscountProduct($product_id);
			if($show_discount_form>0){
				$data['discount_form']=1;
				if($show_discount_form){
					$discountData=$this->model_catalog_product->getDiscountData($show_discount_form);
					$data['discount_caption']=$discountData['name'];
					$data['discount_text']=html_entity_decode($discountData['description']);
					$data['discount_goal']=$discountData['goal'];
					$data['discount_label']=$discountData['label'];
				}
			}else{
				$data['discount_form']=0;
			}
			//$data['benefits']["description"]=html_entity_decode($data['benefits']["description"]);
			
			$nostockData=$this->model_catalog_product->getDocsData(1);
			
			$data['nostock_caption']=$nostockData['name'];
			$data['nostock_text']=html_entity_decode($nostockData['description']);


			$delcostData=$this->model_catalog_product->getDocsData(5);
			$data['delivery_cost_caption']=$delcostData['name'];

			
			$data['delivery_cost_text']=html_entity_decode($delcostData['description']);


			$data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);

			//Калькулятор
			$data['calculator']="";
			//print_r($product_info);
			$calc_nomer=0;
			if($product_info['calc']){
				$calc_nomer=$product_info['calc'];
			}else{
				if($category_info['calc']){
					$calc_nomer=$category_info['calc'];
				}
			}

			if($calc_nomer){
				$data['consumption']=$product_info['consumption'];
				$data['calc_data1']=$product_info['calc_data1'];
				$data['calc_data2']=$product_info['calc_data2'];
				$data['calc_data3']=$product_info['calc_data3'];
				$data['calc_data4']=$product_info['calc_data4'];
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/app/template/calculators/calc_'.$calc_nomer.'.tpl')) {
					$data['calculator']=$this->load->view('calculators/calc_'.$calc_nomer, $data);
				}
			}
			
			$products_links=$this->model_catalog_product->getProductLinks($product_id);
			$data['products_links']=[];
			$flags=[];
			$color_product=[];
			foreach($products_links as $key=>$products_link){
				
				foreach($products_links[$key] as $itm){
					if($itm['product_id']==$product_id){
						$flags[$key]=true;
						if($key==1){
							$color_product=Array("name"=>$itm['name'],"code"=>$itm['code']);
						}
					}
					$data_temp[$key][]=Array(
						"name"=>$itm['name'],
						"code"=>$itm['code'],
						"product_id"=>$itm['product_id'],
						"link"=>$this->url->link('product/product', 'product_id=' . $itm['product_id']),
					);
				}
			}
			foreach($flags as $key=>$flag){
				$data['products_links'][$key]=$data_temp[$key];
			}

			
			$data['color_product']=$color_product;

			$this->model_catalog_product->updateViewed($this->request->get['product_id']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
			

			$this->response->setOutput($this->load->view('product/product', $data));
			
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
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

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
		
		
	}

	public function review() {
		$this->load->language('product/product');

		$this->load->model('catalog/review');

		$data['text_no_reviews'] = $this->language->get('text_no_reviews');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['reviews'] = array();

		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

		foreach ($results as $result) {
			$data['reviews'][] = array(
				'author'     => $result['author'],
				'text'       => nl2br($result['text']),
				'rating'     => (int)$result['rating'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

		$this->response->setOutput($this->load->view('product/review', $data));
	}

	public function write() {
		$this->load->language('product/product');
		
//print_r($this->request->post);
		$json = array();
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['author']) < 3) || (utf8_strlen($this->request->post['author']) > 25)) {
				$json['error']['author'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error']['text'] = $this->language->get('error_text');
			}

			if (!isset($this->request->post['agree']))  {
				$json['error']['agree'] = $this->language->get('error_agree');
			}
			if (isset($this->request->post['email']))  {
				if(!$this->request->post['email']){
					$json['error']['email'] = $this->language->get('error_email');
				}
				if (!preg_match("/^(?:[a-z0-9]+(?:[-_.]?[a-z0-9]+)?@[a-z0-9_.-]+(?:\.?[a-z0-9]+)?\.[a-z]{2,5})$/i", $this->request->post['email'])) {
					$json['error']['email'] = $this->language->get('error_email');
				}
			}

/*
			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}
*/
			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$json['error']['captcha'] = $captcha;
				}
			}
			//echo $json['error'];

			if (!isset($json['error'])) {
				$this->load->model('catalog/review');
				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);
				$json['success']=true;
				//$json['success'] = $this->language->get('text_success');
			}
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getRecurringDescription() {
		$this->load->language('product/product');
		$this->load->model('catalog/product');

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		if (isset($this->request->post['recurring_id'])) {
			$recurring_id = $this->request->post['recurring_id'];
		} else {
			$recurring_id = 0;
		}

		if (isset($this->request->post['quantity'])) {
			$quantity = $this->request->post['quantity'];
		} else {
			$quantity = 1;
		}

		$product_info = $this->model_catalog_product->getProduct($product_id);
		$recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

		$json = array();

		if ($product_info && $recurring_info) {
			if (!$json) {
				$frequencies = array(
					'day'        => $this->language->get('text_day'),
					'week'       => $this->language->get('text_week'),
					'semi_month' => $this->language->get('text_semi_month'),
					'month'      => $this->language->get('text_month'),
					'year'       => $this->language->get('text_year'),
				);

				if ($recurring_info['trial_status'] == 1) {
					$price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					$trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
				} else {
					$trial_text = '';
				}

				$price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

				if ($recurring_info['duration']) {
					$text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				} else {
					$text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				}

				$json['success'] = $text;
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	public function sendOptForm(){
		$this->load->model('catalog/product');
		
		if(trim($this->request->post['workemail']=="")){
			$this->model_catalog_product->sendMailOpt($this->request->post);
		}
		$json['success']="ok";
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));

	}

	public function sendOneForm(){
		$this->load->model('catalog/product');
		
		$json = array();
		if(trim($this->request->post['workemail']=="")){
			$this->model_catalog_product->sendMailOne($this->request->post);
		}
		$json["success"]=true;

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}


}
