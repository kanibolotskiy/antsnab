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
use WS\Override\Controller\Admin\Extension\Module\ReviewpageController as ReviewAdminModule;

class ProductTemplateDecorator implements IDecorator
{
    const RULES_INFORMATION_ID = 5;

    

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
            $data['price_val']=$registry->get('currency')->format((float)$data['price'] ? $data['price'] : $product_info['price'], $registry->get('session')->data['currency']);
        } else {
            $data['price'] = false;
            $data['price_val'] = false;
        }

        if ($registry->get('customer')->isLogged() || !$registry->get('config')->get('config_customer_price')) {
            $data['price_wholesale'] = $registry->get('tax')->calculate($product_info['price_wholesale'], $product_info['tax_class_id'], $registry->get('config')->get('config_tax'));
            $data['price_wholesale_val']=$registry->get('currency')->format((float)$data['price_wholesale'] ? $data['price_wholesale'] : $product_info['price_wholesale'], $registry->get('session')->data['currency']);
        } else {
            $data['price_wholesale'] = false;
            $data['price_wholesale_val'] = false;
        }

        $data['currencySymb'] = $registry->get('currency')->getSymbolRight($registry->get('session')->data['currency']);
        $data['wholesale_threshold'] = (int)$product_info['wholesale_threshold'];

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
        $saleUnit = null;
        $saleToPriceKoef = null;

        try {
            foreach ($prodUnits as $unit_id => $unit) {
                /** единицы измерения с sortorder <> 0 участвуют в отображении в шаблоне */
                if (0 != $unit['switchSortOrder']) {
                    $key = (int)$unit['switchSortOrder'];
                    $pUnits[ $key ] = $unit;
                    
                    //коэффициент пересчета из базовой еденицы продажи в данную отображаемую еденицу
                    $saleToUIKoef = $produnitsCalcGateway->getBaseToUnitKoef($product_id, 'isSaleBase', $unit_id);
                    $pUnits[$key]['sale_to_ui_koef'] = $saleToUIKoef;

                    //текстовые строки
                    $pUnits[$key]['showName'] = ($unit['name_price'])?$unit['name_price']:$unit['name'];
                    $pUnits[$key]['name_plural'] =($unit['name_plural'])?$unit['name_plural']:$unit['name'];

                    //строка описания цен. Например: "ведро, 16 кг"
                    if ($unit['calcKoef'] &&
                        $unit['calcRel'] &&
                        $unit['to_name_plural']) {
                        if ($unit['calcRel'] > 1) {
                            $relStr = $unit['name'] . ', ' . (float)$unit['calcKoef'] . ' ' . $unit['to_name_plural'];
                        }
                    } else {
                        $relStr = $unit['name'];
                    }
                        
                    $pUnits[$key]['relStr'] = $relStr;

                }

                //параллельно ищем $priceUnit (базовая единица цен) - нужна как отдельная переменная
                //для передачи стоимостей в корзину
                if ($unit['isPriceBase'] == 1 && !$priceUnit) {
                    $priceUnit = $unit; 
                    //коэффициент пересчета из базовой еденицы продажи (кратности) в еденицы учета (цены)
                    $saleToPriceKoef = $produnitsCalcGateway->getBaseToUnitKoef($product_id, 'isSaleBase', $unit_id);

                } elseif ($unit['isPriceBase'] == 1) {
                    throw new \Exception('Too many price bases for product ' . $product_id);
                }

                if ($unit['isSaleBase'] == 1 && !$saleUnit) {
                    $saleUnit = $unit; 

                } elseif ($unit['isSaleBase'] == 1) {
                    throw new \Exception('Too many price bases for product ' . $product_id);
                }
            }

            if (!isset($pUnits[1])) {
                throw new \Exception('No one unit wasnt set for product');
            }
            
            if (!$priceUnit) {
                throw new \Exception('Price base wasnt found for product ' . $product_id);
            }

            if (!$saleUnit) {
                throw new \Exception('Sale base wasnt found for product ' . $product_id);
            }

        } catch (\Exception $e) {
            $pUnitsErrors = $e->getMessage();
        }

        $data['pUnits'] = $pUnits;
        $data['pUnitsErrors'] = $pUnitsErrors;
        $data['priceUnit'] = $priceUnit;
        $data['saleUnit'] = $saleUnit;
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
                   'val' => htmlspecialchars_decode($p['val'],ENT_QUOTES),
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

        //яндекс карты во всплывающем модале
        $registry->get('document')->addScript('https://api-maps.yandex.ru/2.0/?lang=ru_RU&load=package.standard','header');

        $data['locations'] = array();

        $registry->get('load')->model('localisation/location');
        $registry->get('load')->model('file/file');

        foreach ((array)$registry->get('config')->get('config_location') as $location_id) {
            $location_info = $registry->get('model_localisation_location')->getLocation($location_id);

            if ($location_info) {
                if ($location_info['image']) {
                    $image = $this->model_tool_image->resize($location_info['image'], $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
                } else {
                    $image = false;
                }

                $location_files=[];
                $files_data = $registry->get('model_file_file')->getLocationFiles($location_id);
                foreach ($files_data as $file) {
                    $file_link = HTTP_SERVER . 'files/' . $file['filename']; 
                    if($file_link){
                        $location_files[] = array(
                            'name' 	    => $file['name'],
                            'file_link' => $file_link
                        );
                    }
                }
                $data['locations'][] = array(
                    'location_id' => $location_info['location_id'],
                    'name'        => $location_info['name'],
                    'address'     => nl2br($location_info['address']),
                    'geocode'     => $location_info['geocode'],
                    'telephone'   => $location_info['telephone'],
                    'fax'         => $location_info['fax'],
                    'image'       => $image,
                    'open'        => nl2br($location_info['open']),
                    'comment'     => $location_info['comment'],
                    'map'         => html_entity_decode($location_info['map']),
                    'files'       => $location_files
                );
            }
        }

        foreach ($data['locations'] as &$location) {
            $geocode = str_replace(' ', '', $location['geocode']);
            $parts = explode(',', $geocode);
            if (count($parts) >=2) {
                $location['latitude'] = $parts[0];
                $location['longitude'] = $parts[1];
            } else {
                $location['latitude'] = '';
                $location['longitude'] = '';
            }
        }

        $data['footer'] = $registry->get('load')->controller('common/footer');

        $ruleId = $registry->get('config')->get(ReviewAdminModule::CONFIG_KEY_RULE_ID);
        $data['rules'] = $registry->get('url')->link('information/information', 'information_id=' . $ruleId);

        return $data;

    }
}
