<?php
class ControllerExtensionModuleYaSearch extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/ya_search');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		
				if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting('ya_search', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module/ya_search', 'token=' . $this->session->data['token'], 'SSL'));
		}

		
		if(isset($this->session->data['success'])){
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}else{
			$data['success'] = '';
		}

		$data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('heading_title');
 		$data['entry_discount'] = $this->language->get('entry_discount');
 		$data['help_discount'] = $this->language->get('help_discount');
		$data['entry_id'] = $this->language->get('entry_id');
 		$data['help_id'] = $this->language->get('help_id');
		$data['help_description'] = $this->language->get('help_description');
		$data['text_help'] = $this->language->get('text_help');
		$data['entry_description'] = $this->language->get('entry_description');
 		$data['help_discount'] = $this->language->get('help_discount');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/ya_search', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$data['action'] = $this->url->link('extension/module/ya_search', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');


		if (isset($this->request->post['ya_search_key_api'])) {
            $data['ya_search_key_api'] = $this->request->post['ya_search_key_api'];
        } else {
            $data['ya_search_key_api'] = $this->config->get('ya_search_key_api');
        }
		if (isset($this->request->post['ya_search_id'])) {
			$data['ya_search_id'] = $this->request->post['ya_search_id'];
		} else {
			$data['ya_search_id'] = $this->config->get('ya_search_id');
		}
		if (isset($this->request->post['ya_search_description'])) {
			$data['ya_search_description'] = $this->request->post['ya_search_description'];
		} else {
			$data['ya_search_description'] = $this->config->get('ya_search_description');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/ya_search.tpl', $data));
	}
	private function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/ya_search')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

}
?>