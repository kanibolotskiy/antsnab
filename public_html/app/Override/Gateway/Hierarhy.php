<?php
namespace WS\Override\Gateway;

use WS\Override\Gateway\Hierarhy\Product;
use WS\Override\Gateway\Hierarhy\Category;
use \Model;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 23, 2018  4:38:53 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class Hierarhy extends Model
{
    const CATEGORY_PREFIX = 'cat';
    const PRODUCT_PREFIX = 'prod';

    public function getCategory($category_id)
    {
        if( null === $this->cache->get(static::CATEGORY_PREFIX . $category_id) ) {
            $this->refreshHierarhy();
        }

        if( null === $this->cache->get(static::CATEGORY_PREFIX . $category_id) ) {
            throw new Exception('Bad category_id or bad cache generated');
        }

        return $this->cache->get(static::CATEGORY_PREFIX . $category_id); 
    }

    public function getProduct($product_id)
    {
        if( null === $this->cache->get(static::PRODUCT_PREFIX . $product_id) ) {
            $this->refreshHierarhy();
        }

        if( null === $this->cache->get(static::PRODUCT_PREFIX . $product_id) ) {
            throw new Exception('Bad product_id or bad cache generated');
        }

        return $this->cache->get(static::PRODUCT_PREFIX . $product_id); 
    }

    public function refreshHierarhy()
    {
        $language_id = (int)$this->config->get('config_language_id');
        $sql = "select c.category_id, c.image, c.parent_id, cd.name " 
            . "from " . DB_PREFIX . "category as c " 
            . "left join " . DB_PREFIX . "category_description as cd on cd.category_id = c.category_id "
            . "where language_id = :language_id order by c.category_id ASC ";
        $categoryRows = $this->db->query($sql, [':language_id' => $language_id])->rows;
        
        //var_dump($sql);
        //var_dump($categoryRows);

        foreach($categoryRows as $cat) {
            $category = new Category();
            $category->setName($cat['name']);
            $category->setId($cat['category_id']);
            //var_dump( serialize($category) );
            $this->cache->set(static::CATEGORY_PREFIX . $cat['category_id'], serialize($category) );
        }

        foreach($categoryRows as $cat ) {
            $category = unserialize($this->cache->get(static::CATEGORY_PREFIX . $cat['category_id']));
            $parent = unserialize($this->cache->get(static::CATEGORY_PREFIX . $cat['parent_id'])); 
            $category->setParent($parent);
        }
    }
}
