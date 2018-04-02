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
 * @version    1.0, Mar 28, 2018  7:46:39 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
interface IFinder
{
/**
     * Finds an object by its primary key / identifier.
     *
     * @param mixed $id The identifier.
     *
     * @return object|null The object.
     */
     function find($id);

    /**
     * Finds all objects in the repository.
     *
     * @return \WS\Domain\IDomain[] 
     */
     function findAll();

    /**
     * Finds objects by a set of criteria.
     *
     * Optionally sorting and limiting details can be passed. An implementation may throw
     * an UnexpectedValueException if certain values of the sorting or limiting details are
     * not supported.
     *
     * @param array      $criteria
     * @param array|null $orderBy
     * @param int|null   $limit
     * @param int|null   $offset
     *
     * @return array The objects.
     *
     * @throws \UnexpectedValueException
     */
     function findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null);

    /**
     * Finds a single object by a set of criteria.
     *
     * @param array $criteria The criteria.
     *
     * @return object|null The object.
     */
     function findOneBy(array $criteria);

}
