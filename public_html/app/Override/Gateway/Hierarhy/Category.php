<?php
namespace WS\Override\Gateway\Hierarhy;

use WS\Override\Gateway\Hierarhy\ICategory;
use WS\Override\Gateway\Hierarhy\ILeaf;
/**
 * Описание класса 
 * 
 * @version    1.0, Apr 23, 2018  4:31:07 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class Category implements ICategory, ILeaf
{
    private $id;
    private $name;
    private $href;
    private $image;

    /** @var  \WS\Ovverride\GateWay\Hierarhy\ICategory */
    private $parent;

    private $childCategories = array();
    private $childProducts = array();

    public function addCategory(ICategory $category)
    {
       $this->childCategories[] = $category; 
    }

    public function addProduct(ILeaf $product)
    {
       $this->childProducts[] = $product; 
    }

    public function getChildCategories()
    {
       return $this->chilCategories; 
    }

    public function getChildProducts()
    {
       return $this->childProducts; 
    }

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

    public function setParent(ICategory $parent)
    {
        $this->parent = $parent;
        return $this;
    }

}
