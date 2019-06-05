<?php
class ModelCatalogCalcs extends Model {
	public function addDoc($data) {
	
		$this->db->query("INSERT INTO dopinfo_calcs SET name = '" . $this->db->escape($data['name']) . "',description='" . $this->db->escape($data['calc_description']) . "', sort_order = '" . (int)$data['sort_order'] . "'");
		//echo "INSERT INTO dopinfo_calcs SET name = '" . $this->db->escape($data['name']) . "',description='" . $this->db->escape($data['calc_description']) . "', sort_order = '" . (int)$data['sort_order'] . "'";
		$calc_id = $this->db->getLastId();

		$this->cache->delete('calc');
		
		return $calc_id;
	}

	public function editDoc($calc_id, $data) {
		
		$this->db->query("UPDATE dopinfo_calcs SET name = '" . $this->db->escape($data['name']) . "', description='" . $this->db->escape($data['calc_description']) . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE calc_id = '" . (int)$calc_id . "'");
		
		$this->cache->delete('calc');
		
	}

	public function deleteDoc($calc_id) {
		$this->db->query("DELETE FROM dopinfo_calcs WHERE calc_id = '" . (int)$calc_id . "'");
	}

	public function getDoc($calc_id) {
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_calcs WHERE calc_id = '" . (int)$calc_id . "'");
		return $query->row;
	}

	

	public function getCalcs($data = array()) {
		$sql = "SELECT * FROM dopinfo_calcs";

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


	public function getTotalCalcs() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM dopinfo_calcs");
		return $query->row['total'];
	}
}
