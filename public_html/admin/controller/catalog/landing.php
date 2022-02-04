<?php
class ControllerCatalogLanding extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/landing');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('catalog/landing');
		$this->getList();
	}

	protected function getList() {

		$data['heading_title'] = $this->language->get('heading_title');
		$data['column_title'] = $this->language->get('column_title');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_action'] = $this->language->get('column_action');
		$data['column_sort_order'] = $this->language->get('column_sort_order');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');


		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
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
			'href' => $this->url->link('catalog/landing', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['add'] = $this->url->link('catalog/landing/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/landing/delete', 'token=' . $this->session->data['token'] . $url, true);

		$filter_data=[];
		$landing_total = $this->model_catalog_landing->getTotalLandings($filter_data);
		$results = $this->model_catalog_landing->getLandings($filter_data);

		$data['landings'] = array();
		foreach ($results as $result) {
			$data['landings'][] = array(
				'disabled'		=> ($result['status']) ?'':'_disabled',
				'landing_id'  	=> $result['landing_id'],
				'title'       	=> $result['title'],
				'status'     	=> ($result['status']) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
				'sort_order'	=> $result['sort_order'],
				'edit'       	=> $this->url->link('catalog/landing/edit', 'token=' . $this->session->data['token'] . '&landing_id=' . $result['landing_id'] . $url, true)
			);
		}

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('catalog/landing_list', $data));
	}

	public function add() {
		
		$this->load->language('catalog/landing');
		$this->document->setTitle($this->language->get('heading_title'));		
		$this->load->model('catalog/landing');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_landing->addLanding($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			/*
			if (isset($this->request->get['filter_product'])) {
				$url .= '&filter_product=' . urlencode(html_entity_decode($this->request->get['filter_product'], ENT_QUOTES, 'UTF-8'));
			}
			
			if (isset($this->request->get['filter_author'])) {
				$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
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
			*/
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
		
			$this->response->redirect($this->url->link('catalog/landing', 'token=' . $this->session->data['token'] . $url, true));
		}
		

		$this->getForm();
	}

	public function edit() {
		
		$this->load->language('catalog/landing');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/landing');

		

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_landing->editLanding($this->request->get['landing_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('catalog/landing', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/landing');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/landing');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $landing_id) {
				$this->model_catalog_landing->deleteLanding($landing_id);
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

			$this->response->redirect($this->url->link('catalog/landing', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	public function upload() {
		$this->load->language('catalog/download');

		$json = array();

		// Check user has permission
		if (!$this->user->hasPermission('modify', 'catalog/download')) {
			$json['error'] = $this->language->get('error_permission');
		}

		if (!$json) {
			if (!empty($this->request->files['file']['name']) && is_file($this->request->files['file']['tmp_name'])) {
				// Sanitize the filename
				$filename = basename(html_entity_decode($this->request->files['file']['name'], ENT_QUOTES, 'UTF-8'));

				// Validate the filename length
				if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 128)) {
					$json['error'] = $this->language->get('error_filename');
				}

				// Allowed file extension types
				$allowed = array();

				$extension_allowed = preg_replace('~\r?\n~', "\n", $this->config->get('config_file_ext_allowed'));

				$filetypes = explode("\n", $extension_allowed);

				foreach ($filetypes as $filetype) {
					$allowed[] = trim($filetype);
				}

				if (!in_array(strtolower(substr(strrchr($filename, '.'), 1)), $allowed)) {
					$json['error'] = $this->language->get('error_filetype');
				}

				// Allowed file mime types
				$allowed = array();

				$mime_allowed = preg_replace('~\r?\n~', "\n", $this->config->get('config_file_mime_allowed'));

				$filetypes = explode("\n", $mime_allowed);

				foreach ($filetypes as $filetype) {
					$allowed[] = trim($filetype);
				}

				if (!in_array($this->request->files['file']['type'], $allowed)) {
					$json['error'] = $this->language->get('error_filetype');
				}

				// Check to see if any PHP files are trying to be uploaded
				$content = file_get_contents($this->request->files['file']['tmp_name']);

				if (preg_match('/\<\?php/i', $content)) {
					$json['error'] = $this->language->get('error_filetype');
				}

				// Return any upload error
				if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {
					$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
				}
			} else {
				$json['error'] = $this->language->get('error_upload');
			}
		}
		
		if (!$json) {
			//$file = $filename . '.' . token(32);
			$file = $filename;
			
			//move_uploaded_file($this->request->files['file']['tmp_name'], DIR_DOWNLOAD . $file);
			move_uploaded_file($this->request->files['file']['tmp_name'], DIR_DOWNLOAD_FILES . "landing/".$file);

			$json['filename'] = $file;
			$json['mask'] = $filename;

			$json['success'] = $this->language->get('text_upload');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
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
		

		if (isset($this->request->get['landing_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			//$landing_info = $this->model_catalog_landing->getLanding($this->request->get['landing_id']);
			
			$landing_info = $this->model_catalog_landing->getLanding($this->request->get['landing_id']);
		}else{
			$landing_info=[];
		}
			$this->load->model('tool/image');
			//$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);
			$image_placeholder=$this->model_tool_image->resize('no_image.png', 100, 100);
			$data['placeholder']=$image_placeholder;

			//Основное
			$data['title']=isset($landing_info['title'])?$landing_info['title']:'';
			$data['meta_title']=isset($landing_info['meta_title'])?$landing_info['meta_title']:'';
			$data['meta_description']=isset($landing_info['meta_description'])?$landing_info['meta_description']:'';
			$data['logotext']=isset($landing_info['logotext'])?$landing_info['logotext']:'';

			$data['sort_order']=isset($landing_info['sort_order'])?$landing_info['sort_order']:'';
			$data['status']=isset($landing_info['status'])?$landing_info['status']:1;
			$data['tp']=isset($landing_info['tp'])?$landing_info['tp']:1;
			$data['seo_url']= isset($landing_info['seo_url'])?$landing_info['seo_url']:'';

			//Блок1
			$data['block1_status']=isset($landing_info['block1_status'])?$landing_info['block1_status']:0;
			$data['block1_caption']=isset($landing_info['block1_caption'])?$landing_info['block1_caption']:'';
			$data['block1_form_status']=isset($landing_info['block1_form_status'])?$landing_info['block1_form_status']:0;
			$data['block1_form_caption']=isset($landing_info['block1_form_caption'])?$landing_info['block1_form_caption']:'';
			$data['block1_form_text']=isset($landing_info['block1_form_text'])?$landing_info['block1_form_text']:'';		
			$data['block1_image']=isset($landing_info['block1_image'])?$landing_info['block1_image']:'';

			if (isset($this->request->post['block1_image']) && is_file(DIR_IMAGE . $this->request->post['block1_image'])) {
				$data['block1_thumb'] = $this->model_tool_image->resize($this->request->post['block1_image'], 100, 100);
			} elseif (!empty($landing_info) && is_file(DIR_IMAGE . $landing_info['block1_image'])) {
				$data['block1_thumb'] = $this->model_tool_image->resize($landing_info['block1_image'], 100, 100);
			} else {
				$data['block1_thumb'] = $image_placeholder;
			}
			
			//Блок2
			$data['block2_status']=isset($landing_info['block2_status'])?$landing_info['block2_status']:0;
			$data['block2_form_status']=isset($landing_info['block2_form_status'])?$landing_info['block2_form_status']:0;
			$data['block2_caption']=isset($landing_info['block2_caption'])?$landing_info['block2_caption']:'';
			$data['block2_text']=isset($landing_info['block2_text'])?$landing_info['block2_text']:'';
			$data['block2_image']=isset($landing_info['block2_image'])?$landing_info['block2_image']:'';

			if (isset($this->request->post['block2_image']) && is_file(DIR_IMAGE . $this->request->post['block2_image'])) {
				$data['block2_thumb'] = $this->model_tool_image->resize($this->request->post['block2_image'], 100, 100);
			} elseif (!empty($landing_info) && is_file(DIR_IMAGE . $landing_info['block2_image'])) {
				$data['block2_thumb'] = $this->model_tool_image->resize($landing_info['block2_image'], 100, 100);
			} else {
				$data['block2_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
			}

			//Блок3
			$data['block3_status']=isset($landing_info['block3_status'])?$landing_info['block3_status']:0;
			$data['block3_form_status']=isset($landing_info['block3_form_status'])?$landing_info['block3_form_status']:0;
			$data['block3_caption']=isset($landing_info['block3_caption'])?$landing_info['block3_caption']:'';

			$data['block3_benefits']=isset($landing_info['block3_benefits'])?$landing_info['block3_benefits']:[];
			foreach($data['block3_benefits'] as $key=>$itm){				
				if($data['block3_benefits'][$key]['image']){
					$data['block3_benefits'][$key]['thumb']=$this->model_tool_image->resize($data['block3_benefits'][$key]['image'], 100, 100);
				}else{
					$data['block3_benefits'][$key]['thumb']=$this->model_tool_image->resize('no_image.png', 100, 100);
				}
			}

			
			//Блок4 (Видео)
			$data['block_video_status']=isset($landing_info['block_video_status'])?$landing_info['block_video_status']:0;
			$data['block_video_caption']=isset($landing_info['block_video_caption'])?$landing_info['block_video_caption']:'';

			
			//Преимущества для товаров
			$data['block_benefit_pr_status']=isset($landing_info['block_benefit_pr_status'])?$landing_info['block_benefit_pr_status']:0;
			$data['block_benefit_pr']=isset($landing_info['block_benefit_pr'])?$landing_info['block_benefit_pr']:[];
			foreach($data['block_benefit_pr'] as $key=>$itm){				
				if($data['block_benefit_pr'][$key]['image']){
					$data['block_benefit_pr'][$key]['thumb']=$this->model_tool_image->resize($data['block_benefit_pr'][$key]['image'], 100, 100);
				}else{
					$data['block_benefit_pr'][$key]['thumb']=$this->model_tool_image->resize('no_image.png', 100, 100);
				}
			}

			//Продукты
			$data['block_pr_status']=isset($landing_info['block_pr_status'])?$landing_info['block_pr_status']:0;
			$data['block_pr_caption']=isset($landing_info['block_pr_caption'])?$landing_info['block_pr_caption']:'';
			$data['block_pr_button']=isset($landing_info['block_pr_button'])?$landing_info['block_pr_button']:'';
			$data['block_pr_file']=isset($landing_info['block_pr_file'])?$landing_info['block_pr_file']:'';
			
			//Сертификаты
			$data['block_cert_status']=isset($landing_info['block_cert_status'])?$landing_info['block_cert_status']:0;
			$data['block_cert_caption']=isset($landing_info['block_cert_caption'])?$landing_info['block_cert_caption']:'';
			
			$data['block_cert_image']=isset($landing_info['block_cert_image'])?$landing_info['block_cert_image']:'';
			if (isset($this->request->post['block_cert_image']) && is_file(DIR_IMAGE . $this->request->post['block_cert_image'])) {
				$data['block_cert_thumb'] = $this->model_tool_image->resize($this->request->post['block_cert_image'], 100, 100);
			} elseif (!empty($landing_info) && is_file(DIR_IMAGE . $landing_info['block_cert_image'])) {
				$data['block_cert_thumb'] = $this->model_tool_image->resize($landing_info['block_cert_image'], 100, 100);
			} else {
				$data['block_cert_thumb'] = $image_placeholder;
			}
						

			$data['block_cert1_caption']=isset($landing_info['block_cert1_caption'])?$landing_info['block_cert1_caption']:'';
			$data['block_cert1_image']=isset($landing_info['block_cert1_image'])?$landing_info['block_cert1_image']:'';
			if (isset($this->request->post['block_cert1_image']) && is_file(DIR_IMAGE . $this->request->post['block_cert1_image'])) {
				$data['block_cert1_thumb'] = $this->model_tool_image->resize($this->request->post['block_cert1_image'], 100, 100);
			} elseif (!empty($landing_info) && is_file(DIR_IMAGE . $landing_info['block_cert1_image'])) {
				$data['block_cert1_thumb'] = $this->model_tool_image->resize($landing_info['block_cert1_image'], 100, 100);
			} else {
				$data['block_cert1_thumb'] = $image_placeholder;
			}
			
			$data['block_cert2_caption']=isset($landing_info['block_cert2_caption'])?$landing_info['block_cert2_caption']:'';
			$data['block_cert2_image']=isset($landing_info['block_cert2_image'])?$landing_info['block_cert2_image']:'';
			if (isset($this->request->post['block_cert2_image']) && is_file(DIR_IMAGE . $this->request->post['block_cert2_image'])) {
				$data['block_cert2_thumb'] = $this->model_tool_image->resize($this->request->post['block_cert2_image'], 100, 100);
			} elseif (!empty($landing_info) && is_file(DIR_IMAGE . $landing_info['block_cert2_image'])) {
				$data['block_cert2_thumb'] = $this->model_tool_image->resize($landing_info['block_cert2_image'], 100, 100);
			} else {
				$data['block_cert2_thumb'] = $image_placeholder;
			}
			
			//Карта
			$data['block_map_status']=isset($landing_info['block_map_status'])?$landing_info['block_map_status']:0;
			$data['block_map_caption']=isset($landing_info['block_map_caption'])?$landing_info['block_map_caption']:'';
			$data['block_map_text']=isset($landing_info['block_map_text'])?$landing_info['block_map_text']:'';
			 
			$data['block_map_image']=isset($landing_info['block_map_image'])?$landing_info['block_map_image']:'';
			if (isset($this->request->post['block_map_image']) && is_file(DIR_IMAGE . $this->request->post['block_map_image'])) {
				$data['block_map_thumb'] = $this->model_tool_image->resize($this->request->post['block_map_image'], 100, 100);
			} elseif (!empty($landing_info) && is_file(DIR_IMAGE . $landing_info['block_map_image'])) {
				$data['block_map_thumb'] = $this->model_tool_image->resize($landing_info['block_map_image'], 100, 100);
			} else {
				$data['block_map_thumb'] = $image_placeholder;
			}
			
			//Сотрудничество
			$data['block_sot_status']=isset($landing_info['block_sot_status'])?$landing_info['block_sot_status']:0;
			$data['block_sot_caption']=isset($landing_info['block_sot_caption'])?$landing_info['block_sot_caption']:'';
			$data['block_sot_subcaption']=isset($landing_info['block_sot_subcaption'])?$landing_info['block_sot_subcaption']:'';
			$data['block_sot_text']=isset($landing_info['block_sot_text'])?$landing_info['block_sot_text']:'';

			//Нижняя форма
			$data['block_bform_status']=isset($landing_info['block_bform_status'])?$landing_info['block_bform_status']:0;
			$data['block_bform_caption']=isset($landing_info['block_bform_caption'])?$landing_info['block_bform_caption']:'';
			$data['block_bform_perc']=isset($landing_info['block_bform_perc'])?$landing_info['block_bform_perc']:'';

		//}


		$data['mail1']=isset($landing_info['mail1'])?$landing_info['mail1']:'';
		$data['mailthanks']=isset($landing_info['mailthanks'])?$landing_info['mailthanks']:'';
		
		$parent_cat_id=71;
		$categories=[];
		$categories_tree=[];
		$this->load->model('catalog/category');
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
		$product_list=isset($landing_info['product_list'])?$landing_info['product_list']:[];
		$product_list_arr=[];
		foreach($product_list as $product_list_item){
			$product_list_arr[]=explode(",",$product_list_item);
		}
		
		$data['product_list']=$product_list_arr;

		$data['categories_tree']=$categories_tree;
		$data['products']=$products_list;
		/*
		$tabs=Array(
			Array("name"=>"Продукты1","caption"=>"test1","button"=>"скачать1","file"=>""),
			Array("name"=>"Продукты2","caption"=>"test2","button"=>"скачать2","file"=>"")
		);
		*/
		$data['tabs']=isset($landing_info['tab'])?$landing_info['tab']:[];;
		//print_r($landing_info);

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
		if (isset($this->error['title'])) {
			$data['error_title'] = $this->error['title'];
		} else {
			$data['error_title'] = '';
		}

		if (isset($this->error['seo_url'])) {
			$data['error_seo_url'] = $this->error['seo_url'];
		} else {
			$data['error_seo_url'] = '';
		}


		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['landing_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');


		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_products'] = $this->language->get('tab_products');
		$data['tab_forms'] = $this->language->get('tab_forms');
		$data['tab_blocks'] = $this->language->get('tab_blocks');


		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_tp'] = $this->language->get('entry_tp');
		$data['entry_logotext'] = $this->language->get('entry_logotext');
		$data['entry_meta_title'] = $this->language->get('entry_meta_title');
		$data['entry_meta_description'] = $this->language->get('entry_meta_description');

		$data['entry_block1_caption'] = $this->language->get('entry_block1_caption');
		$data['entry_block1_image'] = $this->language->get('entry_block1_image');

		$data['entry_block2_caption'] = $this->language->get('entry_block2_caption');
		$data['entry_block2_image'] = $this->language->get('entry_block2_image');

		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

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
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/landing', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['landing_id'])) {
			$data['action'] = $this->url->link('catalog/landing/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/landing/edit', 'token=' . $this->session->data['token'] . '&landing_id=' . $this->request->get['landing_id'] . $url, true);
		}
		
		$data['cancel'] = $this->url->link('catalog/landing', 'token=' . $this->session->data['token'] . $url, true);

		

		$data['ckeditor'] = $this->config->get('config_editor_default');
		$data['token'] = $this->session->data['token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('catalog/landing_form', $data));
		
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/landing')) {
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
		if (utf8_strlen($this->request->post['seo_url']) < 1) {
			$this->error['seo_url'] = $this->language->get('error_seo_url');
		}
		

		/*
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
		if (!$this->user->hasPermission('modify', 'catalog/landing')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
	
}