<?php
class ControllerCatalogCouriers extends Controller {
	private $error = array();

	public function index() {
        $this->load->language('catalog/dopinfo');

		$this->document->setTitle($this->language->get('heading_title_courier'));

		$this->load->model('catalog/couriers');
		$this->getList();
	}
	
    protected function getList() {
		
        if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'sort_order';
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
			'text' => $this->language->get('heading_title_couriers'),
			'href' => $this->url->link('catalog/couriers', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['add'] = $this->url->link('catalog/couriers/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/couriers/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['couriers'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

        $couriers_total=10;

        
		$couriers_total = $this->model_catalog_couriers->getTotalCouriers();


		$results = $this->model_catalog_couriers->getCouriers($filter_data);

		foreach ($results as $result) {
			$data['couriers'][] = array(
				'courier_id' => $result['courier_id'],
				'name'            => $result['name'],
				'weight'          => $result['weight'],
				'price'           => $result['price'],
				'sort_order'      => $result['sort_order'],
				'edit'            => $this->url->link('catalog/couriers/edit', 'token=' . $this->session->data['token'] . '&courier_id=' . $result['courier_id'] . $url, true)
			);
		}
    
			
		$data['heading_title'] = $this->language->get('heading_title_couriers');

		$data['text_list'] = $this->language->get('text_list_couriers');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name_couriers');
		$data['column_sort_order'] = $this->language->get('column_sort_order');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');

		$data['entry_weight']=$this->language->get('entry_weight');
		$data['entry_price']=$this->language->get('entry_price');
		
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

		$data['sort_name'] = $this->url->link('catalog/couriers', 'token=' . $this->session->data['token'] . '&sort=name' . $url, true);
		$data['sort_sort_order'] = $this->url->link('catalog/couriers', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, true);

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $couriers_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/couriers', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($couriers_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($couriers_total - $this->config->get('config_limit_admin'))) ? $couriers_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $couriers_total, ceil($couriers_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        
		$this->response->setOutput($this->load->view('catalog/couriers_list', $data));
		
	}
	
    public function delete() {
		$this->load->model('tool/lastmod');
		$this->model_tool_lastmod->setLastTime(['info/6id'],time());

		$this->load->language('catalog/dopinfo');

		$this->document->setTitle($this->language->get('heading_title_couriers'));

		$this->load->model('catalog/courier');
        
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $benefit_id) {
				$this->model_catalog_benefits->deleteBenefit($benefit_id);
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

            $this->response->redirect($this->url->link('catalog/couriers', 'token=' . $this->session->data['token'] . $url, true));
            
		}
       
		$this->getList();
    }
    
    public function add() {
		$this->load->model('tool/lastmod');
		$this->model_tool_lastmod->setLastTime(['info/6id'],time());

		$this->load->language('catalog/dopinfo');
		
		$this->document->setTitle($this->language->get('heading_title_couriers'));

		$this->load->model('catalog/couriers');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			$this->model_catalog_couriers->addCourier($this->request->post);

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

			$this->response->redirect($this->url->link('catalog/couriers', 'token=' . $this->session->data['token'] . $url, true));
		}
		
		$this->getForm();
	}
	public function edit() {
		
		

        $this->load->language('catalog/dopinfo');
        
		$this->document->setTitle($this->language->get('heading_title_couriers'));

		$this->load->model('catalog/couriers');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->load->model('tool/lastmod');
			$this->model_tool_lastmod->setLastTime(['info/6id','product/'],time());
			
			$this->model_catalog_couriers->editCourier($this->request->get['courier_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('catalog/couriers', 'token=' . $this->session->data['token'] . $url, true));
		}

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
    
            $data['heading_title'] = $this->language->get('heading_title_couriers');
            

            $data['text_form'] = $this->language->get('text_edit_couriers');
            
    
                

			$data['entry_name'] = $this->language->get('entry_name_couriers');
			$data['entry_caption'] = $this->language->get('entry_caption');
            $data['entry_description'] = $this->language->get('entry_description');
            $data['entry_sort_order'] = $this->language->get('entry_sort_order');
			$data['entry_weight'] = $this->language->get('entry_weight');
			$data['entry_weight_str'] = $this->language->get('entry_weight_str');
			$data['entry_price'] = $this->language->get('entry_price');
			$data['entry_price_urgent'] = $this->language->get('entry_price_urgent');
			

			$data['entry_price_ico'] = $this->language->get('entry_price_ico');
			
			

            $data['button_save'] = $this->language->get('button_save');
            $data['button_cancel'] = $this->language->get('button_cancel');

            if (isset($this->error['warning'])) {
                $data['error_warning'] = $this->error['warning'];
            } else {
                $data['error_warning'] = '';
            }
    
            if (isset($this->error['name'])) {
                $data['error_name'] = $this->error['name'];
            } else {
                $data['error_name'] = '';
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
                'text' => $this->language->get('heading_title_couriers'),
                'href' => $this->url->link('catalog/couriers', 'token=' . $this->session->data['token'] . $url, true)
            );
    
            if (!isset($this->request->get['courier_id'])) {
                $data['action'] = $this->url->link('catalog/couriers/add', 'token=' . $this->session->data['token'] . $url, true);
            } else {
                $data['action'] = $this->url->link('catalog/couriers/edit', 'token=' . $this->session->data['token'] . '&courier_id=' . $this->request->get['courier_id'] . $url, true);
            }
    
            $data['cancel'] = $this->url->link('catalog/couriers', 'token=' . $this->session->data['token'] . $url, true);
            
            
            if (isset($this->request->get['courier_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
                $courier_info = $this->model_catalog_couriers->getCourier($this->request->get['courier_id']);
            }
            if(isset($courier_info)){
				$data['courier']=$courier_info['name'];
				$data['price_ico']=$courier_info['price_ico'];
				$data['courier_description']=$courier_info['description'];
				$data['courier_caption']=$courier_info['caption'];
            }else{
				$data['courier']='';
				$data['price_ico']='';
				$data['courier_description']='';
				$data['courier_caption']='';
            }

			
            //print_r($benefit_info);

           

            $data['token'] = $this->session->data['token'];
            $data['ckeditor'] = $this->config->get('config_editor_default');

            if (isset($this->request->post['sort_order'])) {
                $data['sort_order'] = $this->request->post['sort_order'];
            } elseif (!empty($courier_info)) {
                $data['sort_order'] = $courier_info['sort_order'];
            } else {
                $data['sort_order'] = '';
			}
			
			if (isset($this->request->post['weight'])) {
                $data['weight'] = $this->request->post['weight'];
            } elseif (!empty($courier_info)) {
                $data['weight'] = $courier_info['weight'];
            } else {
                $data['weight'] = '';
			}
			if (isset($this->request->post['weight_str'])) {
                $data['weight_str'] = $this->request->post['weight_str'];
            } elseif (!empty($courier_info)) {
                $data['weight_str'] = $courier_info['weight_str'];
            } else {
                $data['weight_str'] = '';
			}

			if (isset($this->request->post['price'])) {
                $data['price'] = $this->request->post['price'];
            } elseif (!empty($courier_info)) {
                $data['price'] = $courier_info['price'];
            } else {
                $data['price'] = '';
			}
			if (isset($this->request->post['price_urgent'])) {
                $data['price_urgent'] = $this->request->post['price_urgent'];
            } elseif (!empty($courier_info)) {
                $data['price_urgent'] = $courier_info['price_urgent'];
            } else {
                $data['price_urgent'] = '';
            }
            
            $data['header'] = $this->load->controller('common/header');
            $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
            $this->response->setOutput($this->load->view('catalog/couriers_form', $data));
        }

    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'catalog/couriers')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        
        if ((utf8_strlen($this->request->post['name']) < 2) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name_couriers');
		}
		/*
		if (($this->request->post['weight']) > 0) {
            $this->error['error_weight'] = $this->language->get('error_weight');
		}
		if (($this->request->post['price']) > 0) {
            $this->error['error_price'] = $this->language->get('error_price');
		}
		*/
        
        return !$this->error;
    }
    protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/couriers')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
    public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/couriers');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_catalog_couriers->getCouriers($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'courier_id' => $result['courier_id'],
					'name'            => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$sort_order = array();

		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
}