<?php

/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Site\Common
 */

namespace WS\Override\Controller\Site\Common;

use WS\Override\Controller\IDecorator;
use WS\ORM\DomainManager;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 25, 2018  7:47:42 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class HomeTemplateDecorator implements IDecorator
{

    const NEWS_MODULE_ID = 36;
    const ARTICLES_MODULE_ID = 37;
    const ARTICLES_CATEGORY_ID = 2;
    const PREVIEW_SYMBOLS_COUNT = 80;

    public function process($data, $registry)
    {
        $registry->get('load')->model('tool/lastmod');
        $registry->get('model_tool_lastmod')->setLastModHeader('home');
        
        $registry->get('load')->model('tool/image');
        $imageTool = $registry->get('model_tool_image');
        $config = $registry->get('config');

        $width = $config->get($config->get('config_theme') . '_image_category_width');
        $height = $config->get($config->get('config_theme') . '_image_category_height');

        $data['rootCategories'] = [];
        $categoryNodes = $registry->get('hierarhy')->getRootNodes();
        $registry->get('load')->model('tool/image');
        $model_tool_image = $registry->get('model_tool_image');
        $config = $registry->get('config');

        foreach( $categoryNodes as $node ) {
            $href = $registry->get('url')->link('product/category', 'path=' . $registry->get('hierarhy')->getPath($node->getId()));
            if (!empty( $node->get('image') ) ) {
                $resizedImage = $model_tool_image->resize(
                    $node->get('image'),
                    320, 
                    400
                );
            } else {
                $resizedImage = $model_tool_image->resize(
                    'placeholder.png', 
                    320, 
                    400
                );
            }
            
            if($node->get('isseo')){
                if($node->get('isbrand')){

                    $image_webp=str_replace(".jpg",".webp",$resizedImage);
                    $image_webp=str_replace(".png",".webp",$image_webp);
                    $data['rootCategoriesBrands'][] = [
                        'name' => $node->get('name'),
                        'href' => $href,
                        'image' => $resizedImage,
                        'image_webp' => $image_webp

                    ];
                }
            }else{
                $image_webp=str_replace(".jpg",".webp",$resizedImage);
                $image_webp=str_replace(".png",".webp",$image_webp);
                $data['rootCategories'][] = [
                    'name' => $node->get('name'),
                    'href' => $href,
                    'image' => $resizedImage,
                    'image_webp' => $image_webp
                ];
            }
        }
        $registry->get('load')->model('catalog/product');

        //Хиты
        $products_hit = $registry->get('model_catalog_product')->getHits();
        shuffle($products_hit) ;
        for($i=0;$i<10;$i++){
            $product_item=$products_hit[$i];
            $labels = $registry->get('model_catalog_product')->getProductLabels($products_hit[$i]);

            $price = number_format($product_item['price'],0,".", " ");


            if ($product_item['image']) {
                $image = $model_tool_image->myResize($product_item['image'], 400,400,1);
            } else {
                $image = $model_tool_image->resize('placeholder.png', 400,400);
            }
            $image_webp=str_replace(".jpg",".webp",$image);
            $image_webp=str_replace(".png",".webp",$image_webp);

            $data['products_hit'][] = array(
                'product_id'  => $product_item['product_id'],
                'thumb'       => $image,
                'thumb_webp'  => $image_webp,
                'name'        => html_entity_decode($product_item['name']),
                'meta_h1'     => html_entity_decode($product_item['meta_h1']),
                'price'       => $price,
                'href'        => $registry->get('url')->link('product/product', 'product_id=' . $product_item['product_id']),
                'labels'	  => $labels,
            );
        }

        //Акции
        $products_accia = $registry->get('model_catalog_product')->getAccias();
        shuffle($products_accia);
        for($i=0;$i<count($products_accia);$i++){
            $product_item=$products_accia[$i];
            $price = number_format($product_item['price'],0,".", " ");
            
            if ($product_item['image']) {
                $image = $model_tool_image->myResize($product_item['image'], 400,400,1);
            } else {
                $image = $model_tool_image->resize('placeholder.png', 400,400);
            }
            
            $price_old_val = $product_item['price']+$product_item['price']*$product_item['discount_percent']/(100-$product_item['discount_percent']);
            $price_old = number_format($price_old_val,0,".", " ");

            $image_webp=str_replace(".jpg",".webp",$image);
            $image_webp=str_replace(".png",".webp",$image_webp);
            $data['products_accia'][] = array(
                'product_id'  => $product_item['product_id'],
                'thumb'       => $image,
                'thumb_webp'  => $image_webp,
                'name'        => html_entity_decode($product_item['name']),
                'meta_h1'     => html_entity_decode($product_item['meta_h1']),
                'price'       => $price,
                'href'        => $registry->get('url')->link('product/product', 'product_id=' . $product_item['product_id']),
                'percent'     => $product_item['discount_percent'],
                'price_old'   => $price_old
            );
        }

        //Новинки
        $products_new = $registry->get('model_catalog_product')->getNews();
        shuffle($products_new);
        //print_r($products_new);

        for($i=0;$i<4;$i++){
            $product_item=$products_new[$i];
            $price = number_format($product_item['price'],0,".", " ");
            
            if ($product_item['image']) {
               $image = $model_tool_image->myResize($product_item['image'], 400,400,1);
            } else {
               $image = $model_tool_image->resize('placeholder.png', 400,400);
            }

            $image_webp=str_replace(".jpg",".webp",$image);
            $image_webp=str_replace(".png",".webp",$image_webp);
            $data['products_new'][] = array(
                'product_id'  => $product_item['product_id'],
                'thumb'       => $image,
                'thumb_webp'       => $image_webp,
                'name'        => html_entity_decode($product_item['name']),
                'price'       => $price,
                'href'        => $registry->get('url')->link('product/product', 'product_id=' . $product_item['product_id']),
            );
        }

        //print_r($data['products_accia']);
        //print_r($products_hit);
        //mobile articles and news

        /** @todo двойная нагрузка, невозможность управления из админки, хардкод idшников модулей*/
        $loader = $registry->get('load');
        $loader->model('extension/module');

        $data['content_articles_mobile'] = '';
        $setting_info = $registry->get('model_extension_module')->getModule(static::ARTICLES_MODULE_ID);
        if ($setting_info && $setting_info['status']) {
            $data['content_articles_mobile'] = $registry->get('load')->controller('extension/module/newsblog_articles', $setting_info);
        }

        $data['content_news_mobile'] = '';
        $setting_info = $registry->get('model_extension_module')->getModule(static::NEWS_MODULE_ID);
        if ($setting_info && $setting_info['status']) {
            $data['content_news_mobile'] = $registry->get('load')->controller('extension/module/newsblog_articles', $setting_info);
        }

        $config=$registry->get("config");
        


        $articles_image_size=array($config->get($config->get('config_theme') . '_image_product_width'),$config->get($config->get('config_theme') . '_image_product_height'));
        $category_image_size=array($config->get($config->get('config_theme') . '_image_category_width'),$config->get($config->get('config_theme') . '_image_category_height'));
        
        $mainInfo = $registry->get('model_catalog_information')->getInformationMain();

        $video_id='';
        $data['main_video']='';
        if (isset($mainInfo["video"])){
            if($mainInfo["video"]){
                preg_match("#(?<=v=)[a-zA-Z0-9-]+(?=&)|(?<=v\/)[^&\n]+(?=\?)|(?<=v=)[^&\n]+|(?<=youtu.be/)[^&\n]+#", $mainInfo["video"], $matches);
                if(isset($matches[0])){
                    $video_id=$matches[0];
                }
            }
            if($video_id){
                $data['main_video'] = 'https://www.youtube.com/embed/'.$video_id;
            }
        }
        $data['seo_text']='';
        if (isset($mainInfo["description"])){
            $data['seo_text'] = $registry->get('model_catalog_information')->cleanText($mainInfo["description"]);
        }
    
        $data['articles'] = array();
        $loader->model('newsblog/article');
        $loader->model('tool/image');

        $filter_data=Array(
            "limit"=>3,
            "start"=>0,
            "sort"=>"RAND()",
            'filter_category_id' => 2,
            'filter_sub_category' => true,);
        
        $results = $registry->get('model_newsblog_article')->getArticles($filter_data);
        $category_path=2;
        $date_format="d.m.Y";
        foreach ($results as $result) {

            if ($result['image']) {
                $original 	= HTTP_SERVER.'image/'.$result['image'];
                $thumb 		= $registry->get('model_tool_image')->resize($result['image'], $articles_image_size[0], $articles_image_size[1]);
            } else {
                $original 	= '';
                $thumb 		= '';	//or use 'placeholder.png' if you need
            }

            $preview = html_entity_decode($result['preview'], ENT_QUOTES, 'UTF-8');
            if( empty($preview) ) {
                $preview = html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8');
            }
            
            $preview = strip_tags($preview);
            $preview = mb_substr($preview, 0, static::PREVIEW_SYMBOLS_COUNT ) . '...';
            
            $image_webp=str_replace(".jpg",".webp",$thumb);
            $image_webp=str_replace(".png",".webp",$image_webp);

            $data['articles'][] = array(
                'article_id' => $result['article_id'],
                'original' => $original,
                'thumb' => $thumb,
                'thumb_webp' => $image_webp,
                'name' => $result['name'],
                //@added
                'cat_name' => $result['cat_name'],
                'main_catid' =>  $result['main_catid'],
                'preview' => $preview, 
                'attributes' => $result['attributes'],
                'href' => $registry->get("url")->link('newsblog/article', 'newsblog_path=' . $category_path . '&newsblog_article_id=' . $result['article_id']),
                'date' => ($date_format ? date($date_format, strtotime($result['date_available'])) : false),
                'date_modified' => ($date_format ? date($date_format, strtotime($result['date_modified'])) : false),
                'viewed' => $result['viewed']
            );

        }
        
        
        
        return $data;
    }

}
