<?php
class ModelModuleReferrer extends Model {

    public function decode($url){
        $decoded_url = urldecode($url );
        $pure_url = htmlspecialchars_decode($decoded_url);
        $pure_url = str_replace("&amp;","&",$pure_url);

        $params=preg_split("/[?,&]/",$pure_url);
        $page=$params[0];
        array_shift($params);

        $patterns = $this->getPatterns();

        foreach( $patterns as $pattern ){
            if (strpos($page,$pattern['url_mask']) === FALSE )
                continue;

            foreach( $params as $param ){
                $pos = strpos($param, $pattern['url_param'] . "=");
                //echo $param . "<br>";
                if( $pos !== 0 )
                    continue;

                return $pattern["name"] . ": " . substr($param,strlen($pattern['url_param'])+1);
            }
        }

        return $pure_url;
    }

    public function getPatterns(){
        $patterns = $this->cache->get('referrer_patterns');
        if( $patterns )
            return $patterns;

        $patterns = array();
        $query = $this->db->query("SELECT name, url_mask, url_param FROM `" . DB_PREFIX . "referrer_patterns`");
        foreach($query->rows as $row ) {
            array_push( $patterns, array( "name" => $row["name"], "url_mask" => $row["url_mask"], "url_param" => $row["url_param"]) );
        }
        $this->cache->set('referrer_patterns',$patterns);
        return $patterns;
    }

    public function deleteRecord($pattern_id) {
        $this->db->query("DELETE FROM `" . DB_PREFIX . "referrer_patterns` WHERE `pattern_id` = '" . (int)$pattern_id . "'");
        $this->cache->delete('referrer_patterns');
    }

    public function updateRecord($data) {
        
        /*
        if($data['name'] == '' or $data['url_mask'] == '' or $data['url_param'] == '')
            return false;
        if($data['pattern_id'] != 0 ) {
            $this->db->query("UPDATE `" . DB_PREFIX . "referrer_patterns` SET `name` = '" . $this->db->escape($data['name']) . "', `url_mask` = '" . $this->db->escape($data['url_mask']) . "', `url_param` = '" . $this->db->escape($data['url_param']) . "' WHERE `pattern_id` = '" . (int)$data['pattern_id'] . "'");
        } else {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "referrer_patterns` SET `name` = '" .  $this->db->escape($data['name']) . "', `url_mask` = '" . $this->db->escape($data['url_mask']) . "', `url_param` = '" . $this->db->escape($data['url_param']) . "'");
        }
        */
        //echo "UPDATE `" . DB_PREFIX . "referrer_patterns` SET `utm_source` = '" . $this->db->escape($data['utm_source']) . "', `utm_medium` = '" . $this->db->escape($data['utm_medium']) . "', `utm_campaign` = '" . $this->db->escape($data['utm_campaign']) . "', `utm_term` = '" . $this->db->escape($data['utm_term']) . "', `utm_content` = '" . $this->db->escape($data['utm_content']) . "', `phone` = '" . $this->db->escape($data['phone']) . "', `email` = '" . $this->db->escape($data['email']) . "' WHERE `pattern_id` = '" . (int)$data['pattern_id'] . "'";
        if($data['pattern_id'] != 0 ) {
            $this->db->query("UPDATE `" . DB_PREFIX . "referrer_patterns` SET `utm_source` = '" . $this->db->escape($data['utm_source']) . "', `utm_medium` = '" . $this->db->escape($data['utm_medium']) . "', `utm_campaign` = '" . $this->db->escape($data['utm_campaign']) . "', `utm_term` = '" . $this->db->escape($data['utm_term']) . "', `utm_content` = '" . $this->db->escape($data['utm_content']) . "', `phone` = '" . $this->db->escape($data['phone']) . "', `email` = '" . $this->db->escape($data['email']) . "' WHERE `pattern_id` = '" . (int)$data['pattern_id'] . "'");
        } else {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "referrer_patterns` SET `utm_source` = '" .  $this->db->escape($data['utm_source']) . "', `utm_medium` = '" . $this->db->escape($data['utm_medium']) . "', `utm_campaign` = '" . $this->db->escape($data['utm_campaign']) . "', `utm_term` = '" . $this->db->escape($data['utm_term']) . "', `utm_content` = '" . $this->db->escape($data['utm_content']) . "', `phone` = '" . $this->db->escape($data['phone']) . "', `email` = '" . $this->db->escape($data['email']) . "'");
        }

        $this->cache->delete('referrer_patterns');
        return true;
    }

    // Get List
    public function getRecords($data = array()) {
        if (!$data) {
            $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "referrer_patterns` ORDER BY pattern_id");
            return $query->rows;
        }

        $sql = "SELECT * FROM `" . DB_PREFIX . "referrer_patterns` ";

        $sort_data = array('name', 'pattern');

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY pattern_id";
        }

        if (isset($data['order']) && ($data['order'] == 'ASC')) {
            $sql .= " ASC";
        } else {
            $sql .= " DESC";
        }

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }

        $query = $this->db->query($sql);
        return  $query->rows;
    }

    // Total Records
    public function getRecordsCount() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "referrer_patterns`;");
        return $query->row['total'];
        //return 0;
    }

    // Install/Uninstall
    public function install() {
        /*
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "referrer_patterns` ( `pattern_id` int(11) NOT NULL AUTO_INCREMENT, `name` varchar(128) NOT NULL, `url_mask` varchar(256) NOT NULL, `url_param` varchar(256) NOT NULL, PRIMARY KEY (`pattern_id`) );");

        $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "order` WHERE `Field` = 'first_referrer'");
        if(count($query->rows) == 0 ) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "order` ADD `first_referrer` text;");
        }
        $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "order` WHERE `Field` = 'last_referrer'");
        if(count($query->rows) == 0 ) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "order` ADD `last_referrer` text;");
        }
        
        $sql = array();
/*
        $sql[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Картинки.Mail', 'go.mail.ru', 'q');";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Google', 'google.','q');";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Google', 'google.','as_q');";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Картинки', 'images.yandex.', 'text');";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс.Mobile', 'm.yandex.', 'query');";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс', 'hghltd.yandex.', 'text');";
        $sql[] = "INSERT INTO `" . DB_PREFIX . "referrer_patterns` (name, url_mask, url_param) VALUES ('Яндекс', 'yandex.', 'text');";
*/
        foreach ($sql as $_sql) {
            $this->db->query($_sql);
        }

        $this->cache->delete('referrer_patterns');
        return TRUE;
    }

    public function uninstall() {
        /*
        $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "order` WHERE `Field` = 'first_referrer'");
        if(count($query->rows) == 1 ) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "order` DROP COLUMN `first_referrer`;");
        }
        $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "order` WHERE `Field` = 'last_referrer'");
        if(count($query->rows) == 1 ) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "order` DROP COLUMN `last_referrer`;");
        }
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "referrer_patterns`");

        $this->cache->delete('referrer_patterns');
        return TRUE;
        */
    }

}
?>