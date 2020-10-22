<?php
class ModelCatalogAbout extends Model {
	public function getAboutInfo(){
    $query = $this->db->query("SELECT DISTINCT * from dopinfo_about WHERE doc_id = '1'");
		return $query->row;
  }
  public function getAboutOff(){
    $query = $this->db->query("SELECT DISTINCT * from dopinfo_about_off");
		return $query->rows;
  }
  public function getAboutMan(){
    $query = $this->db->query("SELECT DISTINCT * from dopinfo_about_man");
		return $query->rows;
  }
  public function getAboutSklad(){
    $query = $this->db->query("SELECT DISTINCT * from dopinfo_about_sklad");
		return $query->rows;
  }
  public function getAboutSert(){
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_about_sert");
		return $query->rows;
	}
  public function getAboutBlock(){
    $results=[];
    $query = $this->db->query("SELECT DISTINCT * from dopinfo_about_block");
    foreach ($query->rows as $result) {
        $query_list = $this->db->query("SELECT DISTINCT * from dopinfo_about_row WHERE block_id = '".$result['id']."' ORDER BY id DESC");
        $results[$result['id']]['data']=$result;
        $results[$result['id']]['list']=$query_list->rows;
    }
    return $results;
  }
  public function getAboutCustomers(){
    $query = $this->db->query("SELECT DISTINCT * from dopinfo_about_customers");
    return $query->rows;
  }
}