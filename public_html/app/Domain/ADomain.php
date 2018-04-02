<?php

/**
 * @category WS patches 
 * @package  
 */

namespace WS\Domain;

use WS\ORM\IDomain;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  11:22:18 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
abstract class ADomain implements IDomain
{
    //@task эти методы не помогают в наследниках, если свойства приватные. а мы хотим приватные*/
    public function set($key, $value)
    {
        if( property_exists($this, $key) ) {
            $this->{$key} = $value;
        }
    }

    public function get($key)
    {
        if ( property_exists($this, $key) ) {
            return $this->{$key};
        }

        throw new \Exception("Field '".  $key . "' is not exsists");
    }

    public function fillData($valueAr)
    {
        foreach ($valueAr as $key => $value) {
            $this->set($key, $value);
        }
    }

}
