<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Common
 */

namespace WS\Override\Controller\Site\Common;

use WS\Override\Controller\IDecorator;

/**
 * Описание класса 
 * @task change Column_left to ColumnLeft 
 * @version    1.0, Apr 5, 2018  10:28:52 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class Column_leftTemplateDecorator implements IDecorator
{
    public function process($data, $registry)
    {
       $data['search'] = $registry->get('load')->controller('common/search');
       return $data; 
    }

}
