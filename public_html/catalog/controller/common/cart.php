<?php
use Phospr\Fraction;
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;
use WS\Override\Gateway\ProdProperties; 
use WS\Patch\Helper\QueryHelper;

class ControllerCommonCart extends Controller {
	public function index() {
		$this->load->language('common/cart');


		// Totals
		/*
		$this->load->model('extension/extension');

		$totals = array();
		$taxes = $this->cart->getTaxes();
		$total = 0;

		/*
		// Because __call can not keep var references so we put them into an array.
		$total_data = array(
			'totals' => &$totals,
			'taxes'  => &$taxes,
			'total'  => &$total
		);

		if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                
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
			$orderSumTotal += $rowTotal;
			
		} else {
			$price = false;
			$total = false;
		}

		// Display prices
		/*if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {

			
			$sort_order = array();

			$results = $this->model_extension_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('extension/total/' . $result['code']);

					// We have to put the totals in an array so that they pass by reference.
					$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
				}
			}

			$sort_order = array();

			foreach ($totals as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $totals);
			
		}


		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_cart'] = $this->language->get('text_cart');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_recurring'] = $this->language->get('text_recurring');

		$productsCount = $this->cart->countProductTypes();
		$productsCountStr = ProdUnitStrings::plural($productsCount, 
						'вид товара', 'вида товара', 'видов товара');
		$data['text_items'] = sprintf($this->language->get('text_items'), $productsCount, $productsCountStr, $this->currency->format($total, $this->session->data['currency']));

		// $data['text_items'] = sprintf($this->language->get('text_items'), $productsCount  + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
		$data['text_loading'] = $this->language->get('text_loading');

		$data['button_remove'] = $this->language->get('button_remove');

		$this->load->model('tool/image');
		$this->load->model('tool/upload');

		$data['products'] = array();
		$products = $this->cart->getProducts();

        $data['products']=[];
        $orderSumTotal = 0;
		foreach ($this->cart->getProducts() as $product) {
			if ($product['image']) {
				$image = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_cart_width'), $this->config->get($this->config->get('config_theme') . '_image_cart_height'));
			} else {
				$image = '';
			}

			$option_data = array();

			foreach ($product['option'] as $option) {
				if ($option['type'] != 'file') {
					$value = $option['value'];
				} else {
					$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

					if ($upload_info) {
						$value = $upload_info['name'];
					} else {
						$value = '';
					}
				}

				$option_data[] = array(
					'name'  => $option['name'],
					'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value),
					'type'  => $option['type']
				);
			}

			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$unit_price = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
				
				$price = $this->currency->format($unit_price, $this->session->data['currency']);
				$total = $this->currency->format($unit_price * $product['quantity'], $this->session->data['currency']);
			} else {
				$price = false;
				$total = false;
			}

			$data['products'][] = array(
				'cart_id'   => $product['cart_id'],
				'thumb'     => $image,
				'name'      => $product['name'],
				'model'     => $product['model'],
				'option'    => $option_data,
				'recurring' => ($product['recurring'] ? $product['recurring']['name'] : ''),
				'quantity'  => $product['quantity'],
				'price'     => $price,
				'total'     => $total,
				'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id'])
			);
		}

		// Gift Voucher
		$data['vouchers'] = array();

		if (!empty($this->session->data['vouchers'])) {
			foreach ($this->session->data['vouchers'] as $key => $voucher) {
				$data['vouchers'][] = array(
					'key'         => $key,
					'description' => $voucher['description'],
					'amount'      => $this->currency->format($voucher['amount'], $this->session->data['currency'])
				);
			}
		}

		$data['totals'] = array();
		
		foreach ($totals as $total) {
			$data['totals'][] = array(
				'title' => $total['title'],
				'text'  => $this->currency->format($total['value'], $this->session->data['currency']),
			);
		}

		$data['total'] = $this->currency->format($orderSumTotal, $this->session->data['currency']);
		$data['cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', true);
		*/


		$data['vouchers'] = array();
		$products = $this->cart->getProducts();

        $data['products']=[];
        $orderSumTotal = 0;
        foreach ($products as $product) {
            $produnitsGateway = new ProdUnits($this->registry);
            $produnitsCalcGateway = new ProdUnitsCalc($this->registry);
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
            }
            if (!$priceUnit) {
                throw new \Exception('Price base wasnt found for product ' . $product['product_id']);
            }

			
            $wholesale_threshold_in_saleUnits = Fraction::fromFloat((float)$product['wholesale_threshold']); 
            $wholesale_threshold = $wholesale_threshold_in_saleUnits->multiply($saleToPriceKoef)->toFloat(); 

            // Display prices
            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                
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
                $orderSumTotal += $rowTotal;
                
            } else {
                $price = false;
                $total = false;
            }
		}

		$data['cart'] = $this->url->link('checkout/cart');
		$data['total'] = $this->currency->format($orderSumTotal, $this->session->data['currency']);
		$data['total_count'] = $orderSumTotal;
		$data['checkout'] = $this->url->link('checkout/checkout', '', true);

		$productsCount = $this->cart->countProductTypes();
		$productsCountStr = ProdUnitStrings::plural($productsCount, 
						'товар', 'товара', 'товаров');

		//$productsCountStr = ProdUnitStrings::plural($productsCount, 
		//				'вид товара', 'вида товара', 'видов товара');

//$_['text_items']               = '<span class="left">В корзине %s<br> %s </span><strong class="right">%s</strong>';
//$_['text_items_empty']         = '<span class="left">В корзине <br>пока пусто</span><strong class="right">0 ₽</strong>';

		if($productsCount){
			$data['total_str'] = sprintf($this->language->get('text_items'), $productsCount, $productsCountStr, $this->currency->format($orderSumTotal, $this->session->data['currency']));
			//$data['total_str'] = $productsCountStr;
		}else{
			$data['total_str'] = sprintf($this->language->get('text_items_empty'), $productsCount, $productsCountStr, $this->currency->format($orderSumTotal, $this->session->data['currency']));
			//$data['total_str'] = $this->language->get('text_items_empty');
		}

		$favorite_arr=[];
		if(isset($_COOKIE["favorite"])){
			$favorite_arr=json_decode($_COOKIE["favorite"]);
		}
		$data['favorite_count'] = count($favorite_arr);
		
		$compare_arr=[];
		if(isset($_COOKIE["compare"])){
			$compare_arr=json_decode($_COOKIE["compare"]);
		}
		$data['compare_count'] = count($compare_arr);

		/*Отключаем ссылки на целевых страницах */		
		if($_SERVER['REQUEST_URI']=='/compare/'){
			$data['comp_link']=false;
		}else{
			$data['comp_link']=true;
		}
		if($_SERVER['REQUEST_URI']=='/favorite/'){
			$data['fav_link']=false;
		}else{
			$data['fav_link']=true;
		}
		
		
		return $this->load->view('common/cart', $data);
	}

	public function info() {
		$this->response->setOutput($this->index());
	}
}
