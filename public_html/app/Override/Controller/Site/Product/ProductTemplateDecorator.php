<?php
/**
 * ProductController Description 
 * 
 * @version    0.1, May 30, 2018  7:14:50 AM 
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */

namespace WS\Override\Controller\Site\Product;
use WS\Override\Controller\IDecorator;
use WS\Override\Gateway\ProdUnits;
use WS\Override\Gateway\ProdUnitStrings;
use WS\Override\Gateway\ProdProperties;
use WS\Override\Gateway\ProdTabs;

class ProductTemplateDecorator implements IDecorator 
{
    public function process($data, $registry)
    {
        $request = $registry->get('request');

        if (isset($request->get['product_id'])) {
			$product_id = (int)$request->get['product_id'];
		} else {
			$product_id = 0;
		}

        //debug
        //$product_id = 51;

        $product_info = $registry->get('model_catalog_product')->getProduct($product_id);

        //описание вверху карточки
        $data['description_mini'] = html_entity_decode($product_info['description_mini']);
        $data['sku'] = $product_info['sku'];
        
        //produnits - разные единицы измерения с их ценами
        $produnitsGateway = new ProdUnits($registry);    
        $priceMeta = $produnitsGateway->getPriceMetaForProduct($product_id);
        $data['priceMeta'] = [];
        foreach($priceMeta as $unitName => $unitParams) {
            foreach ( $unitParams as $key => $value ) {
                $data['priceMeta'][$unitName][$key] = $value;
                if( $key == 'price' || $key == 'price_wholesale' ) {
                    //@task подумать о поддержке налогов,  см в оригинальном контроллере
                    $data['priceMeta'][$unitName][$key . '_str'] = $registry->get('currency')->format( $value, $registry->get('session')->data['currency']); 
                }
            }
        }

        //вспомогательные meta по ценам
        $data['priceMetaJSON'] = [
            'priceMeta' => $data['priceMeta'],
            'bases' => []
        ]; 
        $data['basePriceMeta'] = null;
        $data['firstPriceMeta'] = null;
        $data['secondPriceMeta'] = null;

        if( count($data['priceMeta']) ) {
            foreach($data['priceMeta'] as $u) {
                if ( $u['isPriceBase'] ) {
                    //базовая единица для цен (для подсказки про опт. тк базовая - это еденица относительно которой все считается)
                    $data['basePriceMeta'] = $u;
                    $data['priceMetaJSON']['bases']['price'] = $u['name'];
                }

                if ( $u['isPackageBase'] ) {
                    $data['priceMetaJSON']['bases']['package'] = $u['name'];
                }

                if( $u['isSaleBase'] ) {
                    $data['priceMetaJSON']['bases']['sale'] = $u['name'];
                }
            }

            //цена, отображаемая первой ($data['priceMeta'] отсортирован по switchSortOrder - порядок в переключателе цен
            reset($data['priceMeta']);
            $data['firstPriceMeta']= current($data['priceMeta']);

            //цена,отображаемая второй
           $data['secondPriceMeta'] = next($data['priceMeta']);
        }

        $data['priceMetaJSON'] = json_encode($data['priceMetaJSON'], JSON_UNESCAPED_UNICODE & JSON_HEX_APOS & JSON_HEX_QUOT);

        $data['currencySymb'] = $registry->get('currency')->getSymbolRight( $registry->get('session')->data['currency']);

        //prodstrings - строки справочной информации по упаковкам
        $stringsGateway = new ProdUnitStrings($registry);
        $data['packageStrings'] = $stringsGateway->getAll($product_info['produnit_template_id'], 'order by sortOrder');
     

        //prodproperties - свойства продукта, наследованные из категории и переопределенные в нем
        //для вкладки Описание
        $prodPropertiesGateway = new ProdProperties($registry);
        $properties = $prodPropertiesGateway->getPropertiesWithProductValues($product_id, 'order by sortOrder ASC');
        $data['properties'] = [];
        foreach($properties as $p) {
           if(  !$p['prod_hide'] ) {
               $data['properties'][] = [
                   'name' => $p['cat_name'],
                   'val' => $p['val'],
                   'unit' => $p['cat_unit']
               ]; 
           }
        }

        //prodtabs - кастомные вкладки продукта, наследуемые из категории
        $prodTabsGateway = new ProdTabs($registry);
        $tabs = $prodTabsGateway->getTabsWithProductTexts($product_id, 'order by sortOrder');
        $data['tabs'] = [];
        foreach( $tabs as $t) {
            if( !$t['prod_hide'] ) {
                $data['tabs'][] = [
                    'id'   => $t['category_prodtab_id'],
                    'name' => $t['cat_name'],
                    'text' => html_entity_decode($t['val'])
                ];
            }
        }

        //spinner.js add
        $registry->get('document')->addScript('catalog/view/javascript/product.js');
        $registry->get('document')->addScript('catalog/view/javascript/bootstrap/js/bootstrap.min.js');
        $data['footer'] = $registry->get('load')->controller('common/footer');

        return $data;
    }
}
