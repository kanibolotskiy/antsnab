<?php
/**
 * @category WS patches 
 * @package  WS\Ovverride\GateWay\Hierarhy
 */

namespace WS\Override\Gateway\Hierarhy;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 23, 2018  4:04:59 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
interface ICategory
{
    /**
     * @return \WS\Ovverride\GateWay\Hierarhy\ILeaf[]
     */
    function getChildCategories();

    /**
     * @return \WS\Ovverride\GateWay\Hierarhy\ILeaf[]
     */
    function getChildProducts();

    /**
     * @param \WS\Ovverride\GateWay\Hierarhy\ILeaf $product
     */
    function addProduct(ILeaf $product); 

    /**
     * @param \WS\Ovverride\GateWay\Hierarhy\ICategory $category
     */
    function addCategory(ICategory $category);
     
}
