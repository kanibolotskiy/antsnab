<?php

class ModelExtensionTotalWholesale extends Model
{

    public function getTotal($total)
    {
        $this->load->language('extension/total/wholesale');

        $wholeSaleTotalDiscount = 0 ; 
        $products = $this->cart->getProducts();
        foreach( $products as $product) {
            $quantity = $product['quantity'];
            $wholeSaleThreshold = $product['wholesale_threshold'];
            $wholeSalePrice = $product['price_wholesale'];
            $price = $product['price'];

            $wholeSaleTotalDiscount += ($quantity >= $wholeSaleThreshold)?($wholeSalePrice - $price) * $quantity:0; // <0 !
        }

        $total['totals'][] = array(
            'code' => 'wholesale',
            'title' => $this->language->get('text_total'),
            'value' => $wholeSaleTotalDiscount, 
            'sort_order' => $this->config->get('total_sort_order')
        );

        $total['total'] += $wholeSaleTotalDiscount;
    }

}
