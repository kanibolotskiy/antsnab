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
        
        $data['url' ] = $registry->get('url');
        $data['imageTool'] =  $imageTool;
        $data['width'] = $width;
        $data['height'] = $height;
        $data['allCategories'] = $allCategories;
        
        return $data;
    }

    

}
