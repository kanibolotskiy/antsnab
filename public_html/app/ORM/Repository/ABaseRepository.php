<?php

/**
 * @category WS patches 
 * @package  WS\Domain
 */

namespace WS\ORM\Repository;

use WS\ORM\DomainManager;
use WS\ORM\Exeption\ORMException;
use WS\ORM\Repository\ARepository;
use WS\ORM\Repository\IFinder;

/**
 * Contract for a Doctrine persistence layer ObjectRepository class to implement.
 * interface ObjectRepository
 * 
 * @link   www.doctrine-project.org
 * @since  2.1
 * @author Benjamin Eberlei <kontakt@beberlei.de>
 * @author Jonathan Wage <jonwage@gmail.com>
 */

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 27, 2018  3:39:27 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
abstract class ABaseRepository extends ARepository implements IFinder 
{
    public static function factory($entityName, DomainManager $dm)
    {
        $nameSpace = '\\' . self::DOMAINS_NAMESPACE . '\\' . $entityName . '\\';
        $className = $entityName . self::REPOSITORY_SUFFIX;
        $repo = $nameSpace . $className;
        if (!class_exists($repo)) {
            throw new ORMException('Repository' . $repo . 'not found');
        }
        return new $repo($entityName, $dm);
    }

    public function __construct($entityName, DomainManager $dm)
    {
        $this->dm = $dm;
        $this->entityName = $entityName;
    }

    protected function getOCDAO($route, $context)
    {
        $loader = $this->getEntityManager()->getRegistry()->get('load');
        $loader->model($route, $context);
        $key = 'model_' . str_replace(array('/', '-', '.'), array('_', '', ''), (string) $route) . '_' . $context;
        $openCartDao = $this->getEntityManager()->getRegistry()->get($key);
        return $openCartDao;
    }

}
