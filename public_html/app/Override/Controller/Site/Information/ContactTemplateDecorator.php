<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Information
 */

namespace WS\Override\Controller\Site\Information;
use WS\Override\Controller\IDecorator;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 5, 2018  3:59:07 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ContactTemplateDecorator implements IDecorator
{
    public function process($data, $registry)
    {
       $config = $registry->get('config');
       $data['shop_email'] = $config->get('config_email');
       foreach($data['locations'] as &$location) {
           $geocode = str_replace(' ', '', $location['geocode']);
           $parts = explode(',', $geocode);
           if( count($parts) >=2 ) {
               $location['latitude'] = $parts[0];
               $location['longitude'] = $parts[1];
           } else {
               $location['latitude'] = '';
               $location['longitude'] = '';
           }
       }

       $data['yamap'] = 'https://api-maps.yandex.ru/2.1/?lang=ru_RU';
       
       return $data; 
    }
}
