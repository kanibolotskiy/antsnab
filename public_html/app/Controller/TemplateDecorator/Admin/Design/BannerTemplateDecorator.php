<?php

/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Admin\Design
 */

namespace WS\Controller\TemplateDecorator\Admin\Design;

use WS\Controller\TemplateDecorator\IDecorator;
/**
 * Описание класса 
 * 
 * @version    1.0, Mar 29, 2018  7:06:49 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class BannerTemplateDecorator implements IDecorator
{
    public function process($data, $registry)
    {
       $data['entry_descr'] = $this->language->get('entry_descr');
       return $data; 
    }

}
