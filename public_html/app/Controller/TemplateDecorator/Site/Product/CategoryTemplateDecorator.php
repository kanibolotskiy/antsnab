<?php
/**
 * @category WS patches 
 * @package  WS
 */

namespace WS\Controller\TemplateDecorator\Site\Product;

use WS\Controller\TemplateDecorator\IDecorator as IDecorator;

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
