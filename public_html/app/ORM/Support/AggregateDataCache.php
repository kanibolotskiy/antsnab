<?php
/**
 * @category WS patches 
 * @package  WS\Domain
 */

namespace WS\ORM\Support;

/**
 * Класс для хранения данных кэше с помощью иерархических ключей 
 * @task  реализовать реестр ключей, чтобы иметь возможность делать выборки из узла
 * @version    1.0, Mar 27, 2018  3:37:18 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author Sergey Lapshin (http://vk.com/wslapshin) 
 */
class AggregateDataCache implements IOpenCartCache
{

    const SEPARATOR = '~';
    /**
     * Полный ключ в кэше для родительского контейнера
     * @var string
     */
    private $parentKey;

    /**
     * Относительный ключ для текущего контейнра
     * @var string
     */
    private $currentSubKey;

    /**
     * @var \IOpenCartCahe
     */
    private $cache;


    /**
     * @param string $aggregateKey - Ключ текущего контейнера
     * @param \IOpenCartCache $cache
     */
    public function __construct($aggregateKey, \Cache $cache)
    {
        $parts = explode(static::SEPARATOR, $aggregateKey);
        $this->currentSubKey = array_pop($parts);
        if(count($parts) == 0 ) {
            return new \Exception('AggregateKey must have a namespace, the root level name, given:' . $aggregateKey );
        }
        $this->parentKey = implode(static::SEPARATOR , $parts);
        $this->cache = $cache;

        $this->cache->set($aggregateKey, $this); 
    }

    /**
     * @return WS\ORM\Support\AggregateDataCache 
     */
    public function clear()
    {
        $this->cache->delete( $this->parentKey . $this->currentSubKey );
        return $this;
    }

    /**
     * @param string $valueKey
     * @return void | null
     */
    public function get($valueKey)
    {
        $fullKey =  $this->getCacheFullKey($valueKey); 
        return $this->cache->get($fullKey);
    }

    /**
     * @param string $valueKey
     * @return void | null
     */
    public function set($valueKey, $val)
    {
        $this->checkContainer($valueKey); 
        $this->cache->set($this->getCacheFullKey($valueKey), $val);
        return $this;
    }

    /**
     * @param string $valueKey
     * @return boolean
     */
    public function delete($valueKey)
    {
        $this->checkContainer($valueKey);
        $this->delete($this->getCacheFullKey($valueKey));
        return $this;
    }

    /**
     * @param string $childKey
     * @return IAggregateDataCache
     */
    public function getChild($childKey)
    {
        return new AggregateDataCache($this->getCacheFullKey($childKey), $this->cache);
    }

    /**
     * @return IAggregateDataCache
     */
    public function getParent()
    {
        try {
            $aggregateDataCache = new AggregateDataCache($this->parentKey, $this->cache);
        } catch (\Exception $e){
            //root namespace reached
            return null;
        }
        return $aggregateDataCache; 
    }

    private function getCacheFullKey($valueKey)
    {
        return $this->parentKey . static::SEPARATOR . $this->currentSubKey . static::SEPARATOR . $valueKey;
    }

    private function checkContainer($valueKey)
    {
        //prevent to erase other containers in current context
        if ( $this->get($valueKey) instanceof AggregateDataCache ) {
            throw new \Exception('Tried to erase container, use clear() instead');
        }
    }

}
