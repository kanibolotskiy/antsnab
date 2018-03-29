<?php

/**
 * @category WS patches 
 * @package  WS\ORM\Support
 */

namespace WS\ORM\Support;

//put your use statements here

/**
 * Описание интерфейса 
 * 
 * @version    1.0, Mar 28, 2018  7:52:45 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
interface IOpenCartCache
{
    function get($key);

    function set($key, $value);

    function delete($key);
}
