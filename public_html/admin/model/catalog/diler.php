<?php
class ModelCatalogDiler extends Model {
	public function getDilerInfo(){
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_diler WHERE doc_id = '1'");
		return $query->row;
	}
	public function editDiler($data) {
		//title	content	meta_title	meta_h1	meta_description	meta_keywords	link_caption	link
		//print_r($data);
		$this->db->query("UPDATE dopinfo_diler SET 
		title = '" . $this->db->escape($data['title']) . "', 
		content='" . $this->db->escape($data['content']) . "',
		meta_title='" . $this->db->escape($data['meta_title']) . "',
		meta_h1='" . $this->db->escape($data['meta_h1']) . "',
		meta_description='" . $this->db->escape($data['meta_description']) . "',
		meta_keywords='" . $this->db->escape($data['meta_keywords']) . "',
		link_caption='" . $this->db->escape($data['link_caption']) . "',
		link='" . $this->db->escape($data['link']) . "'
		WHERE doc_id = '1'");
	}
}
