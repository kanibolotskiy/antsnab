<?php
class ControllerCatalogDiscounts extends Controller {
	private $error = array();

	public function index() {
        $this->load->language('catalog/dopinfo');

		$this->document->setTitle($this->language->get('heading_title_discounts'));

		$this->load->model('catalog/discounts');
		$this->getList();
	}
    protected function getList() {
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
			'text' => $this->language->get('heading_title_discounts'),
			'href' => $this->url->link('catalog/discounts', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['add'] = $this->url->link('catalog/discounts/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/discounts/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['discounts'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

        $discounts_total=10;

		$discounts_total = $this->model_catalog_discounts->getTotalDiscounts();

		$results = $this->model_catalog_discounts->getDiscounts($filter_data);

		foreach ($results as $result) {
			$data['discounts'][] = array(
				'discount_id' => $result['discount_id'],
				'name'            => $result['name'],
				'sort_order'      => $result['sort_order'],
				'edit'            => $this->url->link('catalog/discounts/edit', 'token=' . $this->session->data['token'] . '&discount_id=' . $result['discount_id'] . $url, true)
			);
		}
    

		$data['heading_title'] = $this->language->get('heading_title_discounts');

		$data['text_list'] = $this->language->get('text_list_discounts');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name_discounts');
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

		$data['sort_name'] = $this->url->link('catalog/discounts', 'token=' . $this->session->data['token'] . '&sort=name' . $url, true);
		$data['sort_sort_order'] = $this->url->link('catalog/discounts', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, true);

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $discounts_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/discounts', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($discounts_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($discounts_total - $this->config->get('config_limit_admin'))) ? $discounts_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $discounts_total, ceil($discounts_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('catalog/discounts_list', $data));
    }
    public function delete() {
		$this->load->language('catalog/dopinfo');

		$this->document->setTitle($this->language->get('heading_title_discounts'));

		$this->load->model('catalog/discounts');
        
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $discount_id) {
				$this->model_catalog_discounts->deleteDiscount($discount_id);
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

            $this->response->redirect($this->url->link('catalog/discounts', 'token=' . $this->session->data['token'] . $url, true));
            
		}
       
		$this->getList();
    }
    
    public function add() {
		$this->load->language('catalog/dopinfo');

		$this->document->setTitle($this->language->get('heading_title_discounts'));

		$this->load->model('catalog/discounts');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_discounts->addDiscount($this->request->post);

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

			$this->response->redirect($this->url->link('catalog/discounts', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}
	public function edit() {
        $this->load->language('catalog/dopinfo');
        
		$this->document->setTitle($this->language->get('heading_title_discounts'));

		$this->load->model('catalog/discounts');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_discounts->editDiscount($this->request->get['discount_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('catalog/discounts', 'token=' . $this->session->data['token'] . $url, true));
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
    
            $data['heading_title'] = $this->language->get('heading_title_discounts');
            

            $data['text_form'] = $this->language->get('text_edit_discounts');
                

            $data['entry_name'] = $this->language->get('entry_name_discounts');
			$data['entry_description'] = $this->language->get('entry_description');
			$data['entry_goal'] = $this->language->get('entry_goal');
			$data['entry_label'] = $this->language->get('entry_label');

            $data['entry_sort_order'] = $this->language->get('entry_sort_order');

            

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
                'text' => $this->language->get('heading_title_discounts'),
                'href' => $this->url->link('catalog/discounts', 'token=' . $this->session->data['token'] . $url, true)
            );
    
            if (!isset($this->request->get['discount_id'])) {
                $data['action'] = $this->url->link('catalog/discounts/add', 'token=' . $this->session->data['token'] . $url, true);
            } else {
                $data['action'] = $this->url->link('catalog/discounts/edit', 'token=' . $this->session->data['token'] . '&discount_id=' . $this->request->get['discount_id'] . $url, true);
            }
    
            $data['cancel'] = $this->url->link('catalog/discounts', 'token=' . $this->session->data['token'] . $url, true);
            
            
            if (isset($this->request->get['discount_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
                $discount_info = $this->model_catalog_discounts->getDiscount($this->request->get['discount_id']);
            }
            if(isset($discount_info)){
                $data['discount']=$discount_info['name'];
				$data['discount_description']=$discount_info['description'];
				$data['goal']=$discount_info['goal'];
				$data['label']=$discount_info['label'];

            }else{
                $data['discount']='';
				$data['goal']='';
				$data['label']='';
            }

            $data['token'] = $this->session->data['token'];
            $data['ckeditor'] = $this->config->get('config_editor_default');
    
            
            if (isset($this->request->post['sort_order'])) {
                $data['sort_order'] = $this->request->post['sort_order'];
            } elseif (!empty($discount_info)) {
                $data['sort_order'] = $discount_info['sort_order'];
            } else {
                $data['sort_order'] = '';
            }
           

            $data['header'] = $this->load->controller('common/header');
            $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
            $this->response->setOutput($this->load->view('catalog/discounts_form', $data));
        }

    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'catalog/discounts')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        
        if ((utf8_strlen($this->request->post['name']) < 2) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name_discounts');
        }
        
        return !$this->error;
    }
    protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/discounts')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
    public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/discounts');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_catalog_discounts->getDiscounts($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'discount_id' => $result['discount_id'],
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