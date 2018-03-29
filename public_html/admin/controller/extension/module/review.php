<?php
//@task оформить модуль через патч
class ControllerExtensionModuleReview extends Controller
{
public function index()
    {
        /*$dm = DomainManager::create($this->registry);
        $this->load->language('extension/module/category');
		$data['heading_title'] = $this->language->get('heading_title');

		$parts = array();
        $data['category_id'] = 0;
        $data['child_id'] = 0;
        if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} 

		if (isset($parts[0])) {
			$data['category_id'] = $parts[0];
		}

		if (count($parts) > 2) {
			$data['child_id'] = array_pop($parts); 
		}

        $data['url' ] = $this->url;
        $data['categories'] = $dm->getRepository('Category')->findAll();*/
        $this->load->model('extension/review'); 
        $this->response->setOutput($this->load->view('extension/module/review', $data));
    }

    private function validate($permission = 'modify')
    {
        if (!$this->user->hasPermission($permission, $this->route)) {
            $this->error['warning'] = $this->language->get('error_permission');
            return false;
        }

        return true;
    }

    public function install() {
        $this->load->model('setting/setting');
        $post = array();
        $post['review_enabled'] = "1";
        $post['review_entries'] = array();
        $this->model_setting_setting->editSetting('review', $post);
    }

    public function uninstall() {
    }
}