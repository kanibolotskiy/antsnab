<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Product
 * @added Выводится либо список категорий либо список продуктов в зависимости от типа категории (isfinal)
 */

namespace WS\Override\Controller\Site\Product;

use WS\Override\Gateway\FinalCategory;
use WS\Patch\Helper\ProductListHelper;
use WS\Override\Gateway\ProdProperties;
use WS\Patch\Helper\PaginationHelper;

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
        $this->load->model('catalog/information');

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
            
            $category_final_info = $this->model_catalog_category->getCategory($category_id);

            $catalog_page=1;
            if(isset($_GET["page"])){
                $catalog_page=$_GET["page"];
            }

            if((isset($category_final_info["bottom_text"]))and($catalog_page==1)){
                $this->data['bottom_text'] = $this->model_catalog_information->cleanText($category_final_info["bottom_text"]);
                $this->data['description'] = html_entity_decode($category_final_info['description'], ENT_QUOTES, 'UTF-8');
            }else{
                $this->data['bottom_text'] = '';
                $this->data['description'] = '';
            }
        } else {
            $category_id = 0;
        }



        $cat_view1="active";
        $cat_view2="";
        $cat_view_class="tab-block2";
        if(isset($_COOKIE["cat_view"])){
            if($_COOKIE["cat_view"]=="view2"){
                $cat_view1="";                
                $cat_view2="active";
                $cat_view_class="";
            }
        }
        $this->data["cat_view1"]=$cat_view1;
        $this->data["cat_view2"]=$cat_view2;
        $this->data["cat_view_class"]=$cat_view_class;
            
        $this->data['catalog_brand_img']='';
        if($category_final_info["isbrand"]){
            $image_brand = $this->model_tool_image->resize($category_final_info["image"], 100, 100);
            $this->data['catalog_brand_img'] = $image_brand;
        }
        
        //echo $catalog_brand

        $gateway = new FinalCategory($this->registry);
        $isCategoryFinal = $gateway->isCategoryFinal($category_id);
        $flag_is_seo=$gateway->isCategorySeo($category_id);

        $category_info = $this->model_catalog_category->getCategory($category_id);
        
        //print_r($category_info);
        if($category_info["isseo"]){
            $categories_seo = $this->model_catalog_category->getCategoresSeo($category_info["parent_id"]);
        }else{
            $categories_seo = $this->model_catalog_category->getCategoresSeo($category_id);
        }
        $this->data["category_id"]=$category_id;

        
        if (!$category_info) {
            $this->showNotFound();
            return;
        }

        $this->setCommons($category_info);
        
        $this->setFilterCategories($categories_seo,$category_id);

        if($flag_is_seo){
            $this->showProducts($category_id,true,null);
            return;
        }
        if ($isCategoryFinal) {
            $parent_category_info = $this->model_catalog_category->getCategory($category_info["parent_id"]);
            $this->showProducts($category_id,false,$parent_category_info);
            return;
        }

        

        $this->showCategories($category_id);
    }
   
    public function showmore()
    {
        if (isset($this->request->get['cat_path'])) {
            $parts = explode('_', (string) $this->request->get['cat_path']);
            $category_id = (int) array_pop($parts);
        } else {
            $category_id = 0;
        }

        $this->load->model('catalog/product');
        
        $filter_data = $this->getFilter($category_id, $limit, $page, $sort_selected, true);
        

        //$filter_data = $this->getFilter($category_id, $limit, $page, 0, true);
        $products_total = $this->model_catalog_product->getTotalProducts($filter_data);

        $productsHelper = new ProductListHelper($this->registry);
        $products = $productsHelper->getProducts($filter_data,true);
        //print_r($products_data);

        $queryString = $this->hierarhy->getPath($category_id);
        if (isset($this->request->get['filter'])) {
            $queryString .= '&filter=' . $this->request->get['filter'];
        }
        if (isset($this->request->get['sort'])) {
            $queryString .= '&sort=' . $this->request->get['sort'];
        }
        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

        $items = [];
        foreach( $products as $p ){
            $items[] = $this->load->view("partial/product_item", ['p'=>$p]);
        }

        $lazyLoadResponse = PaginationHelper::getLazyLoadResponse($this->registry, [
            'items' => $items, 
            'total' => (int)$products_total,
            'itemsPerPage' => (int)$limit,
            'page' => (int)$page,
            'paginationBaseUrl' => $paginationBaseUrl,
            'lazyLoadBaseUrl' => $lazyLoadBaseUrl,
        ]); 

        $this->response->setOutput($lazyLoadResponse);
        
    }

    private function setFilterCategories($categories_seo, $current_id){
        $url="";
        foreach($categories_seo as $category){
            if((!$category['notshowisseo']) or ($current_id==$category["category_id"])){
                $this->data['categories_isseo'][] = array(
                    'category_id'   => $category['category_id'],
                    'name' => $category['name'],
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $category['category_id'] . $url)
                );
            }
        }
    }

    private function showCategories($category_id)
    {
        $this->data['categories'] = array();
        $results = $this->model_catalog_category->getCategories($category_id);

        //@removed
        $url = '';

        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            }

            $sub = array();
            $path = $this->hierarhy->getPath($result['category_id']);
            if( $result['isfinal'] ) {
                try {
                    $subRes = $this->hierarhy->getNodeById($result['category_id'])->get('products');
                    foreach ($subRes as $p) {
                        $sub[] = array(
                            'name' => $p['name'],
                            'href' => $this->url->link('product/product', 'path=' . $path .  '&product_id=' . $p['product_id'])
                        );
                    }
                } catch (\Exception $e ) {}
            } else {
                $subRes = $this->hierarhy->getNodeById($result['category_id'])->getChildren(); 
                
                foreach ($subRes as $c) {
                    if(!$c->get('isseo')){
                        $sub[] = array (
                            'name' => $c->get('name'),
                            'href' => $this->url->link('product/category', 'path=' . $path . '_' . $c->get('category_id') . $url)
                        );
                    }
                }
            }
            

            $this->data['categories'][] = array(
                'name' => $result['name'],
                'thumb' => $image,
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '...',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url),
                'sub' => $sub
            );
        }
        //$this->setPartials();
        if($category_id==71){
            $this->setPartials();
            $template_catalog='product/category_main';
        }else{
            $template_catalog='product/category';

            //$category_id=264;
            $filter_data = $this->getFilter($category_id, $limit, $page, $sort_selected, true);
            
            $this->data['sort_selected']=$sort_selected;
            $product_total = $this->model_catalog_product->getTotalProducts($filter_data);
            $productsHelper = new ProductListHelper($this->registry);
            
            
            
            $queryString = $this->hierarhy->getPath($category_id);
            if (isset($this->request->get['filter'])) {
                $queryString .= '&filter=' . $this->request->get['filter'];
            }
            if (isset($this->request->get['sort'])) {
                $queryString .= '&sort=' . $this->request->get['sort'];
            }
            $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
            $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

            $paginationModel = PaginationHelper::getPaginationModel($product_total, (int)$limit, (int)$page);
            $this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
            $this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl, $paginationModel);
            
            $this->setPartials();
            
            if ($page == 1) {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_id, true), 'canonical');
            } elseif ($page == 2) {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_id, true), 'prev');
            } else {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_id . '&page='. ($page - 1), true), 'prev');
            }
            
            if ($limit && ceil($product_total / $limit) > $page) {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_id . '&page='. ($page + 1), true), 'next');
            }

            $this->data['products'] = $productsHelper->getProducts($filter_data);
        }
        $this->response->setOutput($this->load->view($template_catalog, $this->data));
    }

    private function showProducts($category_id, $showPropertyTable=false, $parent_category=null)
    {
        
        $filter_data = $this->getFilter($category_id, $limit, $page, $sort_selected, true);
        
        $this->data['sort_selected']=$sort_selected;
        $product_total = $this->model_catalog_product->getTotalProducts($filter_data);
        $productsHelper = new ProductListHelper($this->registry);


        $products_add=[];
        $parent_category_name='';
        if(($product_total<5) and $parent_category) {
            //print_r($parent_category);
            
            $filter_data_add = array(
                'filter_category_id' => $parent_category["category_id"],
                'sort' => 'viewed',
                'order' => 'DESC',
                'start' => 0,
                'limit' => 4,
                'filter_sub_category'=>1
            );
            $parent_category_name=$parent_category["name"];
            $products_add=$productsHelper->getProducts($filter_data_add);
        }
        $this->data["parent_name"]=$parent_category_name;
        $this->data["products_add"]=$products_add;

        
        
        //$filter_data['limit']=18;
        

        $this->data['products'] = $productsHelper->getProducts($filter_data);

        if(!$showPropertyTable){
            //summary table
            $propGateway = new ProdProperties($this->registry);
            $this->data['summary'] = $propGateway->getSummaryTableRows($category_id);
        }

        /** Pagination */
        $queryString = $this->hierarhy->getPath($category_id);
        if (isset($this->request->get['filter'])) {
            $queryString .= '&filter=' . $this->request->get['filter'];
        }
        if (isset($this->request->get['sort'])) {
            $queryString .= '&sort=' . $this->request->get['sort'];
        }
        $paginationBaseUrl = $this->url->link('product/category', 'path=' . $queryString);
        $lazyLoadBaseUrl = $this->url->link('product/category/showmore', 'cat_path=' . $queryString);

        $paginationModel = PaginationHelper::getPaginationModel($product_total, (int)$limit, (int)$page);
        $this->data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
        $this->data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl, $paginationModel);

        
        


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
        if($category_info['meta_keyword']){
            $this->document->setKeywords($category_info['meta_keyword']);
        }else{
            $this->document->setKeywords($category_info['meta_h1']);
        }

        $catalog_page=1;
        if(isset($_GET["page"])){
            $catalog_page=$_GET["page"]*1;
        }
        
        if ($category_info['meta_h1']) {
            $this->data['heading_title'] = $category_info['meta_h1'];
        } else {
            $this->data['heading_title'] = $category_info['name'];
        }
        if($catalog_page>1){
            $this->data['heading_title']=$this->data['heading_title'].". Страница ".$catalog_page;
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

        //$this->data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
        //$this->data['compare'] = $this->url->link('product/compare');
    }

    private function getFilter($category_id, &$limit, &$page = 1 , &$sort_selected = 0, $filter_sub_category=0)
    {
        if (isset($this->request->get['filter'])) {
            $filter = $this->request->get['filter'];
        } else {
            $filter = '';
        }

    
        $sort = '';
        $order = '';
        $sort_selected="";
        if (isset($this->request->get['sort'])) {
            $sort_selected=$this->request->get['sort'];

            $sort_arr=explode("|",$this->request->get['sort']);
            if((isset($sort_arr[0]))and(isset($sort_arr[1]))){
                $sort=$sort_arr[0];
                $order=$sort_arr[1];
            }
        }
        
        /*
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
        */
        if (isset($this->request->get['page'])) {
            if($this->request->get['page']){
                $page = ($this->request->get['page'])*1;
            }else{
                $page=1;
            }
        } else {
            $page = 1;
        }

        if (isset($this->request->get['limit'])) {
            $limit = (int) $this->request->get['limit'];
        } else {
            $limit = (int) $this->config->get($this->config->get('config_theme') . '_product_limit');
        }
        
        
        if (isset($this->request->get['load_pages'])) {
            $end = (int) $this->request->get['load_pages'];
        }else{
            $end = 1;
        }

        
        
        $filter_data = array(
            'filter_category_id' => $category_id,
            'filter_filter' => $filter,
            'sort' => $sort,
            'order' => $order,
            'start' => ($page - 1) * $limit,
            'limit' => $end*$limit,
            'filter_sub_category'=>$filter_sub_category
        );
        
        return $filter_data;
    }
}
