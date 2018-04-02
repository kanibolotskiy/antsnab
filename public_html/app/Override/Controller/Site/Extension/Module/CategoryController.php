<?php

/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Site\Extension\Module
 */

namespace WS\Override\Controller\Site\Extension\Module;

use WS\ORM\DomainManager;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CategoryController extends \Controller
{

    public function index()
    {
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

        $dm = DomainManager::create($this->registry);
        $data['categories'] = $dm->getRepository('Category')->findAll();
        $data['url' ] = $this->url;
        return $this->load->view('extension/module/category', $data);
    }    

}
