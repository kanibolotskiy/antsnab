<?php
/**
 * Абстрактный класс для модулей 
 * 
 * @version    0.1, Sep 28, 2018  9:59:18 AM 
 * @copyright  Copyright (c) 2018 pinstudio. (https://www.pinstudio.ru)
 * @author     Sergey Lapshin 
 */

namespace WS\Override\Controller\Admin\Extension;

abstract class AModuleController extends \Controller
{
    protected $data = [];

    protected $error;

    abstract public function index();

    abstract protected function getCode();

    protected function getType()
    {
        return 'module';
    }


    protected function commonIndex()
    {
        $code = $this->getCode();
        $type = $this->getType();

        $this->load->language('extension/module/' . $code );

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting( $code , $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=' . $type , true));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_status'] = $this->language->get('entry_status');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/' . $code, 'token=' . $this->session->data['token'], true)
		);

		$this->data['action'] = $this->url->link('extension/module/' . $code, 'token=' . $this->session->data['token'], true);

		$this->data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

        $this->data['status_field_name'] = $code . '_status';
		if (isset($this->request->post[ $this->data['status_field_name'] ])) {
			$this->data['module_status'] = $this->request->post[ $this->data['status_field_name'] ];
		} else {
			$this->data['module_status'] = $this->config->get($code . '_status');
		}

		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');

    }

    protected function validate() {
        return true;

        /** @todo check permissions */
		if (!$this->user->hasPermission('modify', 'extension/extension/feed')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

    public function install()
    {
        $this->load->model('extension/extension');
        if ($this->validate()) {
            $this->model_extension_extension->install($this->getType(), $this->getCode());
        }
    }

    public function uninstall()
    {
        $this->load->model('extension/extension');
        if ($this->validate()) {
            $this->model_extension_extension->uninstall($this->getType(), $this->getCode());
        } 
    }

}
