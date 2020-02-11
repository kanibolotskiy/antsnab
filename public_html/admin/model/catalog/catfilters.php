<?php
class ModelCatalogCatfilters extends Model {
	public function getCatFilters($category_id){
		$cat_filters=[];
		$query = $this->db->query("SELECT * FROM category_params WHERE category_id = '" . (int) $category_id . "' order by sort_order ASC");
		return $query->rows;
	}

	public function getCatFilterList($param_id){
		$cat_filters=[];
		$query = $this->db->query("SELECT * FROM category_param_values WHERE param_id = '" . (int) $param_id . "' order by CAST(param_value AS SIGNED) , param_value");
		return $query->rows;
	}
	public function getLinkedProducts($param_id, $param_value){
		$query = $this->db->query("SELECT op.product_id,op.name from product_param_values pv inner join oc_product_description op ON pv.product_id=op.product_id where param_id=".(int)$param_id." and value1=".(int)$param_value);
        return $query->rows;
	}
	public function getLinkedProductsParam($param_id){
		$query = $this->db->query("SELECT op.product_id,op.name from product_param_values pv inner join oc_product_description op ON pv.product_id=op.product_id where param_id=".(int)$param_id." group by product_id");
		return $query->rows;
	}


}