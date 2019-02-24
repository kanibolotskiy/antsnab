<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Newsblog
 */

namespace WS\Override\Controller\Site\Newsblog;

use WS\Patch\Helper\PaginationHelper;

/**
 * Материалы фильтруются по category_id (последняя часть path, напр 2_3, фильтр по 3)
 * Пагинация формирует ссылки относительно всего path (напр 2_3)
 * НО! ссылки на сами материалы формируются из top_category_id ( 2 в примере)
 * @task1 сделать правильную обработку хлебных крошек
 * 
 * внимательно следить за параметрами path, передаваемые в методы paginate и showmore
 * 
 * @version    1.0, Apr 10, 2018  6:47:19 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CategoryController extends \Controller
{

    //@task move to Model. Be accurac, used in ArticleController
    const NEWS_CATEGORY_ID = 1;
    const ARTICLES_CATEGORY_ID = 2;
    const PREVIEW_SYMBOLS_COUNT = 80;

    public function index()
    {
        
        $this->load->language('newsblog/category');

        $this->load->model('newsblog/category');
        $this->load->model('newsblog/article');

        $this->load->model('tool/image');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        if (isset($this->request->get['newsblog_path'])) {
            $path = '';

            $parts = explode('_', (string) $this->request->get['newsblog_path']);

            //@added
            $top_category_id = $parts[0];

            $category_id = (int) array_pop($parts);

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = (int) $path_id;
                } else {
                    $path .= '_' . (int) $path_id;
                }

                $category_info = $this->model_newsblog_category->getCategory($path_id);
                
                if ($category_info) {
                    $data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $path)
                    );
                }
            }
        } else {
            $category_id = 0;
            $top_category_id = 0;
        }

        $category_info = $this->model_newsblog_category->getCategory($category_id);

        if ($category_info) {

            //for no errors with versions < 20160920
            $articles_image_size = array($this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
            $category_image_size = array($this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            $date_format = $this->language->get('date_format_short');
            if ($category_info['settings']) {
                $settings = unserialize($category_info['settings']);
                $category_info = array_merge($category_info, $settings);
                
                $articles_image_size = array($settings['images_size_width'], $settings['images_size_height']);
                $category_image_size = array($settings['image_size_width'], $settings['image_size_height']);
                $date_format = $settings['date_format'];
            }

            if ($category_info['meta_title']) {
                $this->document->setTitle($category_info['meta_title']);
            } else {
                $this->document->setTitle($category_info['name']);
            }

            $this->document->setDescription($category_info['meta_description']);
            $this->document->setKeywords($category_info['meta_keyword']);

            if ($category_info['meta_h1']) {
                $data['heading_title'] = $category_info['meta_h1'];
            } else {
                $data['heading_title'] = $category_info['name'];
            }

            $data['text_empty'] = $this->language->get('text_empty');
            $data['button_continue'] = $this->language->get('button_continue');
            $data['text_refine'] = $this->language->get('text_refine');
            $data['text_attributes'] = $this->language->get('text_attributes');

            $data['continue'] = $this->url->link('common/home');

            // Set the last category breadcrumb
            $data['breadcrumbs'][] = array(
                'text' => $category_info['name'],
                'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $this->request->get['newsblog_path'])
            );

            if ($category_info['image']) {
                $data['original'] = HTTP_SERVER . 'image/' . $category_info['image'];
                $data['thumb'] = $this->model_tool_image->resize($category_info['image'], $category_image_size[0], $category_image_size[1]);
            } else {
                $data['original'] = '';
                $data['thumb'] = '';
            }

            $data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');

            //@removed subcats list
            $data['categories'] = array();

            //@added dropdown list of articles' subcats
            $data['subCats'] = array();
            if( $top_category_id == static::ARTICLES_CATEGORY_ID )
            {
                $subCats = $this->model_newsblog_category->getCategories(static::ARTICLES_CATEGORY_ID);

                //all
                $articlePath = static::ARTICLES_CATEGORY_ID;
                $isActive = (string)$articlePath === $this->request->get['newsblog_path'];
                $data['subCats'][] = array(
                    'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $articlePath),
                    'name' => $this->language->get('all_articles'), 
                    'active' => $isActive
                );

                //particular
                foreach( $subCats as $sc ) {
                    $articlePath = static::ARTICLES_CATEGORY_ID . '_' . $sc['category_id'];
                    $isActive = $articlePath === $this->request->get['newsblog_path'];
                    $data['subCats'][] = array(
                        'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $articlePath) ,
                        'name' => $sc['name'],
                        'active' => $isActive,
                    );
                }
            }

            //collect articles
            $data['articles'] = array();
            $limit = $category_info['limit'];

            if ($limit > 0) {
                $sort = $category_info['sort_by'];
                $order = $category_info['sort_direction'];

                $filter_data = array(
                    'filter_category_id' => $category_id,
                    'filter_sub_category' => true,
                    'sort' => $sort,
                    'order' => $order,
                    'start' => ($page - 1) * $limit,
                    'limit' => $limit
                );

                /** @added filtering by year */
                $data['years'] = array();

                if ($top_category_id == static::NEWS_CATEGORY_ID) {
                    $this->load->model('newsblog/article');
                    $yearsRaw = [];
                    $newsSubCats = $this->model_newsblog_category->getCategories(static::NEWS_CATEGORY_ID);
                    foreach($newsSubCats as $sub) {
                        $newPath = static::NEWS_CATEGORY_ID . '_' . $sub['category_id'];                  
                        $isActive = $newPath === $this->request->get['newsblog_path'];
                        $data['years'][$sub['name']] = [
                            'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $newPath ),
                            'text' => $sub['name'],
                            'active' => $isActive 
                        ];    
                    }
                    krsort($data['years'], SORT_STRING);

                }

                //@changed get articles, pagination construction
                $article_total = $this->model_newsblog_article->getTotalArticles($filter_data);
                $data['articles'] = $this->collectArticles($filter_data, $articles_image_size, $date_format, $top_category_id);
                

                /** Pagination */
                $paginationModel = PaginationHelper::getPaginationModel($article_total, (int)$limit, (int)$page);
                
                $paginationBaseUrl = $this->url->link('newsblog/category', 'newsblog_path=' . $this->request->get['newsblog_path']);
                $data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);

                $lazyLoadBaseUrl = $this->url->link('newsblog/category/showmore', 'path=' . $this->request->get['newsblog_path'] );
                $data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl, $paginationModel);


            }

            /* $data['canonical'] = $this->url->link('newsblog/category', 'newsblog_path=' . $category_info['category_id'], 'SSL'); */

            //for no errors with versions < 20170906
            $data['comments_vk'] = false;
            $data['comments_fb'] = false;
            $data['comments_dq'] = false;
            if ($settings && isset($settings['show_comments_vk_id'])) {
                if ($settings && $settings['show_comments_vk_id'] && $settings['show_comments_vk_category']) {
                    $data['comments_vk'] = $settings['show_comments_vk_id'];
                    $this->document->addScript('//vk.com/js/api/openapi.js');
                }

                if ($settings && $settings['show_comments_fb_category'])
                    $data['comments_fb'] = true;

                if ($settings && $settings['show_comments_dq_id'] && $settings['show_comments_dq_category'])
                    $data['comments_dq'] = $settings['show_comments_dq_id'];
            }

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $template_default = 'category.tpl';
            if ($category_info['template_category'])
                $template_default = $category_info['template_category'];

            $this->response->setOutput($this->load->view('newsblog/' . $template_default, $data));
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('newsblog/category')
            );

            $this->document->setTitle($this->language->get('text_error'));

            $data['heading_title'] = $this->language->get('text_error');

            $data['text_error'] = $this->language->get('text_error');

            $data['button_continue'] = $this->language->get('button_continue');

            $data['continue'] = $this->url->link('common/home');

            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $this->response->setOutput($this->load->view('error/not_found.tpl', $data));
        }
    }

    public function showmore()
    {
        $this->load->model('newsblog/category');
        $this->load->model('newsblog/article');

        $result = array('result'=>null, 'error'=>null);

        $category_id = 0;
        if (isset($this->request->get['path'])) {
            $parts = explode('_', (string) $this->request->get['path']);
            $top_category_id = $parts[0];
            $category_id = (int) array_pop($parts);
        }

        $category_info = $this->model_newsblog_category->getCategory($category_id);
        $date_format = null;
        $articles_image_size = array();
        $limit = 0;

        if ($category_info) {
            if ($category_info['settings']) {
                $settings = unserialize($category_info['settings']);
                $category_info = array_merge($category_info, $settings);

                $articles_image_size = array($settings['images_size_width'], $settings['images_size_height']);
                $date_format = $settings['date_format'];
            }
            $limit = $category_info['limit'];
        }

        if ($limit <= 0) {
            $result['error'] = 'Settings for articles\' category is wrong. Limit cant be negative or 0';
            $this->response->setOutput(json_encode($result));
            return true;
        }

        $page = 1;
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        }

        
        $filter_data = array(
            'filter_category_id' => $category_id,
            'filter_sub_category' => true,
            'sort' => $category_info['sort_by'],
            'order' => $category_info['sort_direction'],
            'start' => ($page - 1) * $limit,
            'limit' => $limit,
            //'filter_year' => $filter_year
        );
        $articles = $this->collectArticles($filter_data, $articles_image_size, $date_format, $top_category_id );
        $article_total = $this->model_newsblog_article->getTotalArticles($filter_data);

        if( !$articles ) {
           $result['error'] = 'Articles not found';
           $this->response->setOutput(json_encode($result));
           return true;
        }

        $template_default = 'category.tpl';
        if ($category_info['template_category'])
            $template_default = $category_info['template_category'];

        $articlesRendered = [];
        foreach( $articles as $a ){
            $articlesRendered[] = $this->load->view("newsblog/partial/item_{$template_default}", ['article'=>$a]);
        }

        $lazyLoadResponse = PaginationHelper::getLazyLoadResponse($this->registry, [
            'items' => $articlesRendered,
            'total' => (int)$article_total,
            'itemsPerPage' => (int)$limit,
            'page' => (int)$page,
            //'paginationBaseUrl' => $this->getPaginationBaseUrl($filter_year, $this->request->get['path'] ),
            'paginationBaseUrl' => $this->url->link('newsblog/category', 'newsblog_path=' . $this->request->get['path']),
            //'lazyLoadBaseUrl' => $this->getLazyLoadBaseUrl($filter_year, $this->request->get['path'] ),
            'lazyLoadBaseUrl' => $this->url->link('newsblog/category/showmore', 'path=' . $this->request->get['path'] )
        ]); 

        $this->response->setOutput($lazyLoadResponse);
    }

    protected function collectArticles($filter_data, $articles_image_size, $date_format, $category_path = 0)
    {
        $articles = array();

        $this->load->model('newsblog/article');
        $this->load->model('tool/image');

        $results = $this->model_newsblog_article->getArticles($filter_data);
        

        foreach ($results as $result) {

            if ($result['image']) {
                $original = HTTP_SERVER . 'image/' . $result['image'];
                $thumb = $this->model_tool_image->resize($result['image'], $articles_image_size[0], $articles_image_size[1]);
            } else {
                $original = '';
                $thumb = ''; //or use 'placeholder.png' if you need
            }

            $preview = html_entity_decode($result['preview'], ENT_QUOTES, 'UTF-8');
            if( empty($preview) ) {
                $preview = html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8');
            }
            $preview = strip_tags($preview);
            $preview = mb_substr($preview, 0, static::PREVIEW_SYMBOLS_COUNT ) . '...';

            $articles[] = array(
                'article_id' => $result['article_id'],
                'original' => $original,
                'thumb' => $thumb,
                'name' => $result['name'],
                //@added
                'cat_name' => $result['cat_name'],
                'main_catid' =>  $result['main_catid'],
                'preview' => $preview, 
                'attributes' => $result['attributes'],
                'href' => $this->url->link('newsblog/article', 'newsblog_path=' . $category_path . '&newsblog_article_id=' . $result['article_id']),
                'date' => ($date_format ? date($date_format, strtotime($result['date_available'])) : false),
                'date_modified' => ($date_format ? date($date_format, strtotime($result['date_modified'])) : false),
                'viewed' => $result['viewed']
            );
        }

        return $articles;
    }

}
