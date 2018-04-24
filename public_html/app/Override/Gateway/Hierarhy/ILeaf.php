<?php

namespace WS\Override\Gateway\Hierarhy;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 23, 2018  4:11:06 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
interface ILeaf
{

    /**
     * @return  \WS\Ovverride\GateWay\Hierarhy\ICategory 
     */
    function getParent();

    /**
     * @param string $name
     */
    function setName($name);

    /**
     * @param string $href
     */
    function setHref($href);

    /**
     * @param string $image
     */
    function setImage($image);

    /**
     * @param int $id
     */
    function setId($id);

    /**
     * @return string
     */
    function getName();

    /**
     * @return string
     */
    function getHref();

    /**
     * @return string
     */
    function getImage();

    /**
     * @return int 
     */
    function getId();
}
