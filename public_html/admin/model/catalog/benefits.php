<?php
class ModelCatalogBenefits extends Model {
	public function addBenefit($data) {
	
		$this->db->query("INSERT INTO dopinfo_benefits SET name = '" . $this->db->escape($data['name']) . "',description='" . $this->db->escape($data['benefit_description']) . "', sort_order = '" . (int)$data['sort_order'] . "'");
		$benefit_id = $this->db->getLastId();

		$this->cache->delete('benefit');
		
		return $benefit_id;
	}

	public function editBenefit($benefit_id, $data) {
		
		$this->db->query("UPDATE dopinfo_benefits SET name = '" . $this->db->escape($data['name']) . "', description='" . $this->db->escape($data['benefit_description']) . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE benefit_id = '" . (int)$benefit_id . "'");
		
		$this->cache->delete('benefit');
		
	}

	public function deleteBenefit($benefit_id) {
		$this->db->query("DELETE FROM dopinfo_benefits WHERE benefit_id = '" . (int)$benefit_id . "'");
	}

	public function getBenefit($benefit_id) {
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_benefits WHERE benefit_id = '" . (int)$benefit_id . "'");


		return $query->row;
	}

	

	public function getBenefits($data = array()) {
		$sql = "SELECT * FROM dopinfo_benefits";

		

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


	public function getTotalBenefits() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM dopinfo_benefits");
		return $query->row['total'];
	}
}
