<?php
class ControllerCatalogDiler extends Controller {
	private $error = array();
	
	public function index() {
        $this->load->language('catalog/dopinfo');
		$this->document->setTitle($this->language->get('heading_title_diler'));

		$this->load->model('catalog/diler');
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
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_data'] = $this->language->get('tab_data');

		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_content'] = $this->language->get('entry_content');
		$data['entry_meta_title'] = $this->language->get('entry_meta_title');
		$data['entry_h1'] = $this->language->get('entry_h1');
		$data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$data['entry_meta_keywords'] = $this->language->get('entry_meta_keywords');
		$data['entry_link'] = $this->language->get('entry_link');
		$data['entry_link_caption'] = $this->language->get('entry_link_caption');
		
		


		$data['heading_title'] = $this->language->get('heading_title_diler');

		$data['text_form'] = $this->language->get('text_edit_diler');
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
			'text' => $this->language->get('heading_title_diler'),
			'href' => $this->url->link('catalog/diler', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['action'] = $this->url->link('catalog/diler/edit', 'token=' . $this->session->data['token'] . $url, true);
		$data['cancel'] = $this->url->link('catalog/diler', 'token=' . $this->session->data['token'] . $url, true);
			
			
		$diler_info = $this->model_catalog_diler->getDilerInfo();
		if(isset($diler_info)){
			//title	content	meta_title	meta_h1	meta_description	meta_keywords	link_caption	link
			$data['title']=$diler_info['title'];
			$data['content']=$diler_info['content'];
			$data['meta_title']=$diler_info['meta_title'];
			$data['meta_h1']=$diler_info['meta_h1'];
			$data['meta_description']=$diler_info['meta_description'];
			$data['meta_keywords']=$diler_info['meta_keywords'];
			$data['link_caption']=$diler_info['link_caption'];
			$data['link']=$diler_info['link'];
			
		}
		
		$data['token'] = $this->session->data['token'];
		$data['ckeditor'] = $this->config->get('config_editor_default');
	
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		

		$this->response->setOutput($this->load->view('catalog/diler_form', $data));
	}
	public function edit() {
		$this->load->model('tool/lastmod');
		$this->model_tool_lastmod->setLastTime(['diler'],time());

        $this->load->language('catalog/dopinfo');
        
		$this->document->setTitle($this->language->get('heading_title_diler'));

		$this->load->model('catalog/diler');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			
			$this->model_catalog_diler->editDiler($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			$this->response->redirect($this->url->link('catalog/diler', 'token=' . $this->session->data['token'] . $url, true));
			/**/
		}
		
		$this->getForm();
		
	}
	
}