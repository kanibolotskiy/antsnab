<?php

/**
 * Cart Description 
 * 
 * @version    0.1, Jun 23, 2018  5:28:50 PM 
 * @author     Sergey Lapshin 
 */

namespace WS\Override\Controller\Site\Checkout;

use Phospr\Fraction;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;

//@task вынужден писать в оверрайд из за одной строчки вконце add, где меняется способ вывода количества
//количество - это не сумма едениц (напр. м2, а кол-во видов товара в корзине,товарных позиций
//подумать как убрать из override и сделать через события
//так же убрана ссылка на продукт из success message
class CartController extends \ControllerCheckoutCart
{
    const DEFAULT_STATUS_ID  = 1; //ожидание
    private $orderFormError = [];

    public function remove() {
		$this->load->language('checkout/cart');

		$json = array();

		// Remove
		if (isset($this->request->post['key'])) {
			$this->cart->remove($this->request->post['key']);

			unset($this->session->data['vouchers'][$this->request->post['key']]);

			$json['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			// Totals
			$this->load->model('extension/extension');

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;

			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);

			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
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

                //modified
                //$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
				$productsCount = $this->cart->countProductTypes();
				$productsCountStr = ProdUnitStrings::plural($productsCount, 
								'вид товара', 'вида товара', 'видов товара');
				$json['total'] = sprintf($this->language->get('text_items'), $productsCount, $productsCountStr, $this->currency->format($total, $this->session->data['currency']));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
    }

    public function add()
    {
        $this->load->language('checkout/cart');

        $json = array();

        if (isset($this->request->post['product_id'])) {
            $product_id = (int) $this->request->post['product_id'];
        } else {
            $product_id = 0;
        }

        $this->load->model('catalog/product');

        $product_info = $this->model_catalog_product->getProduct($product_id);

        if ($product_info) {
            if (isset($this->request->post['quantity']) && ((int) $this->request->post['quantity'] >= $product_info['minimum'])) {
                $quantity = (int) $this->request->post['quantity'];
            } else {
                $quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
            }

            if (isset($this->request->post['option'])) {
                $option = array_filter($this->request->post['option']);
            } else {
                $option = array();
            }

            $product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

            foreach ($product_options as $product_option) {
                if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
                    $json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
                }
            }

            if (isset($this->request->post['recurring_id'])) {
                $recurring_id = $this->request->post['recurring_id'];
            } else {
                $recurring_id = 0;
            }

            $recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

            if ($recurrings) {
                $recurring_ids = array();

                foreach ($recurrings as $recurring) {
                    $recurring_ids[] = $recurring['recurring_id'];
                }

                if (!in_array($recurring_id, $recurring_ids)) {
                    $json['error']['recurring'] = $this->language->get('error_recurring_required');
                }
            }

            if (!$json) {
                $this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);

                //modified
                $json['success'] = sprintf($this->language->get('text_success'), $product_info['meta_h1'], $this->url->link('checkout/cart'));

                // Unset all shipping and payment methods
                unset($this->session->data['shipping_method']);
                unset($this->session->data['shipping_methods']);
                unset($this->session->data['payment_method']);
                unset($this->session->data['payment_methods']);

                // Totals
                $this->load->model('extension/extension');

                $totals = array();
                $taxes = $this->cart->getTaxes();
                $total = 0;

                // Because __call can not keep var references so we put them into an array. 			
                $total_data = array(
                    'totals' => &$totals,
                    'taxes' => &$taxes,
                    'total' => &$total
                );

                // Display prices
                if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
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

                //modified
                //$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
				$productsCount = $this->cart->countProductTypes();
				$productsCountStr = ProdUnitStrings::plural($productsCount, 
								'вид товара', 'вида товара', 'видов товара');
				$json['total'] = sprintf($this->language->get('text_items'), $productsCount, $productsCountStr, $this->currency->format($total, $this->session->data['currency']));
            } else {
                $json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    //@task тут тоже фигня. ради одного скрипта добавлено
    public function index()
    {
        $data['form_data'] = [
            'name' => '',
            'phone' => '',
            'email' => '',
            'need_shipping' => 1,
            'shipping_address' => '',
        ];

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            $data['form_data'] = $this->request->post;
            if (!isset($this->request->post['need_shipping'])) {
                $data['form_data']['need_shipping'] = 0;
            }
            if ($this->validateOrderForm($this->request->post)) {
                $orderId = $this->saveOrder();
                $this->session->data['order_id'] = $orderId;
                $this->response->redirect($this->url->link('checkout/success'));
            }
        }

        $data['form_errors'] = $this->orderFormError;


        //@added
        $this->document->addStyle('admin/view/javascript/font-awesome/css/font-awesome.min.css');

        $this->load->language('checkout/cart');

        $this->document->setTitle($this->language->get('heading_title'));

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/home'),
            'text' => $this->language->get('text_home')
        );

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('checkout/cart'),
            'text' => $this->language->get('heading_title')
        );

