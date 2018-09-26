<?php

/**
 * Управление кэшем иерархии каталога 
 * 
 * @version    0.1, Sep 24, 2018  12:09:58 AM 
 * @author     Sergey Lapshin 
 */

namespace WS\Override\Gateway;

use BlueM\Tree as Tree;

class Hierarhy extends \Model
{
    const CACHE_PREFIX = 'hierarhy'; 

    /** @var Tree */
    private static $cache = null;

    public function __construct($registry)
    {
        parent::__construct($registry);
        $this->load();
    }

    public function __call($name, $arguments)
    {
        return call_user_func_array([Hierarhy::$cache, $name], $arguments);
    }

    /**
     * Get OpenCart category path to the given $id 
     * @param type $id
     */
    public function getPath($id)
    {
        $parents = Hierarhy::$cache->getNodeById($id)->getAncestorsAndSelf();
        $pathes = [];
        $count = count($parents);
        for( $i=$count-1; $i>=0; $i--) {
            $pathes[] = $parents[$i]->getId();
        }
        return implode('_', $pathes);
    }

    public function getTree()
    {
        return Hierarhy::$cache; 
    }

    public function refresh()
    {
        $language_id = (int) $this->config->get('config_language_id');

        $sql = "select c.category_id, c.image, c.parent_id, cd.name, c.isfinal "
            . "from " . DB_PREFIX . "category as c "
            . "left join " . DB_PREFIX . "category_description as cd on cd.category_id = c.category_id "
            . "where language_id = :language_id and c.status=1 and c.category_id<>0 and c.category_id<>:root "
            . "order by c.parent_id, c.sort_order";
        $catRows = $this->db->query($sql, [':language_id' => $language_id, ':root' => ROOT_CATEGORY_ID ])->rows;

        $sql2 = "select p.product_id, p2c.category_id, pd.name, pd.meta_h1 "
            . "from " . DB_PREFIX . "product as p "
            . "left join " . DB_PREFIX . "product_description as pd on pd.product_id = p.product_id "
            . "left join " . DB_PREFIX . "product_to_category as p2c on p.product_id = p2c.product_id "
            . "where p2c.main_category=1 and pd.language_id = :language_id and p.status=1 "
            . "order by p2c.category_id, p.sort_order";

        $productRows = $this->db->query($sql2, [':language_id' => $language_id])->rows;

        $resultRows = [];
        $this->load->model('tool/image');

        foreach ( $catRows as $catRow ) {
            $resultRows[$catRow['category_id']] =  $catRow;
            $catRow['image'] = ( empty($catRow['image']) )?'':$catRow['image'];
            $resultRows[$catRow['category_id']]['image'] = $catRow['image'];
            /*
            if (!empty( $catRow['image']) ) {
                $resizedImage = $this->model_tool_image->resize(
                    $catRow['image'], 
                    $this->config->get($this->config->get('config_theme') . '_image_category_width'), 
                    $this->config->get($this->config->get('config_theme') . '_image_category_height')
                );
            } else {
                $resizedImage = $this->model_tool_image->resize(
                    'placeholder.png', 
                    $this->config->get($this->config->get('config_theme') . '_image_category_width'), 
                    $this->config->get($this->config->get('config_theme') . '_image_category_height')
                );
            }*/
        }

        foreach($productRows as $prodRow) {
            if( !isset($resultRows[$prodRow['category_id']]['products']) ) {
                $resultRows[$prodRow['category_id']]['products'] = [];
            }
            $resultRows[$prodRow['category_id']]['products'][] = $prodRow;
        }

        $tree = new Tree($resultRows, ['rootid'=>ROOT_CATEGORY_ID, 'id'=>'category_id', 'parent'=>'parent_id']);
        $this->cache->set( static::CACHE_PREFIX, serialize($tree) );
        Hierarhy::$cache = $tree; 
    }

    private function load()
    {
        if (null === Hierarhy::$cache) {
            if( false === $this->cache->get(static::CACHE_PREFIX) ) {
                $this->refresh();
            }
            Hierarhy::$cache = unserialize($this->cache->get(static::CACHE_PREFIX));            
        }
    }
}
