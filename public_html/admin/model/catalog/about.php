<?php
class ModelCatalogAbout extends Model {
	public function getAboutDownloads($information_id)
    {
        $information_download_data = array();

        $query = $this->db->query("SELECT * FROM dopinfo_about_to_download WHERE information_id = '" . (int) $information_id . "'");

        foreach ($query->rows as $result) {
            $information_download_data[] = $result['download_id'];
        }

        return $information_download_data;
	}
	public function getAboutSert(){
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_about_sert");
		return $query->rows;
	}
	public function getAboutCustomers(){
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_about_customers");
		return $query->rows;
	}
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
	public function editAbout($data) {
		$this->db->query("UPDATE dopinfo_about SET 
		title = '" . $this->db->escape($data['title']) . "', 
		content='" . $this->db->escape($data['content']) . "',
		meta_title='" . $this->db->escape($data['meta_title']) . "',
		meta_h1='" . $this->db->escape($data['meta_h1']) . "',
		meta_description='" . $this->db->escape($data['meta_description']) . "',
		meta_keywords='" . $this->db->escape($data['meta_keywords']) . "',
		content_cust='" . $this->db->escape($data['content_cust']) . "',
		content_man='" . $this->db->escape($data['content_man']) . "',
		content_sklad='" . $this->db->escape($data['content_sklad']) . "',
		content_off='" . $this->db->escape($data['content_off']) . "',
		content_req='" . $this->db->escape($data['content_req']) . "'
		WHERE doc_id = '1'");

		$block_about=$data['block_about'];
		//print_r($block_about);

		foreach($block_about as $key=>$block_row){
			$this->db->query("UPDATE dopinfo_about_block SET 
			caption = '" . $this->db->escape($block_row['caption']) . "', 
			text = '" . $this->db->escape($block_row['text']) . "', 
			subcaption = '" . $this->db->escape($block_row['subcaption']) . "', 
			image = '" . $this->db->escape($block_row['image']) . "' where id='".$key."' 
			");
			if($data["change_list"][$key]){
				$this->db->query("DELETE from dopinfo_about_row where block_id='".$key."'");
				if(isset($data['about_block'][$key]['list']['caption'])){
					foreach($data['about_block'][$key]['list']['caption'] as $key_list=>$itm){
	$sql="INSERT INTO dopinfo_about_row (block_id,caption,text) values ('".$key."','".$itm."','".$data['about_block'][$key]['list']['text'][$key_list]."')";
	$this->db->query($sql);
					}
				}
			}

		}
		
		foreach($data['customer'] as $key=>$customer){
			
			if($key!="new"){
				if($customer['delete']){
					if(is_numeric($key)){
						$this->db->query("DELETE from dopinfo_about_customers where id='".$key."'");
					}
				}else{
					$this->db->query("UPDATE dopinfo_about_customers SET 
						image = '" . $this->db->escape($customer['image']) . "', 
						fio = '" . $this->db->escape($customer['fio']) . "', 
						position = '" . $this->db->escape($customer['position']) . "', 
						phone = '" . $this->db->escape($customer['phone']) . "', 
						code = '" . $this->db->escape($customer['code']) . "', 
						email = '" . $this->db->escape($customer['email']) . "'
						where id='".$key."' 
					");
				}
			}else{
				foreach($customer['image'] as $key_row=>$customer_row){
					if(!$this->db->escape($customer['delete'][$key_row])){
						$sql_insert="INSERT into dopinfo_about_customers 
							(image, fio, position, phone, code,email)
							values 
							('" . $this->db->escape($customer['image'][$key_row]) . "', 
							'" . $this->db->escape($customer['fio'][$key_row]) . "', 
							'" . $this->db->escape($customer['position'][$key_row]) . "', 
							'" . $this->db->escape($customer['phone'][$key_row]) . "', 
							'" . $this->db->escape($customer['code'][$key_row]) . "', 
							'" . $this->db->escape($customer['email'][$key_row]) . "'
							)";
						$this->db->query($sql_insert);
					}
				}
			}
		}

		if(isset($data['off'])){
			foreach($data['off'] as $key=>$off){
				if($key!="new"){
					if($off['delete']){
						if(is_numeric($key)){
							$this->db->query("DELETE from dopinfo_about_off where id='".$key."'");
						}
					}else{
						$this->db->query("UPDATE dopinfo_about_off SET 
							image = '" . $this->db->escape($off['image']) . "', 
							caption = '" . $this->db->escape($off['caption']) . "', 
							video = '" . $this->db->escape($off['video']) . "'
							where id='".$key."' 
						");
					}
				}else{
					foreach($off['image'] as $key_row=>$off_row){
						if(!$this->db->escape($off['delete'][$key_row])){
							$sql_insert="INSERT into dopinfo_about_off 
								(image, caption, video)
								values 
								('" . $this->db->escape($off['image'][$key_row]) . "', 
								'" . $this->db->escape($off['caption'][$key_row]) . "', 
								'" . $this->db->escape($off['video'][$key_row]) . "'
								)";
							$this->db->query($sql_insert);
						}
					}
				}
			}
		}

		if(isset($data['man'])){
			foreach($data['man'] as $key=>$man){
				if($key!="new"){
					if($man['delete']){
						if(is_numeric($key)){
							$this->db->query("DELETE from dopinfo_about_man where id='".$key."'");
						}
					}else{
						$this->db->query("UPDATE dopinfo_about_man SET 
							image = '" . $this->db->escape($man['image']) . "', 
							caption = '" . $this->db->escape($man['caption']) . "', 
							video = '" . $this->db->escape($man['video']) . "'
							where id='".$key."' 
						");
					}
				}else{
					foreach($man['image'] as $key_row=>$man_row){
						if(!$this->db->escape($man['delete'][$key_row])){
							$sql_insert="INSERT into dopinfo_about_man 
								(image, caption, video)
								values 
								('" . $this->db->escape($man['image'][$key_row]) . "', 
								'" . $this->db->escape($man['caption'][$key_row]) . "', 
								'" . $this->db->escape($man['video'][$key_row]) . "'
								)";
							$this->db->query($sql_insert);
						}
					}
				}
			}
		}
		if(isset($data['sklad'])){
			foreach($data['sklad'] as $key=>$sklad){
				if($key!="new"){
					if($sklad['delete']){
						if(is_numeric($key)){
							$this->db->query("DELETE from dopinfo_about_sklad where id='".$key."'");
						}
					}else{
						$this->db->query("UPDATE dopinfo_about_sklad SET 
							image = '" . $this->db->escape($sklad['image']) . "', 
							caption = '" . $this->db->escape($sklad['caption']) . "', 
							video = '" . $this->db->escape($sklad['video']) . "'
							where id='".$key."' 
						");
					}
				}else{
					foreach($sklad['image'] as $key_row=>$sklad_row){
						if(!$this->db->escape($sklad['delete'][$key_row])){
							$sql_insert="INSERT into dopinfo_about_sklad 
								(image, caption, video)
								values 
								('" . $this->db->escape($sklad['image'][$key_row]) . "', 
								'" . $this->db->escape($sklad['caption'][$key_row]) . "', 
								'" . $this->db->escape($sklad['video'][$key_row]) . "'
								)";
							$this->db->query($sql_insert);
						}
					}
				}
			}
		}

		if(isset($data['sert'])){
			foreach($data['sert'] as $key=>$sert){
				if($key!="new"){
					if($sert['delete']){
						if(is_numeric($key)){
							$this->db->query("DELETE from dopinfo_about_sert where id='".$key."'");
						}
					}else{
						$this->db->query("UPDATE dopinfo_about_sert SET 
							image = '" . $this->db->escape($sert['image']) . "', 
							caption = '" . $this->db->escape($sert['caption']) . "'
							where id='".$key."' 
						");
					}
				}else{
					foreach($sert['image'] as $key_row=>$sert_row){
						if(!$this->db->escape($sert['delete'][$key_row])){
							$sql_insert="INSERT into dopinfo_about_sert 
								(image, caption)
								values 
								('" . $this->db->escape($sert['image'][$key_row]) . "', 
								'" . $this->db->escape($sert['caption'][$key_row]) . "'
								)";
							$this->db->query($sql_insert);
						}
					}
				}
			}
		}


		$this->db->query("DELETE FROM dopinfo_about_to_download WHERE information_id = '1'");
		
        if (isset($data['information_download'])) {	
            foreach ($data['information_download'] as $download_id) {
                $this->db->query("INSERT INTO dopinfo_about_to_download SET 
				information_id = '1', 
				download_id = '" . (int) $download_id . "'");
            }
		}
		

	}
	public function getAboutBlock(){
		$results=[];
		$query = $this->db->query("SELECT DISTINCT * from dopinfo_about_block");
		foreach ($query->rows as $result) {
			$query_list = $this->db->query("SELECT DISTINCT * from dopinfo_about_row WHERE block_id = '".$result['id']."'");
			$results[$result['id']]['data']=$result;
			$results[$result['id']]['list']=$query_list->rows;
		}
		return $results;
	  }

}
