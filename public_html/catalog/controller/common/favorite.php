<?php
use Phospr\Fraction;
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;
use WS\Override\Gateway\ProdProperties; 
use WS\Patch\Helper\QueryHelper;
class ControllerCommonFavorite extends Controller {
	public function index() {
        $this->document->setNoindex(true);
        $ttl="Избранное";
        $data=[];
        
		$this->load->language('common/favorite');
		//$this->document->setTitle($this->language->get('heading_title'));
        $this->document->setTitle($ttl);
        $data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/favorite'),
			'text' => $ttl
        );
        
        $this->document->setNoindex(true);
        //$data['heading_title'] = $this->language->get('heading_title');
        
        $data['heading_title'] = $ttl;
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $products_arr=[];
        if(isset($_COOKIE["favorite"])){
            $products_arr=json_decode($_COOKIE["favorite"]);
        }else{
            $products_arr=[];
        }

        $this->load->model('catalog/information');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        $favorite_page=$this->model_catalog_product->getDocsData(6);
        //print_r($favorite_page);
        $data['favorite_content']=$this->model_catalog_information->cleanText($favorite_page["description"]);



        $this->load->language('catalog/product');

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
                $mincount = 1;
                $step=1;
                if($product['sale1']){
                    $mincount = 1;
                    $step=1;
                }else{
                    if (isset($pUnits[2])){
                        if (( $product["quantity"]<=0) and ($pUnits[2]['denom']>$pUnits[2]['nom']) ){
                            $step = $pUnits[2]['denom'];
                            $mincount=$pUnits[2]['denom'];
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
                }
                /*
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
                */
                

                if (!$priceUnit) {
                    throw new \Exception('Price base wasnt found for product ' . $product['product_id']);
                }

                $wholesale_threshold_in_saleUnits = Fraction::fromFloat((float)$product['wholesale_threshold']); 
                $wholesale_threshold = $wholesale_threshold_in_saleUnits->multiply($saleToPriceKoef)->toFloat(); 

                // Display prices
                /*
                if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                    
                    //$saleUnit_price = (float)$this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
                    //$price = $this->currency->format($saleUnit_price, $this->session->data['currency']);

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
                    

                } else {
                    $price = false;
                    $total = false;
                }
    */
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
                //Цена = Цена + Цена*(%скидки)/(100-%скидки)
                if($product["discount_percent"]){
                    $priceold=$product["price"]+$product["price"]*$product["discount_percent"]/(100-$product["discount_percent"]);
                    $price_wholesaleold=$priceold=$product["price_wholesale"]+$product["price_wholesale"]*$product["discount_percent"]/(100-$product["discount_percent"]);
                }else{
                    $priceold=0;
                    $price_wholesaleold=0;
                }

                $img_webp=str_replace(".jpg",".webp",$image);
                $img_webp=str_replace(".png",".webp",$img_webp);

                $data['products'][] = array(
                    'product_id' => $itm,
                    'thumb' => $image,
                    'thumb_webp' => $img_webp,
                    'name' => $product['name'],

                    
                    'meta_h1' => $product['meta_h1'],
                    'model' => $product['model'],
                    'quantity' => $mincount,
                    
                    'price_val'=>$product['price'],
                    'price_wholesale_val'=>$product['price_wholesale'],
                    'price' => $price,
                    'price_wholesale' => $price_wholesale,
                    //'priceold' => $product['priceold'],
                    //'price_wholesaleold' => $product['price_wholesaleold'],

                    'priceold' => $priceold,
                    'price_wholesaleold' => $price_wholesaleold,

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
        
        echo $this->load->view('common/favorite', $data);
        //return $this->load->view('common/favorite', $data);
        
	}

	public function info() {
        $this->response->setOutput($this->index());
	}
}
