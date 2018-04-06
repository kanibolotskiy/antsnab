<?php

/**
 * @category WS patches 
 * @package  WS\ORM\Support
 */

namespace WS\ORM\Support;

use WS\ORM\Support\AggregateDataCache;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  7:39:22 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CacheKeyGen
{
    const REPOSITORY_ROOT_KEY = '__WS__DOMAIN__CACHE__';

    public static function getKeyByEntity($entityName) {
        return self::REPOSITORY_ROOT_KEY . AggregateDataCache::SEPARATOR . $entityName;  
    }
}
