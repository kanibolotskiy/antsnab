<?php

/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Site\Extension\Module
 */

namespace WS\Override\Controller\Site\Extension\Module;

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
        $this->load->model('catalog/information');
        //$data['reviews'] = $this->model_catalog_review->getRandReviews($data['count']);
        $data_reviews = $this->model_catalog_review->getRandReviews($data['count']);

        $review_page_id = 8;
        $review_link = $this->url->link('information/information', 'information_id=' . $review_page_id);
        
        foreach($data_reviews as $review){
            $review_data=$this->model_catalog_information->cleanText($review);
            

            if($review['product_id']){
                $review_data['href']=$this->url->link('product/product', '&product_id=' . $review['product_id']);
                $review_data['about_txt']='"'.$review_data['name'].'"';
            }else{
                $review_data['href']=$review_link;
                $review_data['about_txt']='"Сервисе"';
            }
            $data['reviews'][]=$review_data;
        }
        return $this->load->view('extension/module/app/review', $data);
    }    

}
