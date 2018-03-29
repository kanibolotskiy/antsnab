<?php

/**
 * @category WS patches 
 * @package  WS\Domain
 */

namespace WS\ORM;

use WS\ORM\IDomain;
use WS\ORM\Repository\BaseCachedRepository;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 27, 2018  3:52:02 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class DomainManager
{
   /** @var WS\Domain\DomainManager <<Singleton>> */
   protected static $instance = null;

   /** @var \Cache */
   private $cache;

   /** @var \Db */
   private $connection;

   /** @var \Registry */
   private $registry;

   /** @var \WS\Domain\ABaseRepository [0..m] */
   private $repositories; 
   
   /**
    * 
    * @param \Registry $registry
    * @return \WS\Domain\DomainManager
    */
   public static function create(\Registry $registry)
   {
        if( null === self::$instance ) {
            $connection = $registry->get('db');
            $cache = $registry->get('cache');
            self::$instance = new DomainManager($connection, $cache, $registry);
        }

        return self::$instance;
   }

   protected function __construct(\DB $connection, \Cache $cache, \Registry $registry)
   {
      $this->cache = $cache;
      $this->connection = $connection;
      $this->registry = $registry;
      $this->repositories = array();
   }

   public function getCache()
   {
       return $this->cache;
   }

   public function getConnection()
   {
       return $this->connection;
   }

   public function getRegistry()
   {
       return $this->registry;
   }

   public function find( $entityName, $id )
   {

   }
   
   /**
    * 
    * @param string $entityName
    * @return \WS\Domain\ABaseRepository 
    */
   public function getRepository( $entityName )
   {
        if( !isset($this->repositories[$entityName]) ) {
            $this->repositories[$entityName] = BaseCachedRepository::factory($entityName, $this);
        }

        return $this->repositories[$entityName];
   }

   /**
    * Gets a reference to the entity identified by the given type and identifier
    * without actually loading it, if the entity is not yet loaded. 
    * @param string $entityName
    * @param int $id
    */
   public function getReference( $entityName, $id )
   {

   }
   	
   public function getPartialReference( $entityName, $identifier )
   {

   }

   public function persist( IDomain $entity )
   {

   }

   public function remove( IDomain $entity )
   {

   }

   public function refresh( IDomain $entity )
   {

   }

   public function copy( IDomain $entity, $deep = false )
   {

   }

   
}
