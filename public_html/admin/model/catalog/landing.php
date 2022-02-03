<?php
class ModelCatalogLanding extends Model {
	
	private function aliasProduct($product_id){
		$sql="select keyword from oc_url_alias where query='product_id=".$product_id."'";
		$query = $this->db->query($sql);
		return $query->row['keyword'];
		
	}
	/*
	private function resetProductsLandingAlias($landing_id,$data){
		$sql="SELECT * FROM `landing` where landing_id='".$landing_id."'";
		$query = $this->db->query($sql);		
		$data = str_replace(array("\r\n", "\n", "\r"),'',$query->row['data']);
		$data = json_decode($data,JSON_UNESCAPED_UNICODE);
		$products=[];
		foreach($data['product_list'] as $tab){
			$temp_arr=explode(",",$tab);
			$products=array_merge($products,$temp_arr);
		}
		foreach($products as $product_id){
			if($product_id){
				$sql="DELETE FROM `oc_url_alias` where query='landing_product_id=".$product_id."'";
				$query = $this->db->query($sql);
			}
		}
		
		$new_products=[];
		foreach($data['product_list'] as $tab){
			$temp_arr=explode(",",$tab);
			$new_products=array_merge($new_products,$temp_arr);
		}

		foreach($new_products as $product_id){
			if($product_id){
				$alias_product=$this->aliasProduct($product_id);

				$sql="INSERT INTO `oc_url_alias` 
				(query,keyword) VALUES(
					'landing_product_id=".$product_id."','lp-".$alias_product."'
				)";
				//echo $sql."<br/>";
				//where query='landing_product_id=".$product_id."'";
				$query = $this->db->query($sql);
			}
		}

	}
	*/
	public function getLandings($data = array()) {
		$sql="SELECT * FROM `landing`";
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function getTotalLandings($data = array()) {
		$sql="SELECT count(landing_id) as cnt FROM `landing`";
		$query = $this->db->query($sql);
		return $query->row['cnt'];
	}
	public function getLanding($landing_id){
		$sql="SELECT * FROM `landing` where landing_id='".$landing_id."'";
		$query = $this->db->query($sql);		
		$data = str_replace(array("\r\n", "\n", "\r"),'',$query->row['data']);
		return json_decode($data,JSON_UNESCAPED_UNICODE);
	}
	public function editLanding($landing_id, $data) {
		//$this->resetProductsLandingAlias($landing_id, $data);

		$alias=$data['seo_url'];
		$sql="UPDATE landing SET 
			data='".json_encode($data,JSON_UNESCAPED_UNICODE)."',
			title='".$data['title']."',
			sort_order='".$data['sort_order']."',
			status='".$data['status']."',
			seo_url='".$data['seo_url']."'
			where landing_id='".$landing_id."'
		";
		//echo $sql;
		$this->db->query($sql);

		$sql_del="DELETE from oc_url_alias where query='landing_id=".$landing_id."'";
		$this->db->query($sql_del);

		if($alias){
			$sql_ins="INSERT INTO oc_url_alias (query,keyword) VALUES ('landing_id=".$landing_id."','".$alias."')";
			$this->db->query($sql_ins);
		}
		$this->cache->delete('seo_pro');
		$this->cache->delete('seo_url');
		
	}
	public function deleteLanding($landing_id){
		$sql_del="DELETE from landing where landing_id='".$landing_id."'";
		$this->db->query($sql_del);

		$sql_del="DELETE from oc_url_alias where query='landing_id=".$landing_id."'";
		$this->db->query($sql_del);
		$this->cache->delete('seo_pro');
		$this->cache->delete('seo_url');
	}
	public function addLanding($data){
		
		$sql="insert into landing (title,sort_order,data,status,seo_url) 
			values (
				'".$data['title']."',
				'".$data['sort_order']."',
				'".json_encode($data,JSON_UNESCAPED_UNICODE)."',
				'".$data['status']."',
				'".$data['seo_url']."')
		";
		//echo $sql;
		$this->db->query($sql);
		$landing_id=$this->db->getLastId();

		$alias=$data['seo_url'];
		if($alias){
			$sql_ins="INSERT INTO oc_url_alias (query,keyword) VALUES ('landing_id=".$landing_id."','".$alias."')";
			$this->db->query($sql_ins);
		}
		$this->cache->delete('seo_pro');
		$this->cache->delete('seo_url');

		return $landing_id;
	}
	
}