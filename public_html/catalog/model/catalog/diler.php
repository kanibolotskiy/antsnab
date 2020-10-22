<?php
class ModelCatalogDiler extends Model {
	public function getDilerInfo(){
        $query = $this->db->query("SELECT DISTINCT * from dopinfo_diler WHERE doc_id = '1'");
		return $query->row;
    }
}