        if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
            $data['heading_title'] = $this->language->get('heading_title');

            $data['text_recurring_item'] = $this->language->get('text_recurring_item');
            $data['text_next'] = $this->language->get('text_next');
            $data['text_next_choice'] = $this->language->get('text_next_choice');

            $data['column_image'] = $this->language->get('column_image');
            $data['column_name'] = $this->language->get('column_name');
            $data['column_model'] = $this->language->get('column_model');
            $data['column_quantity'] = $this->language->get('column_quantity');
            $data['column_price'] = $this->language->get('column_price');
            $data['column_total'] = $this->language->get('column_total');

            $data['button_update'] = $this->language->get('button_update');
            $data['button_remove'] = $this->language->get('button_remove');
            $data['button_shopping'] = $this->language->get('button_shopping');
            $data['button_checkout'] = $this->language->get('button_checkout');

            if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
                $data['error_warning'] = $this->language->get('error_stock');
            } elseif (isset($this->session->data['error'])) {
                $data['error_warning'] = $this->session->data['error'];

                unset($this->session->data['error']);
            } else {
                $data['error_warning'] = '';
            }

            if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
                $data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
            } else {
                $data['attention'] = '';
            }

            if (isset($this->session->data['success'])) {
                $data['success'] = $this->session->data['success'];

                unset($this->session->data['success']);
            } else {
                $data['success'] = '';
            }

            $data['action'] = $this->url->link('checkout/cart/edit', '', true);

            if ($this->config->get('config_cart_weight')) {
                $data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
            } else {
                $data['weight'] = '';
            }

            $this->load->model('tool/image');
            $this->load->model('tool/upload');

            $data['products'] = array();

            $products = $this->cart->getProducts();

            $orderSumTotal = 0;
            foreach ($products as $product) {
                $product_total = 0;

                /** ANTSNAB deleted check total quantity minimum */
                /*foreach ($products as $product_2) {
                    if ($product_2['product_id'] == $product['product_id']) {
                        $product_total += $product_2['quantity'];
                    }
                }

                if ($product['minimum'] > $product_total) {
                    $data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
                }*/

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
                        'name' => $option['name'],
                        'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                    );
                }

                /** 
                 * В корзине используем saleUnits (единицы измерения продажи), но нам до сих пор нужен коэффициент для
                 * пересчета wholesale threshold, тк он в еденицах кратности. А так же нам нужна saleunit для 
                 * опеределения минимального количества и шага в переключателях
                 * @task переосмыслить вместе с ProductTemplateDecorator - и вынести в отдельный метод
                 */
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

                $recurring = '';

                /** AntSnab Deleted */
                /*if ($product['recurring']) {
                    $frequencies = array(
                        'day' => $this->language->get('text_day'),
                        'week' => $this->language->get('text_week'),
                        'semi_month' => $this->language->get('text_semi_month'),
                        'month' => $this->language->get('text_month'),
                        'year' => $this->language->get('text_year'),
                    );

                    if ($product['recurring']['trial']) {
                        $recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
                    }

                    if ($product['recurring']['duration']) {
                        $recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    } else {
                        $recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    }
                }*/



                $data['products'][] = array(
                    'cart_id' => $product['cart_id'],
                    'thumb' => $image,
                    'name' => $product['name'],

                    /** @added */
                    'meta_h1' => $product['meta_h1'],
                    'model' => $product['model'],
                    'option' => $option_data,
                    'recurring' => $recurring,
                    'quantity' => $product['quantity'],
                    'stock' => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
                    'reward' => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),

                    /** @added */
                    'price' => $price,
                    'price_wholesale' => $price_wholesale,
                    'isWholesale' => $isWholesale,
                    'wholesale_threshold' => $product['wholesale_threshold'],
                    'total' => $total,
                    'priceUnit'=> $priceUnit,
                    'saleToPriceKoef' => $saleToPriceKoef,
                    'location' => $product['location'],

                    'href' => $this->url->link('product/product', 'product_id=' . $product['product_id'])
                );
            }

            // Gift Voucher
            $data['vouchers'] = array();

            /** ANTSNAB DELETED */
            /*if (!empty($this->session->data['vouchers'])) {
                foreach ($this->session->data['vouchers'] as $key => $voucher) {
                    $data['vouchers'][] = array(
                        'key' => $key,
                        'description' => $voucher['description'],
                        'amount' => $this->currency->format($voucher['amount'], $this->session->data['currency']),
                        'remove' => $this->url->link('checkout/cart', 'remove=' . $key)
                    );
                }
            }*/

            /** @task - сделать в будущем нормально через некий оптовый модуль, кстати в заказе это как то работает!!!!!!  */
            $data['totals'][] = array(
                'title' => 'Итого', 
                'text' => $this->currency->format($orderSumTotal, $this->session->data['currency'])
            );

