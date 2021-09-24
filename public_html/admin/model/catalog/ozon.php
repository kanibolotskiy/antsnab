<?php
class ModelCatalogOzon extends Model {
	public function getOzonInfo(){
		//$query = $this->db->query("SELECT DISTINCT * from dopinfo_diler WHERE doc_id = '1'");
		//return $query->row;
	}
	public function editOzon($data) {
		foreach($data['ozon_change'] as $key=>$itm){
			if($itm){
				$flag=0;
				if(isset($data['ozon_flag'][$key])){
					$flag=$data['ozon_flag'][$key];
				}
				$sql="UPDATE oc_product SET ozon_count='".$data['ozon_count'][$key]."',ozon_code='".$data['ozon_code'][$key]."', ozon_flag='".$flag."' where product_id='".$key."'";
				$this->db->query($sql);
			}
		}
	}
}
