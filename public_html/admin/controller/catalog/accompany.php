<?php
class ControllerCatalogAccompany extends Controller {
	private $error = array();
	
	public function index() {
        $this->load->language('catalog/dopinfo');
		$this->document->setTitle($this->language->get('heading_title_accompany'));

		$this->load->model('catalog/accompany');
		$this->getList();
		
	}
	
	protected function getList() {
		$data=[];
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
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
			'text' => $this->language->get('heading_title_accompany'),
			'href' => $this->url->link('catalog/accompany', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['add'] = $this->url->link('catalog/accompany/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/accompany/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['heading_title'] = $this->language->get('heading_title_accompany');

		$data['text_list'] = $this->language->get('text_list_accompanies');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name_accompanies');
		$data['column_sort_order'] = $this->language->get('column_sort_order');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('catalog/accompany', 'token=' . $this->session->data['token'] . '&sort=name' . $url, true);
		$data['sort_sort_order'] = $this->url->link('catalog/accompany', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, true);

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		
		$data['accompanies'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$accompanies_total = $this->model_catalog_accompany->getTotalAccompanies();
		$results = $this->model_catalog_accompany->getAccompanies($filter_data);
		foreach ($results as $result) {
			$data['accompanies'][] = array(
				'accompany_id' => $result['accompany_id'],
				'name'            => $result['name'],
				'sort_order'      => $result['sort_order'],
				'edit'            => $this->url->link('catalog/accompany/edit', 'token=' . $this->session->data['token'] . '&accompany_id=' . $result['accompany_id'] . $url, true)
				
			);
		}

		$pagination = new Pagination();
		$pagination->total = $accompanies_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/accompany', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($accompanies_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($accompanies_total - $this->config->get('config_limit_admin'))) ? $accompanies_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $accompanies_total, ceil($accompanies_total / $this->config->get('config_limit_admin')));
		

		$data['sort'] = $sort;
		$data['order'] = $order;
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        
		$this->response->setOutput($this->load->view('catalog/accompanies_list', $data));
		
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
			'text' => $this->language->get('heading_title_accompany'),
			'href' => $this->url->link('catalog/accompany', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['accompany_id'])) {
			$data['action'] = $this->url->link('catalog/accompany/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/accompany/edit', 'token=' . $this->session->data['token'] . '&accompany_id=' . $this->request->get['accompany_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('catalog/accompany', 'token=' . $this->session->data['token'] . $url, true);
			
			
		//$about_info = $this->model_catalog_about->getAboutInfo();
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_products'] = $this->language->get('tab_products');

		$data['entry_name'] = $this->language->get('entry_title');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		

		$data['heading_title'] = $this->language->get('heading_title_accompany');
		$data['text_form'] = $this->language->get('text_edit_accompany'); 
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
		$products_list=$this->model_catalog_category->listProducts(); 
		
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
		//print_r($products_list);
		$data['products']=$products_list;

		//$data_accompany=$this->model_catalog_accompany->getAccompany();
		//title

		$data['token'] = $this->session->data['token'];
		$data['ckeditor'] = $this->config->get('config_editor_default');
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('catalog/accompany_form', $data));
	}
	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/accompany')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		return !$this->error;
	}
	public function delete() {
		$this->load->language('catalog/dopinfo');

		$this->document->setTitle($this->language->get('heading_title_accompany'));

		$this->load->model('catalog/accompany');
        
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $accompany_id) {
				$this->model_catalog_accompany->deleteAccompany($accompany_id);
			}
            
			$this->session->data['success'] = $this->language->get('text_success');

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

            $this->response->redirect($this->url->link('catalog/accompany', 'token=' . $this->session->data['token'] . $url, true));
            
		}
       
		$this->getList();
	}
	
	public function add() {
		$this->load->language('catalog/dopinfo');

		$this->document->setTitle($this->language->get('heading_title_accompany'));

		$this->load->model('catalog/accompany');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			
			$this->model_catalog_accompany->addAccompany($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

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

			$this->response->redirect($this->url->link('catalog/accompany', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}
	protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'catalog/accompany')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        if ((utf8_strlen($this->request->post['name']) < 2) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name_accompany');
        }
        
        return !$this->error;
    }
	public function edit() {
		
        $this->load->language('catalog/dopinfo');
        
		$this->document->setTitle($this->language->get('heading_title_accompany'));

		$this->load->model('catalog/accompany');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			
			$this->model_catalog_accompany->editAccompany($this->request->get['accompany_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			$this->response->redirect($this->url->link('catalog/accompany', 'token=' . $this->session->data['token'] . $url, true));
			/**/
		}
		$this->getForm();
		
	}
	
}