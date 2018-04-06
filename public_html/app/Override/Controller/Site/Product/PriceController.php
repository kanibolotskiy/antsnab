<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Product
 */

namespace WS\Override\Controller\Site\Product;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 6, 2018  2:49:27 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class PriceController extends \Controller
{
    public function index()
    {
        $this->load->language('product/price');
        //breadcrumbs
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_price'),
            'href' => $this->url->link('product/price')
        );

        $data['heading_title'] = $this->language->get('heading_title');

        //common
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('product/price', $data));
    }
}
