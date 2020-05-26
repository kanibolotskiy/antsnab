<?php
class ControllerCatalogAccia extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/accia');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('catalog/accia');
		$this->getList();
	}

	public function add() {
		$this->load->language('catalog/accia');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/accia');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_accia->addAccia($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_product'])) {
				$url .= '&filter_product=' . urlencode(html_entity_decode($this->request->get['filter_product'], ENT_QUOTES, 'UTF-8'));
			}
			/*
			if (isset($this->request->get['filter_author'])) {
				$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
			}
			*/

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['filter_date_start'])) {
				$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
			}
			if (isset($this->request->get['filter_date_end'])) {
				$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
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

			$this->response->redirect($this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('catalog/accia');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/accia');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_accia->editAccia($this->request->get['accia_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['filter_product'])) {
				$url .= '&filter_product=' . urlencode(html_entity_decode($this->request->get['filter_product'], ENT_QUOTES, 'UTF-8'));
			}
			/*
			if (isset($this->request->get['filter_author'])) {
				$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
			}
			*/

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['filter_date_start'])) {
				$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
			}

			if (isset($this->request->get['filter_date_end'])) {
				$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
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

			$this->response->redirect($this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/accia');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/accia');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $accia_id) {
				$this->model_catalog_accia->deleteAccia($accia_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_product'])) {
				$url .= '&filter_product=' . urlencode(html_entity_decode($this->request->get['filter_product'], ENT_QUOTES, 'UTF-8'));
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['filter_date_start'])) {
				$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
			}
			if (isset($this->request->get['filter_date_end'])) {
				$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
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

			$this->response->redirect($this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	protected function getList() {
		
		if (isset($this->request->get['filter_product'])) {
			$filter_product = $this->request->get['filter_product'];
		} else {
			$filter_product = null;
		}
		if (isset($this->request->get['filter_date_start'])) {
			$filter_date_start = $this->request->get['filter_date_start'];
		} else {
			$filter_date_start = null;
		}
		if (isset($this->request->get['filter_date_end'])) {
			$filter_date_end = $this->request->get['filter_date_end'];
		} else {
			$filter_date_end = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}

		if (isset($this->request->get['filter_date_start'])) {
			$filter_date_start = $this->request->get['filter_date_start'];
		} else {
			$filter_date_start = null;
		}

		if (isset($this->request->get['filter_date_end'])) {
			$filter_date_end = $this->request->get['filter_date_end'];
		} else {
			$filter_date_end = null;
		}

/*
		if (isset($this->request->get['filter_author'])) {
			$filter_author = $this->request->get['filter_author'];
		} else {
			$filter_author = null;
		}
		
*/
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'sort_order';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_product'])) {
			$url .= '&filter_product=' . urlencode(html_entity_decode($this->request->get['filter_product'], ENT_QUOTES, 'UTF-8'));
		}

		/*
		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
		}
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
		*/
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['add'] = $this->url->link('catalog/accia/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/accia/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['accias'] = array();

		$filter_data=[];
		
		$filter_data = array(
			'filter_product'    => $filter_product,
			'filter_status'     => $filter_status,
			'filter_date_start' => $filter_date_start,
			'filter_date_end' => $filter_date_end,
			'sort'              => $sort,
			'order'             => $order,
			'start'             => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'             => $this->config->get('config_limit_admin')
		);
		

		$accia_total = $this->model_catalog_accia->getTotalAccias($filter_data);

		$results = $this->model_catalog_accia->getAccias($filter_data);
		//print_r($results);
		$date_now=strtotime(date("Y-m-d"));
		

		foreach ($results as $result) {
			$dis="";
			if($result['date_start']){
				if(strtotime($result['date_start'])>$date_now){
					$dis="_disabled";
				}
			}
			if($result['date_end']){
				if(strtotime($result['date_end'])<$date_now){
					$dis="_disabled";
				}
			}

			$data['accias'][] = array(
				'disabled'=>$dis,
				'accia_id'  => $result['accia_id'],
				'title'       => $result['title'],
				'status'     => ($result['status']) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
				'sort_order'       => $result['sort_order'],
				'date_start' => $result['date_start']?date($this->language->get('date_format_short'), strtotime($result['date_start'])):'',
				'date_end' => $result['date_end']?date($this->language->get('date_format_short'), strtotime($result['date_end'])):'',
				'edit'       => $this->url->link('catalog/accia/edit', 'token=' . $this->session->data['token'] . '&accia_id=' . $result['accia_id'] . $url, true)
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['column_product'] = $this->language->get('column_product');
		/*
		$data['column_author'] = $this->language->get('column_author');
		$data['column_rating'] = $this->language->get('column_rating');
		*/
		$data['column_title'] = $this->language->get('column_title');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_date_start'] = $this->language->get('column_date_start');
		$data['column_date_end'] = $this->language->get('column_date_end');
		$data['column_action'] = $this->language->get('column_action');
		$data['column_sort_order'] = $this->language->get('column_sort_order');

		$data['entry_product'] = $this->language->get('entry_product');

		


		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_date_start'] = $this->language->get('entry_date_start');
		$data['entry_date_end'] = $this->language->get('entry_date_end');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_filter'] = $this->language->get('button_filter');

		$data['token'] = $this->session->data['token'];

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

		if (isset($this->request->get['filter_product'])) {
			$url .= '&filter_product=' . urlencode(html_entity_decode($this->request->get['filter_product'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		/*
		$data['sort_product'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=pd.name' . $url, true);
		$data['sort_author'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=r.author' . $url, true);
		$data['sort_about'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=r.about' . $url, true);
		$data['sort_rating'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=r.rating' . $url, true);
		

		$data['sort_date_added'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=r.date_added' . $url, true);
		*/

		$data['sort_status'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=a.status' . $url, true);
		$data['sort_sort_order'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=a.sort_order' . $url, true);
		$data['sort_title'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=a.title' . $url, true);
		$data['sort_date_start'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=a.date_start' . $url, true);
		$data['sort_date_end'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . '&sort=a.date_end' . $url, true);

		

		$url = '';

		if (isset($this->request->get['filter_product'])) {
			$url .= '&filter_product=' . urlencode(html_entity_decode($this->request->get['filter_product'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $accia_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($accia_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($accia_total - $this->config->get('config_limit_admin'))) ? $accia_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $accia_total, ceil($accia_total / $this->config->get('config_limit_admin')));

		$data['filter_product'] = $filter_product;
		/*$data['filter_author'] = $filter_author;*/
		$data['filter_status'] = $filter_status;
		$data['filter_date_start'] = $filter_date_start;
		$data['filter_date_end'] = $filter_date_end;

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/accia_list', $data));
	}

	protected function getForm() {
		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
		} else {
			$this->document->addScript('view/javascript/summernote/summernote.js');
			$this->document->addScript('view/javascript/summernote/lang/summernote-' . $this->language->get('lang') . '.js');
			$this->document->addScript('view/javascript/summernote/opencart.js');
			$this->document->addStyle('view/javascript/summernote/summernote.css');
		}
		$this->document->addScript('view/javascript/auto_translit.js');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['accia_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_product'] = $this->language->get('entry_product');
		$data['entry_date_start'] = $this->language->get('entry_date_start');
		$data['entry_date_end'] = $this->language->get('entry_date_end');

		$data['entry_image'] = $this->language->get('entry_image');
		$data['entry_banner'] = $this->language->get('entry_banner');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		

		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_products'] = $this->language->get('tab_products');

		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_shorttext'] = $this->language->get('entry_shorttext');
		$data['entry_sended'] = $this->language->get('entry_sended');

		$data['entry_meta_title'] = $this->language->get('entry_meta_title');
		$data['entry_meta_h1'] = $this->language->get('entry_meta_h1');
		$data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');


		

		

		$data['entry_keyword'] = $this->language->get('entry_keyword');

		
		$data['help_product'] = $this->language->get('help_product');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->request->get['accia_id'])) {
			$accia_id=$this->request->get['accia_id'];
		}else{
			$accia_id=0;
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['product'])) {
			$data['error_product'] = $this->error['product'];
		} else {
			$data['error_product'] = '';
		}
		/*
		if (isset($this->error['author'])) {
			$data['error_author'] = $this->error['author'];
		} else {
			$data['error_author'] = '';
		}
		*/
		if (isset($this->error['title'])) {
			$data['error_title'] = $this->error['title'];
		} else {
			$data['error_title'] = '';
		}

		if (isset($this->error['shorttext'])) {
			$data['error_shorttext'] = $this->error['shorttext'];
		} else {
			$data['error_shorttext'] = array();
		}

		if (isset($this->error['keyword'])) {
			$data['error_keyword'] = $this->error['keyword'];
		} else {
			$data['error_keyword'] = array();
		}
		if (isset($this->error['date_end'])) {
			$data['error_date_end'] = $this->error['date_end'];
		} else {
			$data['error_date_end'] = array();
		}
		

		
		/*
		if (isset($this->error['description'])) {
			$data['error_description'] = $this->error['description'];
		} else {
			$data['error_description'] = '';
		}
		if (isset($this->error['meta_title'])) {
			$data['error_meta_title'] = $this->error['meta_title'];
		} else {
			$data['error_meta_title'] = array();
		}
		if (isset($this->error['meta_h1'])) {
			$data['error_meta_h1'] = $this->error['meta_h1'];
		} else {
			$data['error_meta_h1'] = array();
		}
		if (isset($this->error['meta_description'])) {
			$data['error_meta_description'] = $this->error['meta_description'];
		} else {
			$data['error_meta_description'] = array();
		}
		if (isset($this->error['keyword'])) {
			$data['error_keyword'] = $this->error['keyword'];
		} else {
			$data['error_keyword'] = array();
		}
*/
		
		


		/*
		if (isset($this->error['rating'])) {
			$data['error_rating'] = $this->error['rating'];
		} else {
			$data['error_rating'] = '';
		}
		*/

		$url = '';

		if (isset($this->request->get['filter_product'])) {
			$url .= '&filter_product=' . urlencode(html_entity_decode($this->request->get['filter_product'], ENT_QUOTES, 'UTF-8'));
		}
		/*
		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
		}
		*/

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
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


		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['accia_id'])) {
			$data['action'] = $this->url->link('catalog/accia/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/accia/edit', 'token=' . $this->session->data['token'] . '&accia_id=' . $this->request->get['accia_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('catalog/accia', 'token=' . $this->session->data['token'] . $url, true);

		if (isset($this->request->get['accia_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$accia_info = $this->model_catalog_accia->getAccia($this->request->get['accia_id']);
		}
		$data['ckeditor'] = $this->config->get('config_editor_default');
		$data['token'] = $this->session->data['token'];

		/*
		$this->load->model('catalog/product');
		if (isset($this->request->post['product_id'])) {
			$data['product_id'] = $this->request->post['product_id'];
		} elseif (!empty($accia_info)) {
			$data['product_id'] = $accia_info['product_id'];
		} else {
			$data['product_id'] = '';
		}

		if (isset($this->request->post['product'])) {
			$data['product'] = $this->request->post['product'];
		} elseif (!empty($accia_info)) {
			$data['product'] = $accia_info['product'];
		} else {
			$data['product'] = '';
		}

		/*
		if (isset($this->request->post['author'])) {
			$data['author'] = $this->request->post['author'];
		} elseif (!empty($accia_info)) {
			$data['author'] = $accia_info['author'];
		} else {
			$data['author'] = '';
		}
		*/

		if (isset($this->request->post['title'])) {
			$data['title'] = $this->request->post['title'];
		} elseif (!empty($accia_info)) {
			$data['title'] = $accia_info['title'];
		} else {
			$data['title'] = '';
		}

		if (isset($this->request->post['description'])) {
			$data['description'] = $this->request->post['description'];
		} elseif (!empty($accia_info)) {
			$data['description'] = $accia_info['description'];
		} else {
			$data['description'] = '';
		}

		if (isset($this->request->post['shorttext'])) {
			$data['shorttext'] = $this->request->post['shorttext'];
		} elseif (!empty($accia_info)) {
			$data['shorttext'] = $accia_info['shorttext'];
		} else {
			$data['shorttext'] = '';
		}

		if (isset($this->request->post['meta_title'])) {
			$data['meta_title'] = $this->request->post['meta_title'];
		} elseif (!empty($accia_info)) {
			$data['meta_title'] = $accia_info['meta_title'];
		} else {
			$data['meta_title'] = '';
		}
		if (isset($this->request->post['meta_h1'])) {
			$data['meta_h1'] = $this->request->post['meta_h1'];
		} elseif (!empty($accia_info)) {
			$data['meta_h1'] = $accia_info['meta_h1'];
		} else {
			$data['meta_h1'] = '';
		}
		if (isset($this->request->post['meta_description'])) {
			$data['meta_description'] = $this->request->post['meta_description'];
		} elseif (!empty($accia_info)) {
			$data['meta_description'] = $accia_info['meta_description'];
		} else {
			$data['meta_description'] = '';
		}
		if (isset($this->request->post['meta_keyword'])) {
			$data['meta_keyword'] = $this->request->post['meta_keyword'];
		} elseif (!empty($accia_info)) {
			$data['meta_keyword'] = $accia_info['meta_keyword'];
		} else {
			$data['meta_keyword'] = '';
		}
		if (isset($this->request->post['keyword'])) {
			$data['keyword'] = $this->request->post['keyword'];
		} elseif (!empty($accia_info)) {
			$data['keyword'] = $accia_info['keyword'];
		} else {
			$data['keyword'] = '';
		}
		

		/*
		if (isset($this->request->post['rating'])) {
			$data['rating'] = $this->request->post['rating'];
		} elseif (!empty($accia_info)) {
			$data['rating'] = $accia_info['rating'];
		} else {
			$data['rating'] = '';
		}
		*/

		if (isset($this->request->post['date_start'])) {
			$data['date_start'] = $this->request->post['date_start'];
		} elseif (!empty($accia_info)) {
			$data['date_start'] = ($accia_info['date_start'] != '0000-00-00 00:00' ? $accia_info['date_start'] : '');
		} else {
			$data['date_start'] = '';
		}

		if (isset($this->request->post['date_end'])) {
			$data['date_end'] = $this->request->post['date_end'];
		} elseif (!empty($accia_info)) {
			$data['date_end'] = ($accia_info['date_end'] != '0000-00-00 00:00' ? $accia_info['date_end'] : '');
		} else {
			$data['date_end'] = '';
		}
/*
		if (isset($this->request->post['sended'])) {
			$data['sended'] = $this->request->post['sended'];
		} else {
			$data['sended'] = '0';
		}
*/

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($accia_info)) {
			$data['status'] = $accia_info['status'];
		} else {
			$data['status'] = '';
		}

		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($accia_info)) {
			$data['sort_order'] = $accia_info['sort_order'];
		} else {
			$data['sort_order'] = 0;
		}

		$this->load->model('tool/image');
		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		if(isset($accia_info)){
			if (is_file(DIR_IMAGE . $accia_info['image'])) {
				$image = $this->model_tool_image->resize($accia_info['image'], 200,100);
				$data["image"]=$accia_info['image'];
			} else {
				$image = $this->model_tool_image->resize('no_image.png', 100,100);
				$data["image"]='';
			}	
			if (is_file(DIR_IMAGE . $accia_info['banner'])) {
				$banner = $this->model_tool_image->resize($accia_info['banner'], 390, 100);
				$data["banner"]=$accia_info['banner'];
			} else {
				$banner = $this->model_tool_image->resize('no_image.png', 100, 100);
				$data["banner"]='';
			}
		}else{
			$image = $this->model_tool_image->resize('no_image.png', 100,100);
			$banner = $this->model_tool_image->resize('no_image.png', 100, 100);
			$data["image"]='';
			$data["banner"]='';
		}
		$data['thumb_image']=$image;
		$data['thumb_banner']=$banner;

		
		$categories=[];
		$categories_tree=[];
		$category_list=$this->model_catalog_accia->listCatalogAccias();
		foreach($category_list as $category){
			$categories[$category["parent_id"]][]=$category;
		}

		foreach($categories[71] as $key=>$cat_item){
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
		$data["accia_products"]="";
		//print_r($categories_tree);
		$data["categories_tree"]=$categories_tree;
		//oc_category

		$products=[];
		$product_list=$this->model_catalog_accia->listProductsAll();
		//echo "!".$accia_id."!";
		$productsAccia_list=$this->model_catalog_accia->productsAccia($accia_id);
		$productsAccia=[];
		foreach($productsAccia_list as $pr_accia){
			$productsAccia[$pr_accia["product_id"]]=1;
		}
		//print_r($productsAccia);

		foreach($product_list as $product){
			$products[$product["category_id"]][]=$product;
		}
		$data["products"]=$products;
		$data["productAccia"]=$productsAccia;
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('catalog/accia_form', $data));
		
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/accia')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		/*
		if (!$this->request->post['product_id']) {
			$this->error['product'] = $this->language->get('error_product');
		}

		if ((utf8_strlen($this->request->post['author']) < 3) || (utf8_strlen($this->request->post['author']) > 64)) {
			$this->error['author'] = $this->language->get('error_author');
		}
		*/
		if (utf8_strlen($this->request->post['title']) < 1) {
			$this->error['title'] = $this->language->get('error_title');
		}
		if (utf8_strlen($this->request->post['shorttext']) < 1) {
			$this->error['shorttext'] = $this->language->get('error_shorttext');
		}

		if (utf8_strlen($this->request->post['keyword']) < 1) {
			$this->error['keyword'] = $this->language->get('error_keyword');
		}
		if (utf8_strlen($this->request->post['date_end']) < 1) {
			$this->error['date_end'] = $this->language->get('error_date_end');
		}
		/*
		if (!isset($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
			$this->error['rating'] = $this->language->get('error_rating');
		}
		*/

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/accia')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
	
}