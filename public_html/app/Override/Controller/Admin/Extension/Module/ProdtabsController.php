<?php

namespace WS\Override\Controller\Admin\Extension\Module;

use WS\Override\Gateway\ProdTabs;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 * @author     https://github.com/iMateo/generator-opencart-module
 */
class ProdtabsController extends \Controller
{

    private $error = array();
    private $error_fields = array();
    protected $data = array();

    public function index()
    {
        $this->validatePermissions();

        $this->load->language('extension/module/prodtabs');
        $this->setTitle('module_title');
        $this->setPartials();
        $this->setTextStrings();
        $this->addBreadcrumb('common/dashboard', 'text_home')
            ->addBreadcrumb('extension/extension', 'text_module')
            ->addBreadcrumb('extension/module/prodtabs', 'heading_title');

        //button actions
        $this->data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['filter'] = $this->url->link('extension/module/prodtabs', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['editLink'] = $this->url->link('extension/module/prodtabs/getlist', 'token=' . $this->session->data['token'], 'SSL');



        //Specific data
        $this->load->model('catalog/category');

        $filter_data = array(
            'sort' => 'name',
            'order' => 'ASC'
        );

        //Filters
        $this->data['filter_category_value'] = '';
        if (isset($this->request->get['filter_name'])) {
            $this->data['filter_category_value'] = $this->request->get['filter_name'];
            $filter_data['filter_path_name'] = $this->request->get['filter_name'];
        }

        $filter_data['filter_isfinal'] = true;

        $this->data['categories'] = $this->model_catalog_category->getCategories($filter_data);
        //Send the output

        $this->fillErrors();
        $this->response->setOutput($this->load->view('extension/module/prodtabs/index.tpl', $this->data));
    }

    public function getlist()
    {
        if (!isset($this->request->get['category_id'])) {
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->validatePermissions();
        $category_id = (int) $this->request->get['category_id'];

        $this->load->language('extension/module/prodtabs');
        $this->setPartials();
        $this->setTextStrings();
        $this->addBreadcrumb('common/dashboard', 'text_home')
            ->addBreadcrumb('extension/extension', 'text_module')
            ->addBreadcrumb('extension/module/prodtabs', 'module_title');

        //button actions
        $this->data['add'] = $this->url->link('extension/module/prodtabs/getform', 'token=' . $this->session->data['token'] . '&category_id=' . $category_id, 'SSL');
        $this->data['edit'] = $this->url->link('extension/module/prodtabs/getform', 'token=' . $this->session->data['token'] . '&category_id=' . $category_id, 'SSL');
        $this->data['delete'] = $this->url->link('extension/module/prodtabs/delete', 'token=' . $this->session->data['token'] . '&category_id=' . $category_id, 'SSL');
        $this->data['cancel'] = $this->url->link('extension/module/prodtabs', 'token=' . $this->session->data['token'], 'SSL');


        //specific data
        $this->load->model('catalog/category');
        $category = $this->model_catalog_category->getCategory($category_id);
        $this->data['category'] = $category;

        $this->setTitle('lists_title', $category['name']);
        $this->data['lists_title'] .= ' ' . $category['name'];
        $this->addBreadcrumb('extension/module/prodtabs/getlist&category_id=' . $category_id, 'lists_title', $category['name']);

        $gateway = new ProdTabs($this->registry);
        $order = "order by sortOrder ASC";
        $this->data['tabs'] = $gateway->getTabs($category_id, $order);

        //Send the output
        $this->fillErrors();
        $this->response->setOutput($this->load->view('extension/module/prodtabs/list.tpl', $this->data));
    }

    public function edit()
    {
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validatePermissions() && $this->validateForm()) {
            $category_id = $this->request->get['category_id'];
            $tab_id = $this->request->get['tab_id'];

            $updateData = $this->request->post;
            $updateData['category_id'] = $category_id;
            $updateData['category_prodtab_id'] = $tab_id;


            $gateway = new ProdTabs($this->registry);
            $res = $gateway->updateTab($updateData, $tab_id);

            if ($res) {
                $this->session->data['success'] = $this->language->get('text_success');
                $redirect_url = $this->data['filter'] = $this->url->link('extension/module/prodtabs/getlist', 'token=' . $this->session->data['token'] . '&category_id=' . $category_id . '&tab_id' . $tab_id, 'SSL');

                $this->response->redirect($redirect_url);
                exit();
            }

            $this->error['warning'] = $this->language->get('text_edit_error');
        }

        $this->getForm();
    }

    public function add()
    {
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validatePermissions() && $this->validateForm()) {

            $category_id = $this->request->get['category_id'];

            $addData = $this->request->post;
            $addData['category_id'] = $category_id;

            $gateway = new ProdTabs($this->registry);
            $res = $gateway->addTab($addData);

            if ($res) {
                $this->session->data['success'] = $this->language->get('text_success');
                $redirect_url = $this->data['filter'] = $this->url->link('extension/module/prodtabs/getlist', 'token=' . $this->session->data['token'] . '&category_id=' . $category_id, 'SSL');

                $this->response->redirect($redirect_url);
            }

            $this->error['warning'] = $this->language->get('text_add_error');
        }

        $this->getForm();
    }

