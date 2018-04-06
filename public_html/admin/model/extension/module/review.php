<?php
/**
 * @category WS patches 
 * @package  
 */
//@task move to overrided models

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 1, 2018  8:37:32 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ModelExtensionModuleReview extends Model
{
    const DEFAULT_REVIEWS_COUNT = 4;
    const DEFAULT_REVIEWS_VISIBLE = 2;
    const CONFIG_CODE = 'review';
    const CONFIG_KEY_COUNT  = 'review_count';
    const CONFIG_KEY_VISIBLE = 'review_visible';

    public function installDatabase()
    {
        $sql = "insert into " . DB_PREFIX . "_setting (store_id, code, `key`, `value`, serialized) values" . 
               " (0, '".static::CONFIG_CODE."', '".static::CONFIG_KEY_COUNT."',". static::DEFAULT_REVIEWS_COUNT .", false), " . 
               " (0, '".static::CONFIG_CODE."', '".static::CONFIG_KEY_VISIBLE."',". static::DEFAULT_REVIEWS_VISIBLE . ", false), " .
               " (0, '".static::CONFIG_CODE."', 'review_status',1, false)";
        return $this->db->query($sql);
    }

    public function uninstallDatabase()
    {
       $sql = "delete from " . DB_PREFIX . "_setting where code='" . static::CONFIG_CODE . "'";
       return $this->db->query($sql);
    }
}
