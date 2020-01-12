<?php
class ModelCatalogProduct extends Model {
	public function updateViewed($product_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "product SET viewed = (viewed + 1) WHERE product_id = '" . (int)$product_id . "'");
	}
	public function getProductLabels($product){
		//print_r($product);

		//Скидка
		$labels=[];
		if($product['price_wholesaleold']*1){
			$priceold = number_format($product['price_wholesaleold'],0,"."," ");
			$discount_label = (int)(($product['price_wholesale']/$product['price_wholesaleold']-1)*100);
			$labels["_discount"]=Array(
				"label"=>$discount_label."%",
				"title"=>"Сегодня этот товар продается со скидкой"
			);
		}

		//Акция

		//Новинка
		$datediff=time()-strtotime($product['date_added']);
		$limit=15724800; //60*60*24*182 //182 дня (пол года)
		if($datediff<$limit){
			$labels["_new"]=Array(
				"label"=>"New",
				"title"=>"Новый товар в каталоге"
			);
		}

		//Хит
		$sql="SELECT op.product_id FROM oc_product_to_category oc inner join oc_product op ON oc.product_id=op.product_id
		where category_id=(select category_id from oc_product_to_category where product_id='".$product["product_id"]."' and main_category=1)
		order by op.viewed DESC limit 3";
		$query = $this->db->query($sql);
		$product_hit=[];
		foreach ($query->rows as $result) {
			$product_hit[]=$result["product_id"];
		}
		if(in_array($product['product_id'], $product_hit)){
			$labels["_hit"]=Array(
				"label"=>"Хит",
				"title"=>"Хит продаж в категории товаров"
			);
		}

		return $labels;
		
	}
	public function getProductsPopular(){
		$start_cats=[264,263,265,354];
		//$start_cats=[263];
		$product_result=[];
		foreach($start_cats as $start_cat){
			$products=[];
			$sql="select category_id from oc_category where isseo=0 and parent_id=".$start_cat;
			$query = $this->db->query($sql);
			$subcats=[];
			foreach ($query->rows as $result_s) {
				$subcats[]=$result_s["category_id"];
			}

			if($subcats){
				$sql="select category_id from oc_category where isseo=0 and parent_id in ".implode(",",$subcats);
				$subcats_childs=[];
				foreach ($query->rows as $result_sub) {
					$subcats_childs[]=$result_sub["category_id"];
				}
				if($subcats_childs){
					$sql_product="select op.product_id,(SELECT AVG(rating) AS total FROM oc_review r1 WHERE r1.product_id = op.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating from oc_product op INNER JOIN oc_product_to_category oc ON op.product_id=oc.product_id where oc.category_id in (".implode(",",$subcats_childs).") order by rating desc limit 5";
					$query_product = $this->db->query($sql_product);
					if ($query_product->num_rows) {
						foreach ($query_product->rows as $result_product) {
							$products[]=$result_product["product_id"];
						}
					}
				}
				$k = array_rand($products);
				$product_result[] = $products[$k];
			}

		}
		//print_r($product_result);

		//$products=[838,839];
		return $product_result;
	}
	public function getProduct($product_id) {
		$query = $this->db->query("SELECT DISTINCT *,"

            /** @task move to override */
            ."p2c.category_id as main_category, "
            
            ."pd.name AS name, p.image, (SELECT md.name FROM " . DB_PREFIX . "manufacturer_description md WHERE md.manufacturer_id = p.manufacturer_id AND md.language_id = '" . (int)$this->config->get('config_language_id') . "') AS manufacturer, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special, (SELECT points FROM " . DB_PREFIX . "product_reward pr WHERE pr.product_id = p.product_id AND customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "') AS reward, (SELECT ss.name FROM " . DB_PREFIX . "stock_status ss WHERE ss.stock_status_id = p.stock_status_id AND ss.language_id = '" . (int)$this->config->get('config_language_id') . "') AS stock_status, (SELECT wcd.unit FROM " . DB_PREFIX . "weight_class_description wcd WHERE p.weight_class_id = wcd.weight_class_id AND wcd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS weight_class, (SELECT lcd.unit FROM " . DB_PREFIX . "length_class_description lcd WHERE p.length_class_id = lcd.length_class_id AND lcd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS length_class, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r2 WHERE r2.product_id = p.product_id AND r2.status = '1' GROUP BY r2.product_id) AS reviews, p.sort_order FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) "

            /** @task move to override */
            ."LEFT JOIN " . DB_PREFIX . "product_to_category as p2c on p2c.product_id=p.product_id and p2c.main_category = 1 "
            
            ."WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");
        
		if ($query->num_rows) {

			return array(
				'product_id'       => $query->row['product_id'],
				'name'             => $query->row['name'],
				'description'      => $query->row['description'],

                //@task move to override
                'description_mini' => $query->row['description_mini'],
                'produnit_template_id' => $query->row['produnit_template_id'],
                'price_wholesale' => $query->row['price_wholesale'],
                'wholesale_threshold' => $query->row['wholesale_threshold'],
                'main_category' => $query->row['main_category'],
                //

				'meta_title'       => $query->row['meta_title'],
				'meta_h1'          => $query->row['meta_h1'],
				'meta_description' => $query->row['meta_description'],
				'meta_keyword'     => $query->row['meta_keyword'],
				'tag'              => $query->row['tag'],
				'video'            => $query->row['video'],
				'model'            => $query->row['model'],
				'sku'              => $query->row['sku'],
				'upc'              => $query->row['upc'],
				'ean'              => $query->row['ean'],
				'jan'              => $query->row['jan'],
				'isbn'             => $query->row['isbn'],
				'mpn'              => $query->row['mpn'],
				'location'         => $query->row['location'],
				'quantity'         => $query->row['quantity'],
				'stock_status'     => $query->row['stock_status'],
				'image'            => $query->row['image'],
				'manufacturer_id'  => $query->row['manufacturer_id'],
				'manufacturer'     => $query->row['manufacturer'],
				'price'            => ($query->row['discount'] ? $query->row['discount'] : $query->row['price']),
				'special'          => $query->row['special'],
				'reward'           => $query->row['reward'],
				'points'           => $query->row['points'],
				'tax_class_id'     => $query->row['tax_class_id'],
				'date_available'   => $query->row['date_available'],
				'weight'           => $query->row['weight'],
				'weight_class_id'  => $query->row['weight_class_id'],
				'length'           => $query->row['length'],
				'width'            => $query->row['width'],
				'height'           => $query->row['height'],
				'length_class_id'  => $query->row['length_class_id'],
				'subtract'         => $query->row['subtract'],
				'rating'           => round($query->row['rating'],1),
				'reviews'          => $query->row['reviews'] ? $query->row['reviews'] : 0,
				'minimum'          => $query->row['minimum'],
				'sort_order'       => $query->row['sort_order'],
				'status'           => $query->row['status'],
				'date_added'       => $query->row['date_added'],
				'date_modified'    => $query->row['date_modified'],
				'viewed'           => $query->row['viewed'],
				'mincount'         => $query->row['mincount'],
				'calc'	   		   => $query->row['calc'],
				'consumption'	   => $query->row['consumption'],
				'calc_data1'	   => $query->row['calc_data1'],
				'calc_data2'	   => $query->row['calc_data2'],
				'calc_data3'	   => $query->row['calc_data3'],
				'calc_data4'	   => $query->row['calc_data4'],

				'priceold'     			=> $query->row['priceold'],
				'price_wholesaleold'	=> $query->row['price_wholesaleold'],
			);
		} else {
			return false;
		}
	}
	
	public function getProducts($data = array()) {

		$sql = "SELECT DISTINCT p.product_id, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";

		if (!empty($data['filter_category_id'])) {
			if (!empty($data['filter_sub_category'])) {
				$sql .= " FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (cp.category_id = p2c.category_id)";
			} else {
				$sql .= " FROM " . DB_PREFIX . "product_to_category p2c";
			}

			if (!empty($data['filter_filter'])) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id) LEFT JOIN " . DB_PREFIX . "product p ON (pf.product_id = p.product_id)";
			} else {
				$sql .= " LEFT JOIN " . DB_PREFIX . "product p ON (p2c.product_id = p.product_id)";
			}
		} else {
			$sql .= " FROM " . DB_PREFIX . "product p";
		}

		$sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

		if (!empty($data['filter_category_id'])) {
			if (!empty($data['filter_sub_category'])) {
				$sql .= " AND cp.path_id = '" . (int)$data['filter_category_id'] . "'";
			} else {
				$sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
			}

			if (!empty($data['filter_filter'])) {
				$implode = array();

				$filters = explode(',', $data['filter_filter']);

				foreach ($filters as $filter_id) {
					$implode[] = (int)$filter_id;
				}

				$sql .= " AND pf.filter_id IN (" . implode(',', $implode) . ")";
			}
			$sql .= " AND p2c.main_category=1 ";

		}

		if (!empty($data['filter_name']) || !empty($data['filter_tag'])) {
			$sql .= " AND (";

			if (!empty($data['filter_name'])) {
				$implode = array();

				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_name'])));

				foreach ($words as $word) {
					$implode[] = "pd.name LIKE '%" . $this->db->escape($word) . "%'";
				}

				if ($implode) {
					$sql .= " " . implode(" AND ", $implode) . "";
				}

				if (!empty($data['filter_description'])) {
					$sql .= " OR pd.description LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
				}
			}

			if (!empty($data['filter_name']) && !empty($data['filter_tag'])) {
				$sql .= " OR ";
			}

			if (!empty($data['filter_tag'])) {
				$implode = array();

				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_tag'])));

				foreach ($words as $word) {
					$implode[] = "pd.tag LIKE '%" . $this->db->escape($word) . "%'";
				}

				if ($implode) {
					$sql .= " " . implode(" AND ", $implode) . "";
				}
			}

			if (!empty($data['filter_name'])) {
				$sql .= " OR LCASE(p.model) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                /** @task move to override */
                $sql .= " OR LCASE(pd.meta_h1) like '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
				$sql .= " OR LCASE(p.sku) like '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
				$sql .= " OR LCASE(p.upc) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
				$sql .= " OR LCASE(p.ean) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
				$sql .= " OR LCASE(p.jan) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
				$sql .= " OR LCASE(p.isbn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
				$sql .= " OR LCASE(p.mpn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
			}

			$sql .= ")";
		}

		if (!empty($data['filter_manufacturer_id'])) {
			$sql .= " AND p.manufacturer_id = '" . (int)$data['filter_manufacturer_id'] . "'";
		}
		
		if (!empty($data['product_ids'])) {
			$sql .= " AND p.product_id in (" . $data['product_ids'] . ")";
		}

		$sql .= " GROUP BY p.product_id";

		$sort_data = array(
			'pd.name',
			'p.model',
			'p.quantity',
			'p.price',
			'rating',
			'p.sort_order',
			'p.date_added'
		);
		//echo "!".$data['sort']."!".$data['order']."!";

		$sort_by=' p.sort_order';
		$sort_dir=' ASC';
		if(isset($data['sort']) && isset($data['order'])){

			//&& (isset($data['order']))

			if($data['sort']=="name"){
				$sort_by=" LCASE(pd.name)";
			}
			if($data['sort']=="price"){
				$sort_by=" p.price";
			}
			if($data['sort']=="ids"){
				$sort_by="FIELD(p.product_id, ".$data['product_ids'].")";
			}
			if($data['sort']=="viewed"){
				$sort_by=" p.viewed";
			}
			

			if($data['order']=="DESC"){
				$sort_dir = " DESC";
			}
			if($data['order']=="ids"){
				$sort_dir = "";
			}
		}
		$sql .= " ORDER BY ".$sort_by.$sort_dir;
		
		/*
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
				$sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
			} elseif ($data['sort'] == 'p.price') {
				$sql .= " ORDER BY (CASE WHEN special IS NOT NULL THEN special WHEN discount IS NOT NULL THEN discount ELSE p.price END)";
			} else {
				$sql .= " ORDER BY " . $data['sort'];
			}
		} else {
			$sql .= " ORDER BY p.sort_order";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC, LCASE(pd.name) DESC";
		} else {
			$sql .= " ASC, LCASE(pd.name) ASC";
		}
		*/
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
		
		$product_data = array();

		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$product_data[$result['product_id']] = $this->getProduct($result['product_id']);
		}

		return $product_data;
	}

	public function getProductSpecials($data = array()) {
		$sql = "SELECT DISTINCT ps.product_id, (SELECT AVG(rating) FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = ps.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating FROM " . DB_PREFIX . "product_special ps LEFT JOIN " . DB_PREFIX . "product p ON (ps.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) GROUP BY ps.product_id";

		$sort_data = array(
			'pd.name',
			'p.model',
			'ps.price',
			'rating',
			'p.sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
				$sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
			} else {
				$sql .= " ORDER BY " . $data['sort'];
			}
		} else {
			$sql .= " ORDER BY p.sort_order";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC, LCASE(pd.name) DESC";
		} else {
			$sql .= " ASC, LCASE(pd.name) ASC";
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
		
		$product_data = array();

		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$product_data[$result['product_id']] = $this->getProduct($result['product_id']);
		}

		return $product_data;
	}

	public function getLatestProducts($limit) {
		$product_data = $this->cache->get('product.latest.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . (int)$limit);

		if (!$product_data) {
			$query = $this->db->query("SELECT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY p.date_added DESC LIMIT " . (int)$limit);

			foreach ($query->rows as $result) {
				$product_data[$result['product_id']] = $this->getProduct($result['product_id']);
			}

			$this->cache->set('product.latest.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . (int)$limit, $product_data);
		}

		return $product_data;
	}

	public function getPopularProducts($limit) {
		$product_data = $this->cache->get('product.popular.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . (int)$limit);

		if (!$product_data) {
			$query = $this->db->query("SELECT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY p.viewed DESC, p.date_added DESC LIMIT " . (int)$limit);

			foreach ($query->rows as $result) {
				$product_data[$result['product_id']] = $this->getProduct($result['product_id']);
			}

			$this->cache->set('product.popular.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . (int)$limit, $product_data);
		}

		return $product_data;
	}

	public function getBestSellerProducts($limit) {
		$product_data = $this->cache->get('product.bestseller.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . (int)$limit);

		if (!$product_data) {
			$product_data = array();

			$query = $this->db->query("SELECT op.product_id, SUM(op.quantity) AS total FROM " . DB_PREFIX . "order_product op LEFT JOIN `" . DB_PREFIX . "order` o ON (op.order_id = o.order_id) LEFT JOIN `" . DB_PREFIX . "product` p ON (op.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE o.order_status_id > '0' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' GROUP BY op.product_id ORDER BY total DESC LIMIT " . (int)$limit);

			foreach ($query->rows as $result) {
				$product_data[$result['product_id']] = $this->getProduct($result['product_id']);
			}

			$this->cache->set('product.bestseller.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . (int)$limit, $product_data);
		}

		return $product_data;
	}

	public function getProductAttributes($product_id) {
		$product_attribute_group_data = array();

		$product_attribute_group_query = $this->db->query("SELECT ag.attribute_group_id, agd.name FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_group ag ON (a.attribute_group_id = ag.attribute_group_id) LEFT JOIN " . DB_PREFIX . "attribute_group_description agd ON (ag.attribute_group_id = agd.attribute_group_id) WHERE pa.product_id = '" . (int)$product_id . "' AND agd.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY ag.attribute_group_id ORDER BY ag.sort_order, agd.name");

		foreach ($product_attribute_group_query->rows as $product_attribute_group) {
			$product_attribute_data = array();

			$product_attribute_query = $this->db->query("SELECT a.attribute_id, ad.name, pa.text FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE pa.product_id = '" . (int)$product_id . "' AND a.attribute_group_id = '" . (int)$product_attribute_group['attribute_group_id'] . "' AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "' AND pa.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY a.sort_order, ad.name");

			foreach ($product_attribute_query->rows as $product_attribute) {
				$product_attribute_data[] = array(
					'attribute_id' => $product_attribute['attribute_id'],
					'name'         => $product_attribute['name'],
					'text'         => $product_attribute['text']
				);
			}

			$product_attribute_group_data[] = array(
				'attribute_group_id' => $product_attribute_group['attribute_group_id'],
				'name'               => $product_attribute_group['name'],
				'attribute'          => $product_attribute_data
			);
		}

		return $product_attribute_group_data;
	}

	public function getProductOptions($product_id) {
		$product_option_data = array();

		$product_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY o.sort_order");

		foreach ($product_option_query->rows as $product_option) {
			$product_option_value_data = array();

			$product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_id = '" . (int)$product_id . "' AND pov.product_option_id = '" . (int)$product_option['product_option_id'] . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY ov.sort_order");

			foreach ($product_option_value_query->rows as $product_option_value) {
				$product_option_value_data[] = array(
					'product_option_value_id' => $product_option_value['product_option_value_id'],
					'option_value_id'         => $product_option_value['option_value_id'],
					'name'                    => $product_option_value['name'],
					'image'                   => $product_option_value['image'],
					'quantity'                => $product_option_value['quantity'],
					'subtract'                => $product_option_value['subtract'],
					'price'                   => $product_option_value['price'],
					'price_prefix'            => $product_option_value['price_prefix'],
					'weight'                  => $product_option_value['weight'],
					'weight_prefix'           => $product_option_value['weight_prefix']
				);
			}

			$product_option_data[] = array(
				'product_option_id'    => $product_option['product_option_id'],
				'product_option_value' => $product_option_value_data,
				'option_id'            => $product_option['option_id'],
				'name'                 => $product_option['name'],
				'type'                 => $product_option['type'],
				'value'                => $product_option['value'],
				'required'             => $product_option['required']
			);
		}

		return $product_option_data;
	}

	public function getProductDiscounts($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND quantity > 1 AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity ASC, priority ASC, price ASC");

		return $query->rows;
	}

	public function getProductImages($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "' ORDER BY sort_order ASC");

		return $query->rows;
	}

	public function getProductRelated($product_ids, $rand=false,$limit=0,$table,$exclude_ids='') {
		$product_data = array();
		$order_rand="";
		if($rand){
			$order_rand="ORDER BY RAND() LIMIT ".$limit;
		}
		$exclude_sql="";
		if($exclude_ids){
			$exclude_sql=" AND p.product_id NOT IN (".$exclude_ids.")";
		}
		$query = $this->db->query("SELECT related_id FROM " . DB_PREFIX .$table. " pr LEFT JOIN " . DB_PREFIX . "product p ON (pr.related_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pr.product_id in (" . $product_ids . ") ".$exclude_sql." AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' group by related_id ".$order_rand);

		foreach ($query->rows as $result) {
			$product_data[$result['related_id']] = $this->getProduct($result['related_id']);
		}
		return $product_data;
	}

	public function getProductLayoutId($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");

		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return 0;
		}
	}

	public function getCategories($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");

		return $query->rows;
	}
	

	public function getTotalProducts($data = array()) {
		$sql = "SELECT COUNT(DISTINCT p.product_id) AS total";

		if (!empty($data['filter_category_id'])) {
			if (!empty($data['filter_sub_category'])) {
				$sql .= " FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (cp.category_id = p2c.category_id)";
			} else {
				$sql .= " FROM " . DB_PREFIX . "product_to_category p2c";
			}

			if (!empty($data['filter_filter'])) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id) LEFT JOIN " . DB_PREFIX . "product p ON (pf.product_id = p.product_id)";
			} else {
				$sql .= " LEFT JOIN " . DB_PREFIX . "product p ON (p2c.product_id = p.product_id)";
			}
		} else {
			$sql .= " FROM " . DB_PREFIX . "product p";
		}

		$sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

		if (!empty($data['filter_category_id'])) {
			if (!empty($data['filter_sub_category'])) {
				$sql .= " AND cp.path_id = '" . (int)$data['filter_category_id'] . "'";
			} else {
				$sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
			}

			if (!empty($data['filter_filter'])) {
				$implode = array();

				$filters = explode(',', $data['filter_filter']);

				foreach ($filters as $filter_id) {
					$implode[] = (int)$filter_id;
				}

				$sql .= " AND pf.filter_id IN (" . implode(',', $implode) . ")";
			}
		}

		if (!empty($data['filter_name']) || !empty($data['filter_tag'])) {
			$sql .= " AND (";


			if (!empty($data['filter_name'])) {
				$implode = array();

				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_name'])));

				foreach ($words as $word) {
					$implode[] = "pd.name LIKE '%" . $this->db->escape($word) . "%'";
				}

				if ($implode) {
					$sql .= " " . implode(" AND ", $implode) . "";
				}

				if (!empty($data['filter_description'])) {
					$sql .= " OR pd.description LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
				}
			}

			if (!empty($data['filter_name']) && !empty($data['filter_tag'])) {
				$sql .= " OR ";
			}

			if (!empty($data['filter_tag'])) {
				$implode = array();

				$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_tag'])));

				foreach ($words as $word) {
					$implode[] = "pd.tag LIKE '%" . $this->db->escape($word) . "%'";
				}

				if ($implode) {
					$sql .= " " . implode(" AND ", $implode) . "";
				}
			}

			if (!empty($data['filter_name'])) {
				$sql .= " OR LCASE(p.model) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
				/** @tas move to override */
                $sql .= " OR LCASE(pd.meta_h1) like '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
				$sql .= " OR LCASE(p.sku)  like '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
				$sql .= " OR LCASE(p.upc) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
				$sql .= " OR LCASE(p.ean) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
				$sql .= " OR LCASE(p.jan) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
				$sql .= " OR LCASE(p.isbn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
				$sql .= " OR LCASE(p.mpn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
			}

			$sql .= ")";
		}

		if (!empty($data['filter_manufacturer_id'])) {
			$sql .= " AND p.manufacturer_id = '" . (int)$data['filter_manufacturer_id'] . "'";
		}
		if (!empty($data['product_ids'])) {
			$sql .= " AND p.product_id in (" . $data['product_ids'] . ")";
		}
		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getProfile($product_id, $recurring_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "recurring r JOIN " . DB_PREFIX . "product_recurring pr ON (pr.recurring_id = r.recurring_id AND pr.product_id = '" . (int)$product_id . "') WHERE pr.recurring_id = '" . (int)$recurring_id . "' AND status = '1' AND pr.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "'");

		return $query->row;
	}

	public function getProfiles($product_id) {
		$query = $this->db->query("SELECT rd.* FROM " . DB_PREFIX . "product_recurring pr JOIN " . DB_PREFIX . "recurring_description rd ON (rd.language_id = " . (int)$this->config->get('config_language_id') . " AND rd.recurring_id = pr.recurring_id) JOIN " . DB_PREFIX . "recurring r ON r.recurring_id = rd.recurring_id WHERE pr.product_id = " . (int)$product_id . " AND status = '1' AND pr.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' ORDER BY sort_order ASC");

		return $query->rows;
	}

	public function getTotalProductSpecials() {
		$query = $this->db->query("SELECT COUNT(DISTINCT ps.product_id) AS total FROM " . DB_PREFIX . "product_special ps LEFT JOIN " . DB_PREFIX . "product p ON (ps.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))");

		if (isset($query->row['total'])) {
			return $query->row['total'];
		} else {
			return 0;
		}
	}
	public function getProductBenefits($product_id) {
		$query = $this->db->query("SELECT dbp.product_id,db.benefit_id,db.name,db.description,db.goal,db.filename FROM `dopinfo_benefits_to_product` dbp left join dopinfo_benefits db ON dbp.benefit_id=db.benefit_id WHERE dbp.product_id=" . (int)$product_id ." order by sort_order");
		$benefits_product=$query->rows;
		
		if(count($benefits_product)){
			return $benefits_product;
		}else{
			$query_cat = $this->db->query("SELECT category_id from " . DB_PREFIX . "product_to_category where main_category=1 AND product_id=" . (int)$product_id." LIMIT 1");
			$cat_id=$query_cat->row["category_id"];
			
			$query = $this->db->query("SELECT dbp.product_id,db.benefit_id,db.name,db.description,db.goal,db.filename FROM `dopinfo_benefits_to_product` dbp left join dopinfo_benefits db ON dbp.benefit_id=db.benefit_id WHERE dbp.product_id=" . (int)$cat_id ." order by sort_order");

			return $query->rows;
		}
		
	}

	public function getDeliveryDocs(){
		$query = $this->db->query("SELECT * FROM `dopinfo_couriers` order by weight");

		foreach ($query->rows as $result) {
			$delivery_weights[$result['weight']]=Array(
				$result['price'],
				$result['caption'],
				$result['description'],
				$result['weight'],
				$result['name'],
				$result['price_ico']
			);
		}
		
		return $delivery_weights;
	}
	public function isDayWork($date_str){
		$query = $this->db->query("SELECT state FROM dayworks WHERE date='".$date_str."'");
		if(count($query->rows)){
			$iswork=$query->row['state'];
		}else{
			$iswork=file_get_contents ("https://isdayoff.ru/".$date_str);
			//echo "INSERT INTO dayworks (date,state) values ('".$date_str."','".$iswork."')";
			$this->db->query("INSERT INTO dayworks (date,state) values ('".$date_str."','".$iswork."')");
		}
		//print_r(count($query->rows));
		return $iswork;
	}
	public function getDeliveryPrice($weight_product){
		$delivery_weights=$this->getDeliveryDocs();
		$delivery_weights_rev=array_reverse($delivery_weights,true);
		$del_price=0;
		foreach($delivery_weights_rev as $del_weight=>$key){
			if($weight_product<=$del_weight){
				$del_price=$key[0];
			}
		}
		return $del_price;

	}
	public function getDelivery($product_id, $weight_product){
		$result=[];
		/**Стоимость и сроки доставки */
		$array_week=Array("в воскресенье","в понедельник","во вторник","в среду","в четверг","в пятницу","в субботу");

		$delivery_weights=$this->getDeliveryDocs();
		

		$delivery_weights_rev=array_reverse($delivery_weights,true);
		$del_price="";
		$del_caption="";
		$del_text="";
		$del_ico="";
		
		$product=$this->getProduct($product_id);

		$delday_text='';
		if($product['quantity']>0){
			foreach($delivery_weights_rev as $del_weight=>$key){
				if($weight_product<=$del_weight){
					$del_price=$key[0];
					$del_caption=$key[1];
					$del_text=$key[2];
					$del_ico=$key[5];
				}
			}
			$date_str=date("Ymd");
			$iswork=$this->isDayWork($date_str);
			$date_week = date('w');
			$hours=date("H");
			$days=0;
			
			if(!$iswork and $hours<14){
				$delday_text="сегодня";
			}else{
				$days=0;
				$end = date('Ymd', strtotime('+'.($days+1).' days'));
				$date_week = date('w', strtotime('+'.($days+1).' days'));
				$iswork=$this->isDayWork($end);

				while($iswork){
					$end = date('Ymd', strtotime('+'.($days+1).' days'));
					$date_week = date('w', strtotime('+'.($days+1).' days'));
					$iswork=$this->isDayWork($end);
					
					$days++;
				}
				if($days==0){
					$delday_text="завтра";
				}else{
					$delday_text=$array_week[$date_week];
				}
			}
		}else{
			$doc_data=$this->getDocsData(1);

			$delday_text='1-3 дня';
			$del_price='по запросу';
			
			$del_caption=$doc_data['name'];
			
			$del_text=$doc_data['description'];
			
		}
		$result['date_delivery']=$delday_text;
		$result['price_delivery']=$del_price.($del_ico?' <div class="rur">i</div>':'');
		$result['caption_delivery']=$del_caption;
		$result['text_delivery']=$del_text;
		

		//return '<span class="nowrap">'.$delday_text.',</span> <span class="nowrap">'.$del_price.'</span>';
		return $result;
	}
	public function getDocsData($doc_id){
		$query = $this->db->query("SELECT * from dopinfo_docs where doc_id='". (int)$doc_id."'");
		return $query->row;
	}
	public function getDiscountData($doc_id){
		$query = $this->db->query("SELECT * from dopinfo_discounts where discount_id='". (int)$doc_id."'");
		return $query->row;
	}
	

	public function showDiscountProduct($product_id){

		$query = $this->db->query("SELECT discount from " . DB_PREFIX . "product where product_id='". (int)$product_id."'");
		$showDiscountProduct=$query->row['discount'];
		
		
		if($showDiscountProduct==0){
			$query_cat = $this->db->query("SELECT category_id from " . DB_PREFIX . "product_to_category where main_category=1 AND product_id=" . (int)$product_id." LIMIT 1");
			$cat_id=$query_cat->row["category_id"];
			
			$query = $this->db->query("SELECT discount FROM " . DB_PREFIX . "category where category_id='".(int)$cat_id."'");
			$showDiscountProduct=$query->row['discount'];
		
		}
		
		return $showDiscountProduct;
	}

	public function sendMailOpt($data_post)
    {
		
		$this->load->language('extension/module/productform');
		$data=[];
		$data["logo"]= $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');

		
		//$this->load->model('checkout/order');
		
		$data["caption"]=$this->language->get('text_caption');
		$subject=$this->language->get('text_subject');
		
		/*
		$data["data_content"][]=array("Имя клиента",$data_post['name']);
		$data["data_content"][]=array("Организация",$data_post['company']);
		$data["data_content"][]=array("Телефон",$data_post['phone']);
		$data["data_content"][]=array("Email",$data_post['email']);
		$data["data_content"][]=array("Сайт",$data_post['site']);
		$data["data_content"][]=array("Дата события",date("d.m.Y H:i"));
		*/
		$data_post['time']=date("d.m.Y H:i");
		
		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
		
		
		$mail->setTo($this->config->get('config_email_opt'));


		if ($_FILES['download']['error'] <= 0 ){ // success, no error
			
			$uploaddir = 'uploads/';
			
			$file_name=basename($_FILES['download']['name']);
			
			$uploadfile = $uploaddir . $file_name;
			if (move_uploaded_file($_FILES['download']['tmp_name'], $uploadfile)) {
				$mail->addAttachment($uploadfile,$file_name);
				$data["data_content"][]=array("Реквизиты",$file_name);
			}
			
		}
		//$message = $this->load->view('extension/call_report', $data);
		$message = $this->load->view('extension/call_report_txt', $data_post);


		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
		$mail->setSubject($subject);
		//$mail->setHTML($message);
		$mail->setText($message);

		$mail->send();
		unlink($uploadfile);
	}

	public function sendMailOne($data_post)
    {
		
		$this->load->language('extension/module/productform');
		$data=[];
		$data["logos"]= $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
		
		//$data_post['time']=date("d.m.Y H:i");
		$data["caption"]=$this->language->get('text_caption_one');



		//$data["data_content"][]=array("Имя клиента",$data_post['name']);
		//$data["data_content"][]=array("Организация",$data_post['company']);

		$data["data_content"][]=array("Телефон",$data_post['phone']);
		$data["data_content"][]=array("Товар",$data_post['product']);
		$data["data_content"][]=array("Дата события",date("d.m.Y H:i"));

		/**UTM метки */
		$this->load->model('module/referrer');
		$contact_data_referrer=$this->model_module_referrer->getContactsReferrer();

		
		$data["data_utm"][]=Array('utm_source',isset($contact_data_referrer['utm_source'])?$contact_data_referrer['utm_source']:"");

		$data["data_utm"][]=Array('utm_medium',isset($contact_data_referrer['utm_medium'])?$contact_data_referrer['utm_medium']:"");
		$data["data_utm"][]=Array('utm_campaign',isset($contact_data_referrer['utm_campaign'])?$contact_data_referrer['utm_campaign']:"");
		$data["data_utm"][]=Array('utm_content',isset($contact_data_referrer['utm_content'])?$contact_data_referrer['utm_content']:"");
		$data["data_utm"][]=Array('utm_term',isset($contact_data_referrer['utm_term'])?$contact_data_referrer['utm_term']:"");
		
		$subject=$this->language->get('text_subject_one');
		
		
		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
		
		
		$mail->setTo($this->config->get('config_email_one'));
		
		$message = $this->load->view('extension/one_report', $data);
		//$message="ok";

		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
		$mail->setSubject($subject);
		$mail->setHTML($message);
		//$mail->setText($message);

		$mail->send();
		/**/
		
	}
	

}
