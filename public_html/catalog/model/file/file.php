<?php
class ModelFileFile extends Model {
	public function getProductFiles($product_id) {
		$product_files_data = array(); 
		
		$product_files_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "file` f 
		LEFT JOIN `" . DB_PREFIX . "file_description` fd ON (f.file_id = fd.file_id) 
		LEFT JOIN `" . DB_PREFIX . "file_page` fp ON (f.file_id = fp.file_id) 
		WHERE fp.page_id = '" . (int)$product_id . "' 
		AND fd.language_id = '" . (int)$this->config->get('config_language_id') . "' 
		AND f.status = '1' 
		AND fp.page_type = 'product' ORDER BY f.sort_order ASC
		");
		
		foreach ($product_files_query->rows as $product_file) {			
			$product_files_data[] = array(
				'file_id'        => $product_file['file_id'],
				'file'           => $product_file['file'], 
				'image'          => $product_file['image'],
				'sort_order'     => $product_file['sort_order'],
				'status'         => $product_file['status'],
				'page_id'        => $product_file['page_id'],
				'page_type'      => $product_file['page_type'],
				'name'           => $product_file['name'],
				'title'          => $product_file['title']
			);
		}
		
		return $product_files_data;
	}

	public function checkDBTables(){
		$sql = "CREATE TABLE IF NOT EXISTS `file` (
			  `file_id` int(11) NOT NULL AUTO_INCREMENT,
			  `file` varchar(255) DEFAULT NULL,
			  `image` varchar(255) DEFAULT NULL,
			  `sort_order` int(3) NOT NULL DEFAULT '0',
			  `status` int(1) NOT NULL,
			  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
			  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
			  PRIMARY KEY (`file_id`)
			) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1";	
		$this->db->query($sql);
		
		$sql = "CREATE TABLE IF NOT EXISTS `file_description` (
			  `file_id` int(11) NOT NULL,
			  `language_id` int(11) NOT NULL DEFAULT '0',
			  `name` varchar(2048) DEFAULT NULL,
			  `title` varchar(2048) DEFAULT NULL
			) ENGINE=MyISAM DEFAULT CHARSET=utf8;";	
		$this->db->query($sql);		

		$sql = "CREATE TABLE IF NOT EXISTS `file_page` (
			  `file_id` int(11) NOT NULL,
			  `page_id` int(11) NOT NULL,
			  `page_type` varchar(127) NOT NULL,
			  PRIMARY KEY (`file_id`,`page_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8;";	
		$this->db->query($sql);			
	}	

	public function getCustomerGroupId($customer_id) {
		$query = $this->db->query("SELECT customer_group_id FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");
		
		return $query->row['customer_group_id'];
	}
	
}
?>