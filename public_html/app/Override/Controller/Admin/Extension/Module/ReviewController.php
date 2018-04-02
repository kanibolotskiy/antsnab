<?php

/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Site\Extension\Module
 */

namespace WS\Override\Controller\Admin\Extension\Module;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ReviewController extends \Controller
{
    protected $error;

    public function index()
    {
        $this->load->language('extension/module/review');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');
        $this->load->model('extension/module/review');

        $data = array();
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('review', $this->request->post);
        
            $this->session->data['success'] = $this->language->get('text_success');
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_status'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');

        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_count'] = $this->language->get('entry_count');
        $data['entry_visible'] = $this->language->get('entry_visible');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['error_empty_line'] = $this->language->get('error_empty_line');


        if (isset($this->error['error_entries'])) {
            $data['error_entries'] = $this->error['error_entries'];
        } else {
            $data['error_entries'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/review', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['action'] = $this->url->link('extension/module/review', 'token=' . $this->session->data['token'], 'SSL');

        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        // status
        if (isset($this->request->post['review_status'])) {
            $data['review_status'] = $this->request->post['review_status'];
        } else {
            $data['review_status'] = $this->config->get('review_status');
        }

        // entry
        if (isset($this->request->post['review_count'])) {
            $data['review_count'] = $this->request->post['review_count'];
        } else {
            $data['review_count'] = $this->config->get(\ModelExtensionModuleReview::CONFIG_KEY_COUNT);
        }
        if (isset($this->request->post['review_visible'])) {
            $data['review_visible'] = $this->request->post['review_visible'];
        } else {
            $data['review_visible'] = $this->config->get(\ModelExtensionModuleReview::CONFIG_KEY_VISIBLE);
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/module/review', $data));
    }

    private function validate($permission = 'modify')
    {
        if (!$this->user->hasPermission($permission, 'extension/module/review')) {
            $this->error['warning'] = $this->language->get('error_permission');
            return false;
        }
        return true;
    }

    public function install()
    {
        $this->load->model('extension/module/review');
        return $this->model_extension_module_review->installDatabase();
    }

    public function uninstall()
    {
        $this->load->model('extension/module/review');
        return $this->model_extension_module_review->uninstallDatabase();
    }

}
