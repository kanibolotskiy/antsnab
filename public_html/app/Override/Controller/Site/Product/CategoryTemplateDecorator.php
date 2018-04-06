<?php
/**
 * @category WS patches 
 * @package  WS
 */

namespace WS\Override\Controller\Site\Product;

use WS\Override\Controller\IDecorator;

/**
 * Декоратор шаблона product\category
 * @version    1.0, Mar 9, 2018  5:12:44 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CategoryTemplateDecorator implements IDecorator
{
    public function process($data, $registry)
    {
        //$data['always_here'] = 'Hello world';        
        return $data;
    }
}
