<?php
class ControllerCheckoutSuccess extends Controller {
	public function index() {
		$this->load->language('checkout/success');
		$order_id='';
		if (isset($this->session->data['order_id'])) {
			$this->cart->clear();
			
			$this->session->data['save_order_od']=$this->session->data['order_id'];

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$this->load->model('account/activity');

				if ($this->customer->isLogged()) {
					$activity_data = array(
						'customer_id' => $this->customer->getId(),
						'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName(),
						'order_id'    => $this->session->data['order_id']
					);

					$this->model_account_activity->addActivity('order_account', $activity_data);
				} else {
					$activity_data = array(
						'name'     => $this->session->data['guest']['firstname'] . ' ' . $this->session->data['guest']['lastname'],
						'order_id' => $this->session->data['order_id']
					);

					$this->model_account_activity->addActivity('order_guest', $activity_data);
				}
			}

			
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['guest']);
			unset($this->session->data['comment']);
			unset($this->session->data['order_id']);
			unset($this->session->data['coupon']);
			unset($this->session->data['reward']);
			unset($this->session->data['voucher']);
			unset($this->session->data['vouchers']);
			unset($this->session->data['totals']);
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_basket'),
			'href' => $this->url->link('checkout/cart')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_checkout'),
			'href' => $this->url->link('checkout/checkout', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_success'),
			'href' => $this->url->link('checkout/success')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		if ($this->customer->isLogged()) {
			$data['text_message'] = sprintf($this->language->get('text_customer'), $this->url->link('account/account', '', true), $this->url->link('account/order', '', true), $this->url->link('account/download', '', true), $this->url->link('information/contact'));
		} else {
			$data['text_message'] = sprintf($this->language->get('text_guest'), $this->url->link('information/contact'));
		}

		$data['button_continue'] = $this->language->get('button_continue');

		$data['continue'] = $this->url->link('common/home');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		/**Текст спасибо за оформление заказа */
		$this->load->model('catalog/information');
		//echo date("H:m");
		if($this->OfficeWorkTime()){
			$information_id = 14;
		}else{
			$information_id = 13;
		}
		
		$information_info = $this->model_catalog_information->getInformation($information_id);
		$data['content']=html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');


		$data['order_id']=$this->session->data['save_order_od'];

		$this->response->setOutput($this->load->view('common/success', $data));
	}
	public function OfficeWorkTime($dummy = false) {
		$OfficeWorkTimes = array(
			
			1 => array('8:30','18:30'), // MON
			2 => array('8:30','18:30'),
			3 => array('8:30','18:30'),
			4 => array('6:30','18:30'),
			5 => array('8:30','18:30'), // FRI
			6 => null, // SUN
			0 => null // SUN
		  );
		// Return: FALSE || array('begin' -> unix_datetime, 'end' -> unix_datetime)
		
		$Now = getdate();	
		$v = $OfficeWorkTimes[$Now['wday']];
		if (null == $v) 
			return false;
		else {
			$begin = strtotime($OfficeWorkTimes[$Now['wday']][0]);
			$end = strtotime($OfficeWorkTimes[$Now['wday']][1]);
			if ( (time() < $begin ) OR ( time() > $end ) ) 
				return false;
			else 
				return true;
		}
	}
}
