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
        

        $favorite_arr=[];
        if(isset($_COOKIE["favorite"])){
            $favorite_arr=json_decode($_COOKIE["favorite"]);
        }
        
        $compare_arr=[];
        if(isset($_COOKIE["compare"])){
            $compare_arr=json_decode($_COOKIE["compare"]);
        }

        foreach ($results as $result) {
            
            
            if(in_array($result['product_id'], $favorite_arr)){
                $fav_active=' active';
            }else{
                $fav_active='';
            }
            if(in_array($result['product_id'], $compare_arr)){
                $compare_active=' active';
            }else{
                $compare_active='';
            }

            //$labels=[];
            $labels = $this->model_catalog_product->getProductLabels($result);

            if ($result['image']) {
                //$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
                $image = $this->model_tool_image->myResize($result['image'], 400, 400,2);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', 400, 400);
            }


            if ($this->config->get('config_review_status')) {
                //$rating = (int) $result['rating'];
                $rating = round($result['rating'],2);
            } else {
                $rating = 0;
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

            
            unset($pUnits);
            //print_r($result);
            foreach ($prodUnits as $unit_id => $unit) {
                if (0 != $unit['switchSortOrder']) {
                    $key = (int)$unit['switchSortOrder'];

                    
                    $saleToUIKoef = $produnitsCalcGateway->getBaseToUnitKoef($result['product_id'], 'isSaleBase', $unit_id);
                    $array_koef = (array) $saleToUIKoef;
                    $z=0;
                    $koef_numerator=1;
                    $koef_denomirator=1;
                    foreach($array_koef as $koef_item){
                        if($z){
                            $koef_denomirator=$koef_item;
                        }else{
                            $koef_numerator=$koef_item;
                        }
                        $z++;
                    }
                    $pUnits[$key]['nom']=$koef_numerator;
                    $pUnits[$key]['denom']=$koef_denomirator;

                    $koef_d=$koef_numerator/$koef_denomirator;
                    if($result['quantity']>0){
                        $pUnits[$key]['mincount']=ceil(1*$koef_d);
                    }else{
                        $pUnits[$key]['mincount']=ceil($result['mincount']*$koef_d);
                    }

                }
            
            }
            /*
            <?php if($p['ui_unit_force_step_by_one'] == 1){ ?>
                data-ui_minimum="1" 
                data-ui_step= "1"
            <?php }else{ ?>
                data-ui_minimum = "<?=$p['mincount']?>" 
                data-ui_step = "<?=$p['step']?>"
            <?php } ?>
            */
            /*
            $step=1;
            if (isset($pUnits[2])){
                if (( $result['quantity']<=0) and ($pUnits[2]['denom']>$pUnits[2]['nom']) ){
                    $step = $pUnits[2]['denom'];
                    
                    if($pUnits[1]['mincount']<$pUnits[2]['denom']){
                        $mincount = $pUnits[2]['denom'];
                    }else{
                        $mincount = $pUnits[1]['mincount'];
                    }
                }else{
                    //$mincount = $pUnits[1]['mincount'];
                }

            }else{
                //$mincount = $pUnits[1]['mincount'];
            }
            
            /**-----------------*/
            $dataui_min=1;
            $step=1;
            $mincount = 1;
            if(isset($pUnits)){
                if($result['sale1']){
                    $mincount = 1;
                    $step=1;
                }else{
                    if (isset($pUnits[2])){
                        if (( $result["quantity"]<=0) and ($pUnits[2]['denom']>$pUnits[2]['nom']) ){
                            $step = $pUnits[2]['denom'];
                            $mincount=$pUnits[2]['denom'];
                            if($pUnits[1]['mincount']<$pUnits[2]['denom']){
                                $mincount = $pUnits[2]['denom'];
                            }else{
                                $mincount = $pUnits[1]['mincount'];
                            }
                        }else{
                            $mincount = $pUnits[1]['mincount'];
                        }
                    }else{
                        $mincount = $pUnits[1]['mincount'];
                    }
                }
            }
            /**-----------------*/

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
            $priceold=0;
            $discount_label=0;

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
                    $price_val = $this->tax->calculate($uiPrice, $result['tax_class_id'], $this->config->get('config_tax'));
                    //$price = $this->currency->format($price_val, $this->session->data['currency']);
                    $price = number_format($price_val,0,".", " ");
                    
                } else {
                    $price = false;
                }
                
                /*
                if($result['price_wholesaleold']*1){
                    $priceold = number_format($result['price_wholesaleold'],0,"."," ");
                    $discount_label = (int)(($result['price_wholesale']/$result['price_wholesaleold']-1)*100);
                }
                */

                if($result['discount_percent']*1){
                    //$priceold = number_format($result['price_wholesaleold'],0,"."," ");
                    $discount_label = $result['discount_percent'];
                    //Цена = Цена + Цена*(%скидки)/(100-%скидки)

                    $price_temp = $result['price_wholesale']+$result['price_wholesale']*$discount_label/(100-$discount_label);
                    $priceold = number_format($price_temp,0,"."," ");
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

            //$path = $this->hierarhy->getPath($result['main_category']);
            $img_webp=str_replace(".jpg",".webp",$image);
            $img_webp=str_replace(".png",".webp",$img_webp);
            
            $color_result = $this->model_catalog_product->getColorProduct($result['product_id']);
            
            $colorname='';
            $colorcode='';
            
            if(isset($color_result['name'])){
                $colorname=$color_result['name'];
            }
            if(isset($color_result['code'])){
                $colorcode=$color_result['code'];
            }
            $products[] = array(
                'product_id' => $result['product_id'],
                'quantity'=>$result['quantity'],
                'unit_errors' => empty($unitErrors)?null:$unitErrors,

                // этот для расчета количества, передаваемого в корзину
                'sale_to_price_koef' =>  $saleToPriceKoef,
                
                 // эти коэффициенты нужны для инпута 
                'sale_to_ui_koef' => $saleToUiKoef,
                'ui_unit_force_step_by_one' => $forceStepsByOne??null,
                'ui_unit_name' => $uiUnit?$uiUnit['name']:null,
                'ui_unit_name_plural' => $uiUnit?$uiUnit['name_plural']:null, 
                'ui_unit_name_genitive' => $uiUnit?$uiUnit['name_package_dimension']:null,

                'mincount'=>$mincount,
                'step'=>$step,
                'thumb' => $image,
                'thumb_webp' => $img_webp,
                
                //'name' => $result['meta_h1'],
                'name' => html_entity_decode($result['name']),
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                //'descriptionPreview' => utf8_substr(strip_tags(html_entity_decode($result['location'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '...',
                'descriptionPreview' => html_entity_decode($result['description_mini']),
                'price_val'=>$price_val,
                'price' => $price??0,
                'priceold' => $priceold,
                'special' => $special??0,
                'tax' => $tax,
                'minimum' => ($result['minimum'] > 0) ? $result['minimum'] : 1,
                'rating' => $rating,
                'reviews' => $result['reviews'],
                'properties' => $previewProperties,
                'href' => $this->url->link('product/product', 'path=' . '&product_id=' . $result['product_id']),
                'favorite'=>$fav_active,
                'compare'=>$compare_active,
                'labels'=>$labels,
                'color_name'=>$colorname,
                'color_code'=>$colorcode,
                'position'=>$result['position'],
                'sku' => $result['sku'],
                'notavail' => $result['notavail'],
            );
        }
        return $products;
    }
}
