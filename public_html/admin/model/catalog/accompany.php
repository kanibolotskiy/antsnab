<?php
class ModelCatalogAccompany extends Model {
	public function getTotalAccompanies(){
		$query = $this->db->query("SELECT COUNT(*) AS total FROM dopinfo_accompanies");
		return $query->row['total'];
	}
	public function getAccompanies($data = array()){
		$sql = "SELECT * FROM dopinfo_accompanies";


		if (!empty($data['filter_name'])) {
			$sql .= " where name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sort_data = array(
			'name',
			'sort_order'
		);
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY name";
		}
		
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
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

		return $query->rows;
	}
	public function getAccompany($accompany_id){
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_accompanies WHERE accompany_id = '" . (int)$accompany_id . "'");
		return $query->row;
	}
	public function getAccompanyProducts($accompany_id){
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_accompany_products WHERE accompany_id = '" . (int)$accompany_id . "'");
		return $query->rows;
	}
	public function editAccompany($accompany_id,$data){
		$this->db->query("UPDATE dopinfo_accompanies SET name = '" . $this->db->escape($data['name']) . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE accompany_id = '" . (int)$accompany_id . "'");
		if($data['products_change']){
			$this->db->query("DELETE FROM dopinfo_accompany_products WHERE accompany_id = '" . (int)$accompany_id . "'");
			$products_str=$data['products'];
			if($products_str){
				$products=explode(",",$products_str);
				foreach($products as $product){
					$this->db->query("INSERT INTO dopinfo_accompany_products SET accompany_id = '" . $accompany_id . "', product_id = '" . (int)$product . "'");
				}
			}
		}
	}
	public function addAccompany($data){
		$this->db->query("INSERT INTO dopinfo_accompanies SET name = '" . $this->db->escape($data['name']) . "', sort_order = '" . (int)$data['sort_order'] . "'");
		$accompany_id = $this->db->getLastId();
		if($data['products_change']){
			$this->db->query("DELETE FROM dopinfo_accompany_products WHERE accompany_id = '" . (int)$accompany_id . "'");
			$products_str=$data['products'];
			if($products_str){
				$products=explode(",",$products_str);
				foreach($products as $product){
					$this->db->query("INSERT INTO dopinfo_accompany_products SET accompany_id = '" . $accompany_id . "', product_id = '" . (int)$product . "'");
				}
			}
		}
		return $accompany_id;
	}
	public function deleteAccompany($accompany_id) {
		$this->db->query("DELETE FROM dopinfo_accompanies WHERE accompany_id = '" . (int)$accompany_id . "'");
		$this->db->query("DELETE FROM dopinfo_accompany_products WHERE accompany_id = '" . (int)$accompany_id . "'");
	}
	
}