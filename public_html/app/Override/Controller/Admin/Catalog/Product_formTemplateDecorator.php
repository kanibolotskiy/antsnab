<?php

namespace WS\Override\Controller\Admin\Catalog;

use WS\Override\Controller\IDecorator;
use WS\Override\Gateway\ProdProperties;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 22, 2018  9:10:13 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class Product_formTemplateDecorator implements IDecorator
{

    public function process($data, $registry)
    {
        $language = $registry->get('language');
        $request = $registry->get('request');

        $data['tab_prodproperties'] = $language->get('tab_prodproperties');
        $data['property_helptext'] = $language->get('property_helptext');
        $data['property_column_sortorder'] = $language->get('property_column_sortorder'); 
        $data['property_column_showInPreview'] =  $language->get('property_column_showInPreview'); 
        $data['property_column_showInSummary'] =  $language->get('property_column_showInSummary'); 
        $data['property_column_name'] =  $language->get('property_column_name'); 
        $data['property_column_defval'] =  $language->get('property_column_defval'); 
        $data['property_column_val'] =  $language->get('property_column_val'); 
        $data['property_column_unit'] =  $language->get('property_column_unit'); 
        $data['property_column_hide'] =  $language->get('property_column_hide'); 
        $data['yes'] = $language->get('yes');
        $data['no'] = $language->get('no');
        $data['entry_showInSummary'] = $language->get('entry_showInSummary');

        $data['showInSummary'] = false;
        $data['prodproperties'] = array();
        if ( isset($request->get['product_id'])  ) {
           $product_id = (int)$request->get['product_id'];


           $gateway = new ProdProperties($registry);
           $data['showInSummary'] =  $gateway->isProductShowInSummary($product_id);
           $data['prodproperties'] = $gateway->getPropertiesWithProductValues($product_id, 'order by showInSummary DESC, sortOrder ASC'); 
        }
       
        return $data;
    }

}
