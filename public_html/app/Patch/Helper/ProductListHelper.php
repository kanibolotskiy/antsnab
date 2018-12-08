<?php

/**
 * Class for construction product list for final categories and search page
 *
 * @version    0.1, Sep 27, 2018  5:46:34 PM
 * @author     Sergey Lapshin
 */

namespace WS\Patch\Helper;

use Phospr\Fraction;
use WS\Override\Gateway\ProdProperties;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;

class ProductListHelper extends \Model
{

    /** @const route (in OC terms) to products list template */
    const RENDER_ROUTE = 'partial/product_list';

    public function getProducts($filter_data)
    {
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        $propGateway = new ProdProperties($this->registry);

        $results = $this->model_catalog_product->getProducts($filter_data);
        $products = [];

        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
            }


            if ((float) $result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $special = false;
            }

            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
            } else {
                $tax = false;
            }

            if ($this->config->get('config_review_status')) {
                $rating = (int) $result['rating'];
            } else {
                $rating = false;
            }
            
            
            $properties = $propGateway->getPropertiesWithProductValues($result['product_id'], 'order by sortOrder ASC');
            $previewProperties = array();
            foreach ($properties as $p) {
                if ($p['showInProdPreview']) {
                    $previewProperties[] = array(
                        'name' => $p['cat_name'],
                        'val' => $p['val'],
                        'unit' => $p['cat_unit']
                    );
                }
            }

            //units
            /*
            * @task переосмыслить вместе с ProductTemplateDecorator - и вынести в отдельный метод
            */
            $produnitsGateway = new ProdUnits($this->registry);
            $produnitsCalcGateway = new ProdUnitsCalc($this->registry);
            $prodUnits = $produnitsGateway->getUnitsByProduct($result['product_id']);
            $priceUnit = null;
            $saleUnit = null;
            foreach ($prodUnits as $unit_id => $unit) {
                if ($unit['isPriceBase'] == 1 && !$priceUnit) {
                    $priceUnit = $unit;
                    //коэффициент пересчета из базовой еденицы продажи (кратности) в еденицы учета (цены)
                    $saleToPriceKoef = $produnitsCalcGateway->getBaseToUnitKoef($result['product_id'], 'isSaleBase', $unit_id);
                } elseif ($unit['isPriceBase'] == 1) {
                    throw new \Exception('Too many price bases for product ' . $result['product_id']);
                }

                if ($unit['isSaleBase'] == 1 && !$saleUnit) {
                    $saleUnit = $unit;
                } elseif ($unit['isSaleBase'] == 1) {
                    throw new \Exception('Too many sale bases for product ' . $result['product_id']);
                }
            }
            if (!$priceUnit) {
                throw new \Exception('Price base wasnt found for product ' . $result['product_id']);
            }
            if (!$saleUnit) {
                throw new \Exception('Sale base wasnt found for product ' . $result['product_id']);
            }

            //@task - сделать цена от...
            $priceUnitPrice = (float)$result['price_wholesale'];
            $saleUnitPrice = $saleToPriceKoef->multiply(Fraction::fromFloat($priceUnitPrice))->toFloat();

            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($saleUnitPrice, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $price = false;
            }
            
            $path = $this->hierarhy->getPath($result['main_category']);
            $products[] = array(
                'product_id' => $result['product_id'],
                'sale_to_price_koef' => $saleToPriceKoef,
                'sale_unit_name' => $saleUnit['name'],
                'thumb' => $image,
                'name' => $result['meta_h1'],
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                'descriptionPreview' => utf8_substr(strip_tags(html_entity_decode($result['location'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '...',
                'price' => $price,
                'special' => $special,
                'tax' => $tax,
                'minimum' => ($result['minimum'] > 0) ? $result['minimum'] : 1,
                'rating' => $rating,
                'properties' => $previewProperties,
                'href' => $this->url->link('product/product', 'path=' . $path . '&product_id=' . $result['product_id'])
            );
        }

        return $products;
    }

    public function render($products)
    {
        return $this->load->view(self::RENDER_ROUTE, ['products'=>$products]);
    }
}
