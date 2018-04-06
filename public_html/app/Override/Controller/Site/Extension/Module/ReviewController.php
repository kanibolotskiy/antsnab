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
class ReviewController extends \Controller
{
    public function index()
    {
        $data = [];
        $this->load->language('extension/module/review');
        $data['heading_title'] = $this->language->get('heading_title');
        $data['visible'] = $this->config->get('review_visible');
        $data['count'] = $this->config->get('review_count');
        $this->load->model('catalog/review');
        $data['reviews'] = $this->model_catalog_review->getRandReviews($data['count']);
        return $this->load->view('extension/module/review', $data);
    }    

}
