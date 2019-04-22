<?php
///3274///
class ModelFileFile extends Model {	
	public function checkDBTables(){
		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "file` (
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
		
		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "file_description` (
			  `file_id` int(11) NOT NULL,
			  `language_id` int(11) NOT NULL DEFAULT '0',
			  `name` varchar(2048) DEFAULT NULL,
			  `title` varchar(2048) DEFAULT NULL
			) ENGINE=MyISAM DEFAULT CHARSET=utf8;";	
		$this->db->query($sql);		

		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "file_page` (
			  `file_id` int(11) NOT NULL,
			  `page_id` int(11) NOT NULL,
			  `page_type` varchar(127) NOT NULL,
			  PRIMARY KEY (`file_id`,`page_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8;";	
		$this->db->query($sql);			
	}
	
	public function addProductFiles($product_id, $product_files){
		foreach ($product_files as $product_file){
			if(isset($product_file['file_id'])){
				$this->db->query("UPDATE " . DB_PREFIX . "file SET 
				file = '" . $this->db->escape(html_entity_decode($product_file['file'], ENT_QUOTES, 'UTF-8')) . "', 
				image = '" . $this->db->escape(html_entity_decode($product_file['file_image'], ENT_QUOTES, 'UTF-8')) . "',
				sort_order = '" . (int)$product_file['sort_order'] . "',			
				status = '" . (int)$product_file['status'] . "', 			
				date_modified = NOW() 
				WHERE file_id = '" . (int)$product_file['file_id'] . "'
				"); 

				$this->db->query("UPDATE " . DB_PREFIX . "file_page SET 
				page_id = '" . (int)$product_id . "',
				page_type = 'product' 
				WHERE file_id = '" . (int)$product_file['file_id'] . "'
				"); 			
				
				
				$this->db->query("DELETE FROM " . DB_PREFIX . "file_description WHERE file_id = '" . (int)$product_file['file_id'] . "'");
				
				foreach ($product_file['description'] as $language_id => $value) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "file_description SET 
					file_id = '" . (int)$product_file['file_id'] . "',
					language_id = '" . (int)$language_id . "', 
					name = '" . $this->db->escape($value['name']) . "', 
					title = '" . $this->db->escape($value['title']) . "' 
					");
				}						
			}else{ //add new files
				$this->db->query("INSERT INTO " . DB_PREFIX . "file SET 
				file = '" . $this->db->escape(html_entity_decode($product_file['file'], ENT_QUOTES, 'UTF-8')) . "', 
				image = '" . $this->db->escape(html_entity_decode($product_file['file_image'], ENT_QUOTES, 'UTF-8')) . "',
				sort_order = '" . (int)$product_file['sort_order'] . "',		
				status = '" . (int)$product_file['status'] . "', 			
				date_added = NOW()
				"); 
					
				$file_id = $this->db->getLastId();	
					
				$this->db->query("INSERT INTO " . DB_PREFIX . "file_page SET 
				file_id = '" . $file_id . "', 
				page_id = '" . (int)$product_id . "',
				page_type = 'product' 
				"); 			
				
				foreach ($product_file['description'] as $language_id => $value) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "file_description SET 
					file_id = '" . $file_id . "',
					language_id = '" . (int)$language_id . "', 
					name = '" . $this->db->escape($value['name']) . "', 
					title = '" . $this->db->escape($value['title']) . "' 
					");
				}						
			}		
		}			
	}

	public function deleteProductFiles($delete_id) { 
		$delete_array_id = explode(',', $delete_id);

		if($delete_id){
			foreach($delete_array_id as $delete_file_id){
				$delete_array_name = $this->db->query("SELECT file FROM " . DB_PREFIX . "file WHERE file_id = '" . $delete_file_id . "'");
				
				$this->db->query("DELETE FROM " . DB_PREFIX . "file WHERE file_id = '" . $delete_file_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "file_description WHERE file_id = '" . $delete_file_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "file_page WHERE file_id = '" . $delete_file_id . "'");

				if(isset($delete_array_name->row['file'])){
					if(file_exists(str_replace("system/download", "files", DIR_DOWNLOAD) . $delete_array_name->row['file'])){
						unlink(str_replace("system/download", "files", DIR_DOWNLOAD) . $delete_array_name->row['file']);
					}				
				}				
			}
		}
	}
	
	public function deleteProductFilesForProduct_id($product_id) {
		$delete_array = $this->db->query("SELECT file_id FROM " . DB_PREFIX . "file_page WHERE page_id = '" . $product_id . "' AND page_type='product'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "file_page WHERE page_id = '" . $product_id . "' AND page_type='product'");

		if($delete_array->rows){
			foreach($delete_array->rows as $delete_file_id){
				$delete_array_name = $this->db->query("SELECT file FROM " . DB_PREFIX . "file WHERE file_id = '" . $delete_file_id['file_id'] . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "file WHERE file_id = '" . $delete_file_id['file_id'] . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "file_description WHERE file_id = '" . $delete_file_id['file_id'] . "'");
				
				if(file_exists(str_replace("system/download", "files", DIR_DOWNLOAD) . $delete_array_name->row['file'])){
					unlink(str_replace("system/download", "files", DIR_DOWNLOAD) . $delete_array_name->row['file']);
				}				
			}
		}
	}	
	
	public function getProductFiles($product_id) {
		$product_files_data = array(); 
		
		$product_files_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "file` f 
		LEFT JOIN `" . DB_PREFIX . "file_page` fp ON (f.file_id = fp.file_id) 
		WHERE fp.page_id = '" . (int)$product_id . "' 
		AND fp.page_type = 'product' ORDER BY f.sort_order ASC
		");
		
		foreach ($product_files_query->rows as $product_file) {
			$product_file_description_data = array();
			
			$product_file_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "file_description WHERE file_id = '" . (int)$product_file['file_id'] . "'");
			
			foreach ($product_file_description_query->rows as $product_file_description) {
				$product_file_description_data[$product_file_description['language_id']] = array(
					'name' => $product_file_description['name'],
					'title' => $product_file_description['title']
				);
			}
			
			$product_files_data[] = array(
				'file_id'               => $product_file['file_id'],
				'file'                  => $product_file['file'], 
				'image'                 => $product_file['image'],
				'sort_order'            => $product_file['sort_order'],
				'status'                => $product_file['status'],
				'page_id'               => $product_file['page_id'],
				'page_type'             => $product_file['page_type'],
				'file_description' 		=> $product_file_description_data
			);
		}
		
		return $product_files_data;
	}
}	
?>