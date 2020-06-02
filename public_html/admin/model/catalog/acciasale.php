<?php
class ModelCatalogAcciasale extends Model {
	private function changeProductsDiscount($data){
		foreach($data as $key=>$itm){
			if($itm){
				//echo $key."=".$itm."|<br/>";
				$this->db->query("UPDATE oc_product set discount_percent=".$itm." where product_id=".$key);
			}
		}
		//print_r($data);
	}
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
		if($data["change_products"]){
			$this->changeProductsDiscount($data["discount"]);
		}
	}
	public function productsAcciaSale(){
		$query = $this->db->query("SELECT product_id, discount_percent,price,price_wholesale from oc_product WHERE discount_percent>0");
		return $query->rows;
	}

}
