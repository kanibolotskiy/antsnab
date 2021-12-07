<?php
class ControllerCatalogAbout extends Controller {
	private $error = array();
	
	public function index() {
        $this->load->language('catalog/dopinfo');
		$this->document->setTitle($this->language->get('heading_title_about'));

		$this->load->model('catalog/about');
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
		$this->load->model('tool/image');
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_data'] = $this->language->get('tab_data');

		$data['tab_data'] = $this->language->get('tab_data');
		$data['tab_cust'] = $this->language->get('tab_cust');
		$data['tab_off'] = $this->language->get('tab_off');
		$data['tab_man'] = $this->language->get('tab_man');
		$data['tab_sklad'] = $this->language->get('tab_sklad');
		$data['tab_req'] = $this->language->get('tab_req');
		$data['tab_sert'] = $this->language->get('tab_sert');
		

		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_content'] = $this->language->get('entry_content');
		$data['entry_meta_title'] = $this->language->get('entry_meta_title');
		$data['entry_h1'] = $this->language->get('entry_h1');
		$data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$data['entry_meta_keywords'] = $this->language->get('entry_meta_keywords');
		$data['entry_download'] = $this->language->get('entry_download');

		$data['entry_content_cust'] = $this->language->get('entry_content_cust');
		$data['entry_content_man'] = $this->language->get('entry_content_man');
		$data['entry_content_sklad'] = $this->language->get('entry_content_sklad');
		$data['entry_content_off'] = $this->language->get('entry_content_off');
		$data['entry_req'] = $this->language->get('entry_req');
		
		
		$data['heading_title'] = $this->language->get('heading_title_about');
		$data['text_form'] = $this->language->get('text_edit_about');
			

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
			'text' => $this->language->get('heading_title_about'),
			'href' => $this->url->link('catalog/about', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['action'] = $this->url->link('catalog/about/edit', 'token=' . $this->session->data['token'] . $url, true);
		$data['cancel'] = $this->url->link('catalog/about', 'token=' . $this->session->data['token'] . $url, true);
			
			
		$about_info = $this->model_catalog_about->getAboutInfo();

		if(isset($about_info)){
			//title	content	meta_title	meta_h1	meta_description	meta_keywords	link_caption	link
			$data['title']=$about_info['title'];
			$data['content']=$about_info['content'];
			$data['meta_title']=$about_info['meta_title'];
			$data['meta_h1']=$about_info['meta_h1'];
			$data['meta_description']=$about_info['meta_description'];
			$data['meta_keywords']=$about_info['meta_keywords'];

			$data['content_off']=$about_info['content_off'];
			$data['content_cust']=$about_info['content_cust'];
			$data['content_man']=$about_info['content_man'];
			$data['content_sklad']=$about_info['content_sklad'];
			$data['content_req']=$about_info['content_req'];
			

		}
		$data['image_placeholder']=$this->model_tool_image->resize('no_image.png', 100, 100);

		$about_info = $this->model_catalog_about->getAboutBlock();
		foreach($about_info as $key=>$about_row){
			$data['about_info'][$key]=$about_info[$key];

			if(isset($about_info[$key]['data']['image'])){
				$data['about_info'][$key]['thumb']=$this->model_tool_image->resize($about_info[$key]['data']['image'], 100, 100);
			}else{
				$data['about_info'][$key]['thumb']=$data['image_placeholder'];
			}
			
		}
	
		$cust_info = $this->model_catalog_about->getAboutCustomers();
		
		$data['cust_info']=[];
		foreach($cust_info as $key=>$cust_row){
			$data['cust_info'][$cust_row["id"]]=$cust_info[$key];
			if($cust_row['image']){
				$data['cust_info'][$cust_row["id"]]['thumb']=$this->model_tool_image->resize($cust_row['image'], 100, 100);
			}else{
				$data['cust_info'][$cust_row["id"]]['thumb']=$this->model_tool_image->resize('no_image.png', 100, 100);
			}
		}

		$off_info = $this->model_catalog_about->getAboutOff();
		$data['off_info']=[];
		foreach($off_info as $key=>$off_row){
			$data['off_info'][$off_row["id"]]=$off_info[$key];
			if($off_row['image']){
				$data['off_info'][$off_row["id"]]['thumb']=$this->model_tool_image->resize($off_row['image'], 100, 100);
			}else{
				$data['off_info'][$off_row["id"]]['thumb']=$this->model_tool_image->resize('no_image.png', 100, 100);
			}
		}

		$man_info = $this->model_catalog_about->getAboutMan();
		$data['man_info']=[];
		foreach($man_info as $key=>$man_row){
			$data['man_info'][$man_row["id"]]=$man_info[$key];
			if($man_row['image']){
				$data['man_info'][$man_row["id"]]['thumb']=$this->model_tool_image->resize($man_row['image'], 100, 100);
			}else{
				$data['man_info'][$man_row["id"]]['thumb']=$this->model_tool_image->resize('no_image.png', 100, 100);
			}
		}

		$sklad_info = $this->model_catalog_about->getAboutSklad();
		$data['sklad_info']=[];
		foreach($sklad_info as $key=>$sklad_row){
			$data['sklad_info'][$sklad_row["id"]]=$sklad_info[$key];
			if($sklad_row['image']){
				$data['sklad_info'][$sklad_row["id"]]['thumb']=$this->model_tool_image->resize($sklad_row['image'], 100, 100);
			}else{
				$data['sklad_info'][$sklad_row["id"]]['thumb']=$this->model_tool_image->resize('no_image.png', 100, 100);
			}
		}

		$this->load->model('catalog/download');
		
		$information_downloads = $this->model_catalog_about->getAboutDownloads(1);
		$data['information_downloads'] = [];
		foreach ($information_downloads as $download_id) {
			$download_info = $this->model_catalog_download->getDownload($download_id);
			if ($download_info) {
				$data['information_downloads'][] = array(
					'download_id' => $download_info['download_id'],
					'name'        => $download_info['name']
				);
			}
		}


		$sert_info = $this->model_catalog_about->getAboutSert();
		$data['sert_info']=[];
		foreach($sert_info as $key=>$sert_row){
			$data['sert_info'][$sert_row["id"]]=$sert_info[$key];
			if($sert_row['image']){
				$data['sert_info'][$sert_row["id"]]['thumb']=$this->model_tool_image->resize($sert_row['image'], 100, 100);
			}else{
				$data['sert_info'][$sert_row["id"]]['thumb']=$this->model_tool_image->resize('no_image.png', 100, 100);
			}
		}


		$data['token'] = $this->session->data['token'];
		$data['ckeditor'] = $this->config->get('config_editor_default');
	
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('catalog/about_form', $data));
	}
	public function edit() {
		


        $this->load->language('catalog/dopinfo');
        
		$this->document->setTitle($this->language->get('heading_title_about'));

		$this->load->model('catalog/about');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			$this->load->model('tool/lastmod');
			$this->model_tool_lastmod->setLastTime(['information/about'],time());
				
			$this->model_catalog_about->editAbout($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			$this->response->redirect($this->url->link('catalog/about', 'token=' . $this->session->data['token'] . $url, true));
			/**/
		}
		$this->getForm();
		
	}
	
}