    public function getForm()
    {
        $this->validatePermissions();

        if (!isset($this->request->get['category_id'])) {
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
        }

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

        $tab_id = null;
        $tab = null;
        if (isset($this->request->get['tab_id'])) {
            $tab_id = $this->request->get['tab_id'];
            $gateway = new ProdTabs($this->registry);
            $tab = $gateway->getTab($tab_id);
        }

        $category_id = $this->request->get['category_id'];
        $this->data['category_id'] = $category_id;
        $this->load->model('catalog/category');
        $category = $this->model_catalog_category->getCategory($category_id);

        $this->load->language('extension/module/prodtabs');
        $this->setTitle('form_title');
        $this->setPartials();
        $this->setTextStrings();

        if (null === $tab_id) {
            $this->data['form_title'] = $this->data['form_title_add'] . ' ' . $category['name'];
            $this->setTitle('form_title_add', $category['name']);
            $tab_id_url = '';
        } else {
            $this->data['form_title'] = $this->data['form_title_edit'] . ' ' . $category['name'];
            $this->setTitle('form_title_edit', $category['name']);
            $tab_id_url = '&tab_id=' . $tab_id;
        }

        $this->addBreadcrumb('common/dashboard', 'text_home')
            ->addBreadcrumb('extension/extension', 'text_module')
            ->addBreadcrumb('extension/module/prodtabs', 'module_title')
            ->addBreadcrumb('extension/module/prodtabs/getlist&category_id=' . $category_id, 'lists_title', $category['name'])
            ->addBreadcrumb('extension/module/prodtabs/getform&category_id=' . $category_id . $tab_id_url, 'form_title_edit', $category['name']);



        $this->data['category_id'] = $this->request->get['category_id'];
        $this->data['category_prodtab_id'] = (null === $tab_id) ? '' : $tab_id;

        if (null === $tab_id) {
            $this->data['action'] = $this->url->link('extension/module/prodtabs/add', 'token=' . $this->session->data['token'] . '&category_id=' . $category_id, 'SSL');
        } else {
            $this->data['action'] = $this->url->link('extension/module/prodtabs/edit', 'token=' . $this->session->data['token'] . '&category_id=' . $category_id . $tab_id_url, 'SSL');
        }

        $this->data['cancel'] = $this->url->link('extension/module/prodtabs/getlist', 'token=' . $this->session->data['token'] . '&category_id=' . $category_id, 'SSL');

        $this->data['name'] = '';
        if (isset($this->request->post['name'])) {
            $this->data['name'] = $this->request->post['name'];
        } elseif (!empty($tab)) {
            $this->data['name'] = $tab['name'];
        }


        $this->data['default'] = '';
        if (isset($this->request->post['default'])) {
            $this->data['default'] = $this->request->post['default'];
        } elseif (!empty($tab)) {
            $this->data['default'] = $tab['default'];
        }


        $this->data['sortOrder'] = 0;
        if (isset($this->request->post['sortOrder'])) {
            $this->data['sortOrder'] = $this->request->post['sortOrder'];
        } elseif (!empty($tab)) {
            $this->data['sortOrder'] = $tab['sortOrder'];
        }

        $this->fillErrors();
        $this->response->setOutput($this->load->view('extension/module/prodtabs/form.tpl', $this->data));
    }

