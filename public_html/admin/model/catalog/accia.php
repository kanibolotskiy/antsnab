<?php
class ModelCatalogAccia extends Model {
	
	/*
	public function getReviews($data = array()) {
        //@task to wspatch

        $sql = "SELECT r.review_id, pd.name, r.author, r.email, r.company, r.rating, r.status, r.date_added, r.about, r.moderator, r.answer FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product_description pd ON (r.product_id = pd.product_id) WHERE (pd.language_id = '" . (int)$this->config->get('config_language_id') . "' or pd.language_id is NULL)";

		if (!empty($data['filter_product'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_product']) . "%'";
		}
	*/
	public function deleteAccia($accis_id){
		$this->db->query("DELETE FROM accia WHERE accia_id = '" . (int)$accis_id . "'");
		$this->db->query("DELETE FROM accia_products WHERE accia_id = '" . (int)$accis_id . "'");
	}
	public function listCatalogAccias(){
		$sql="SELECT oc.category_id, oc.parent_id, oc.top, od.name
		FROM oc_category oc
		LEFT JOIN oc_category_description od ON oc.category_id=od.category_id
		where oc.isseo=0 order by oc.sort_order";
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function productsAccia($accia_id){
		$sql="select product_id from accia_products where accia_id=".$accia_id;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function listProductsAll(){
		$sql="SELECT od.product_id, op.price, op.price_wholesale, od.name, op.sort_order, oc.category_id
		FROM oc_product op 
		LEFT JOIN oc_product_description od ON op.product_id=od.product_id
		LEFT JOIN oc_product_to_category oc ON od.product_id=oc.product_id and oc.main_category=1
		order by op.sort_order";
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function getAccias($data = array()) {
		if($data["sort"]){
			$sql_sort=" order by ".$data["sort"]." ".$data["order"];
		}
		
		$sql_add=[];
		$sql_add_str="";

		if(isset($data["filter_product"])){
			$sql_accia="select ap.accia_id from accia_products ap LEFT JOIN oc_product_description od ON ap.product_id=od.product_id
			where od.name='".$this->db->escape($data["filter_product"])."'";
			$query_accia = $this->db->query($sql_accia);
			$accias=[];
			
			foreach($query_accia->rows as $row_accia){
				$accias[]=$row_accia["accia_id"];
			}
			if($accias){
				$sql_add[]="a.accia_id in (".implode(",",$accias).")";
			}
			
			
		}
		if(isset($data["filter_status"])){
			$sql_add[]="a.status=".$data["filter_status"];
		}
		
		if(isset($data["filter_date_start"])){
			$sql_add[]="DATE(a.date_start) = '".$data["filter_date_start"]."'";
		}
		if(isset($data["filter_date_end"])){
			$sql_add[]="DATE(a.date_end) = '".$data["filter_date_end"]."'";
		}
		
		if($sql_add){
			$sql_add_str=" WHERE ".implode(" AND ",$sql_add);
		}
		
		$sql="select * from accia a ".$sql_add_str.$sql_sort;
		//echo $sql;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function getAccia($accia_id) {
		$query = $this->db->query("SELECT * from accia WHERE accia_id = '" . (int)$accia_id . "'");
		return $query->row;
	}
	
	public function getTotalAccias($data = array()) {
		/*
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product_description pd ON (r.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_product'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_product']) . "%'";
		}

		if (!empty($data['filter_author'])) {
			$sql .= " AND r.author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND r.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(r.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
		*/
		return 0;
	}


	
	private function addProductsAccia($data,$accia_id){

		$this->db->query("delete from accia_products where accia_id=".$accia_id);
		if(isset($data["accia_products"])){
			$product_arr=explode(",",$data["accia_products"]);
			foreach($product_arr as $product_itm){
				$this->db->query("insert into accia_products (accia_id, product_id) values (".$accia_id.",".trim($product_itm).")");
				//echo "insert into accia_products (accia_id, product_id) values (".$accia_id.",".trim($product_itm).")";
			}
		}
	}
	
	public function addAccia($data) {
		if($data["date_start"]){
			$date_start="'".$data["date_start"]."'";
		}else{
			$date_start="NULL";
		}
		if($data["date_end"]){
			$date_end="'".$data["date_end"]."'";
		}else{
			$date_end="NULL";
		}
		$this->db->query("INSERT INTO accia SET 
		title='".$data["title"]."', 
		meta_title='".$data["meta_title"]."', 
		meta_h1='".$data["meta_h1"]."', 
		meta_description='".$data["meta_description"]."', 
		meta_keyword='".$data["meta_keyword"]."', 
		keyword='".$data["keyword"]."', 
		sort_order=".$data["sort_order"].", 
		description='".$data["description"]."', 
		shorttext='".$data["shorttext"]."', 
		image='".$data["image"]."', 
		banner='".$data["banner"]."', 
		status = '" . (int)$data['status'] . "',
		date_start = ".$date_start.",
		date_end = ".$date_end);
		$accia_id = $this->db->getLastId();

		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'sale_id=" . (int)$accia_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		$this->addProductsAccia($data,$accia_id);

		return $accia_id;
	}
	public function editAccia($accia_id, $data) {
		if($data["date_start"]){
			$date_start="'".$data["date_start"]."'";
		}else{
			$date_start="NULL";
		}
		if($data["date_end"]){
			$date_end="'".$data["date_end"]."'";
		}else{
			$date_end="NULL";
		}
		$this->db->query("UPDATE accia SET 
		title='".$data["title"]."', 
		meta_title='".$data["meta_title"]."', 
		meta_h1='".$data["meta_h1"]."', 
		meta_description='".$data["meta_description"]."', 
		meta_keyword='".$data["meta_keyword"]."', 
		keyword='".$data["keyword"]."', 
		sort_order=".$data["sort_order"].", 
		description='".$data["description"]."', 
		shorttext='".$data["shorttext"]."', 
		image='".$data["image"]."', 
		banner='".$data["banner"]."', 
		status = '" . (int)$data['status'] . "',
		date_start = ".$date_start.",
		date_end = ".$date_end."
		where accia_id=".$accia_id);

		if($data["accia_products_change"]){
			$this->addProductsAccia($data,$accia_id);
		}		
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'sale_id=" . (int)$accia_id . "'");
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'sale_id=" . (int)$accia_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
	}

	
}