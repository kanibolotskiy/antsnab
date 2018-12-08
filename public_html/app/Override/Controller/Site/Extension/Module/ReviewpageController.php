<?php
namespace WS\Override\Controller\Site\Extension\Module;

use WS\Patch\Helper\PaginationHelper;
use WS\Override\Controller\Admin\Extension\Module\ReviewpageController as AdminModule;

/**
 * Модуль вывода отзывов на странице отзывов 
 * 
 * @version    1.0, Apr 2, 2018  9:04:28 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ReviewpageController extends \Controller
{
    protected $error;

    public function index()
    {
        $this->load->language('extension/module/reviewpage');
        $this->load->model('catalog/review');
        $defaultRaiting = (int)$this->config->get(AdminModule::CONFIG_KEY_RAITING);

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            $json = array();
            if ($this->validateForm($this->request->post)) {
                $newData = $this->request->post;
                $newData['rating'] = $defaultRaiting;
                $result = $this->model_catalog_review->addCompanyReview($newData);
                if($result) {
                    $json['success'] = "Отзыв сохранен";
                } else {
                    $json['error'] = 'Server error';
                }

            } else {
                $json['error'] = $this->error;
            }
            $this->response->addHeader('Content-Type: application/json');
            exit(json_encode($json));
        }

        $reviewsLimit = (int)$this->config->get(AdminModule::CONFIG_KEY_COUNT);
        $ruleId = $this->config->get(AdminModule::CONFIG_KEY_RULE_ID);
        
        $data['rules'] = $this->url->link('information/information', 'information_id=' . $ruleId);
        $data['text_thankyou_header'] = $this->language->get('text_thankyou_header');
        $data['text_thankyou'] = $this->language->get('text_thankyou');

        $current_route = $this->request->get['route'];
        $current_infId = $this->request->get['information_id'];
        $url = $this->url->link($current_route, 'information_id=' . $current_infId);

        //current page
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
        $limit = $reviewsLimit;
        $start = ($page - 1) * $limit;

        // new review
        $p = ( $page == 1 ) ? '' : '&page=' . $page;
        $data['action'] = $url . $p; 

        //review list
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
        $reviewsTotal = $this->model_catalog_review->getCompanyReviewsTotal();
        $meta[PaginationHelper::BASE_URL_META_INDEX] = $url;
        $paginationModel = PaginationHelper::getPaginationModel($reviewsTotal, $limit, (int)$page, $reviews , $meta);
        PaginationHelper::setDocumentLinks($this->document, $paginationModel);    
        $data['pagination'] = PaginationHelper::render($this->load, $paginationModel);

        
        $this->error = array();
        $data['entry_author'] = isset($this->request->post['author']) ? $this->request->post['author'] : '';
        $data['entry_email'] = isset($this->request->post['email']) ? $this->request->post['email'] : '';
        $data['entry_company'] = isset($this->request->post['company']) ? $this->request->post['company'] : '';
        $data['entry_text'] = isset($this->request->post['text']) ? $this->request->post['text'] : '';
        $data['show_popup'] = false;
        $data['captcha_key'] = $this->config->get('google_captcha_key');

        return $this->load->view('extension/module/app/reviewpage', $data);
    }

    protected function validateForm($request)
    {
        if ((utf8_strlen($this->request->post['author']) < 3) || (utf8_strlen($this->request->post['author']) > 64)) {
            $this->error['author'] = $this->language->get('error_author');
        }

        if ((utf8_strlen($this->request->post['company']) > 255)) {
            $this->error['company'] = $this->language->get('error_company');
        }

        /*
            можно было бы использовать закомментированную регулярку. но с кириллицей и @ не работает
            так же не работает часть {2,6} видимо из-за многобайтовой кодировки
        */
        $emailAr = explode('@', $this->request->post['email']);
        if( count($emailAr) != 2 ) {
            $this->error['email'] = $this->language->get('error_email');
        } else {
            $leftValid = preg_match('~([А-Яа-яA-Za-z0-9_-]+\.)*[А-Яа-яA-Za-z0-9_-]+~', $emailAr[0]) ; 
            $rightValid = preg_match('~[А-Яа-яA-Za-z0-9_-]+(\.[А-Яа-яA-Za-z0-9_-]+)*\.[А-Яа-яA-Za-z]~', $emailAr[1]);
            if( !($leftValid && $rightValid) ) {
                $this->error['email'] = $this->language->get('error_email');
            } 
        }
        /*if (1 != preg_match('~^([А-Яа-яA-Za-z0-9_-]+\.)*[А-Яа-яA-Za-z0-9_-]+@[А-Яа-яA-Za-z0-9_-]+(\.[А-Яа-яA-Za-z0-9_-]+)*\.[А-Яа-яA-Za-z]{2,6}$~', $this->request->post['email'])) {
            $this->error['email'] = $this->language->get('error_email');
        }*/

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