    public function save()
    {
        if (!$this->validatePermissions() || !$this->validateSave()) {
            if (isset($this->request->post['tab_id'])) {
                //на редактирование
                $this->response->redirect($this->url->link('extension/module/prodtabs/edit', 'token=' . $this->session->data['token'] . '&tab_id=' . $this->request->post['tab_id'], 'SSL'));
            }

            //на создание
            $this->response->redirect($this->url->link('extension/module/prodtabs/add', 'token=' . $this->session->data['token'] . '&category_id=' . $this->request->post['category_id'], 'SSL'));
            exit();
        }

        $gateway = new ProdTabs($this->registry);
        if (isset($this->request->post['tab_id'])) {
            $gateway->update($this->request->post);
        } else {
            $gateway->create($this->request->post);
        }

        $this->response->redirect($this->url->link('extension/module/prodtabs/getlist', 'token=' . $this->session->data['token'] . '&category_id=' . $this->request->post['category_id'], 'SSL'));
    }

    public function delete()
    {
        if (isset($this->request->post['selected']) && $this->validatePermissions()) {

            $gateway = new ProdTabs($this->registry);

            foreach ($this->request->post['selected'] as $tab_id) {
                $gateway->deleteTab($tab_id);
            }

            $this->load->language('extension/module/prodtabs');
            $this->session->data['success'] = $this->language->get('text_success');

            if (isset($this->request->get['category_id'])) {
                $url = '&category_id=' . $this->request->get['category_id'];
            } else {
                $url = '';
            }

            //@task add sorting maybe
            /* if (isset($this->request->get['sort'])) {
              $url .= '&sort=' . $this->request->get['sort'];
              }

              if (isset($this->request->get['order'])) {
              $url .= '&order=' . $this->request->get['order'];
              }

              if (isset($this->request->get['page'])) {
              $url .= '&page=' . $this->request->get['page'];
              } */

            //$this->response->redirect($this->url->link('extension/module/prodproperties/getlist', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getList();
    }

    /** Necessary for module methods */
    public function install()
    {

    }

    public function uninstall()
    {

    }

    /*
     *
     * Check that user actions are authorized
     *
     */

    private function validatePermissions()
    {
        if (!$this->user->hasPermission('modify', 'extension/module/prodtabs')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

    private function validateForm()
    {
        $this->load->language('extension/module/prodtabs');

        if (empty(trim($this->request->post['name']))) {
            $this->error_fields['name'] = $this->language->get('error_name');
        }

        if (empty(trim($this->request->post['default']))) {
            $this->error_fields['default'] = $this->language->get('error_default');
        }

        $res = true;
        if (!empty($this->error_fields)) {
            $res = false;
            $this->error['warning'] = $this->language->get('error_warning');
        }

        return $res;
    }

    protected function fillErrors()
    {
        //error handling
        $this->data['error_warning'] = '';
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        }

        $this->data['error_fields'] = $this->error_fields;
    }

    protected function setTextStrings()
    {
        foreach ($this->language->all() as $k => $v) {
            $this->data[$k] = $v;
        }
    }

    protected function setTitle($langKey, $additional = '')
    {
        $this->document->setTitle($this->language->get($langKey) . ' ' . $additional);
    }

    protected function setPartials()
    {
        $this->data['header'] = $this->load->controller('common/header');
        $this->data['column_left'] = $this->load->controller('common/column_left');
        $this->data['footer'] = $this->load->controller('common/footer');
    }

    protected function addBreadcrumb($urlRoute, $langKey, $additional = '')
    {
        if (!isset($this->data['breadcrumbs'])) {
            $this->data['breadcrumbs'] = array();
        }

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get($langKey) . ' ' . $additional,
            'href' => $this->url->link($urlRoute, 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        return $this;
    }

}
