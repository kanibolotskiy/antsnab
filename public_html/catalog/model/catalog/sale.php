<?php
class ModelCatalogSale extends Model {
	
	public function cleanText($text){
		$text=html_entity_decode($text, ENT_QUOTES, 'UTF-8');
		
		$text = preg_replace('/alt="([^"]+)"/i', 'alt="$1" title="$1"', $text);
		
		$text = preg_replace_callback('/<a[^>]+/', array($this, 'cleanInternalUrl'), $text);
		
		$text=str_replace("₽","<div class='rur'>i</div>",$text);
		$text=str_replace('<b ','<span class="textBold"',$text);
		$text=str_replace('<b>','<span class="textBold">',$text);
		$text=str_replace('<strong','<span class="textBold"',$text);
		$text=str_replace('</b>','</span>',$text);
		$text=str_replace('</strong>','</span>',$text);
		return $text;
	}
	public function acciaProducts($sale_id){
		$query = $this->db->query("SELECT product_id FROM accia_products where accia_id = ".$sale_id);
		return $query->rows;
	}
	public function acciaProductsSale(){
		$query = $this->db->query("SELECT product_id FROM oc_product where status=1 and discount_percent>0");
		return $query->rows;
	}


	public function getSaleDiscount(){
		$query = $this->db->query("SELECT DISTINCT * FROM accia_sale");
		return $query->row;
	}
	public function getSale($sale_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM accia where accia_id=".$sale_id);
		return $query->row;
	}
	/*
	public function getTotalSales($data=[]){
		$sql = "SELECT COUNT(DISTINCT a.accia_id) AS total from accia a  where a.status=1 ";

		$query = $this->db->query($sql);
		return $query->row['total'];
	}
	*/
	public function activeAcciaDiscount(){
		//Если есть товары со скидками
		$result=[];
		$sql="select count(product_id) as count from oc_product where status=1 and discount_percent>0";
		$query = $this->db->query($sql);
		if($query->row["count"]){
			$query = $this->db->query("SELECT DISTINCT * FROM accia_sale where id=1");
			$result=$query->row;
		}
		return $result;
	}
	public function getSales($data=[]) {
		$d_now=date("Y-m-d");
		$results=[];

		if($data["select"]==1 or $data["select"]==0){
			//Активные акции
			$sql="SELECT DISTINCT * FROM accia where status=1 AND (DATE(date_start) <= '".$d_now."' or date_start is null) AND (DATE(date_end) >= '".$d_now."' or date_end is null) order by sort_order DESC";
			$query = $this->db->query($sql);
			foreach($query->rows as $row){
				$results[]=$row;
			}

			//Если есть товары со скидками
			//$sql="select count(product_id) as count from oc_product where status=1 and priceold>0";
			$sql="select count(product_id) as count from oc_product where status=1 and discount_percent>0";
			$query = $this->db->query($sql);
			if($query->row["count"]){
				//Дискаунт
				$sql="SELECT DISTINCT * FROM accia_sale where id=1";
				$query = $this->db->query($sql);
				$results[]=$query->row;
			}
		}
		if($data["select"]==2 or $data["select"]==0){
			//Закончившиеся акции
			$sql="SELECT DISTINCT * FROM accia where status=1 AND (DATE(date_start) <= '".$d_now."' or date_start is null) AND (DATE(date_end) < '".$d_now."' or date_end is null) order by sort_order DESC";
			$query = $this->db->query($sql);
			foreach($query->rows as $row){
				$results[]=$row;
			}
		}
		return $results;
		/*
		$sql_add="";
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 10;
			}

			$sql_add .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
		$sql="SELECT DISTINCT * FROM accia where status=1 ".$sql_add;

		$query = $this->db->query($sql);

		return $query->rows;
		*/
	}
	
	public function activeAccias(){
		$date_str=date("Y-m-d");
		$query = $this->db->query("SELECT accia_id,title,image,banner,shorttext FROM accia where status=1 AND (DATE(date_start) <= '".$date_str."' or date_start is null) AND (DATE(date_end) >= '".$date_str."' or date_end is null)" );
		return $query->rows;
	}
	
}