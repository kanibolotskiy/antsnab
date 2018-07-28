<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Admin\Catalog
 */

namespace WS\Override\Controller\Admin\Catalog;

use WS\Override\Controller\IDecorator;
use WS\Override\Gateway\ProdProperties;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 23, 2018  6:30:35 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class Category_formTemplateDecorator implements IDecorator
{
    public function process($data, $registry)
    {
        $language = $registry->get('language');
        $url = $registry->get('url');
        $request = $registry->get('request');
        $session = $registry->get('session');

        $data['entry_isfinal'] = $language->get('entry_isfinal');
        $data['entry_category_prodproperties'] = $language->get('entry_category_prodproperties');

        if (isset($request->get['category_id'])){
            $category_id = $request->get['category_id'];
            $gateway = new ProdProperties($registry);
            $data['isfinal'] = $gateway->isCategoryFinal($category_id);
            $data['category_prodproperties'] = $url->link('extension/module/prodproperties/getlist', 'token=' . $session->data['token'] . '&category_id=' . $category_id, 'SSL');
        } else {
            $data['isfinal'] = false;
            $data['category_prodproperties'] = '';
        }

        return $data;    
    }
}
