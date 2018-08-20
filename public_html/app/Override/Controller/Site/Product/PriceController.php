<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Product
 */

namespace WS\Override\Controller\Site\Product;

use WS\Override\Gateway\ProdUnits;
use WS\Override\Gateway\FinalCategory;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 6, 2018  2:49:27 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class PriceController extends \Controller
{

    /**id странички информаций для управления в админке*/
    const PRICE_INFORMATION_PAGE_ID = 7;

    /**id модуля hmtl в админке для управления нижним текстом в прайсе*/
    const PRICE_DOWNHTML_MODULE_ID = 39;

    /**родительская категория для первого селекта прайс-листа*/
    const START_CATEGORY_PARENT_ID = 71;

    /**с какой категории начать отображать прайс-лист - выбор в 1м селекте*/
    const START_CATEGORY_ID = 73;

    /** Значение для опции в селекте, "Отобразить все" */
    const SHOW_ALL_OPTION_VALUE = "-1";

    public function index()
    {
        $this->load->language('information/information');
        $this->load->model('catalog/information');
        $priceInformationPage = $this->model_catalog_information->getInformation(static::PRICE_INFORMATION_PAGE_ID);

        //breadcrumbs
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $priceInformationPage['title'],
            'href' => $this->url->link('product/price')
        );

        $data['heading_title'] = $priceInformationPage['meta_h1'];
        $data['description'] = $priceInformationPage['description'];
        $data['description_down'] = '';

        if ($priceInformationPage['meta_title']) {
            $this->document->setTitle($priceInformationPage['meta_title']);
        } else {
            $this->document->setTitle($priceInformationPage['title']);
        }
        $this->document->setDescription($priceInformationPage['meta_description']);
        $this->document->setKeywords($priceInformationPage['meta_keyword']);

        $data['price_text'] = $this->language->get('price_text');
        $data['price_wholesale_text']  = $this->language->get('price_wholesale_text');
        $data['product_text'] = $this->language->get('product_text');
        $data['package_text'] = $this->language->get('package_text');
        $data['select_category_text'] = $this->language->get('select_category_text');
        $data['select_subcategory_text'] = $this->language->get('select_subcategory_text');
        $data['select_product_text'] = $this->language->get('select_product_text');

        //down text
        $this->load->model('extension/module');
        $htmlModule = $this->model_extension_module->getModule(static::PRICE_DOWNHTML_MODULE_ID);
        $data['description_down'] = html_entity_decode($htmlModule['module_description'][ (int)$this->config->get('config_language_id') ]['description']);

        //content of table
        $data['selectors'] = $this->getPriceSelectors(static::START_CATEGORY_PARENT_ID, static::START_CATEGORY_ID);
        $data['SHOW_ALL_OPTION_VALUE'] = static::SHOW_ALL_OPTION_VALUE;
        $data['priceTableContent'] = $this->getPriceTableContentHTML(self::START_CATEGORY_ID);

        //common
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('product/price', $data));
    }

    public function ajaxRefresh()
    {
        $finalsParent = static::START_CATEGORY_PARENT_ID; 

        $firstActive = null;
        if( isset($this->request->post['firstActive']) ) {
            $firstActive = $this->request->post['firstActive'];
            $finalsParent = $firstActive;
        }

        $secondActive = null;
        if( isset($this->request->post['secondActive']) ) {
            $secondActive = $this->request->post['secondActive'];
            $finalsParent = $secondActive;
        }

        $thirdActive = null;
        if( isset($this->request->post['thirdActive']) ) {
            $thirdActive = $this->request->post['thirdActive'];
            $finalsParent = $thirdActive;
        }

        $result = [
            'selectors' => $this->getPriceSelectors(static::START_CATEGORY_PARENT_ID, $firstActive, $secondActive, $thirdActive),
            'table' => $this->getPriceTableContentHTML($finalsParent)
        ];

        $this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($result));
    }

    protected function getPriceSelectors($firstParentId, $firstActive = null,  $secondActive = null, $thirdActive = null)
    {
        $this->load->language('information/information');
        $this->load->model('catalog/category');
        $lists = [
            'l1' => [],
            'l2' => [],
            'active' => []
        ];    

        $firstCategories = $this->model_catalog_category->getCategories($firstParentId);
        if( empty($firstCategories) ) {
            return $lists;
        }
        $firstActive = (null==$firstActive)?$firstCategories[0]['category_id']:$firstActive;
        $lists['active'][] = $firstActive;
        foreach($firstCategories as $cat) {
            $lists['l1'][$cat['name']] =  $cat['category_id'];
        }

        $secondCategories = $this->model_catalog_category->getCategories($firstActive);
        $lists['l2'][$this->language->get('all_text')] = static::SHOW_ALL_OPTION_VALUE;
        if( empty($secondCategories) ) {
            return $lists;
        }

        foreach($secondCategories as $cat) {
            $lists['l2'][$cat['name']] = $cat['category_id'];
        }
        if( null == $secondActive || !in_array($secondActive, array_values($lists['l2']) ) ) {
            return $lists;
        }
        $lists['active'][] = $secondActive;

        $finalCategoriesGateway = new FinalCategory($this->registry);
        $thirdCategories = $finalCategoriesGateway->getFinalCategories($secondActive);
        if( empty($thirdCategories) ) {
            return $lists;
        }
        /*Вернулась та же самая категория. Значит она уже финальная*/
        if( 1===count($thirdCategories) && isset( $thirdCategories[$secondActive] ) ) {
            return $lists;
        }

        $lists['l3'] = [];
        $lists['l3'][$this->language->get('all_text')] = static::SHOW_ALL_OPTION_VALUE ; 
        foreach($thirdCategories as $cat) {
            $lists['l3'][$cat['name']] = $cat['category_id'];
        }
        
        if( null == $thirdActive || !in_array($thirdActive, array_values($lists['l3'])) ) {
           return $lists;
        }
        $lists['active'][] = $thirdActive;

        return $lists;
    }

    protected function getPriceTableContentHTML($finalsParent)
    {
        $fCategoryGateway = new FinalCategory($this->registry);
        $data['categories'] = $fCategoryGateway->getFinalCategoriesWithProducts(
            $finalsParent,
            'LCASE(cd.name)', //categories order
            ['sort'=>'pd.name'] //products order in categories
        );

        $productIds = [];
        foreach( $data['categories'] as  $category ) {
            $productIds = array_merge($productIds, array_keys($category['products']) );
        }
        $unitsGateway = new ProdUnits($this->registry);
        $data['priceUnits'] = $unitsGateway->getProductsWithUnit($productIds, 'isPriceBase');
        $data['saleUnits'] = $unitsGateway->getProductsWithUnit($productIds, 'isSaleBase');
        $data['cur'] = $this->currency;
        $data['curSym'] = $this->config->get('config_currency');

        return $this->load->view('product/price_tableContent', $data);
    }
}
