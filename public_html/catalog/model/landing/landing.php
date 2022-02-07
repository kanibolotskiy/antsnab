<?php
class ModelLandingLanding extends Model {
    public function productFiles($product_id){
        $query = $this->db->query("SELECT * FROM oc_file_page op LEFT JOIN oc_file of ON op.file_id=of.file_id left join oc_file_description od ON od.file_id=op.file_id WHERE page_id='".$product_id."' order by sort_order");
		return $query->rows;
    }
    public function addLandingHistory($data){
		$sql="INSERT INTO landing_history (data,date)
		VALUES('".json_encode($data,JSON_UNESCAPED_UNICODE)."',NOW())";
		$this->db->query($sql);
	}

    public function landingProductID($alias){
		$query = $this->db->query("select query FROM oc_url_alias where keyword='".$alias."'");
		return $query->row['query'];
	}
    function remove_utf8_bom($str){
        return str_replace("\xEF\xBB\xBF",'',$str); 
    }
    public function getLandingAlias($landing_id){
        $sql='SELECT seo_url from landing where landing_id="'.$landing_id.'"';
        $query = $this->db->query($sql);
        return $query->row['seo_url'];
        
    }
    public function getProductAlias($product_id){
        $sql='SELECT * FROM `oc_url_alias` WHERE query="product_id='.$product_id.'"';
        $query = $this->db->query($sql);
        return $query->row['keyword'];
    }
    public function getProductImages($product_id){
        $sql="select image from oc_product_image where product_id='".$product_id."' order by sort_order";
        $query = $this->db->query($sql);
        return $query->rows;
    }
    public function getProductFullInfo($product_id){
        $sql="select 
            od.meta_title,
            od.meta_description,
            op.product_id,
            op.produnit_template_id,
            op.quantity,
            op.mincount,
            op.data_lp, 
            op.image, 
            od.name, 
            od.description,
            op.price, 
            op.price_wholesale, 
            op.price_c1, 
            op.price_c2,
            op.price_c3
        from oc_product op LEFT JOIN oc_product_description od ON op.product_id=od.product_id where op.product_id='".$product_id."'";
        
        $query = $this->db->query($sql);
        return $query->row;
    }
    public function getProductInfo($product_id){
        $sql="select 
            op.product_id,
            op.data_lp, 
            op.image, 
            od.name, 
            od.description_mini,
            op.price, 
            op.price_wholesale, 
            op.price_c1, 
            op.price_c2,
            op.price_c3
        from oc_product op LEFT JOIN oc_product_description od ON op.product_id=od.product_id where op.product_id='".$product_id."'";

        $query = $this->db->query($sql);
        return $query->row;
    }
	public function getLandingInfo($landing_id){
        $query = $this->db->query("select * from landing where landing_id='".$landing_id."'");
		if ($query->num_rows) {
            $data = str_replace(array("\r\n", "\n", "\r"),'',$query->row['data']);
            return json_decode($data,JSON_UNESCAPED_UNICODE);
        }
    }
}
?>