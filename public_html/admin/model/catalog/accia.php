<?php
class ModelCatalogAccia extends Model {
	public function addAccia($data) {
		$this->db->query("INSERT INTO accia SET sended=0, author = '" . $this->db->escape($data['author']) . "', product_id = '" . (int)$data['product_id'] . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = '" . $this->db->escape($data['date_added']) . "'");

		$review_id = $this->db->getLastId();

		$this->cache->delete('product');

		return $review_id;
	}
	/*
	public function getReviews($data = array()) {
        //@task to wspatch

        $sql = "SELECT r.review_id, pd.name, r.author, r.email, r.company, r.rating, r.status, r.date_added, r.about, r.moderator, r.answer FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product_description pd ON (r.product_id = pd.product_id) WHERE (pd.language_id = '" . (int)$this->config->get('config_language_id') . "' or pd.language_id is NULL)";

		if (!empty($data['filter_product'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_product']) . "%'";
		}
	*/
	
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
		$sql="SELECT od.product_id, od.name, op.sort_order, oc.category_id
		FROM oc_product op 
		LEFT JOIN oc_product_description od ON op.product_id=od.product_id
		LEFT JOIN oc_product_to_category oc ON od.product_id=oc.product_id and oc.main_category=1
		order by op.sort_order";
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function getAccias($data = array()) {
		$sql="select * from accia";
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
	public function editAccia($accia_id, $data) {
		$this->db->query("UPDATE accia SET 
		name='".$data["name"]."', 
		sort_order=".$data["sort_order"].", 
		text='".$data["text"]."', 
		shorttext='".$data["shorttext"]."', 
		shorttext='".$data["shorttext"]."', 
		image='".$data["image"]."', 
		banner='".$data["banner"]."', 
		status = '" . (int)$data['status'] . "'
		where accia_id=".$accia_id);

		if($data["accia_products_change"]){
			$this->db->query("delete from accia_products where accia_id=".$accia_id);
			if(isset($data["accia_products"])){
				$product_arr=explode(",",$data["accia_products"]);
				foreach($product_arr as $product_itm){
					$this->db->query("insert into accia_products (accia_id, product_id) values (".$accia_id.",".trim($product_itm).")");
					//echo "insert into accia_products (accia_id, product_id) values (".$accia_id.",".trim($product_itm).")";
				}
			}
		}

		//echo "accia_id=".$accia_id;
		//print_r($data);
		//$this->db->query("UPDATE " . DB_PREFIX . "review SET sended='" . $sended . "', author = '" . $this->db->escape($data['author']) . "', product_id = '" . (int)$data['product_id'] . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = '" . $this->db->escape($data['date_added']) . "', date_modified = NOW() WHERE review_id = '" . (int)$review_id . "'");
	}

	/*
    //@task - move to overrideds
    public function afterAddReview($data, $output)
    {
       $review_id = $output;
       $this->afterEditReview($review_id, $data, $output);
       return $output;
    }

    public function afterEditReview($review_id, $data, $output)
    {
        $reviewAboutField = $this->db->escape($data['about']);
        $reviewAnswerField = $this->db->escape($data['answer']);
        $reviewModeratorField = $this->db->escape($data['moderator']);
        $reviewCompanyField = $this->db->escape($data['company']);
        $reviewEmailField = $this->db->escape($data['email']);
        $this->db->query("UPDATE " . DB_PREFIX . "review SET ". 
            "about = '" . $reviewAboutField . "', ". 
            "answer = '" . $reviewAnswerField . "', ". 
            "moderator = '" . $reviewModeratorField . "', ". 
            "company = '" . $reviewCompanyField . "', ". 
            "email = '" . $reviewEmailField . "' ". 
            "where review_id = " . $review_id);

        $this->cache->delete('product');
    }


	public function editReview($review_id, $data) {
		if(isset($data['sended'])){
			$sended=$data['sended'];
		}else{
			$sended=0;
		}
		if(!$sended and $data['status']){
			$this->sendReview($data['product_id'], $data);
			$sended=1;
		}
		$this->db->query("UPDATE " . DB_PREFIX . "review SET sended='" . $sended . "', author = '" . $this->db->escape($data['author']) . "', product_id = '" . (int)$data['product_id'] . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = '" . $this->db->escape($data['date_added']) . "', date_modified = NOW() WHERE review_id = '" . (int)$review_id . "'");
		$this->cache->delete('product');
	}

	public function deleteReview($review_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE review_id = '" . (int)$review_id . "'");

		$this->cache->delete('product');
	}

	public function getReview($review_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT pd.name FROM " . DB_PREFIX . "product_description pd WHERE pd.product_id = r.product_id AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS product FROM " . DB_PREFIX . "review r WHERE r.review_id = '" . (int)$review_id . "'");

		return $query->row;
	}

	public function getReviews($data = array()) {
        //@task to wspatch

        $sql = "SELECT r.review_id, pd.name, r.author, r.email, r.company, r.rating, r.status, r.date_added, r.about, r.moderator, r.answer FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product_description pd ON (r.product_id = pd.product_id) WHERE (pd.language_id = '" . (int)$this->config->get('config_language_id') . "' or pd.language_id is NULL)";

		if (!empty($data['filter_product'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_product']) . "%'";
		}

		if (!empty($data['filter_author'])) {
			$sql .= " AND r.author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
		}

        if (!empty($data['filter_about'])) {
			$sql .= " AND r.about LIKE '" . $this->db->escape($data['filter_about']) . "%'";
		}

        if (!empty($data['filter_moderator'])) {
			$sql .= " AND r.moderator LIKE '" . $this->db->escape($data['filter_moderator']) . "%'";
		}

        if (!empty($data['moderator_author'])) {
			$sql .= " AND r.moderator LIKE '" . $this->db->escape($data['filter_moderator']) . "%'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND r.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(r.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$sort_data = array(
			'pd.name',
			'r.author',
			'r.rating',
			'r.status',
			'r.date_added'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY r.date_added";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getTotalReviews($data = array()) {
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
	}
	*/
	
}