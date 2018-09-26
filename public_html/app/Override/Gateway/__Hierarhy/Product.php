<?php

namespace WS\Override\Gateway\Hierarhy;

use WS\Override\Gateway\Hierarhy\ILeaf;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 23, 2018  4:37:43 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class Product implements ILeaf
{
    private $id;
    private $name;
    private $href;
    private $image;

    /** @var  \WS\Ovverride\GateWay\Hierarhy\ICategory */
    private $parent;
    public function getId()
    {
        return $this->id;
    }

    public function getName()
    {
        return $this->name;
    }

    public function getHref()
    {
        return $this->href;
    }

    public function getImage()
    {
        return $this->image;
    }

    public function getParent()
    {
        return $this->parent;
    }

    public function setId($id)
    {
        $this->id = $id;
        return $this;
    }

    public function setName($name)
    {
        $this->name = $name;
        return $this;
    }

    public function setHref($href)
    {
        $this->href = $href;
        return $this;
    }

    public function setImage($image)
    {
        $this->image = $image;
        return $this;
    }

    public function setParent(\WS\Ovverride\GateWay\Hierarhy\ICategory $parent)
    {
        $this->parent = $parent;
        return $this;
    }
}
