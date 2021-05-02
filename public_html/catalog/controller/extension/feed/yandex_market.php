<?php
/**
 * Класс YML экспорта
 * YML (Yandex Market Language) - стандарт, разработанный "Яндексом"
 * для принятия и публикации информации в базе данных Яндекс.Маркет
 * YML основан на стандарте XML (Extensible Markup Language)
 * описание формата YML http://partner.market.yandex.ru/legal/tt/
 */


use WS\Override\Controller\IDecorator;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;

class ControllerExtensionFeedYandexMarket extends Controller {
	private $shop = array();
	private $currencies = array();
	private $categories = array();
	private $deliveries = array();
	private $offers = array();
	private $from_charset = 'utf-8';
	private $eol = "\n";

	public function index() {
		if ($this->config->get('yandex_market_status')) {

			if (!($allowed_categories = $this->config->get('yandex_market_categories'))) exit();

			$this->load->model('extension/feed/yandex_market');
			$this->load->model('localisation/currency');
			$this->load->model('tool/image');

			// Магазин
			$this->setShop('name', $this->config->get('yandex_market_shopname'));
			$this->setShop('company', $this->config->get('yandex_market_company'));
			$this->setShop('url', HTTP_SERVER);
			$this->setShop('phone', $this->config->get('config_telephone'));
			$this->setShop('platform', 'ocStore');
			$this->setShop('version', VERSION);

			// Валюты
			// TODO: Добавить возможность настраивать проценты в админке.
			$offers_currency = $this->config->get('yandex_market_currency');
			if (!$this->currency->has($offers_currency)) exit();

			$decimal_place = $this->currency->getDecimalPlace($offers_currency);

			$shop_currency = $this->config->get('config_currency');

			$this->setCurrency($offers_currency, 1);

			$currencies = $this->model_localisation_currency->getCurrencies();

			//$supported_currencies = array('RUR', 'RUB', 'USD', 'BYR', 'KZT', 'EUR', 'UAH');
			$supported_currencies = array('RUB');

			$currencies = array_intersect_key($currencies, array_flip($supported_currencies));

			foreach ($currencies as $currency) {
				if ($currency['code'] != $offers_currency && $currency['status'] == 1) {
					$this->setCurrency($currency['code'], number_format(1/$this->currency->convert($currency['value'], $offers_currency, $shop_currency), 4, '.', ''));
				}
			}

			//Опции доставки
			$this->setDeliveryOptions();
			
			// Категории
			$categories = $this->model_extension_feed_yandex_market->getCategory($allowed_categories);
			
			
			foreach ($categories as $category) {
				$this->setCategory($category['name'], $category['category_id'], $category['parent_id']);

			}

			
			// Товарные предложения
			$in_stock_id = $this->config->get('yandex_market_in_stock'); // id статуса товара "В наличии"
			$out_of_stock_id = $this->config->get('yandex_market_out_of_stock'); // id статуса товара "Нет на складе"
			$vendor_required = false; // true - только товары у которых задан производитель, необходимо для 'vendor.model'
			$products = $this->model_extension_feed_yandex_market->getProduct($allowed_categories, $out_of_stock_id, $vendor_required,true);

			//$products = $this->model_extension_feed_yandex_market->getProduct($allow_cat_str, $out_of_stock_id, $vendor_required);

			$produnitsGateway = new ProdUnits($this->registry);
			$produnitsCalcGateway = new ProdUnitsCalc($this->registry);
			$this->load->model('catalog/product');

			//$weight=$this->request->post['weight'];
			//$product_id=$this->request->post['product_id'];
			//$delivery_info = $this->model_catalog_product->getDelivery($product_id,$weight);
			$delivery_weights=$this->model_catalog_product->getDeliveryDocs();
			$delivery_weights_rev=array_reverse($delivery_weights,true);

			$z=0;
			
			foreach ($products as $product) {
				
				$prodUnits = $produnitsGateway->getUnitsByProduct($product['product_id']);
				$price=0;
				$weight=0;
				$unit_array=[];
				
				$mincount=1;
				unset($pUnits);
				foreach ($prodUnits as $unit_id => $unit) {
					/*
					if($product['product_id']==956){
						print_r($unit);
					}
					*/
				//foreach($prodUnits as $prodUnit){
					if($unit['switchSortOrder']==1){
						$unit_array=[$unit["name"],$unit["name_package_dimension"],$unit["name_plural"]];
					}
					if($unit['isPackageBase']){
						
						if($unit['isPriceBase']==1){
							$price=$unit['price'];
						}else{
							$price=$unit['price']*$unit['calcKoef'];
						}
						$weight=$unit['weight'];						
					}
					if (0 != $unit['switchSortOrder']) {
						$key = (int)$unit['switchSortOrder'];
						//print_r($unit);
						
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
				
				$uiUnit = null;
				//print_r($prodUnits);
				//$uiUnitAr = QueryHelper::arrayWhere($prodUnits, 'switchSortOrder', 1);

				if(!$price){
					$price=$product['price'];
				}
				
				$del_price=0;
				//and $product["mincount"]>1
				if($product['quantity']<=0 and $mincount>1 ){
					$cnt=$this->model_extension_feed_yandex_market->declOfNum($mincount,$unit_array);
					$product_name=$product['meta_h1']." (".$mincount." ".$cnt.")";
					if($mincount>0){
						$weight=$weight*$mincount;
						$price=$product['price']*$mincount;
					}
				}else{
					$product_name=$product['meta_h1'];
				}
				
				
				foreach($delivery_weights_rev as $del_weight=>$key){
					if($weight<=$del_weight){
						$del_price=$key[0];
					}
				}
				
				$del_price_val = preg_replace('~[^0-9]+~','',$del_price);
				//echo $del_price_val."<br/>";
				$data = array();

				
				
				//$delivery_price=$this->model_catalog_product->getDelivery($product['product_id'],$weight);
				//$data['sales_notes']=$delivery_price;

				// Атрибуты товарного предложения
				$data['id'] = $product['product_id'];
//				$data['type'] = 'vendor.model';
				//$data['available'] = ($product['quantity'] > 0 || $product['stock_status_id'] == $in_stock_id);
				$data['available'] =($product['quantity'] > 0);
//				$data['bid'] = 10;
//				$data['cbid'] = 15;

				// Параметры товарного предложения
				//."&utm_source=market&utm_medium=cpc"
				$data['url'] = $this->url->link('product/product', 'path=' . $this->getPath($product['category_id']) . '&product_id=' . $product['product_id'])."?utm_source=market&utm_medium=cpc&utm_term=".$product['product_id'];
				
				$data['price'] = $this->currency->convert($this->tax->calculate($price, $product['tax_class_id']), $shop_currency, $offers_currency);
				$data['currencyId'] = $offers_currency;
				$data['categoryId'] = $product['category_id'];
				$data['delivery'] = 'true';

				
				if($product['quantity'] > 0){
					$data['pickup'] = 'true';
					/*$data['delivery-options'] = Array(
						
						'option'=>Array(
							"cost"=>$del_price_val,
							"days"=>"1",
							"order-before"=>"14"
						)
					);
					*/	
					$data['delivery-options'] = Array(
						'option'=>Array(
							"cost"=>$del_price_val,
							"days"=>"1-3"
						)
					);
				
				}else{
					$data['pickup'] = 'false';
					$data['delivery-options'] = Array(
						'option'=>Array(
							"cost"=>$del_price_val,
							"days"=>"1-3"
						)
					);
				}
				
				//<option cost="300" days="1" order-before="18"/>
				

//				$data['local_delivery_cost'] = 100;

				//$data['name'] = $product['meta_h1'];
				$data['name'] = $product_name;
				$data['vendor'] = $product['manufacturer'];
				$data['vendorCode'] = $product['model'];
				$data['model'] = $product['name'];
				$data['description'] = $product['description'];
				$data['sales_notes']='Цена доставки зависит от адреса и веса товара';

//				$data['manufacturer_warranty'] = 'true';
//				$data['barcode'] = $product['sku'];
				if ($product['image']) {
					//$data['picture'] = $this->model_tool_image->resize($product['image'], 100, 100);
					$data['picture'] = HTTP_SERVER.'image/'.$product['image'];
				}
/*
				// пример структуры массива для вывода параметров
				$data['param'] = array(
					array(
						'name'=>'Wi-Fi',
						'value'=>'есть'
					), array(
						'name'=>'Размер экрана',
						'unit'=>'дюйм',
						'value'=>'20'
					), array(
						'name'=>'Вес',
						'unit'=>'кг',
						'value'=>'4.6'
					)
				);
*/
				//print_r($data);
				$this->setOffer($data);
				
				
			}

			//$this->categories = array_filter($this->categories, array($this, "filterCategory"));

			$this->response->addHeader('Content-Type: application/xml');
			$this->response->setOutput($this->getYml());
		}
	}

	/**
	 *  Опции доставки
	 */
	private function setDeliveryOptions(){
		if($this->config->get('yandex_market_deliverycost')){
			$del_array['cost']=$this->config->get('yandex_market_deliverycost');
		}
		if($this->config->get('yandex_market_deliverydate')){
			$del_array['days']=$this->config->get('yandex_market_deliverydate');
		}
		if($this->config->get('yandex_market_deliverypre')){
			$del_array['order-before']=$this->config->get('yandex_market_deliverypre');
		}

		$this->deliveries[] = $del_array;
		/*
		<delivery-options>
			<option cost="600" days="1-3" order-before="16"/>
		</delivery-options>
	 */
		//return true;
		return $del_array;
	}


	/**
	 * Методы формирования YML
	 */

	/**
	 * Формирование массива для элемента shop описывающего магазин
	 *
	 * @param string $name - Название элемента
	 * @param string $value - Значение элемента
	 */
	private function setShop($name, $value) {
		$allowed = array('name', 'company', 'url', 'phone', 'platform', 'version', 'agency', 'email');
		if (in_array($name, $allowed)) {
			$this->shop[$name] = $this->prepareField($value);
		}
	}

	/**
	 * Валюты
	 *
	 * @param string $id - код валюты (RUR, RUB, USD, BYR, KZT, EUR, UAH)
	 * @param float|string $rate - курс этой валюты к валюте, взятой за единицу.
	 *	Параметр rate может иметь так же следующие значения:
	 *		CBRF - курс по Центральному банку РФ.
	 *		NBU - курс по Национальному банку Украины.
	 *		NBK - курс по Национальному банку Казахстана.
	 *		СВ - курс по банку той страны, к которой относится интернет-магазин
	 * 		по Своему региону, указанному в Партнерском интерфейсе Яндекс.Маркета.
	 * @param float $plus - используется только в случае rate = CBRF, NBU, NBK или СВ
	 *		и означает на сколько увеличить курс в процентах от курса выбранного банка
	 * @return bool
	 */
	private function setCurrency($id, $rate = 'CBRF', $plus = 0) {
		$allow_id = array('RUR', 'RUB', 'USD', 'BYR', 'KZT', 'EUR', 'UAH');
		if (!in_array($id, $allow_id)) {
			return false;
		}
		$allow_rate = array('CBRF', 'NBU', 'NBK', 'CB');
		if (in_array($rate, $allow_rate)) {
			$plus = str_replace(',', '.', $plus);
			if (is_numeric($plus) && $plus > 0) {
				$this->currencies[] = array(
					'id'=>$this->prepareField(strtoupper($id)),
					'rate'=>$rate,
					'plus'=>(float)$plus
				);
			} else {
				$this->currencies[] = array(
					'id'=>$this->prepareField(strtoupper($id)),
					'rate'=>$rate
				);
			}
		} else {
			$rate = str_replace(',', '.', $rate);
			if (!(is_numeric($rate) && $rate > 0)) {
				return false;
			}
			$this->currencies[] = array(
				'id'=>$this->prepareField(strtoupper($id)),
				'rate'=>(float)$rate
			);
		}

		return true;
	}

	/**
	 * Категории товаров
	 *
	 * @param string $name - название рубрики
	 * @param int $id - id рубрики
	 * @param int $parent_id - id родительской рубрики
	 * @return bool
	 */
	private function setCategory($name, $id, $parent_id = 0) {
		$id = (int)$id;
		if ($id < 1 || trim($name) == '') {
			return false;
		}
		if ((int)$parent_id > 0) {
			$this->categories[$id] = array(
				'id'=>$id,
				'parentId'=>(int)$parent_id,
				'name'=>$this->prepareField($name)
			);
		} else {
			$this->categories[$id] = array(
				'id'=>$id,
				'name'=>$this->prepareField($name)
			);
		}

		return true;
	}

	/**
	 * Товарные предложения
	 *
	 * @param array $data - массив параметров товарного предложения
	 */
	private function setOffer($data) {
		//print_r($data);
		
		$offer = array();
		
		$attributes = array('id', 'type', 'available', 'bid', 'cbid', 'param');
		$attributes = array_intersect_key($data, array_flip($attributes));
		
		foreach ($attributes as $key => $value) {
			switch ($key)
			{
				case 'id':
				case 'bid':
				case 'cbid':
					$value = (int)$value;
					if ($value > 0) {
						$offer[$key] = $value;
					}
					break;

				case 'type':
					if (in_array($value, array('vendor.model', 'book', 'audiobook', 'artist.title', 'tour', 'ticket', 'event-ticket'))) {
						$offer['type'] = $value;
					}
					break;

				case 'available':
					$offer['available'] = ($value ? 'true' : 'false');
					break;

				case 'param':
					if (is_array($value)) {
						$offer['param'] = $value;
					}
					break;

				default:
					break;
			}
		}
		
		$type = isset($offer['type']) ? $offer['type'] : '';

		$allowed_tags = array('url'=>0, 'buyurl'=>0, 'price'=>1, 'wprice'=>0, 'currencyId'=>1, 'xCategory'=>0, 'categoryId'=>1, 'picture'=>0, 'store'=>0, 'pickup'=>0, 'delivery'=>0, 'delivery-options'=>0, 'deliveryIncluded'=>0, 'local_delivery_cost'=>0, 'orderingTime'=>0);

		switch ($type) {
			case 'vendor.model':
				$allowed_tags = array_merge($allowed_tags, array('typePrefix'=>0, 'vendor'=>1, 'vendorCode'=>0, 'model'=>1, 'provider'=>0, 'tarifplan'=>0));
				break;

			case 'book':
				$allowed_tags = array_merge($allowed_tags, array('author'=>0, 'name'=>1, 'publisher'=>0, 'series'=>0, 'year'=>0, 'ISBN'=>0, 'volume'=>0, 'part'=>0, 'language'=>0, 'binding'=>0, 'page_extent'=>0, 'table_of_contents'=>0));
				break;

			case 'audiobook':
				$allowed_tags = array_merge($allowed_tags, array('author'=>0, 'name'=>1, 'publisher'=>0, 'series'=>0, 'year'=>0, 'ISBN'=>0, 'volume'=>0, 'part'=>0, 'language'=>0, 'table_of_contents'=>0, 'performed_by'=>0, 'performance_type'=>0, 'storage'=>0, 'format'=>0, 'recording_length'=>0));
				break;

			case 'artist.title':
				$allowed_tags = array_merge($allowed_tags, array('artist'=>0, 'title'=>1, 'year'=>0, 'media'=>0, 'starring'=>0, 'director'=>0, 'originalName'=>0, 'country'=>0));
				break;

			case 'tour':
				$allowed_tags = array_merge($allowed_tags, array('worldRegion'=>0, 'country'=>0, 'region'=>0, 'days'=>1, 'dataTour'=>0, 'name'=>1, 'hotel_stars'=>0, 'room'=>0, 'meal'=>0, 'included'=>1, 'transport'=>1, 'price_min'=>0, 'price_max'=>0, 'options'=>0));
				break;

			case 'event-ticket':
				$allowed_tags = array_merge($allowed_tags, array('name'=>1, 'place'=>1, 'hall'=>0, 'hall_part'=>0, 'date'=>1, 'is_premiere'=>0, 'is_kids'=>0));
				break;

			default:
				$allowed_tags = array_merge($allowed_tags, array('name'=>1, 'vendor'=>0, 'vendorCode'=>0));
				break;
		}

		$allowed_tags = array_merge($allowed_tags, array('aliases'=>0, 'additional'=>0, 'description'=>0, 'sales_notes'=>0, 'promo'=>0, 'manufacturer_warranty'=>0, 'country_of_origin'=>0, 'downloadable'=>0, 'adult'=>0, 'barcode'=>0));

		$required_tags = array_filter($allowed_tags);
		
		if (sizeof(array_intersect_key($data, $required_tags)) != sizeof($required_tags)) {
			return;
		}
		
		
		$data = array_intersect_key($data, $allowed_tags);
//		if (isset($data['tarifplan']) && !isset($data['provider'])) {
//			unset($data['tarifplan']);
//		}

		$allowed_tags = array_intersect_key($allowed_tags, $data);

		// Стандарт XML учитывает порядок следования элементов,
		// поэтому важно соблюдать его в соответствии с порядком описанным в DTD
		$offer['data'] = array();
		foreach ($allowed_tags as $key => $value) {
			if(is_array($data[$key])){
				$offer['data'][$key] = $data[$key];
			}else{
				$offer['data'][$key] = $this->prepareField($data[$key]);
			}
		}

		$this->offers[] = $offer;
	}

	/**
	 * Формирование YML файла
	 *
	 * @return string
	 */
	private function getYml() {
		$yml  = '<?xml version="1.0" encoding="windows-1251"?>' . $this->eol;
		$yml .= '<!DOCTYPE yml_catalog SYSTEM "shops.dtd">' . $this->eol;
		$yml .= '<yml_catalog date="' . date('Y-m-d H:i') . '">' . $this->eol;
		$yml .= '<shop>' . $this->eol;

		// информация о магазине
		$yml .= $this->array2Tag($this->shop);

		// опции доставки
		
		$yml .= '<delivery-options>' . $this->eol;
		//print_r($this->deliveries);
		
		foreach ($this->deliveries as $delivery) {
			$yml .= $this->getElement($delivery, 'option ');
		}
		
		$yml .= '</delivery-options>' . $this->eol;
		/**/

		// валюты
		$yml .= '<currencies>' . $this->eol;
		foreach ($this->currencies as $currency) {
			$yml .= $this->getElement($currency, 'currency');
		}
		$yml .= '</currencies>' . $this->eol;

		// категории
		$yml .= '<categories>' . $this->eol;
		foreach ($this->categories as $category) {
			$category_name = $category['name'];
			unset($category['name'], $category['export']);
			$yml .= $this->getElement($category, 'category', $category_name);
		}
		$yml .= '</categories>' . $this->eol;

		// товарные предложения
		$yml .= '<offers>' . $this->eol;
		
		foreach ($this->offers as $offer) {
			
			$tags = $this->array2Tag($offer['data']);
			
			unset($offer['data']);
			if (isset($offer['param'])) {
				$tags .= $this->array2Param($offer['param']);
				unset($offer['param']);
			}
			$yml .= $this->getElement($offer, 'offer', $tags);
		}
		$yml .= '</offers>' . $this->eol;

		$yml .= '</shop>';
		$yml .= '</yml_catalog>';

		return $yml;
	}

	/**
	 * Фрмирование элемента
	 *
	 * @param array $attributes
	 * @param string $element_name
	 * @param string $element_value
	 * @return string
	 */
	private function getElement($attributes, $element_name, $element_value = '') {
		$retval = '<' . $element_name . ' ';
		foreach ($attributes as $key => $value) {
			if(is_array($value)){

			}else{
				$retval .= $key . '="' . $value . '" ';
			}
		}
		$retval .= $element_value ? '>' . $this->eol . $element_value . '</' . $element_name . '>' : '/>';
		$retval .= $this->eol;

		return $retval;
	}

	/**
	 * Преобразование массива в теги
	 *
	 * @param array $tags
	 * @return string
	 */
	private function array2Tag($tags) {
		$retval = '';
		foreach ($tags as $key => $value) {
			if(!is_array($value)){
				$retval .= '<' . $key . '>' . $value . '</' . $key . '>' . $this->eol;
			}else{
				//echo "!".$key."!";
				foreach($value as $key_arr=>$item_arr){
					$str="";
					foreach($item_arr as $itm=>$key){
						$str.=' '.$itm.'="'.$key.'"';
					}
					$str="<".$key_arr.$str."></".$key_arr.">";
				}
				//echo $key."==".$value;
				
				$retval.="<delivery-options>".$str."</delivery-options>";
				//$retval .= '<' . $key . '><option cost="te"></option></' . $key . '>' . $this->eol;
			}
		}

		return $retval;
	}

	/**
	 * Преобразование массива в теги параметров
	 *
	 * @param array $params
	 * @return string
	 */
	private function array2Param($params) {
		$retval = '';
		foreach ($params as $param) {
			$retval .= '<param name="' . $this->prepareField($param['name']);
			if (isset($param['unit'])) {
				$retval .= '" unit="' . $this->prepareField($param['unit']);
			}
			$retval .= '">' . $this->prepareField($param['value']) . '</param>' . $this->eol;
		}

		return $retval;
	}

	/**
	 * Подготовка текстового поля в соответствии с требованиями Яндекса
	 * Запрещаем любые html-тэги, стандарт XML не допускает использования в текстовых данных
	 * непечатаемых символов с ASCII-кодами в диапазоне значений от 0 до 31 (за исключением
	 * символов с кодами 9, 10, 13 - табуляция, перевод строки, возврат каретки). Также этот
	 * стандарт требует обязательной замены некоторых символов на их символьные примитивы.
	 * @param string $text
	 * @return string
	 */
	private function prepareField($field) {
		$field = htmlspecialchars_decode($field);
		$field = strip_tags($field);
		$from = array('"', '&', '>', '<', '\'');
		$to = array('&quot;', '&amp;', '&gt;', '&lt;', '&apos;');
		$field = str_replace($from, $to, $field);
		if ($this->from_charset != 'windows-1251') {
			$field = iconv($this->from_charset, 'windows-1251//TRANSLIT//IGNORE', $field);
		}
		$field = preg_replace('#[\x00-\x08\x0B-\x0C\x0E-\x1F]+#is', ' ', $field);

		return trim($field);
	}

	protected function getPath($category_id, $current_path = '') {
		if (isset($this->categories[$category_id])) {
			$this->categories[$category_id]['export'] = 1;

			if (!$current_path) {
				$new_path = $this->categories[$category_id]['id'];
			} else {
				$new_path = $this->categories[$category_id]['id'] . '_' . $current_path;
			}

			if (isset($this->categories[$category_id]['parentId'])) {
				return $this->getPath($this->categories[$category_id]['parentId'], $new_path);
			} else {
				return $new_path;
			}

		}
	}

	function filterCategory($category) {
		return isset($category['export']);
	}
}
?>
