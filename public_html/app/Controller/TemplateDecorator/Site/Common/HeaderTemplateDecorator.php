<?php

/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Site\Common
 */

namespace WS\Controller\TemplateDecorator\Site\Common;
use WS\Controller\TemplateDecorator\IDecorator as IDecorator;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 25, 2018  7:47:42 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class HeaderTemplateDecorator implements IDecorator
{
    public function process($data, $registry)
    {
        $config = $registry->get('config');
        $data['telephone2'] = $config->get('config_fax'); 

        /*@task  XSS attack posibble. change css and markup later. now used '<p>sometext</p>' */ 
        $data['worktime'] = htmlspecialchars_decode($config->get('config_open')); 
        return $data;
    }

}
