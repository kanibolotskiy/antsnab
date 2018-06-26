<?php

/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Site\Common
 */

namespace WS\Override\Controller\Site\Common;

use WS\Override\Controller\IDecorator;
/**
 * Описание класса 
 * 
 * @version    1.0, Mar 25, 2018  9:07:46 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CartTemplateDecorator implements IDecorator
{
    public function process($data, $registry)
    {
        $language = $registry->get('language');
        $session = $registry->get('session');
        $currency = $registry->get('currency');
        $data['text_empty'] = sprintf($language->get('text_empty'), $currency->format(0, $session->data['currency']));
        
        return $data;
    }
}
