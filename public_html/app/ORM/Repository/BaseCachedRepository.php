<?php

/**
 * @category WS patches 
 * @package  WS\ORM\Repository
 */

namespace WS\ORM\Repository;

use WS\ORM\Repository\ICachedRepository;
use WS\ORM\DomainManager;
use WS\ORM\Repository\ABaseRepository;
use WS\ORM\Repository\ARepository;
use WS\ORM\Support\CacheKeyGen;

//put your use statements here

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  8:44:54 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class BaseCachedRepository extends ARepository implements ICachedRepository
{
    const CASHED_REPOSITORY_SUFFIX = 'CachedRepository';

    /** @var boolean */
    protected $cacheResults = false;

    /** @var \WS\ORM\Repository\ABaseRepository */
    protected $repository;

    public static function factory($entityName, DomainManager $dm)
    {
        $nameSpace = '\\' . ARepository::DOMAINS_NAMESPACE . '\\' . $entityName . '\\';
        $className = $entityName . self::CASHED_REPOSITORY_SUFFIX;
        $repoCache = $nameSpace . $className;
        if (!class_exists($repoCache)) {
            $repoCache = __CLASS__;
        }

        return new $repoCache($entityName, $dm);
    }

    public function __construct($entityName, DomainManager $dm)
    {
        $this->dm = $dm;
        $this->entityName = $entityName;
        $this->repository = ABaseRepository::factory($entityName, $dm);
    }

    /* @task доделать */
    public function __call($name, $args)
    {
        if( !method_exists($this->repository, $name) ) {
            throw new ORMException('Bad method for repository given: ' . $name . ' entity: ' . $this->getEntityName());
        }
        //$class = get_class($this->repository);
        return call_user_func(array($this->repository, $name), $args);
    }

    public function cache()
    {
       return $this->repository; 

       //$this->cacheResults = true;
       //return $this;
    }

    public function delete($obj)
    {
        $result = $this->repository->delete($obj);
        if( $result ) {
            $key =  CacheKeyGen::getKeyByEntity($this->getEntityName());
            $this->dm->getCache()->delete($key) ; 
        }
        return $result;
    }

    public function insert($obj)
    {
        
    }

    public function massDelete($col)
    {
        
    }

    public function massInsert($col)
    {
        
    }

    public function massUpdate($col)
    {
        
    }

    public function update($obj)
    {
        
    }

}
