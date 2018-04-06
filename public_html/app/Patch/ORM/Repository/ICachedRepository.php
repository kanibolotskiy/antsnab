<?php

/**
 * @category WS patches 
 * @package  WS\ORM\Repository
 */

namespace WS\ORM\Repository;

//put your use statements here

/**
 * Описание интерфейса 
 * 
 * @version    1.0, Mar 28, 2018  8:45:10 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
interface ICachedRepository
{
    /**
     * Sets caching mode on
     * @return ICachedRepository
     */
    function cache();
}
