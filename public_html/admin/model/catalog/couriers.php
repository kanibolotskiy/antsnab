<?php
class ModelCatalogCouriers extends Model {
	public function addCourier($data) {
	
		$this->db->query("INSERT INTO dopinfo_couriers SET name = '" . $this->db->escape($data['name']) . "',description='" . $this->db->escape($data['courier_description']) . "', caption='" . $this->db->escape($data['courier_caption']) . "', weight = '" . $this->db->escape($data['weight']) . "', price = '" . $this->db->escape($data['price']) . "', sort_order = '" . (int)$data['sort_order'] . "'");
		$courier_id = $this->db->getLastId();

		$this->cache->delete('courier');
		
		return $courier_id;
	}

	public function editCourier($courier_id, $data) {
		
		$this->db->query("UPDATE dopinfo_couriers SET name = '" . $this->db->escape($data['name']) . "', description='" . $this->db->escape($data['courier_description']) . "', caption='" . $this->db->escape($data['courier_caption']) . "', weight = '" . $this->db->escape($data['weight']) . "', price = '" . $this->db->escape($data['price']) . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE courier_id = '" . (int)$courier_id . "'");
		
		$this->cache->delete('courier');
		
	}

	public function deleteCourier($courier_id) {
		$this->db->query("DELETE FROM dopinfo_couriers WHERE courier_id = '" . (int)$courier_id . "'");
	}

	public function getCourier($courier_id) {
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_couriers WHERE courier_id = '" . (int)$courier_id . "'");
		return $query->row;
	}

	

	public function getCouriers($data = array()) {
		$sql = "SELECT * FROM dopinfo_couriers";

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


	public function getTotalCouriers() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM dopinfo_couriers");
		return $query->row['total'];
	}
}
