<?php

/**
 * Доступ к данным. Паттерн Active Record
 * @category WS patches 
 * @package  
 */

namespace WS\Domain;

use WS\Domain\DomainException as DomainException;

/**
 * Реализует:
 * 1. Ленивую подгрузку свойств (Martin Fowler ghost object).
 *    В момент загрузки свойств из хранилища, модифицированные программно свойства не затираются
 * 2. Статический доступ к дескриптору БД и Кэшу
 * 3. Общий API для CRUD операций (Active Record Pattern)
 * 4. Контракт для имплементации CRUD операций
 * 
 * @version    1.0, Mar 21, 2018  11:46:21 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
abstract class ADomain
{

    /** @var \DB дескриптор бд */
    private static $db = null;

    /** @var \Cache кэш-прокси OpenCart */
    private static $cache = null;



    /** if primary key name changes, this should change too*/
    const PRIMARY_ATTR = 'pk';

    /** @var int common primary key*/
    protected $pk = null;

    /** @var string статус загрузки @see DomainStatus */
    protected $ghostStatus = DomainConstants::ENTITY_STATUS;

    /** @var boolean объект не синхронизирован с хранилищем*/
    protected $modified = true; 



    /** Data Access implementation contract*/

    /**
     * Загрузка объекта из хранилища
     * @return key-value array свойств объекта
     */
    abstract protected static function loadReal($id);

    /**
     * Вставка объекта в хранилище
     * @param array $fields - key-value пары известных свойств объекта 
     * @see ADomain::markAllPropsUndefined() для ghost объектов
     * @return int - primary key вставленной записи
     * @throws WS\Domain\DomainException в случае неудачного сохранения
     */
    abstract protected function insert($fields);

    /**
     * Обновление объекта в хранилище
     * @param array $fields - key-value пары известных свойств объекта
     * @see ADomain::markAllPropsUndefined() для ghost объектов
     * @return void - в случае ошибки достаточно исключения
     * @throws WS\Domain\DomainException в случае неудачного сохранения
     */
    abstract protected function update($fields);

    /**
     * Удаление объекта в хранилище
     * @return boolean - true при успешном удалении
     */
    abstract protected function deleteReal();




    /** Static behaviour */ 

    /** инициализация в статическом контексте */
    public static function init(\DB $db, \Cache $cache)
    {
        if (null === self::$db) {
            self::$db = $db;
        }
        if (null === self::$cache) {
            self::$cache = $cache;
        }
    }

    public static function getDb()
    {
        return self::$db;
    }

    public static function getCache()
    {
        return self::$cache;
    }

    /**
     * Инстанцировать объект-призрак, с привязкой к primary key хранилища
     * Функционал для ленивой загрузки. Martin Fowler pattern 
     * @param int $id
     * @return ADomain 
     */
    final public static function getGhost($id)
    {
        $obj = static::build();
        $obj->createGhost($id);
        return $obj;
    }

    /**
     * Инстанцировать объект из хранилища
     * @param int $id
     * @return ADomain 
     */
    final public static function getInstance($id)
    {
        $obj = static::getGhost($id);
        $obj->load();
        return $obj;
    }

    /**
     * Общий статический конструктор.
     * Если меняется основной конструктор - нужно переопределить. 
     * @return ADomain
     */
    protected static function build()
    {
        return new static();
    }

    /**
     * Конструктор объекта-призрака (помощник для static getGhost ) 
     * @param type $id
     */
    final protected function createGhost($id)
    {
        $this->{static::PRIMARY_ATTR} = $id;
        $this->modified = false;
        $this->markAllPropsUndefined();
        $this->ghostStatus = DomainConstants::GHOST_STATUS;
    }

    /**
     * Загрузка инстанса ( помощник для static::getInstance() и lazy load в ADomain::get() ) 
     * @throws DomainException
     * @return ADomain
     */
    final protected function load()
    {
        try {
            $data = static::loadReal($this->{static::PRIMARY_ATTR});
            if( !( is_array( $data ) && $this->is_assoc( $data ) ) ) {
                throw new \Exeption("Wrong impl. of loadReal method, return value must be associative array");    
            }

            /*объект-призрак мог быть модифицирован, безопасное заполнение*/
            foreach ($data as $key => $value ) {
               $this->checkPkSafety($key, $value);
               $this->checkPropertyExists($key);
               if ( $this->{$key} === DomainConstants::UNDEFINED ) {
                   $this->{$key} = $value;
               }
            }

            $this->ghostStatus = DomainConstants::LOADED_STATUS;
        } catch (\Exception $e) {
            throw new DomainException(DomainException::WRONG_LOAD . $e->getMessage());
        }

        return $this;
    }

    final public function isGhost()
    {
        return $this->ghostStatus === DomainConstants::GHOST_STATUS;
    }

    final public function isNew()
    {
        return $this->ghostStatus === DomainConstants::ENTITY_STATUS;
    }

    final public function isLoad()
    {
        return $this->ghostStatus === DomainConstants::LOADED_STATUS;
    }

    final public function isModified()
    {
        return $this->modified;
    }

    /**
     * Сохраняет объект в хранилище
     * @return ADomain - в успешном случае
     * @throws WS\Domain\DomainException 
     */
    final public function flush()
    {
        if ( !$this->isModified() ) return false; 

        //подготавливаем массив свойств
        $propertiesAr = array();
        $properties = $this->getProperties();
        foreach( $properties as $p ) {
            //очищаем свойства от "незагруженных"
            if( $this->isGhost() &&
                $p->getValue() === DomainConstants::UNDEFINED ) continue;
                
            $propertiesAr[ $p->getName() ] = $p->getValue();
        }

        $methodName = ($this->isNew())?'insert':'update';

        try {
            $result = $this->{$methodName}($propertiesAr);    
        } catch (\Exception $e) {
            throw new DomainException(DomainException::WRONG_SAVE . $e->getMessage());
        }
        
        //after save
        $this->modified = false;
        
        if( $methodName === 'insert' ) {
            $this->ghostStatus = DomainConstants::LOADED_STATUS;
            $this->{static::PRIMARY_ATTR} = $result;
        }

        return $this;
    }
    
    /**
     * Удаляет объект из хранилища
     * @return ADomain - в успешном случае
     * @throws WS\Domain\DomainException 
     */
    final public function delete()
    {
       try {
            $this->deleteReal();
        } catch (\Exception $e) {
            throw new DomainException(DomainException::WRONG_DELETE . $e->getMessage());
        }

        $this->{ADomain::PRIMARY_ATTR} = null;
        $this->modified = true;
        $this->ghostStatus = DomainConstants::ENTITY_STATUS;
        return $this;
    }
    

    /**
     * Универсальный сеттер 
     * @param string $key - имя свойства
     * @param void $value
     * @return ADomain
     */
    final public function set($key, $value)
    {
      $this->checkPkSafety($key, $value);
      $this->checkPropertyExists($key);
      $this->{$key} = $value;
      $this->modified = true;
      return $this;
    }

    final public function get($key)
    {
      $this->checkPropertyExists($key);
      if ( $this->isGhost() && !$this->isPrimaryKeyName($key) ) {
          $this->load();
      }
      return $this->{$key};
    }

    public function getPrimary()
    {
        return $this->{static::PRIMARY_ATTR};
    }


    /** PRIVATE HELPERS */


    /**
     * Получает список свойств для текущего класса 
     * @return \ReflectionProperty[] 
     */
    protected function getProperties()
    {
       $reflection = new \ReflectionClass($this);
       $properties = $reflection->getProperties();
       
       return $properties;
    }

    /**
     * Помечаем все свойства как неизвестные (при создании ghost объекта) 
     * @return boolean
     */
    protected function markAllPropsUndefined()
    {
        $props = $this->getProperties();
        foreach ($props as $p) {
            $name = $p->getName();
            if ( $name !== ADomain::PRIMARY_ATTR ) {
                $this->{$name} = DomainConstants::UNDEFINED;
            }
        }
        return true;
    }

    protected function checkPropertyExists($key)
    {
       if( !property_exists($this, $key) ) {
           throw new DomainException(DomainException::WRONG_ATTRIBUTE . "[" . static::class . "::" .  $key . "]" );
       } 
    }

    protected function isPrimaryKeyName($key)
    {
        return  $key === static::PRIMARY_ATTR ; 
    }

    protected function checkPkSafety($key, $value)
    {
        if( isPrimaryKeyName($key) && $value !== $this->{static::PRIMARY_ATTR} ) {
           throw new DomainException(DomainException::WRONG_ATTRIBUTE_PK);
        }
    }

    /**
    * Tests if an array is associative or not.
    * @copyright Kohana framework
    * @param array array to check
    * @return boolean
    */
    private function is_assoc(array $array)
    {
        // Keys of the array
        $keys = array_keys($array);

        // If the array keys of the keys match the keys, then the array must
        // not be associative (e.g. the keys array looked like {0:0, 1:1...}).
        return array_keys($keys) !== $keys;
    }
}

class DomainConstants
{
    /** Объект создан программно, новая запись */
    const ENTITY_STATUS = 'entity';

    /** Объект связан с хранилищем, но загрузка свойств не производилась */
    const GHOST_STATUS = 'ghost';

    /** Объект загружен полностью */
    const LOADED_STATUS = 'loaded';

    /** Маркер незагруженного свойства */
    const UNDEFINED = '__NOT_LOADED_PROPERTY__';

    /** Загружен персистентный объект со всеми свойствами */
    //const PERSISTENT_STATUS = 'persistent';

    /** Загружен объект из кэша со всеми свойствами */
    //const CACHE_STATUS = 'cached';

}
