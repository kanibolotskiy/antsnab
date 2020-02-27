<?php
class ModelCatalogDocs extends Model {
	public function addDoc($data) {
	
		$this->db->query("INSERT INTO dopinfo_docs SET name = '" . $this->db->escape($data['name']) . "',description='" . $this->db->escape($data['doc_description']) . "', sort_order = '" . (int)$data['sort_order'] . "'");
		//echo "INSERT INTO dopinfo_docs SET name = '" . $this->db->escape($data['name']) . "',description='" . $this->db->escape($data['doc_description']) . "', sort_order = '" . (int)$data['sort_order'] . "'";
		$doc_id = $this->db->getLastId();

		$this->cache->delete('doc');
		
		return $doc_id;
	}

	public function editDoc($doc_id, $data) {
		
		$this->db->query("UPDATE dopinfo_docs SET name = '" . $this->db->escape($data['name']) . "', description='" . $this->db->escape($data['doc_description']) . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE doc_id = '" . (int)$doc_id . "'");
		
		$this->cache->delete('doc');
		
	}

	public function deleteDoc($doc_id) {
		$this->db->query("DELETE FROM dopinfo_docs WHERE doc_id = '" . (int)$doc_id . "'");
	}

	public function getDoc($doc_id) {
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_docs WHERE doc_id = '" . (int)$doc_id . "'");
		return $query->row;
	}

	

	public function getDocs($data = array()) {
		$sql = "SELECT * FROM dopinfo_docs";

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


	public function getTotalDocs() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM dopinfo_docs");
		return $query->row['total'];
	}
}
