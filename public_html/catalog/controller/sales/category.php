<?php
use WS\Patch\Helper\ProductListHelper;
use WS\Patch\Helper\PaginationHelper;
class ControllerSalesCategory extends Controller {
	public function index() {
		
		$this->load->language('sales/sales');

		$this->load->model('catalog/sale');
		$this->load->model('tool/image');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_sales'),
			'href' => $this->url->link('sales/category')
		);

		$data["heading_title"]="Акции и скидки";
		$this->document->setTitle("Акции, скидки, специальные предложения | Ант-Снаб");
		$this->document->setDescription("На странице собраны текущие и закончившиеся акции, информация о скидках и специальные предложения на строительные материалы, инструменты и сопутствующие товары Ант-Снаб");
		$this->document->setKeywords("акции, скидки, спецпредложения, специальные предложения, строительные материалы, стройматериалы, инструменты, распродажа");

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		$data['articles'] = array();

		$limit = 9;

		$select=0;
		if(isset($_GET["active"])){
			if($_GET["active"]==1){
				$select=1;
			}else{
				$select=2;
			}
		}
		$data["select"]=$select;

		if ($limit>0) {
			
			$filter_data = array(
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit,
				'select'=>$select
			);

			//$sale_total = $this->model_catalog_sale->getTotalSales($filter_data);
			//$sale_total=$sale_total+1;
			$sale_total=3;
			$results = $this->model_catalog_sale->getSales($filter_data);
			//print_r($results);
			$sales=[];
			$dateNow=strtotime(date("Y-m-d"));
			foreach ($results as $result) {
				$date_end_str="";
				if(isset($result["date_end"])){

					$accia_type=0;

					if($dateNow>strtotime($result["date_end"])){
						//$accia_end=true;
						$accia_type=1;
					}
					$date_end_arr=explode("-",$result["date_end"]);
					$date_end_str=$date_end_arr[2].".".$date_end_arr[1].".".$date_end_arr[0];
				}else{
					$accia_type=2;
				}
				if ($result['image']) {
					$original 	= HTTP_SERVER.'image/'.$result['image'];
					//$thumb 		= $this->model_tool_image->cropsize($result['image'], 210, 102);
					$thumb 		= $this->model_tool_image->cropsize($result['image'], 605, 294);
				} else {
					$original 	= '';
					//$thumb 		= $this->model_tool_image->cropsize($result['image'], 210, 103);
					$thumb = $this->model_tool_image->resize('no_image.png', 605, 294);
				}
				if(isset($result["accia_id"])){
					$href=$this->url->link('sale/sale', 'sale_id=' . $result["accia_id"]);
				}else{
					$href="sales/".$result["keyword"]."/";
				}

				$sales[] = array(
					"accia_type"=>$accia_type,
					//"sale_id"=>$result["accia_id"],
					"title"=>$result["title"],
					"thumb"=>$thumb,
					"date_end"=>$date_end_str,
					"shorttext"=>$result["shorttext"],
					"href"=>$href
				);				
			}
			$data['sales']=$sales;
			

			$paginationModel = PaginationHelper::getPaginationModel($sale_total, (int)$limit, (int)$page);
            
			$paginationBaseUrl = $this->url->link('sales/category');
			$data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
			$lazyLoadBaseUrl = $this->url->link('sales/category');
			$data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl, $paginationModel);
			
			/*
			$pagination = new Pagination();
			$pagination->total = $sale_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('sale/category', '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($sale_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($sale_total - $limit)) ? $sale_total : ((($page - 1) * $limit) + $limit), $sale_total, ceil($sale_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			
			if ($page == 1) {
				$this->document->addLink($this->url->link('sales/category', 'SSL'), 'canonical');
			} elseif ($page == 2) {
				$this->document->addLink($this->url->link('sales/category', 'SSL'), 'prev');
			} else {
				//$this->document->addLink($this->url->link('sales/category' . '&page='. ($page - 1), 'SSL'), 'prev');
			}

			if ($limit && ceil($sale_total / $limit) > $page) {
				//$this->document->addLink( $this->url->link('sales/category') . '&page='. ($page + 1), 'SSL'), 'next');
			}
			*/
			
		}

		$data['canonical']=$this->url->link('sales/category', 'SSL');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		$this->response->setOutput($this->load->view('sale/category', $data));
		
	}

	
}