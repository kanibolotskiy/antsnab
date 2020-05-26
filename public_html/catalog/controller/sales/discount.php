<?php
use WS\Patch\Helper\ProductListHelper;
class ControllerSalesDiscount extends Controller {
	public function index() {
		
		$this->load->language('sales/sales');

		$this->load->model('catalog/sale');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_sales'),
			'href' => $this->url->link('sales/category')
		);
		if (isset($this->request->get['sale_id'])) {
			$sale_id = (int)$this->request->get['sale_id'];
		} else {
			$sale_id = 0;
		}
		
		$sale_info = $this->model_catalog_sale->getSale($sale_id);
		
		if ($sale_info){
			
			if ($sale_info['meta_title']) {
				$this->document->setTitle($sale_info['meta_title']);
			} else {
				$this->document->setTitle($sale_info['title']);
			}

			$this->document->setDescription($sale_info['meta_description']);
			$this->document->setKeywords($sale_info['meta_keyword']);
			/*
			if($sale_info['noindex']){
				$this->document->setNoindex('<meta name="robots" content="noindex">');
			}
			*/
			
			$data['breadcrumbs'][] = array(
				'text' => $sale_info['title'],
				'href' => $this->url->link('sale/sale', 'sale_id=' .  $sale_id)
			);

			if ($sale_info['meta_h1']) {
				$data['heading_title'] = $sale_info['meta_h1'];
			} else {
				$data['heading_title'] = $sale_info['title'];
			}

			if($sale_info['image']){
				$this->load->model('tool/image');
				$data['image']=$this->model_tool_image->resize($sale_info['image'], 1100, 540);
			}else{
				$data['image']='';
			}
			if($sale_info['date_end']){
				$date_arr=explode("-",$sale_info['date_end']);

				$data["date_end"]=$date_arr[2].".".$date_arr[1].".".$date_arr[0];
			}
			

			$accia_products=$this->model_catalog_sale->acciaProducts($sale_id);

			$products=[];
			if($accia_products){
				//print_r($accia_products);
				$acc_pr=[];
				foreach($accia_products as $accia_product){
					$acc_pr[]=$accia_product["product_id"];
				}

				$filter_data=["product_ids"=>implode(",",$acc_pr)];

				$productsHelper = new ProductListHelper($this->registry);
				//$data["products"]=$productsHelper->getProducts($filter_data);
				$data_products=$productsHelper->getProducts($filter_data);
				foreach($data_products as $p){
					$data["p"]=$p;
					$products[]=$this->load->view('partial/product_item.tpl', $data);
				}
				$data['products']=$products;
			}
			$data['description'] = html_entity_decode($sale_info['description'], ENT_QUOTES, 'UTF-8');
			$data['continue'] = $this->url->link('common/home');
			


			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
			
			$this->response->setOutput($this->load->view('sale/sale', $data));
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('information/information', 'information_id=' . $information_id)
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

	
}