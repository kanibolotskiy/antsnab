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
                    $config->get($config->get('config_theme') . '_image_category_width'), 
                    $config->get($config->get('config_theme') . '_image_category_height')
                );
            } else {
                $resizedImage = $model_tool_image->resize(
                    'placeholder.png', 
                    $config->get($config->get('config_theme') . '_image_category_width'), 
                    $config->get($config->get('config_theme') . '_image_category_height')
                );
            }
            
            if($node->get('isseo')){
                if($node->get('isbrand')){
                    $data['rootCategoriesBrands'][] = [
                        'name' => $node->get('name'),
                        'href' => $href,
                        'image' => $resizedImage
                    ];
                }
            }else{
                $data['rootCategories'][] = [
                    'name' => $node->get('name'),
                    'href' => $href,
                    'image' => $resizedImage
                ];
            }
        }

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
        

//print_r($config->get('config_theme'));
        $articles_image_size=array($config->get($config->get('config_theme') . '_image_product_width'),$config->get($config->get('config_theme') . '_image_product_height'));
        $category_image_size=array($config->get($config->get('config_theme') . '_image_category_width'),$config->get($config->get('config_theme') . '_image_category_height'));
        

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
            
            $data['articles'][] = array(
                'article_id' => $result['article_id'],
                'original' => $original,
                'thumb' => $thumb,
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
