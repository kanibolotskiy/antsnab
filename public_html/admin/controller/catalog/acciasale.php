<?php
class ControllerCatalogAcciasale extends Controller {
	private $error = array();
	
	public function index() {
		
        $this->load->language('catalog/acciasale');
		$this->document->setTitle($this->language->get('heading_title_acciasale'));

		$this->load->model('catalog/acciasale');
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

		if (isset($this->error['title'])) {
			$data['error_title'] = $this->error['title'];
		} else {
			$data['error_title'] = '';
		}
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

		if (isset($this->error['shorttext'])) {
			$data['error_shorttext'] = $this->error['shorttext'];
		} else {
			$data['error_shorttext'] = array();
		}

		$accia_info = $this->model_catalog_acciasale->getAcciasaleInfo();
		

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
		$data['heading_title'] = $this->language->get('heading_title_acciasale');
		$data['text_form'] = $this->language->get('text_edit_main');
		$data['entry_description'] = $this->language->get('entry_description_seo');
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_products'] = $this->language->get('tab_products');
		*/

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		$url = '';

		

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title_acciasale'),
			'href' => $this->url->link('catalog/acciasale', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['action'] = $this->url->link('catalog/acciasale/edit', 'token=' . $this->session->data['token'] . $url, true);
		$data['cancel'] = $this->url->link('catalog/acciasale', 'token=' . $this->session->data['token'] . $url, true);
			
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

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('catalog/acciasale', $data));
	}
	public function edit() {
		
        $this->load->language('catalog/dopinfo');
        
		$this->document->setTitle($this->language->get('heading_title_acciasale'));

		$this->load->model('catalog/acciasale');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			
			$this->model_catalog_acciasale->editAcciasale($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			$this->response->redirect($this->url->link('catalog/acciasale', 'token=' . $this->session->data['token'] . $url, true));
			/**/
		}
		
		$this->getForm();
		
	}
	
}