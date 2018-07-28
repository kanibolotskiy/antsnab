<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Product
 * @added Выводится либо список категорий либо список продуктов в зависимости от типа категории (isfinal)
 */

namespace WS\Override\Controller\Site\Product;

use WS\Override\Gateway\ProdProperties;
use WS\Patch\Helper\PaginationHelper;
use WS\Override\Gateway\Hierarhy;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 23, 2018  9:17:39 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CategoryController extends \Controller
{

    private $data;

    public function index()
    {
        $this->load->language('product/category');
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        if (isset($this->request->get['path'])) {
            //@removed
            $url = '';

            $path = '';

            $parts = explode('_', (string) $this->request->get['path']);

            $category_id = (int) array_pop($parts);

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = (int) $path_id;
                } else {
                    $path .= '_' . (int) $path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $this->data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('product/category', 'path=' . $path . $url)
                    );
                }
            }
        } else {
            $category_id = 0;
        }

        $gateway = new ProdProperties($this->registry);
        $isCategoryFinal = $gateway->isCategoryFinal($category_id);

        $category_info = $this->model_catalog_category->getCategory($category_id);
        if (!$category_info) {
            $this->showNotFound();
            return;
        }

        $this->setCommons($category_info);

        if ($isCategoryFinal) {
            $this->showProducts($category_id);
            return;
        }

        $this->showCategories($category_id);
    }

    private function showCategories($category_id)
    {

        $this->data['categories'] = array();
        $results = $this->model_catalog_category->getCategories($category_id);

        //@removed
        $url = '';

        foreach ($results as $result) {
            $filter_data = array(
                'filter_category_id' => $result['category_id'],
                'filter_sub_category' => true
            );

             if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            }

            //@task important!!! очень высокая нагрузка на базу - исправить
            $sub = array();
            if( $result['isfinal'] ) {
                $subRes = $this->model_catalog_product->getProducts(
                    ['filter_category_id' => $result['category_id'] ]   
                );
                foreach ($subRes as $s) {
                    $sub[] = array(
                        'name' => $s['model'],
                        'href' => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $s['product_id'])
                    );
                }
            } else {
                $subRes = $this->model_catalog_category->getCategories( $result['category_id'] );
                foreach ($subRes as $s) {
                    $sub[] = array (
                        'name' => $s['name'],
                        'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $s['category_id'] . $url)
                    );
                }
            }
            

            $this->data['categories'][] = array(
                'name' => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
                'thumb' => $image,
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url),
                'sub' => $sub
            );
        }
        $this->setPartials();
        $this->response->setOutput($this->load->view('product/category', $this->data));
    }

    private function showProducts($category_id)
    {
        $this->data['products'] = array();
        
        //при формировании breadcrumbs для финальной категории нужно учесть сортировки,фильтры и т п
        $url = '';

        if (isset($this->request->get['filter'])) {
            $filter = $this->request->get['filter'];
        } else {
            $filter = '';
        }

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'p.sort_order';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        if (isset($this->request->get['limit'])) {
            $limit = (int) $this->request->get['limit'];
        } else {
            $limit = (int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        }

        $filter_data = array(
            'filter_category_id' => $category_id,
            'filter_filter' => $filter,
            'sort' => $sort,
            'order' => $order,
            'start' => ($page - 1) * $limit,
            'limit' => $limit
        );

        //need later for prod props and summary table
        $propGateway = new ProdProperties($this->registry);

        $this->load->model('catalog/product');
        $results = $this->model_catalog_product->getProducts($filter_data);

        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            }

            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $price = false;
            }

            if ((float) $result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $special = false;
            }

            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
            } else {
                $tax = false;
            }

            if ($this->config->get('config_review_status')) {
                $rating = (int) $result['rating'];
            } else {
                $rating = false;
            }

            $properties = $propGateway->getPropertiesWithProductValues($result['product_id'], 'order by sortOrder ASC');
            $previewProperties = array();
            foreach($properties as $p){
                if( $p['showInProdPreview']) {
                    $previewProperties[] = array(
                        'name' => $p['cat_name'],
                        'val' => $p['val'],
                        'unit' => $p['cat_unit']
                    );
                }
            }

            $this->data['products'][] = array(
                'product_id' => $result['product_id'],
                'thumb' => $image,
                'name' => $result['name'],
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                'descriptionPreview' => utf8_substr(strip_tags(html_entity_decode($result['location'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '...', 
                'price' => $price,
                'special' => $special,
                'tax' => $tax,
                'minimum' => ($result['minimum'] > 0) ? $result['minimum'] : 1,
                'rating' => $rating,
                'properties' => $previewProperties,
                'href' => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
            );
        }


        //pagination
        $product_total = $this->model_catalog_product->getTotalProducts($filter_data);
        $meta[PaginationHelper::BASE_URL_META_INDEX] = $this->url->link('product/category', 'path=' . $this->request->get['path']);
        $paginationModel = PaginationHelper::getPaginationModel($product_total, $limit, (int)$page, $results , $meta);
        PaginationHelper::setDocumentLinks($this->document, $paginationModel);    
        $this->data['pagination'] = PaginationHelper::render($this->load, $paginationModel);

        //summary table
        $this->data['summary'] = $propGateway->getSummaryTableRows($category_id);

        $this->setPartials();
        $this->response->setOutput($this->load->view('product/category_final', $this->data));
    }

    private function showNotFound()
    {
        $url = '';

        if (isset($this->request->get['path'])) {
            $url .= '&path=' . $this->request->get['path'];
        }

        if (isset($this->request->get['filter'])) {
            $url .= '&filter=' . $this->request->get['filter'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_error'),
            'href' => $this->url->link('product/category', $url)
        );

        $this->document->setTitle($this->language->get('text_error'));

        $this->data['heading_title'] = $this->language->get('text_error');

        $this->data['text_error'] = $this->language->get('text_error');

        $this->data['button_continue'] = $this->language->get('button_continue');

        $this->data['continue'] = $this->url->link('common/home');

        $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

        $this->setPartials();

        $this->response->setOutput($this->load->view('error/not_found', $this->data));

        exit();
    }

    private function setPartials()
    {
        $this->data['column_left'] = $this->load->controller('common/column_left');
        $this->data['column_right'] = $this->load->controller('common/column_right');
        $this->data['content_top'] = $this->load->controller('common/content_top');
        $this->data['content_bottom'] = $this->load->controller('common/content_bottom');
        $this->data['footer'] = $this->load->controller('common/footer');
        $this->data['header'] = $this->load->controller('common/header');
    }

    private function setCommons($category_info)
    {
        if ($category_info['meta_title']) {
            $this->document->setTitle($category_info['meta_title']);
        } else {
            $this->document->setTitle($category_info['name']);
        }
        $this->document->setDescription($category_info['meta_description']);
        $this->document->setKeywords($category_info['meta_keyword']);

        if ($category_info['meta_h1']) {
            $this->data['heading_title'] = $category_info['meta_h1'];
        } else {
            $this->data['heading_title'] = $category_info['name'];
        }

        $this->data['text_refine'] = $this->language->get('text_refine');
        $this->data['text_empty'] = $this->language->get('text_empty');
        $this->data['text_quantity'] = $this->language->get('text_quantity');
        $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $this->data['text_model'] = $this->language->get('text_model');
        $this->data['text_price'] = $this->language->get('text_price');
        $this->data['text_tax'] = $this->language->get('text_tax');
        $this->data['text_points'] = $this->language->get('text_points');
        $this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
        $this->data['text_sort'] = $this->language->get('text_sort');
        $this->data['text_limit'] = $this->language->get('text_limit');

        $this->data['button_cart'] = $this->language->get('button_cart');
        $this->data['button_wishlist'] = $this->language->get('button_wishlist');
        $this->data['button_compare'] = $this->language->get('button_compare');
        $this->data['button_continue'] = $this->language->get('button_continue');
        $this->data['button_list'] = $this->language->get('button_list');
        $this->data['button_grid'] = $this->language->get('button_grid');

        // Set the last category breadcrumb
        $this->data['breadcrumbs'][] = array(
            'text' => $category_info['name'],
            'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'])
        );

        if ($category_info['image']) {
            $this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            $this->document->setOgImage($this->data['thumb']);
        } else {
            $this->data['thumb'] = '';
        }

        $this->data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
        $this->data['compare'] = $this->url->link('product/compare');
    }

}
