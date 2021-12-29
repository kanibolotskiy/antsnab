<?php class ControllerExtensionFeedGoogleMerchant extends Controller {
    private $from_charset = 'utf-8';
    public function index() {
        
        //header("Content-type: text/xml;charset=utf-8");
        
        //$products=$this->model_extension_feed_google_merchant->getProducts();
        $query = $this->db->query("SELECT op.product_id, op.image, om.name as man, op.price, op.quantity, od.name, od.description FROM oc_product op LEFT JOIN oc_product_description od ON op.product_id=od.product_id LEFT JOIN oc_manufacturer om ON op.manufacturer_id=om.manufacturer_id");
        $products=$query->rows;
            
        $this->load->model('tool/image');
        $items='';

        foreach($products as $product){

            if($product['quantity']>0){
                $stock='in stock';
            }else{
                $stock='out of stock';
            }
            $items.='<item>
                <g:id>'.$product['product_id'].'</g:id>
                <g:title>'.$product['name'].'</g:title>
                <g:description>'.$product['description'].'</g:description>
                <g:link>http://www.example.com/electronics/tv/22LB4510.html</g:link>
                <g:image_link>'.$product['image'].'</g:image_link>
                <g:condition>new</g:condition>
                <g:availability>'.$stock.'</g:availability>
                <g:price>'.$product['price'].' RUB</g:price>
                <g:brand>'.$product['man'].'</g:brand>
                <g:mpn>ANT-114398-nm-'.$product['product_id'].'</g:mpn>
            </item>';
        }       

        $output = '<?xml version="1.0" encoding="UTF-8"?>
        <rss xmlns:g="http://base.google.com/ns/1.0" version="2.0">
            <channel>
                <title>Ант-Снаб</title>
                <link>https://ant-snab.ru</link>
                <description>Строительные материалы</description>
                '.$items.'
            </channel>
        </rss>';

        //
        $this->response->addHeader('Content-Type: application/rss+xml;charset=utf-8');
        //$this->response->setOutput($output);
        echo $output;
    }
}
?>