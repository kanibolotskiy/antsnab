<?php

namespace WS\Override\Controller\Admin\Catalog;

use WS\Override\Controller\IDecorator;
use WS\Override\Gateway\ProdProperties;
use WS\Override\Gateway\ProdTabs;
use WS\Override\Gateway\ProdUnitTemplates;

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
        $document = $registry->get('document');

        //свойства
        $data['tab_prodproperties'] = $language->get('tab_prodproperties');
        $data['property_helptext'] = $language->get('property_helptext');
        $data['property_column_sortorder'] = $language->get('property_column_sortorder');
        $data['property_column_showInPreview'] = $language->get('property_column_showInPreview');
        $data['property_column_showInSummary'] = $language->get('property_column_showInSummary');
        $data['property_column_name'] = $language->get('property_column_name');
        $data['property_column_defval'] = $language->get('property_column_defval');
        $data['property_column_val'] = $language->get('property_column_val');
        $data['property_column_unit'] = $language->get('property_column_unit');
        $data['property_column_hide'] = $language->get('property_column_hide');
        $data['yes'] = $language->get('yes');
        $data['no'] = $language->get('no');
        $data['entry_showInSummary'] = $language->get('entry_showInSummary');

        $data['showInSummary'] = false;
        $data['prodproperties'] = array();
        if (isset($request->get['product_id'])) {
            $product_id = (int) $request->get['product_id'];


            $gateway = new ProdProperties($registry);
            $data['showInSummary'] = $gateway->isProductShowInSummary($product_id);
            $data['prodproperties'] = $gateway->getPropertiesWithProductValues($product_id, 'order by showInSummary DESC, sortOrder ASC');
        }
        
        //вкладки продукта
        $data['tab_tabs'] = $language->get('tab_tabs');
        $data['tab_helptext'] = $language->get('tab_helptext');
        $data['tab_column_sortorder'] = $language->get('tab_column_sortorder');
        $data['tab_column_name'] = $language->get('tab_column_name');
        $data['tab_column_defval'] = $language->get('tab_column_defval');
        $data['tab_column_val'] = $language->get('tab_column_val');
        $data['tab_column_hide'] = $language->get('tab_column_hide');
        $data['tab_entry_linkto_tabmanagement'] = $language->get('tab_entry_linkto_tabmanagement');

        $data['column_price_wholesale'] = $language->get('column_price_wholesale');
        $data['entry_price_wholesale'] = $language->get('entry_price_wholesale');
        $data['entry_wholesale_threshold'] = $language->get('entry_wholesale_threshold');
        $data['entry_description_mini'] = $language->get('entry_description_mini');
        $data['tab_prices'] = $language->get('tab_prices');
        $data['entry_produnit_template_id'] = $language->get('entry_produnit_template_id');

        $data['prodtabs'] = array();
        $prodTabs = array();
        if (isset($request->get['product_id'])) {
            $product_id = (int) $request->get['product_id'];

            $gateway = new ProdTabs($registry);
            $prodTabs = $gateway->getTabsWithProductTexts($product_id, 'order by sortOrder ASC');
        }
        foreach( $prodTabs as $tabRow) {
           $tabCatId = $tabRow['category_id'];
           $tabId = $tabRow['category_prodtab_id'];
           $link = $registry->get('url')->link('extension/module/prodtabs/getform&category_id='.$tabCatId.'&tab_id='.$tabId, 'token=' . $registry->get('session')->data['token'], 'SSL');
            $data['prodtabs'][] = array_merge($tabRow, ['link'=>$link]);
        }

        //CKEditor
        if ($registry->get('config')->get('config_editor_default')) {
            $document->addScript('view/javascript/ckeditor/ckeditor.js');
            $document->addScript('view/javascript/ckeditor/ckeditor_init.js');
        } else {
            $document->addScript('view/javascript/summernote/summernote.js');
            $document->addScript('view/javascript/summernote/lang/summernote-' . $language->get('lang') . '.js');
            $document->addScript('view/javascript/summernote/opencart.js');
            $document->addStyle('view/javascript/summernote/summernote.css');
        }
        $data['header'] = $registry->get('load')->controller('common/header');


        //Custom fields
        if (isset($request->get['product_id'])) {
			$product_info = $registry->get('model_catalog_product')->getProduct($request->get['product_id']);
		}

        if (isset($request->post['price_wholesale'])) {
            $data['price_wholesale'] = $request->post['price_wholesale'];
        } elseif (!empty($product_info)) {
            $data['price_wholesale'] = $product_info['price_wholesale'];
        } else {
            $data['price_wholesale'] = 0.0000;
        }

        if (isset($request->post['wholesale_threshold'])) {
            $data['wholesale_threshold'] = $request->post['wholesale_threshold'];
        } elseif (!empty($product_info)) {
            $data['wholesale_threshold'] = $product_info['wholesale_threshold'];
        } else {
            $data['wholesale_threshold'] = 0.0000;
        }

        if (isset($request->post['produnit_template_id'])) {
            $data['produnit_template_id'] = $request->post['produnit_template_id'];
        } elseif (!empty($product_info)) {
            $data['produnit_template_id'] = $product_info['produnit_template_id'];
        } else {
            $data['produnit_template_id'] = '';
        }

        $prodUnits = new ProdUnitTemplates($registry);
        $data['produnitTemplates'] = $prodUnits->getTemplates();

        //не вычитаем со склада по-умолчанию
   		if (isset($registry->get('request')->post['subtract'])) {
			$data['subtract'] = $registry->get('request')->post['subtract'];
		} elseif (!empty($product_info)) {
			$data['subtract'] = $product_info['subtract'];
		} else {
			$data['subtract'] = 0;
		}

        return $data;
    }

}