/*
            // Totals
            $this->load->model('extension/extension');

            $totals = array();
            $taxes = $this->cart->getTaxes();
            $total = 0;

            // Because __call can not keep var references so we put them into an array. 			
            $total_data = array(
                'totals' => &$totals,
                'taxes' => &$taxes,
                'total' => &$total
            );

            // Display prices
            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
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

            $data['totals'] = array();

            foreach ($totals as $total) {
                //@added
                if ($total['code'] == 'total') {
                    $data['totals'][] = array(
                        'title' => $total['title'],
                        'text' => $this->currency->format($total['value'], $this->session->data['currency'])
                    );
                }
            }
*/

            $data['continue'] = $this->url->link('common/home');
            $data['checkout'] = $this->url->link('checkout/checkout', '', true);

            $this->load->model('extension/extension');

            $data['modules'] = array();

            $files = glob(DIR_APPLICATION . '/controller/extension/total/*.php');

            if ($files) {
                foreach ($files as $file) {
                    $result = $this->load->controller('extension/total/' . basename($file, '.php'));

                    if ($result) {
                        $data['modules'][] = $result;
                    }
                }
            }

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            //related products
            /*
            $this->load->model('catalog/product');
            $results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
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
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}*/

            $this->response->setOutput($this->load->view('checkout/cart', $data));
        } else {
            $data['heading_title'] = $this->language->get('heading_title');

            $data['text_error'] = $this->language->get('text_empty');

            $data['button_continue'] = $this->language->get('button_continue');

            $data['continue'] = $this->url->link('common/home');

            unset($this->session->data['success']);

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $this->response->setOutput($this->load->view('error/not_found', $data));
        }
    }

    private function validateOrderForm($post)
    {
        $this->load->language('checkout/cart');

        if ((utf8_strlen($post['name']) < 3) || (utf8_strlen($post['name']) > 255)) {
            $this->orderFormError['name'] = $this->language->get('error_name');
        }

        if (empty($post['phone'])) {
            $this->orderFormError['phone'] = $this->language->get('error_phone');
        } else {
            $trimmedPhone = preg_replace('~\D~', '', $post['phone']);
            if (strlen($trimmedPhone) != 10) {
                $this->orderFormError['phone'] = $this->language->get('error_phone2');
            }
        }

        if (1 != preg_match('~^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$~', $this->request->post['email'])) {
            $this->orderFormError['email'] = $this->language->get('error_email');
        }

        if (isset($post['need_shipping'])) {
            if ($post['need_shipping'] == 1 && empty($post['shipping_address'])) {
                $this->orderFormError['shipping_address'] = $this->language->get('error_shipping_address');
            }
        }

        return !$this->orderFormError;
    }

    private function saveOrder()
    {
        $orderData = $this->getOrderData();
        //@task - не резолвит почему - то обычным способом
        //вообще жесть какая то с этой моделью. есть модификация! добавлена строка 170 track_no
        //сейчас работает поверх оригинального класса. который тоже переделан, для отправки писем

        include_once 'catalog/model/checkout/order.php';
        $model = new \ModelCheckoutOrder($this->registry);
        $order_id = $model->addOrder($orderData);
        if ($order_id) {
            //send emails
            try {
                $model->addOrderHistory($order_id, self::DEFAULT_STATUS_ID , $comment = '', $notify = true) ;
            } catch ( \Exception $e) {

            }
        }

        return $order_id;
    }

    private function getOrderData()
    {
        $order_data = array();

        //TOTALS
        $totals = array();
        $taxes = $this->cart->getTaxes();
        $total = 0;

        // Because __call can not keep var references so we put them into an array.
        $total_data = array(
            'totals' => &$totals,
            'taxes' => &$taxes,
            'total' => &$total
        );

        $this->load->model('extension/extension');

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

        $order_data['totals'] = $totals;

        $order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
        $order_data['store_id'] = $this->config->get('config_store_id');
        $order_data['store_name'] = $this->config->get('config_name');

        if ($order_data['store_id']) {
            $order_data['store_url'] = $this->config->get('config_url');
        } else {
            if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
                $order_data['store_url'] = HTTPS_SERVER;
            } else {
                $order_data['store_url'] = HTTP_SERVER;
            }
        }

        if ($this->customer->isLogged()) {
            $this->load->model('account/customer');

            $customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

            $order_data['customer_id'] = $this->customer->getId();
            $order_data['customer_group_id'] = $customer_info['customer_group_id'];
            $order_data['firstname'] = $customer_info['firstname'];
            $order_data['lastname'] = $customer_info['lastname'];
            $order_data['email'] = $customer_info['email'];
            $order_data['telephone'] = $customer_info['telephone'];
            $order_data['fax'] = $customer_info['fax'];
            $order_data['custom_field'] = json_decode($customer_info['custom_field'], true);
        } else {
            $order_data['customer_id'] = 0;
            $order_data['customer_group_id'] = 0;
            $order_data['firstname'] = $this->request->post['name'];
            $order_data['lastname'] = $this->request->post['name'];
            $order_data['email'] = $this->request->post['email'];
            $order_data['telephone'] = $this->request->post['phone'];
            $order_data['custom_field'] = [];
        }

        $shippingAddress = (isset($this->request->post['shipping_address'])) ? $this->request->post['shipping_address'] : '';

        $order_data['payment_firstname'] = $this->request->post['name'];
        $order_data['payment_lastname'] = $this->request->post['name'];
        $order_data['payment_company'] = '';
        $order_data['payment_address_1'] = $shippingAddress;
        $order_data['payment_address_2'] = $shippingAddress;
        $order_data['payment_city'] = '';
        $order_data['payment_postcode'] = '';
        $order_data['payment_zone'] = '';
        $order_data['payment_zone_id'] = '';
        $order_data['payment_country'] = '';
        $order_data['payment_country_id'] = '';
        $order_data['payment_address_format'] = '';
        $order_data['payment_custom_field'] = [];
        $order_data['payment_method'] = '';
        $order_data['payment_code'] = '';

        $order_data['shipping_firstname'] = $this->request->post['name'];
        $order_data['shipping_lastname'] = $this->request->post['name'];
        $order_data['shipping_company'] = '';
        $order_data['shipping_address_1'] = $shippingAddress;
        $order_data['shipping_address_2'] = $shippingAddress;
        $order_data['shipping_city'] = '';
        $order_data['shipping_postcode'] = '';
        $order_data['shipping_zone'] = '';
        $order_data['shipping_zone_id'] = '';
        $order_data['shipping_country'] = '';
        $order_data['shipping_country_id'] = '';
        $order_data['shipping_address_format'] = '';
        $order_data['shipping_custom_field'] = array();
        $order_data['shipping_method'] = '';
        $order_data['shipping_code'] = '';

        $order_data['products'] = array();

        foreach ($this->cart->getProducts() as $product) {
            $option_data = array();

            foreach ($product['option'] as $option) {
                $option_data[] = array(
                    'product_option_id' => $option['product_option_id'],
                    'product_option_value_id' => $option['product_option_value_id'],
                    'option_id' => $option['option_id'],
                    'option_value_id' => $option['option_value_id'],
                    'name' => $option['name'],
                    'value' => $option['value'],
                    'type' => $option['type']
                );
            }

            $order_data['products'][] = array(
                'product_id' => $product['product_id'],
                'name' => $product['name'],
                'model' => $product['model'],
                'option' => $option_data,
                'download' => $product['download'],
                'quantity' => $product['quantity'],
                'subtract' => $product['subtract'],
                'price' => $product['price'],
                'price_wholesale' => $product['price_wholesale'],
                'wholesale_threshold' => $product['wholesale_threshold'],
                'total' => $product['total'],
                'tax' => $this->tax->getTax($product['price'], $product['tax_class_id']),
                'reward' => $product['reward']
            );
        }

        $order_data['vouchers'] = array();

        $order_data['comment'] = '';
        $order_data['total'] = $total_data['total'];

        $order_data['affiliate_id'] = 0;
        $order_data['commission'] = 0;
        $order_data['marketing_id'] = 0;
        $order_data['tracking'] = '';

        if (isset($this->request->cookie['tracking'])) {
            $order_data['tracking'] = $this->request->cookie['tracking'];

            $subtotal = $this->cart->getSubTotal();

            // Affiliate
            $this->load->model('affiliate/affiliate');

            $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);

            if ($affiliate_info) {
                $order_data['affiliate_id'] = $affiliate_info['affiliate_id'];
                $order_data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
            } else {
                $order_data['affiliate_id'] = 0;
                $order_data['commission'] = 0;
            }

            // Marketing
            $this->load->model('checkout/marketing');

            $marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);

            if ($marketing_info) {
                $order_data['marketing_id'] = $marketing_info['marketing_id'];
            } else {
                $order_data['marketing_id'] = 0;
            }
        } else {
            $order_data['affiliate_id'] = 0;
            $order_data['commission'] = 0;
            $order_data['marketing_id'] = 0;
            $order_data['tracking'] = '';
        }

        $order_data['language_id'] = $this->config->get('config_language_id');
        $order_data['currency_id'] = $this->currency->getId($this->session->data['currency']);
        $order_data['currency_code'] = $this->session->data['currency'];
        $order_data['currency_value'] = $this->currency->getValue($this->session->data['currency']);
        $order_data['ip'] = $this->request->server['REMOTE_ADDR'];

        if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
            $order_data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
        } elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
            $order_data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
        } else {
            $order_data['forwarded_ip'] = '';
        }

        if (isset($this->request->server['HTTP_USER_AGENT'])) {
            $order_data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
        } else {
            $order_data['user_agent'] = '';
        }

        if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
            $order_data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
        } else {
            $order_data['accept_language'] = '';
        }

        $order_data['fax'] = '';
        
        return $order_data;
    }

}
