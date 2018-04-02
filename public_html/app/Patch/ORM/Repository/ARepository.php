<?php

/**
 * @category WS patches 
 * @package  WS\ORM\Repository
 */

namespace WS\ORM\Repository;
use WS\ORM\Repository\IPersister;
use WS\ORM\Repository\IRepository;

//put your use statements here

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  9:13:38 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
abstract class ARepository implements  IPersister, IRepository
{
    /** @const string Used to find appropriate Repository for given Entity */
    const REPOSITORY_SUFFIX = 'Repository';

    const DOMAINS_NAMESPACE = 'WS\\Domain';

    /** @var \WS\ORM\DomainManager */
    protected $dm;

    /** @var string */
    protected $entityName;

    /**
     * Returns the class name of the object managed by the repository.
     *
     * @return string
     */
    public function getClassName()
    {
        return '\\' . self::DOMAINS_NAMESPACE . '\\' . $this->getEntityName();
    }

    public function getEntityName()
    {
        return $this->entityName;
    }

    public function getEntityManager()
    {
        return $this->dm;
    }

}
