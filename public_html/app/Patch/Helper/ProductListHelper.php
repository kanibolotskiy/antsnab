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

    public function getProducts($filter_data)
    {
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        $propGateway = new ProdProperties($this->registry);

        $results = $this->model_catalog_product->getProducts($filter_data);
        $products = [];

        foreach ($results as $result) {
            if ($result['image']) {
                //$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
                //$image ='';
                $image = $this->model_tool_image->myResize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'),1);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
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
                        'val' => htmlspecialchars_decode($p['val'],ENT_QUOTES),
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
            $uiUnit = null;
            $unitErrors = [];

            $priceUnitAr = QueryHelper::arrayWhere($prodUnits, 'isPriceBase', 1);
            $saleUnitAr = QueryHelper::arrayWhere($prodUnits, 'isSaleBase', 1);
            $uiUnitAr = QueryHelper::arrayWhere($prodUnits, 'switchSortOrder', 1);

            if( count($priceUnitAr) != 1) {
                $unitErrors[] = "There is must be exactly one price unit set for product. Nothing given or ambiguous";
            }

            if( count($saleUnitAr) != 1) {
                $unitErrors[] = "There is must be exactly one sale unit set for product. Nothing given or ambiguous";
            }

            $saleToPriceKoef = null;
            $saleToUiKoef = null;
            $tax = null;
            if( !$unitErrors ) {
                if (count($uiUnitAr) == 0 ) {
                    $uiUnit = array_shift($saleUnitAr);
                } else {
                    $uiUnit = array_shift($uiUnitAr);
                }
                $saleUnit = array_shift($saleUnitAr);
                $priceUnit = array_shift($priceUnitAr);

                $saleToPriceKoef = $produnitsCalcGateway->getBaseToUnitKoef($result['product_id'], 
                    'isSaleBase', $priceUnit['unit_id']);
                $saleToUiKoef = $produnitsCalcGateway->getBaseToUnitKoef($result['product_id'], 
                'isSaleBase', $uiUnit['unit_id']);

                //forceStepsByOne - шаг кратности всегда =1
                //например, продаем в рулонах (saleUnit) а отображаем(uiUnit) в паллетах. На паллете пусть 20 рулонов
                //без этого флага шаг будет 1/20 для паллет - что нам не удобно
                $forceStepsByOne = $uiUnit['force_step_by_one']; 


                if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                    //пересчитываем цену из цен за еденицу в которой ведем учет (unitPrice) в ту, в которой показываем
                    $price = (float)$result['price_wholesale'];
                    $uiPrice = $saleToPriceKoef
                                ->divide($saleToUiKoef)
                                ->multiply( Fraction::fromFloat($price) )
                                ->toFloat();
                    $price = $this->currency->format($this->tax->calculate($uiPrice, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $price = false;
                }


                if ((float) $result['special']) {
                    $uiUnitSpecial = 
                        $priceToUiKoef
                        ->multiply(Fraction::fromFloat( (float)$result['special']) )
                        ->toFloat();
                    $special = $this->currency->format($this->tax->calculate($uiUnitSpecial, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $special = false;
                }
    
                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format($special? $special : $price, $this->session->data['currency']);
                } else {
                    $tax = false;
                }
            }

            $path = $this->hierarhy->getPath($result['main_category']);
            $products[] = array(
                'product_id' => $result['product_id'],
                'unit_errors' => empty($unitErrors)?null:$unitErrors,

                // этот для расчета количества, передаваемого в корзину
                'sale_to_price_koef' =>  $saleToPriceKoef,
                
                 // эти коэффициенты нужны для инпута 
                'sale_to_ui_koef' => $saleToUiKoef,
                'ui_unit_force_step_by_one' => $forceStepsByOne??null,
                'ui_unit_name' => $uiUnit?$uiUnit['name']:null,
                'ui_unit_name_plural' => $uiUnit?$uiUnit['name_plural']:null, 
                'ui_unit_name_genitive' => $uiUnit?$uiUnit['name_package_dimension']:null,

                'thumb' => $image,
                'name' => $result['meta_h1'],
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                'descriptionPreview' => utf8_substr(strip_tags(html_entity_decode($result['location'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '...',
                'price' => $price??0,
                'special' => $special??0,
                'tax' => $tax,
                'minimum' => ($result['minimum'] > 0) ? $result['minimum'] : 1,
                'rating' => $rating,
                'properties' => $previewProperties,
                'href' => $this->url->link('product/product', 'path=' . $path . '&product_id=' . $result['product_id'])
            );
        }

        return $products;
    }
}
