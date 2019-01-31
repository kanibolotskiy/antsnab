<?php
class ModelCatalogReview extends Model {
	public function addReview($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "review SET sended=0, author = '" . $this->db->escape($data['author']) . "', product_id = '" . (int)$data['product_id'] . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = '" . $this->db->escape($data['date_added']) . "'");

		$review_id = $this->db->getLastId();

		$this->cache->delete('product');

		return $review_id;
	}

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
		/*$sql = "SELECT r.review_id, pd.name, r.author, r.rating, r.status, r.date_added FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product_description pd ON (r.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";*/

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

	public function getTotalReviewsAwaitingApproval() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review WHERE status = '0'");

		return $query->row['total'];
	}

	private function sendReview($product_id, $data)
    {
        if (in_array('review', (array) $this->config->get('config_mail_alert'))) {
            $this->load->language('mail/review');
        

            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
            $mail->smtp_username = $this->config->get('config_mail_smtp_username');
            $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
            $mail->smtp_port = $this->config->get('config_mail_smtp_port');
            $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

            //$mail->setTo($this->config->get('config_email'));
			//$mail->setTo($this->config->get('config_email_recall'));

			$mail->setTo($data['email']);
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
            
            if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
                $b_patch=$this->config->get('config_ssl').'image/';
            } else {
                $b_patch=$this->config->get('config_url').'image/';
			}
			
            
            $data["logo"]=$b_patch."catalog/image/header/logo.png";
			
			/*
            $data["data_content"][]=array("Имя клиента",$data['author']);
            $data["data_content"][]=array("Компания",$data['company']);
			$data["data_content"][]=array("Email",$data['email']);
			*/
			
            if($product_id){
				$subject = $this->language->get('text_subject_product');
				$data["caption"]=$this->language->get('text_caption_thanks');
				$review_link=HTTP_CATALOG.'index.php?route=product/product&product_id='.$product_id;
            }else{
				$subject = $this->language->get('text_subject_company');
				$data["caption"]=$this->language->get('text_caption_thanks');
				$review_page_id = 8;
				$review_link = HTTP_CATALOG.'index.php?route=information/information&information_id='.$review_page_id;
			}

			$mail->setSubject($subject);
			
		
			$data["data_text"]=sprintf($this->language->get('text_thanks'),$data["author"],$review_link);
			
			
            $report_text=$this->load->view('catalog/review_report', $data);

            $mail->setHTML($report_text);
            $mail->send();
        }
    }
}