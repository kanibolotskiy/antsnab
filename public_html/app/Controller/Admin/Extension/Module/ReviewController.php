<?php

/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Site\Extension\Module
 */

namespace WS\Controller\Admin\Extension\Module;

use WS\ORM\DomainManager;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ReviewController extends \Controller
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
        $this->response->setOutput($this->model_extension_d_opencart_patch_load->view($this->route . '/' . $this->codename . '_editor', $data));
    }

    private function validate($permission = 'modify')
    {
        if (!$this->user->hasPermission($permission, $this->route)) {
            $this->error['warning'] = $this->language->get('error_permission');
            return false;
        }

        return true;
    }

    public function install()
    {
        /*if ($this->d_shopunity) {
            $this->load->model('extension/d_shopunity/mbooth');
            $this->model_extension_d_shopunity_mbooth->installDependencies($this->codename);
        }

        $this->load->model($this->route);
        $this->model_extension_module_d_admin_menu->installDatabase();
        $this->model_extension_module_d_admin_menu->modification_handler(1);*/
    }

    public function uninstall()
    {
        /*$this->load->model($this->route);
        $this->model_extension_module_d_admin_menu->uninstallDatabase();
        $this->model_extension_module_d_admin_menu->modification_handler(0);

        $this->uninstallEvents();*/
    }

}
