<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Information
 */

namespace WS\Override\Controller\Site\Information;

use WS\Patch\Helper\Pagination;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 2, 2018  9:04:28 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ReviewController extends \Controller
{

    protected $error;

    public function index()
    {
        $this->load->language('information/review');

        //breadcrumbs
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_reviews'),
            'href' => $this->url->link('information/review')
        );

        //seo meta
        //@task get meta somewhere
        $meta_info = array(
            'heading_title' => 'Отзывы о работе компании Ант-Снаб',
            'review_meta_title' => 'Отзывы о работе компании Ант-Снаб',
            'review_meta_description' => 'Some description',
            'review_meta_keyword' => 'Some keywords',
        );
        $reviewsLimit = 20;
        $defaultRaiting = 5;
        //$this->config->get($this->config->get('config_theme') . '_product_limit')

        $this->document->setTitle($meta_info['review_meta_title']);
        $this->document->setDescription($meta_info['review_meta_description']);
        $this->document->setKeywords($meta_info['review_meta_keyword']);

        $data['heading_title'] = $meta_info['heading_title'];

        //seo route
        if (isset($this->request->get['route'])) {
            $this->document->addLink($this->config->get('config_url'), 'canonical');
        }

        //current page
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
        $limit = $reviewsLimit;
        $start = ($page - 1) * $limit;

        //review list
        $this->load->model('catalog/review');
        $data['reviews'] = [];
        $reviews = $this->model_catalog_review->getCompanyReviews($start, $limit);
        if ($reviews) {
            foreach ($reviews as $review) {
                $data['reviews'][] = array(
                    'author' => $review['author'],
                    'text' => $review['text'],
                    'about' => $review['about'],
                    'moderator' => $review['moderator'],
                    'answer' => $review['answer'],
                    'date' => $review['date_added']
                );
            }
        }

        //pagination
        $pagination = new Pagination();
        $reviewsTotal = $this->model_catalog_review->getCompanyReviewsTotal();
        $pagination->total = $reviewsTotal;
        $pagination->page = $page;
        $pagination->limit = $limit;
        $pagination->url = $this->url->link('information/review', '&page={page}');

        $data['pagination'] = $pagination->render();


        // http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
        if ($page == 1) {
            $this->document->addLink($this->url->link('information/review', '', true), 'canonical');
        } elseif ($page == 2) {
            $this->document->addLink($this->url->link('information/review', '', true), 'prev');
        } else {
            $this->document->addLink($this->url->link('information/review', '&page=' . ($page - 1), true), 'prev');
        }

        if ($limit && ceil($reviewsTotal / $limit) > $page) {
            $this->document->addLink($this->url->link('information/review', '&page=' . ($page + 1), true), 'next');
        }

        // new review
        $p = ( $page == 1 ) ? '' : '&page=' . $page;
        $data['action'] = $this->url->link('information/review', $p);
        $this->document->addScript('https://www.google.com/recaptcha/api.js', 'footer');
        $this->error = array();
        $data['entry_author'] = isset($this->request->post['author']) ? $this->request->post['author'] : '';
        $data['entry_email'] = isset($this->request->post['email']) ? $this->request->post['email'] : '';
        $data['entry_company'] = isset($this->request->post['company']) ? $this->request->post['company'] : '';
        $data['entry_text'] = isset($this->request->post['text']) ? $this->request->post['text'] : '';
        $data['show_popup'] = false;
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ($this->validateForm($this->request->post)) {
                $newData = $this->request->post;
                $newData['rating'] = $defaultRaiting;
                $result = $this->model_catalog_review->addCompanyReview($newData);
                if($result) {
                    $data['show_popup'] = true;
                }
            }
        }
        $data['errors'] = $this->error;

        //common
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('information/review', $data));
    }

    protected function validateForm($request)
    {

        if ((utf8_strlen($this->request->post['author']) < 3) || (utf8_strlen($this->request->post['author']) > 64)) {
            $this->error['author'] = $this->language->get('error_author');
        }

        if ((utf8_strlen($this->request->post['company']) > 255)) {
            $this->error['company'] = $this->language->get('error_company');
        }

        if (1 != preg_match('~^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$~', $this->request->post['email'])) {
            $this->error['email'] = $this->language->get('error_email');
        }

        if (utf8_strlen($this->request->post['text']) < 1) {
            $this->error['text'] = $this->language->get('error_text');
        }

        if( !isset($this->request->post['agree']) || ('1' !== $this->request->post['agree']) ) {
            $this->error['agree'] = $this->language->get('error_agree');
        }

        // Captcha
        if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array) $this->config->get('config_captcha_page'))) {
            $captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

            if ($captcha) {
                $this->error['captcha'] = $captcha;
            }
        }

        return !$this->error;
    }

}
