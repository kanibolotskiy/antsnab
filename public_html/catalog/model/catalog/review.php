<?php

//@task move to wspatch (refactor all)
class ModelCatalogReview extends Model
{

    const DEFAULT_PRODUCT_ID = 0; //product_id for companys' reviews

    //@added

    private function sendReview($product_id, $data)
    {
        if (in_array('review', (array) $this->config->get('config_mail_alert'))) {
            $this->load->language('mail/review');
            $this->load->model('catalog/product');

            $product_info = $this->model_catalog_product->getProduct($product_id);

            $subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

            $message = $this->language->get('text_waiting') . "\n";
            $message .= sprintf($this->language->get('text_product'), html_entity_decode($product_info['name'], ENT_QUOTES, 'UTF-8')) . "\n";
            $message .= sprintf($this->language->get('text_reviewer'), html_entity_decode($data['name'], ENT_QUOTES, 'UTF-8')) . "\n";
            $message .= sprintf($this->language->get('text_rating'), $data['rating']) . "\n";
            $message .= $this->language->get('text_review') . "\n";
            $message .= html_entity_decode($data['text'], ENT_QUOTES, 'UTF-8') . "\n\n";

            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
            $mail->smtp_username = $this->config->get('config_mail_smtp_username');
            $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
            $mail->smtp_port = $this->config->get('config_mail_smtp_port');
            $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

            $mail->setTo($this->config->get('config_email'));
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
            $mail->setSubject($subject);
            $mail->setText($message);
            $mail->send();

            // Send to additional alert emails
            $emails = explode(',', $this->config->get('config_alert_email'));

            foreach ($emails as $email) {
                if ($email && preg_match($this->config->get('config_mail_regexp'), $email)) {
                    $mail->setTo($email);
                    $mail->send();
                }
            }
        }
    }

    public function addCompanyReview($data)
    {
        return $this->addReview(static::DEFAULT_PRODUCT_ID, $data);
    }

    public function addReview($product_id, $data)
    {
       /* $this->db->query("INSERT INTO " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['name']) . "', customer_id = '" . (int) $this->customer->getId() . "', product_id = '" . (int) $product_id . "', text = '" . $this->db->escape($data['text']) . "', rating = '" . (int) $data['rating'] . "', date_added = NOW()");*/

         $this->db->query("INSERT INTO " . DB_PREFIX . "review SET company ='" . $this->db->escape($data['company']) . "', email = '" . $this->db->escape($data['email']) . "', author = '" . $this->db->escape($data['author']) . "', customer_id = '" . (int) $this->customer->getId() . "', product_id = '" . (int) $product_id . "', text = '" . $this->db->escape($data['text']) . "', rating = '" . (int) $data['rating'] . "', date_added = NOW()");


        $review_id = $this->db->getLastId();

        //@moved to private
        $this->sendReview($product_id, $data);

        return $review_id;
    }

    //@added
    public function getCompanyReviews($start = 0, $limit = 20)
    {
        return $this->getReviewsByProductId(static::DEFAULT_PRODUCT_ID, $start, $limit);
    }

    public function getCompanyReviewsTotal()
    {
        return $this->getTotalReviewsByProductId(static::DEFAULT_PRODUCT_ID);
    }

    public function getCompanyReview($data)
    {
        $product_id = static::DEFAULT_PRODUCT_ID;
        return $this->addReview($product_id, $data);
    }

    public function getReviewsByProductId($product_id, $start = 0, $limit = 20)
    {
        if ($start < 0) {
            $start = 0;
        }

        if ($limit < 1) {
            $limit = 20;
        }

        /*         * $query = $this->db->query("SELECT r.review_id, r.author, r.rating, r.text, p.product_id, pd.name, p.price, p.image, r.date_added FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY r.date_added DESC LIMIT " . (int)$start . "," . (int)$limit); */

        $query = $this->db->query("SELECT r.review_id, r.about, r.moderator, r.answer, r.author, r.rating, r.text, p.product_id, pd.name, p.price, p.image, r.date_added FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE r.product_id = '" . (int) $product_id . "' AND (p.date_available <= NOW() or p.date_available is NULL) AND (p.status = '1' or p.status is NULL) AND r.status = '1' AND (pd.language_id = '" . (int) $this->config->get('config_language_id') . "' or pd.language_id is NULL) ORDER BY r.date_added DESC LIMIT " . (int) $start . "," . (int) $limit);

        return $query->rows;
    }

    public function getTotalReviewsByProductId($product_id)
    {
        /* $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int) $product_id . "' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1' AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "'"); */

        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE r.product_id = '" . (int) $product_id . "' AND (p.date_available <= NOW() or p.date_available is null) AND (p.status = '1' or p.status is NULL) AND r.status = '1' AND ( pd.language_id = '" . (int) $this->config->get('config_language_id') . "' or pd.language_id is NULL) ");
        return $query->row['total'];
    }

    //@task move to modules' model maybe
    public function getRandReviews($count = 2)
    {
        $result = array();
        
        $c = 0;
        $total = $this->getCompanyReviewsTotal();
        
        while( $c < $count) {
            $offset = random_int(0, $total-1);
            $query = $this->db->query("select * from " . DB_PREFIX . "review limit $offset,1" );
            $result[] = $query->row;
            $c++;
        }

        return $result;
    }

}
