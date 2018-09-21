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

    public function process($data, $registry)
    {
        $registry->get('load')->model('tool/image');
        $imageTool = $registry->get('model_tool_image');
        $config = $registry->get('config');

        $width = $config->get($config->get('config_theme') . '_image_category_width');
        $height = $config->get($config->get('config_theme') . '_image_category_height');

        $dm = DomainManager::create($registry);
        $allCategories = $dm->getRepository('Category')->findAll();
        $rootCategories = $allCategories->toArray();

        $data['url'] = $registry->get('url');
        $data['imageTool'] = $imageTool;
        $data['width'] = $width;
        $data['height'] = $height;
        $data['allCategories'] = $allCategories;

        //mobile articles and news
        //@task1 двойная нагрузка, невозможность управления из админки, хардкод idшников модулей
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

        return $data;
    }

}
