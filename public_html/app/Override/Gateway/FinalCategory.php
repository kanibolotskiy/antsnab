<?php

/**
 * Финальная категория - та, которая содержит только продукты.
 * И в ней возможно построение смежной таблицы свойств ( по свойствам, наследуемым из этой категории) 
 * 
 * @version    0.1, Aug 14, 2018  6:49:41 PM 
 * @copyright  Copyright (c) 2018 pinstudio. (https://www.pinstudio.ru)
 * @author     Sergey Lapshin 
 */

namespace WS\Override\Gateway;

use WS\Patch\Helper\QueryHelper;

class FinalCategory extends \Model
{
    /**
     * @param type $category_id
     * @return boolean | null 
     */
    public function isCategoryFinal($category_id)
    {
        $query = "select isfinal from " . DB_PREFIX . "category where category_id = :id limit 1";
        $res = $this->db->query($query, [':id' => $category_id]);
        if ($res->num_rows == 0) {
            return null;
        }

        return (boolean) $res->row['isfinal'];
    }

    /**
     * Глубокий поиск финальных категорий, с любого родительского уровня или самой себя
     * @param int | array $category_id - id родительской категории на любом верхнем уровне или сама финальная категория
     * @param type $strictParent - искать только категории, находящиеся на один уровень ниже $category_id 
     * @return array
     */
    public function getFinalCategories($category_id, $order = null, $strictParent = false)
    {
        $category_id = QueryHelper::paramToArray($category_id);

        $query = "SELECT *, cd.name FROM " . DB_PREFIX . "category c "
            . "LEFT JOIN " . DB_PREFIX . "category_description cd "
            . "ON (c.category_id = cd.category_id) "
            . "LEFT JOIN " . DB_PREFIX . "category_to_store c2s "
            . "ON (c.category_id = c2s.category_id) ";
        if (!$strictParent) {
            $query .= "LEFT JOIN " . DB_PREFIX . "category_path cp "
                . "ON (cp.category_id = c.category_id) "
                . "WHERE " . QueryHelper::paramToEqualSqlCondition('cp.path_id', $category_id);
        } else {
            $query .= "WHERE " . QueryHelper::paramToEqualSqlCondition('c.parent_id', $category_id);
        }

        $query .= " AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' "
            . "AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "'  "
            . "AND c.status = '1' AND c.isfinal = '1'"; 
        if( null == $order ) {
            $order = 'parent_id, c.sort_order, LCASE(cd.name)';
        }
        $query .= ' ORDER BY ' . $order;

        $rows = $this->db->query($query)->rows;
        $categories = [];
        foreach ($rows as $row) {
            $categories[$row['category_id']] = $row;
        }

        $categoryIds = array_keys($categories);
        $pathes = $this->getCategoryPath($categoryIds);

        $result = [];
        foreach( $categories as $categoryId => $params ) {
            $result[$categoryId] = $params;
            $result[$categoryId]['path'] = $pathes[$categoryId];
            $result[$categoryId]['href'] =  $this->url->link('product/category', 'path=' . $pathes[$categoryId] ); 
        }

        return $result;
    }

