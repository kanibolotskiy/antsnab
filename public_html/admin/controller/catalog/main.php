<?php
class ControllerCatalogMain extends Controller {
	private $error = array();
	
	public function index() {
        $this->load->language('catalog/dopinfo');
		$this->document->setTitle($this->language->get('heading_title_main'));

		$this->load->model('catalog/main');
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

		$data['heading_title'] = $this->language->get('heading_title_main');
		

		$data['text_form'] = $this->language->get('text_edit_main');
			

		$data['entry_video'] = $this->language->get('entry_video');
		$data['entry_description'] = $this->language->get('entry_description_seo');
	

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
			'text' => $this->language->get('heading_title_main'),
			'href' => $this->url->link('catalog/main', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['action'] = $this->url->link('catalog/main/edit', 'token=' . $this->session->data['token'] . $url, true);
		$data['cancel'] = $this->url->link('catalog/main', 'token=' . $this->session->data['token'] . $url, true);
			
			
		$main_info = $this->model_catalog_main->getMainInfo();
		if(isset($main_info)){
			$data['video']=$main_info['video'];
			$data['description']=$main_info['description'];
		}else{
			$data['video']='';
			$data['description']='';
		}
		
		$data['token'] = $this->session->data['token'];
		$data['ckeditor'] = $this->config->get('config_editor_default');
	
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('catalog/main_form', $data));
	}
	public function edit() {
		
        $this->load->language('catalog/dopinfo');
        
		$this->document->setTitle($this->language->get('heading_title_main'));

		$this->load->model('catalog/main');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			
			$this->model_catalog_main->editMain($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			$this->response->redirect($this->url->link('catalog/main', 'token=' . $this->session->data['token'] . $url, true));
			/**/
		}
		
		$this->getForm();
		
	}
	
}