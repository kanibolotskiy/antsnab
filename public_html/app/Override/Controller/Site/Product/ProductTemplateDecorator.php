<?php
/**
 * ProductController Description
 *
 * @version    0.1, May 30, 2018  7:14:50 AM
 * @author     Sergey Lapshin (http://vk.com/wslapshin)
 */

namespace WS\Override\Controller\Site\Product;

use WS\Override\Controller\IDecorator;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;
use WS\Override\Gateway\ProdProperties;
use WS\Override\Gateway\ProdTabs;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;

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

        $product_info = $registry->get('model_catalog_product')->getProduct($product_id);

        if ($registry->get('customer')->isLogged() || !$registry->get('config')->get('config_customer_price')) {
            $data['price'] = $registry->get('tax')->calculate($product_info['price'], $product_info['tax_class_id'], $registry->get('config')->get('config_tax'));
        } else {
            $data['price'] = false;
        }

        if ($registry->get('customer')->isLogged() || !$registry->get('config')->get('config_customer_price')) {
            $data['price_wholesale'] = $registry->get('tax')->calculate($product_info['price_wholesale'], $product_info['tax_class_id'], $registry->get('config')->get('config_tax'));
        } else {
            $data['price_wholesale'] = false;
        }

        $data['currencySymb'] = $registry->get('currency')->getSymbolRight($registry->get('session')->data['currency']);
        $data['wholesale_threshold'] = $product_info['wholesale_threshold'];

        //описание вверху карточки
        $data['description_mini'] = html_entity_decode($product_info['description_mini']);
        $data['sku'] = $product_info['sku'];
       
        //produnits - единицы измерения
        $produnitsGateway = new ProdUnits($registry);
        $produnitsCalcGateway = new ProdUnitsCalc($registry);
        $prodUnits = $produnitsGateway->getUnitsByProduct($product_id);
        
        /** make array for using in template */
        $pUnits = [];
        $pUnitsErrors = null;
        $priceUnit = null;
        $saleToPriceKoef = null;

        try {
            foreach ($prodUnits as $unit_id => $unit) {
                if (0 != $unit['switchSortOrder']) {
                    $key = (int)$unit['switchSortOrder'];
                    $pUnits[ $key ] = $unit;
                    
                    //коэффициент пересчета из базовой еденицы продажи в данную отображаемую еденицу
                    $saleToUIKoef = $produnitsCalcGateway->getBaseToUnitKoef($product_id, 'isSaleBase', $unit_id);
                    $pUnits[$key]['sale_to_ui_koef'] = $saleToUIKoef;

                    //текстовые строки
                    $pUnits[$key]['showName'] = ($unit['name_price'])?$unit['name_price']:$unit['name'];
                    $pUnits[$key]['name_plural'] =($unit['name_plural'])?$unit['name_plural']:$unit['name'];
 
                    if ($unit['calcKoef'] &&
                        $unit['calcRel'] &&
                        $unit['to_name_plural']) {
                        if ($unit['calcRel'] > 1) {
                            $relStr = htmlspecialchars($unit['name'] . ', ' . (int)$unit['calcKoef'] . ' ' . $unit['to_name_plural']);
                        }
                    } else {
                        $relStr = htmlspecialchars($unit['name']);
                    }
                        
                    $pUnits[$key]['relStr'] = $relStr;
                    //параллельно ищем $priceUnit - нужна как отдельная переменная

                    if ($unit['isPriceBase'] == 1 && !$priceUnit) {
                        $priceUnit = $pUnits[$key];
                        //коэффициент пересчета из базовой еденицы продажи (кратности) в еденицы учета (цены)
                        $saleToPriceKoef = $saleToUIKoef;
                    } elseif ($unit['isPriceBase'] == 1) {
                        throw new \Exception('Too many price bases for product ' . $product_id);
                    }
                }
            }

            if (!$pUnits[1]) {
                throw new \Exception('No one unit wasnt set for product');
            }
            
            if (!$priceUnit) {
                throw new \Exception('Price base wasnt found for product ' . $product_id);
            }

        } catch (\Exception $e) {
            $pUnitsErrors = $e->getMessage();
        }
        $data['pUnits'] = $pUnits;
        $data['pUnitsErrors'] = $pUnitsErrors;
        $data['priceUnit'] = $priceUnit;
        $data['sale_to_price_koef'] = $saleToPriceKoef;


        //prodstrings - строки справочной информации по упаковкам
        $stringsGateway = new ProdUnitStrings($registry);
        $data['packageStrings'] = $stringsGateway->getAll($product_info['produnit_template_id'], 'order by sortOrder');
     

        //prodproperties - свойства продукта, наследованные из категории и переопределенные в нем
        //для таблицы вкладки Описание
        $prodPropertiesGateway = new ProdProperties($registry);
        $properties = $prodPropertiesGateway->getPropertiesWithProductValues($product_id, 'order by sortOrder ASC');
        $data['properties'] = [];
        foreach ($properties as $p) {
            if (!$p['prod_hide']) {
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
        foreach ($tabs as $t) {
            if (!$t['prod_hide']) {
                $data['tabs'][] = [
                    'id'   => $t['category_prodtab_id'],
                    'name' => $t['cat_name'],
                    'text' => html_entity_decode($t['val'])
                ];
            }
        }

        $data['footer'] = $registry->get('load')->controller('common/footer');

        return $data;
    }
}
