<?php
class ModelCatalogMain extends Model {
	public function getMainInfo(){
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_main WHERE doc_id = '1'");
		return $query->row;
	}
	public function editMain($data) {
		$this->db->query("UPDATE dopinfo_main SET video = '" . $this->db->escape($data['video']) . "', description='" . $this->db->escape($data['description']) . "' WHERE doc_id = '1'");
	}
}
