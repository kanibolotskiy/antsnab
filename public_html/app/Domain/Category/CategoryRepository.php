<?php

/**
 * @category WS patches 
 * @package  
 */

namespace WS\Domain\Category;

use WS\ORM\Repository\ABaseRepository;
use WS\Helper\RouteHelper;
use Doctrine\Common\Collections\ArrayCollection;
use WS\Domain\Category\Category;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 27, 2018  10:30:46 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CategoryRepository extends ABaseRepository
{
    //@task - the ability to cache results
    public function find($id)
    {
        
    }

    public function findAll()
    {
        $OCDAO = $this->getOCDAO('catalog/category', RouteHelper::ADMIN_CONTEXT);
        $resultSet = $OCDAO->getAllCategories();
        $collection = new ArrayCollection();

        foreach ($resultSet[0] as $topCat) {
            $parent = new Category();
            $parent->fillData($topCat);
            if (isset($resultSet[$parent->get('category_id')])) {
                $this->recursiveFindAllHelper($parent, $resultSet[$parent->get('category_id')], $resultSet);    
            }
            $collection->add($parent);
        }
        return $collection;
    }

    //@task DRY
    private function recursiveFindAllHelper(&$parentObj, $relArray, $resultSet)
    {
        foreach ($relArray as $childCat) {
            $child = new Category();
            $child->fillData($childCat);
            $parentObj->get('categories')->add($child);
            $child->set('parCategory', $parentObj);
            if( isset($resultSet[$child->get('category_id')]) ) {
                $this->recursiveFindAllHelper($child, $resultSet[$child->get('category_id')], $resultSet);
            }
        }
    }

    public function findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
    {
        
    }

    public function findOneBy(array $criteria)
    {
        
    }
    public function delete($obj)
    {
        
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
