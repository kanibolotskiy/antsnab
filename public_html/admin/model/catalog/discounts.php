<?php
class ModelCatalogDiscounts extends Model {
	public function addDiscount($data) {
	
		$this->db->query("INSERT INTO dopinfo_discounts SET name = '" . $this->db->escape($data['name']) . "',description='" . $this->db->escape($data['discount_description']) . "', sort_order = '" . (int)$data['sort_order'] . "'");
		$discount_id = $this->db->getLastId();

		$this->cache->delete('discount');
		
		return $discount_id;
	}

	public function editDiscount($discount_id, $data) {
		
		$this->db->query("UPDATE dopinfo_discounts SET name = '" . $this->db->escape($data['name']) . "', description='" . $this->db->escape($data['discount_description']) . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE discount_id = '" . (int)$discount_id . "'");
		
		$this->cache->delete('discount');
		
	}

	public function deleteDiscount($discount_id) {
		$this->db->query("DELETE FROM dopinfo_discounts WHERE discount_id = '" . (int)$discount_id . "'");
	}

	public function getDiscount($discount_id) {
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_discounts WHERE discount_id = '" . (int)$discount_id . "'");


		return $query->row;
	}

	

	public function getDiscounts($data = array()) {
		$sql = "SELECT * FROM dopinfo_discounts";

		

		if (!empty($data['filter_name'])) {
			$sql .= " AND name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
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


	public function getTotalDiscounts() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM dopinfo_discounts");
		return $query->row['total'];
	}
}
