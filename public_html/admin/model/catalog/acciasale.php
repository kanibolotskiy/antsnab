<?php
class ModelCatalogAcciasale extends Model {
	public function getAcciasaleInfo(){
		$query = $this->db->query("SELECT DISTINCT * from accia_sale WHERE id = '1'");
		return $query->row;
	}
	public function editAcciasale($data) {
		$this->db->query("UPDATE accia_sale SET 
		title='".$data["title"]."', 
		meta_title='".$data["meta_title"]."', 
		meta_h1='".$data["meta_h1"]."', 
		meta_description='".$data["meta_description"]."', 
		meta_keyword='".$data["meta_keyword"]."', 
		description='".$data["description"]."', 
		shorttext='".$data["shorttext"]."', 
		keyword='".$data["keyword"]."', 
		image='".$data["image"]."', 
		banner='".$data["banner"]."' WHERE id = '1'");
	}
}