    /**
     * Получить продукты в финальных категориях, глубокий поиск по категориям с любого уровня
     * 
     * Аналог коробочного model_catalog_product->getProducts() но с улучшениями: 
     * 1. Ищет только по финальным категориям, начать можно с любого верхнего уровня
     * 2. Делает только один запрос к базе данных на выборку продуктов (а не по одному)
     * 3. Можно передавать массив категорий (финальных или родительских - неважно)
     * 
     * Расширяет  self::getFinalCategories() 
     * @param int | array $category_id - id родительской категории на любом верхнем уровне или сама финальная категория
     * @param $data - правила выборки (аналогично model_catalog_product->getProducts())
     *        отсутствуют filter_category_id и filter_sub_category, здесь управляется через strictParent
     *        start и limit работают только если выбирается одна категория 
     * @param type $strictParent - искать только категории, находящиеся на один уровень ниже $category_id 
     * @return array
     */
    public function getFinalCategoriesWithProducts($category_id, $category_order, $data = array(), $strictParent = false)
    {
        $fCategories = $this->getFinalCategories($category_id, $category_order, $strictParent);
        if (count($fCategories) == 0) {
            return [];
        }

        $fCategoriesIds = array_keys($fCategories);
        $sql = "SELECT 
                    cat.category_id, 
                    p.*,
                    pd.name AS name,
                    pd.description AS description,
                    pd.meta_title AS meta_title,
                    pd.meta_h1 AS meta_h1,
                    pd.meta_description as meta_description,
                    pd.meta_keyword as meta_keyword,
                    pd.description_mini as description_mini,
                    
                    (   SELECT md.name 
                        FROM " . DB_PREFIX . "manufacturer_description md 
                        WHERE md.manufacturer_id = p.manufacturer_id AND md.language_id = '"
            . (int) $this->config->get('config_language_id') . "'
                    ) AS manufacturer, 
                    (   SELECT price 
                        FROM " . DB_PREFIX . "product_discount pd2 
                        WHERE pd2.product_id = p.product_id 
                            AND pd2.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "' 
                            AND pd2.quantity = '1' 
                            AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) 
                            AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) 
                        ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1
                    ) AS discount, 
                    (   SELECT price 
                        FROM " . DB_PREFIX . "product_special ps 
                        WHERE ps.product_id = p.product_id 
                            AND ps.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "' 
                            AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) 
                            AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) 
                        ORDER BY ps.priority ASC, ps.price ASC LIMIT 1
                    ) AS special, 
                    (   SELECT points 
                        FROM " . DB_PREFIX . "product_reward pr 
                        WHERE pr.product_id = p.product_id 
                            AND customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "'
                    ) AS reward, 
                    (   SELECT ss.name 
                        FROM " . DB_PREFIX . "stock_status ss 
                        WHERE ss.stock_status_id = p.stock_status_id 
                            AND ss.language_id = '" . (int) $this->config->get('config_language_id') . "'
                    ) AS stock_status, 
                    (   SELECT wcd.unit 
                        FROM " . DB_PREFIX . "weight_class_description wcd 
                        WHERE p.weight_class_id = wcd.weight_class_id 
                            AND wcd.language_id = '" . (int) $this->config->get('config_language_id') . "'
                    ) AS weight_class, 
                    (   SELECT lcd.unit 
                        FROM " . DB_PREFIX . "length_class_description lcd 
                        WHERE p.length_class_id = lcd.length_class_id 
                            AND lcd.language_id = '" . (int) $this->config->get('config_language_id') . "'
                    ) AS length_class, 
                    (   SELECT AVG(rating) AS total 
                        FROM " . DB_PREFIX . "review r1 
                        WHERE r1.product_id = p.product_id 
                            AND r1.status = '1' 
                        GROUP BY r1.product_id  
                    ) AS rating, 
                    (   SELECT COUNT(*) AS total 
                        FROM " . DB_PREFIX . "review r2 
                        WHERE r2.product_id = p.product_id 
                            AND r2.status = '1' 
                        GROUP BY r2.product_id
                    ) AS reviews, 
                    p.sort_order 
                    FROM " . DB_PREFIX . "category as cat 
                        inner join " . DB_PREFIX . "product_to_category p2c 
                        on p2c.category_id = cat.category_id and "
            . QueryHelper::paramToEqualSqlCondition('cat.category_id', $fCategoriesIds) . "
                        LEFT JOIN  " . DB_PREFIX . "product p 
                        ON p.product_id = p2c.product_id  

                        LEFT JOIN " . DB_PREFIX . "product_description pd 
                        ON (p.product_id = pd.product_id) 
                        
                        LEFT JOIN " . DB_PREFIX . "product_to_store p2s 
                        ON (p.product_id = p2s.product_id) 
                        
                        LEFT JOIN " . DB_PREFIX . "manufacturer m 
                        ON (p.manufacturer_id = m.manufacturer_id) 
                    WHERE 
                        pd.language_id = '" . (int) $this->config->get('config_language_id') . "' 
                        AND p.status = '1' 
                        AND p.date_available <= NOW() 
                        AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ";

        /* FILTERS FROM ORIGIN model_catalog_product->getProducts() */
        if (!empty($data['filter_name']) || !empty($data['filter_tag'])) {
            $sql .= " AND (";

            if (!empty($data['filter_name'])) {
                $implode = array();

                $words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_name'])));

                foreach ($words as $word) {
                    $implode[] = "pd.name LIKE '%" . $this->db->escape($word) . "%'";
                }

                if ($implode) {
                    $sql .= " " . implode(" AND ", $implode) . "";
                }

                if (!empty($data['filter_description'])) {
                    $sql .= " OR pd.description LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
                }
            }

            if (!empty($data['filter_name']) && !empty($data['filter_tag'])) {
                $sql .= " OR ";
            }

            if (!empty($data['filter_tag'])) {
                $implode = array();

                $words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_tag'])));

                foreach ($words as $word) {
                    $implode[] = "pd.tag LIKE '%" . $this->db->escape($word) . "%'";
                }

                if ($implode) {
                    $sql .= " " . implode(" AND ", $implode) . "";
                }
            }

            if (!empty($data['filter_name'])) {
                $sql .= " OR LCASE(p.model) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                $sql .= " OR LCASE(p.sku) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                $sql .= " OR LCASE(p.upc) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                $sql .= " OR LCASE(p.ean) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                $sql .= " OR LCASE(p.jan) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                $sql .= " OR LCASE(p.isbn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                $sql .= " OR LCASE(p.mpn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
            }

            $sql .= ")";
        }

        if (!empty($data['filter_manufacturer_id'])) {
            $sql .= " AND p.manufacturer_id = '" . (int) $data['filter_manufacturer_id'] . "'";
        }

        $sql .= 'ORDER BY cat.category_id ASC';

        /* SORTING FROM ORIGIN model_catalog_product->getProducts() */
        $sort_data = array(
            'pd.name',
            'p.model',
            'p.quantity',
            'p.price',
            'rating',
            'p.sort_order',
            'p.date_added'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
                $sql .= ",(" . $data['sort'] . ")";
            } elseif ($data['sort'] == 'p.price') {
                $sql .= ",(CASE WHEN special IS NOT NULL THEN special WHEN discount IS NOT NULL THEN discount ELSE p.price END)";
            } else {
                $sql .= "," . $data['sort'];
            }
        } else {
            $sql .= ",p.sort_order";
        }

        if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC, LCASE(pd.name) DESC";
        } else {
            $sql .= " ASC, LCASE(pd.name) ASC";
        }

        /* LIMITS FROM ORIGIN */
        if (count($fCategories) == 1) {
            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 20;
                }

                $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
            }
        }


        $products = $this->db->query($sql)->rows;
        foreach ($products as $product) {
            $catId = $product['category_id'];
            $prodId = $product['product_id'];
            if (!isset($fCategories[$catId]['products'])) {
                $fCategories[$catId]['products'] = [];
            }
            $fCategories[$catId]['products'][$prodId] = $product;
            $fCategories[$catId]['products'][$prodId]['href'] = $this->url->link('product/product', 'path=' . $fCategories[$catId]['path'] . '&product_id=' . $prodId); 
        }

        return $fCategories;
    }

    /**
     * @param type $category_id
     * @return type
     */
    public function getCategoryPath($category_id)
    {
        $category_id = QueryHelper::paramToArray($category_id);
        $query = $this->db->query("SELECT category_id, path_id, level FROM " . DB_PREFIX . "category_path WHERE ".QueryHelper::paramToEqualSqlCondition('category_id', $category_id)." and level <> 0 order by category_id, level");

        $pathes = [];
        foreach( $query->rows as $row) {
            if( !isset($pathes[$row['category_id']]) ) {
                $pathes[$row['category_id']] = [];
            }
            $pathes[$row['category_id']][] = $row['path_id'];
        }

        $result = [];
        foreach( $pathes as $categoryId => $categoryPathAr ) {
            $result[$categoryId] = implode('_', $categoryPathAr);            
        }

        return $result; 
    }

}
