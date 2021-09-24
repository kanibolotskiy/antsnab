<?php
class ModelExtensionFeedOzon extends Model {
	 
	
	public function getProduct() {
		$query = $this->db->query("SELECT product_id,ozon_code,ozon_count,quantity,price,discount_percent from oc_product where ozon_flag='1' and notavail='0'");
		
		return $query->rows;
	}
}
?>
