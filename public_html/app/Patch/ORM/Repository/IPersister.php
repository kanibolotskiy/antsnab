<?php
/**
 * @category WS patches 
 * @package  WS\Domain
 */
namespace WS\ORM\Repository;


/**
 * Описание класса 
 * @task add comments 
 * @version    1.0, Mar 27, 2018  3:37:18 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
interface IPersister
{
    /**
     * @param IDomain $obj
     */
     function insert($obj);

    /**
     * @param IDomain $obj
     */
     function update($obj);

    /**
     * @param IDomain $obj
     */
     function delete($obj);

    /**
     * @param ArrayCollection $col
     */
     function massInsert($col);

    /**
     * @param ArrayCollection $col
     */
     function massUpdate($col);

    /**
     * @param ArrayCollection $col
     */
     function massDelete($col);
}
