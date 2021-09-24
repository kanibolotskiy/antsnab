<?php
class ControllerCatalogOzon extends Controller {
	private $error = array();
	
	public function index() {
        $this->load->language('catalog/dopinfo');
		$this->document->setTitle($this->language->get('heading_title_ozon'));

		//$this->load->model('catalog/ozon');
		//$this->getList();
		$this->getForm();
	}
	
	protected function getForm() {
		//CKEditor
        if ($this->config->get('config_editor_default')) {
            
            $this->document->addScript('view/javascript/ckeditor/ckeditor.js');
            $this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
        } else {
            $this->document->addScript('view/javascript/summernote/summernote.js');
            $this->document->addScript('view/javascript/summernote/lang/summernote-' . $this->language->get('lang') . '.js');
            $this->document->addScript('view/javascript/summernote/opencart.js');
            $this->document->addStyle('view/javascript/summernote/summernote.css');
        }
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
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
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title_ozon'),
			'href' => $this->url->link('catalog/ozon', 'token=' . $this->session->data['token'] . $url, true)
		);
		/*
		if (!isset($this->request->get['accompany_id'])) {
			$data['action'] = $this->url->link('catalog/accompany/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/accompany/edit', 'token=' . $this->session->data['token'] . '&accompany_id=' . $this->request->get['accompany_id'] . $url, true);
		}
		*/

		$data['action'] = $this->url->link('catalog/ozon/edit', 'token=' . $this->session->data['token'] . $url, true);

		$data['cancel'] = $this->url->link('catalog/ozon', 'token=' . $this->session->data['token'] . $url, true);
			
		$data['entry_name'] = $this->language->get('entry_title');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		

		$data['heading_title'] = $this->language->get('heading_title_ozon');
		$data['text_form'] = $this->language->get('text_edit_ozon'); 
		$data['productUsed']=[];
		if (isset($this->request->get['accompany_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$accompany_info = $this->model_catalog_accompany->getAccompany($this->request->get['accompany_id']);
			$accompany_products=$this->model_catalog_accompany->getAccompanyProducts($this->request->get['accompany_id']);
			$data['name']=$accompany_info['name'];
			$data['sort_order']=$accompany_info['sort_order'];

			
			$productUsed=$this->model_catalog_accompany->getAccompanyProducts($this->request->get['accompany_id']);
			foreach($productUsed as $prUsed){
				$data['productUsed'][$prUsed['product_id']]=1;
			}

			//print_r($data['productUsed']);
		}


		$this->load->model('catalog/category');
		$parent_cat_id=71;
		$categories=[];
		$categories_tree=[];
		
		$category_list=$this->model_catalog_category->listCatalog();
		$products_list=$this->model_catalog_category->listProductsOzon(); 
		
		foreach($category_list as $category){
			$categories[$category["parent_id"]][]=$category;
		}

		if(isset($categories[$parent_cat_id])){
			foreach($categories[$parent_cat_id] as $key=>$cat_item){
				$categories_tree[$key]=$cat_item;
				$cat_child=[];
				if(isset($categories[$cat_item["category_id"]])){
					foreach($categories[$cat_item["category_id"]] as $cat_item_child){
						$cat_child2=[];
						if(isset($categories[$cat_item_child["category_id"]])){
							foreach($categories[$cat_item_child["category_id"]] as $cat_item_child2){
								$cat_item_child["list"][]=$cat_item_child2;
							}
						}
						$categories_tree[$key]["list"][]=$cat_item_child;
					}
				}
			}
		}

		$data['categories_tree']=$categories_tree;
		$data['products']=$products_list;
		

		$data['token'] = $this->session->data['token'];
		$data['ckeditor'] = $this->config->get('config_editor_default');
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('catalog/ozon_form', $data));
	}
	public function edit() {
		
        $this->load->language('catalog/dopinfo');
        
		$this->document->setTitle($this->language->get('heading_title_ozon'));

		$this->load->model('catalog/ozon');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			
			$this->model_catalog_ozon->editOzon($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			$this->response->redirect($this->url->link('catalog/ozon', 'token=' . $this->session->data['token'] . $url, true));
			/**/
		}
		
		$this->getForm();
		
	}
	
}