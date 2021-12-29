<?php
    class ModelExtensionFeedGoogleMerchant extends Model {
        public function getProducts() {
            $query = $this->db->query("SELECT op.product_id, op.image, om.name as man, op.price, op.quantity, od.name, od.description FROM oc_product op LEFT JOIN oc_product_description od ON op.product_id=od.product_id LEFT JOIN oc_manufacturer om ON op.manufacturer_id=om.manufacturer_id");
            return $query->rows;
        }
    }
?>

