<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Admin\Common
 */

namespace WS\Override\Controller\Admin\Common;
use WS\Override\Controller\IDecorator;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 5, 2018  12:06:36 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class HeaderTemplateDecorator implements IDecorator
{
  public function process($data, $registry){
      $data['styles'][] = array(
          'href' => 'view/stylesheet/app.css',
          'rel' => 'stylesheet',
          'media' => 'screen'
       );
      return $data;
  }
}

