<?php
namespace WS\Override\Controller\Site\Extension\Module;

use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\FinalCategory;
use WS\Override\Controller\Admin\Extension\Module\PriceController as AdminModule;
use Fpdf\Fpdf;

/**
 * Вывод модуля прайса 
 * 
 * @version    1.0, Apr 6, 2018  2:49:27 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class PriceController extends \Controller
{
    /** Значение для опции в селекте, "Отобразить все" */
    const SHOW_ALL_OPTION_VALUE = "-1";

    public function makepdf(){
        $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

        //define('FPDF_FONTPATH','system/library/fpdf/fonts/');
        
        //require('system/library/fpdf/fpdf.php');
        //ob_start();
        //$this->load->
        
        //$this->load->model('system/library/fpdf/fpdf.php');
        //$pdf = new FPDF();

        //$dompdf = new Dompdf\Dompdf();
        /*
        $pdf->AddPage();
        $pdf->SetFont('Arial','B',16);
        $pdf->Cell(40,10,'Hello World!');
        
        //$pdf->Output();
        //ob_end_flush();
        //require_once(DIR_SYSTEM . 'library/fpdf.php');
        $pdf = new FPDF();
        $pdf->SetAuthor('Lana Kovacevic');
        $pdf->SetTitle('FPDF tutorial');
        //$pdf->SetFont('verdana','B',20);
        $pdf->AddFont('Arial','','arial.php'); 
        $pdf->SetFont('Arial');
        
        $pdf->SetTextColor(50,60,100);
        //$pdf->AddPage('P');

        $pdf->SetMargins(1,2);
        $pdf->AddPage();

        $pdf->Cell(80);
        // Framed title
        $pdf->Cell(30,10,'Title',1,0,'C');
        // Line break
        $pdf->Ln(20);

        /*
        $pdf->Cell(10,10,'FPDF Tutorial',1,0,'C',0);
        //Set x and y position for the main text, reduce font size and write content
        $pdf->SetXY (10,50);
        $pdf->SetFontSize(10);
        $pdf->Write(5,'Congratulations! You have generated a PDF.Привет прайс-лист');
        $pdf->Write(0,iconv('utf-8', 'windows-1251',"Коммерческое предложение"));
        //Output the document
        
        $pdf->SetTitle("Тестовый документ");
        $pdf->SetAuthor('Steven Wittens');


        $pdf->Write(12, "Test.\n");
        $pdf->Write(12, "Тестовая строка.\n");


        $pdf->Output('example1.pdf','I');

        $pdf->Output('example1.pdf','I');
        */
    }
    public function index()
    {
        $this->load->language('extension/module/price');

        $data['price_text'] = $this->language->get('price_text');
        $data['price_wholesale_text']  = $this->language->get('price_wholesale_text');
        $data['product_text'] = $this->language->get('product_text');
        $data['package_text'] = $this->language->get('package_text');
        $data['select_category_text'] = $this->language->get('select_category_text');
        $data['select_subcategory_text'] = $this->language->get('select_subcategory_text');
        $data['select_product_text'] = $this->language->get('select_product_text');
        $data['price_download'] = $this->language->get('price_download');
        $data['pdf'] = $this->config->get(AdminModule::CONFIG_KEY_PDF_ROUTE);
        $data['xls'] = $this->config->get(AdminModule::CONFIG_KEY_XLS_ROUTE);
        
        $data['date']=date("d.m.Y");
        //content of table
        $rootCat = $this->config->get(AdminModule::CONFIG_KEY_START_CATEGORY_PARENT_ID);
        $startCat = $this->config->get(AdminModule::CONFIG_KEY_START_CATEGORY_ID);
        $data['selectors'] = $this->getPriceSelectors($rootCat, $startCat);

        $data['SHOW_ALL_OPTION_VALUE'] = static::SHOW_ALL_OPTION_VALUE;
        $data['priceTableContent'] = $this->getPriceTableContentHTML($startCat);

        return $this->load->view('extension/module/app/price/price', $data);
    }

    public function ajaxRefresh()
    {

        $firstActive = $this->config->get(AdminModule::CONFIG_KEY_START_CATEGORY_ID);
        if( isset($this->request->post['firstActive']) ) {
            $firstActive = $this->request->post['firstActive'];
        }
        $finalsParent = $firstActive;

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
        
        $rootCat = $this->config->get(AdminModule::CONFIG_KEY_START_CATEGORY_PARENT_ID);
        $result = [
            'selectors' => $this->getPriceSelectors($rootCat, $firstActive, $secondActive, $thirdActive),
            'table' => $this->getPriceTableContentHTML($finalsParent)
        ];

        $this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($result));
    }
 
    protected function getPriceSelectors($firstParentId, $firstActive = null,  $secondActive = null, $thirdActive = null)
    {
        $this->load->language('extension/module/price');
        
        $lists = [
            'l1' => [],
            'l2' => [],
            'active' => []
        ];    

        $firstParentNode = $this->hierarhy->getNodeById($firstParentId);
        $firstCategories = $firstParentNode->getChildren(); 
        if( empty($firstCategories) ) {
            return $lists;
        }
        $firstActive = (null==$firstActive)?$firstCategories[0]->get('category_id'):$firstActive;
        $lists['active'][] = $firstActive;
        foreach($firstCategories as $cat) {
            if((!$cat->get('isseo')) and (!$cat->get('isbrand'))){
                $lists['l1'][ $cat->get('name') ] =  $cat->get('category_id');
            }
        }

        $secondParentNode = $this->hierarhy->getNodeById($firstActive);
        $secondCategories = $secondParentNode->getChildren(); 
        $lists['l2'][$this->language->get('all_text')] = static::SHOW_ALL_OPTION_VALUE;
        
        if( empty($secondCategories) ) {
            return $lists;
        }

        foreach($secondCategories as $cat) {
            if((!$cat->get('isseo')) and (!$cat->get('isbrand'))){
                $lists['l2'][$cat->get('name')] = $cat->get('category_id');
            }
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
            'c.parent_id, c.sort_order' //categories order
            /*'LCASE(cd.name)',*/ //categories order
            /*['sort'=>'pd.name']*/ //products order in categories*/
        );

        $productIds = [];
        //print_r($data['categories']);
        foreach( $data['categories'] as  $category ) {
            $productIds = array_merge($productIds, array_keys($category['products']) );
        }
        
        $unitsGateway = new ProdUnits($this->registry);
        $data['priceUnits'] = $unitsGateway->getProductsWithUnit($productIds, 'isPriceBase');
        $data['saleUnits'] = $unitsGateway->getProductsWithUnit($productIds, 'isSaleBase');
        $data['cur'] = $this->currency;
        $data['curSym'] = $this->config->get('config_currency');
        
        
        return $this->load->view('extension/module/app/price/price_tableContent', $data);
    }
}
