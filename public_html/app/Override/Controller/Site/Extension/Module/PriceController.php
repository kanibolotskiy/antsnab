<?php
namespace WS\Override\Controller\Site\Extension\Module;

use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\FinalCategory;
use WS\Override\Controller\Admin\Extension\Module\PriceController as AdminModule;
use Fpdf\Fpdf;
class PDF extends FPDF
{
function Header()
{
    $this->AddFont('OpenSans','B','OpenSans-Regular.php');
    $this->AddFont('OpenSansBold','B','OpenSans-Bold.php');
    $this->SetLineWidth(.3);
    $this->Image('image/logo_price.png',10,5,-540,0,'','https://ant-snab.ru');
        
        $this->Image('image/mail.png',65,11,-250);
        $this->Image('image/phone_price.png',117,10,-360);
        $this->Image('image/earth_price_n.png',163,9,-650);


        $this->SetFont('OpenSans','B',9); 
        $this->Cell(60,0,'');
        $this->SetTextColor(0);

        $this->SetTextColor(0);
        $this->SetFont('Arial','BU',10); 
        //$this->Cell(46,6,'info@ant-snab.ru','',0,'L','','mailto:info@ant-snab.ru');
        $this->Cell(52,6,'info@ant-snab.ru','',0,'L','','mailto:info@ant-snab.ru');

        
        $this->SetFont('OpenSansBold','B',10); 
        $this->Cell(48,0,'8 495 255-01-37','',0,'');
        
        $this->SetFont('Arial','BU',10); 
        $this->Cell(31,5,'www.ant-snab.ru','',0,'R','','https://ant-snab.ru');

        $this->Ln(5);

        $this->Cell(112,0,'');
        $this->SetFont('OpenSansBold','B',10); 
        $this->Cell(62,0,'8 800 775-28-31','',0,'');


        
        $this->SetFont('OpenSans','B',9); 
        $this->SetTextColor(0);
        $this->Ln(4);
        $this->Cell(191,0,date("d.m.Y"),'',0,'R');

        /*
        $this->Cell(48,0,iconv('utf-8', 'windows-1251', 'Позвоните нам'),'',0,'');
        $this->Cell(62,0,iconv('utf-8', 'windows-1251', 'Бесплатный звонок по РФ'),'',0,'');
        $this->SetTextColor(65,115,125);
        $this->SetFont('Arial','BU',9); 
        $this->Cell(26,0,'info@ant-snab.ru','',0,'R','','mailto:info@ant-snab.ru');
        
        $this->SetTextColor(0);
        $this->Ln(6);
        $this->SetFont('OpenSansBold','B',15); 
        $this->Cell(55,0,'');
        
        $this->SetFontSize(10);
        $this->SetTextColor(65,115,125);
        
        $this->SetFont('Arial','BU',10); 
        
        
        // Insert a dynamic image from a URL
        //$this->Image('http://chart.googleapis.com/chart?cht=p3&chd=t:60,40&chs=250x100&chl=Hello|World',60,30,90,0,'PNG');
        //$this->Cell(10,10,'Title','',0,'C');
        //$this->Cell(50,10,'Title1','',0,'C');
        //$this->Cell(100,10,'Title2','',0,'C');
        //$this->Cell(200,10,'Title3','',0,'C');
        //$pdf->Cell($w[2],6,'123.66','LR',0,'R',$fill);
        */

        $this->Ln(4);
        $this->Cell(0,20,'','T',0,'');
        // Line break
        $this->Ln(10);
}
}
class PriceController extends \Controller
{
    /** Значение для опции в селекте, "Отобразить все" */
    /** Значение для опции в селекте, "Отобразить все" */
    const SHOW_ALL_OPTION_VALUE = "-1";
    /*
    class PDF extends FPDF{
        function Header(){
            // Select Arial bold 15
            $this->AddFont('OpenSans','B','OpenSans-Regular.php');
            $this->AddFont('OpenSansBold','B','OpenSans-Bold.php');
            $this->SetLineWidth(.3);
            // Move to the right
            //$this->Cell(80);
            // Framed title
            //$this->Cell(30,10,'Title',1,0,'C');
            // Insert a logo in the top-left corner at 300 dpi
            $this->Image('image/logo_price.png',10,5,-540,0,'','https://ant-snab.ru');
            
            $this->Image('image/mail.png',65,11,-250);
            $this->Image('image/phone_price.png',117,10,-360);
            $this->Image('image/earth_price_n.png',163,9,-650);
    
    
            $this->SetFont('OpenSans','B',9); 
            $this->Cell(60,0,'');
            $this->SetTextColor(0);
    
            $this->SetTextColor(0);
            $this->SetFont('Arial','BU',10); 
            //$this->Cell(46,6,'info@ant-snab.ru','',0,'L','','mailto:info@ant-snab.ru');
            $this->Cell(52,6,'info@ant-snab.ru','',0,'L','','mailto:info@ant-snab.ru');
    
            
            $this->SetFont('OpenSansBold','B',10); 
            $this->Cell(48,0,'8 495 255-01-37','',0,'');
            
            $this->SetFont('Arial','BU',10); 
            $this->Cell(31,5,'www.ant-snab.ru','',0,'R','','https://ant-snab.ru');
    
            $this->Ln(5);
    
            $this->Cell(112,0,'');
            $this->SetFont('OpenSansBold','B',10); 
            $this->Cell(62,0,'8 800 775-28-31','',0,'');
    
    
            
            $this->SetFont('OpenSans','B',9); 
            $this->SetTextColor(0);
            $this->Ln(4);
            $this->Cell(191,0,date("d.m.Y"),'',0,'R');
        
            $this->Ln(4);
            $this->Cell(0,20,'','T',0,'');
            // Line break
            $this->Ln(10);
        }
        
    }
    */
    
    public function makepdf(){
        //
        //header("content-type:text/html; charset=cp1251");
        ini_set('display_errors', 1);
        require('system/library/fpdf/fpdf.php');
        //require("makefont/makefont.php");   
//
//        MakeFont("font/test/arial.ttf","cp1251");  
//        MakeFont("font/test/times.ttf","cp1251"); 

        //require_once('vendor/autoload.php');
        define('FPDF_FONTPATH','system/library/fpdf/fonts/');
        //require('fpdf.php');
        
        $pdf = new PDF();
        
        //$pdf->SetFont('OpenSans-Regular','B',16);
        //$pdf->AddFont('OpenSans-Regular','','opensans.php');
        //$pdf->AddFont('OpenSans-Regular','','OpenSans-Regular.php');
        //$pdf->SetFont('OpenSans','B',16);

        //$pdf->AddFont('verdana','','verdana.php');
        //$pdf->SetFont('verdana','B',16);
        //$pdf->AddFont('OpenSans','','OpenSans.php');
        ///$pdf->SetFont('OpenSans-Regular','B',10);
        //$pdf->SetFont('Arial','B',16);
        $pdf->AddPage();
        $pdf->SetLineWidth(.1);
        //работает
$pdf->AddFont('OpenSans','B','OpenSans-Regular.php');
$pdf->AddFont('OpenSansBold','B','OpenSans-Bold.php');

$pdf->SetFont('OpenSansBold','B',9); 

$pdf->SetFont('OpenSansBold','B',11); 
$pdf->Cell(180,6,iconv('utf-8', 'windows-1251', 'Содержание'),'',0,'C');
$pdf->Ln();


$pdf->SetTextColor(65,115,126);
$pdf->SetFont('OpenSansBold','B',9); 
// Add a Unicode font (uses UTF-8)
//$pdf->AddFont('DejaVu','','DejaVuSansCondensed.ttf',true);
//$pdf->SetFont('DejaVu','',14);
        //$pdf->AddFont('DejaVu','','DejaVuSans-Bold.ttf',true);
        //$pdf->SetFont('DejaVu','',14);

        for($i=1;$i<=80;$i++)
        // /$pdf->Cell(0,6,'Printing line number '.$i,0,1);

        //$pdf->Cell(40,10,$text);
        //$pdf->Cell(40,10,$text);

        //Цены на инструменты, расходники и сопутствующие материалы указаны в рублях с учетом НДС;
        //● Цены указаны с учетом самовывоза со складов поставщика. Стоимость доставки уточняйте у менеджеров;
        //● Оптовые цены действительны только при 100% предоплате.

        $rub=iconv('utf-8', 'windows-1251', ' р.');
        $parent_cat_id=71;
		$categories=[];
		$categories_tree=[];
		
        $this->load->model('catalog/category');

		$category_list=$this->model_catalog_category->listCatalog();
		$products_list=$this->model_catalog_category->listProducts(); 
		
		foreach($category_list as $category){
			$categories[$category["parent_id"]][]=$category;
		}

		if(isset($categories[$parent_cat_id])){
			foreach($categories[$parent_cat_id] as $key=>$cat_item){
                

				$categories_tree[$key]=$cat_item;
				$cat_child=[];
				if(isset($categories[$cat_item["category_id"]])){
					foreach($categories[$cat_item["category_id"]] as $cat_item_child){
						$cat_child2=[];
						if(isset($categories[$cat_item_child["category_id"]])){
							foreach($categories[$cat_item_child["category_id"]] as $cat_item_child2){
								$cat_item_child["list"][]=$cat_item_child2;
							}
						}
						$categories_tree[$key]["list"][]=$cat_item_child;
					}
				}
			}
		}
        
        foreach($categories_tree as $category_level1){
            $link = $pdf->AddLink();
            $links[$category_level1['category_id']]=$link;
            $pdf->Cell(20,6,iconv('utf-8', 'windows-1251', $category_level1['name']),'',0,'L','',$link);
            $pdf->Ln();
            foreach($category_level1['list'] as $category_level2){
                $link = $pdf->AddLink();
                $links[$category_level2['category_id']]=$link;

                $pdf->Cell(10,6,'');
                $pdf->Cell(20,6,iconv('utf-8', 'windows-1251', $category_level2['name']),'',0,'L','',$link);
                $pdf->Ln(5);
            }
        }
        
        $w = array(110, 30, 25, 25);
        $productIds = [];
        //print_r($data['categories']);
        
        foreach($products_list as $products) {
            foreach($products as $product){
                $productIds[]=$product['product_id'];
            }
        }

        $unitsGateway = new ProdUnits($this->registry);
        $priceUnits = $unitsGateway->getProductsWithUnit($productIds, 'isPriceBase');
        $saleUnits = $unitsGateway->getProductsWithUnit($productIds, 'isSaleBase');

        //print_r($priceUnits);
        //$links=[];
        foreach($categories_tree as $category_level1){
            $pdf->AddPage();
            $pdf->setLink($links[$category_level1['category_id']]);

            /*
            
            $pdf->Write(5,'here',$link);
            
            */

            foreach($category_level1['list'] as $category_level2){
                $pdf->setLink($links[$category_level2['category_id']]);

                if (isset($category_level2['list'])){
                    
                    foreach($category_level2['list'] as $category_level3){
                        //$pdf->setLink($links[$category_level3['category_id']]);
                        //Заголовок
                        $pdf->SetFont('OpenSansBold','B',9); 
                        $pdf->SetTextColor(65,115,126);
                        $pdf->Cell(20,6,iconv('utf-8', 'windows-1251', $category_level1['name'].' > '.$category_level2['name'].' > '.$category_level3['name']),'',0,'L');
                        $pdf->Ln(6);

                        if(isset($products_list[$category_level3['category_id']])){
                            //Шапка таблицы
                            $pdf->SetFillColor(213,171,129);
                            $pdf->SetTextColor(255,255,255);
                            
                            $fill = false;
                            $pdf->SetLineWidth(.3);
                            $pdf->SetDrawColor(160,160,160);
                            $pdf->SetFont('OpenSansBold','B',9); 
                            $header=['Название','Упаковка','Цена розница','Цена опт'];
                            for($i=0;$i<count($header);$i++){
                                $pdf->Cell($w[$i],7,iconv('utf-8', 'windows-1251', $header[$i]),1,0,'C',true);
                            }
                            $pdf->Ln();
                            
                            foreach($products_list[$category_level3['category_id']] as $product){
                                $package = '';
                                if( isset($saleUnits[$product['product_id']]) ){
                                    $saleUnit = $saleUnits[$product['product_id']];
                                    $package = iconv('utf-8', 'windows-1251', $saleUnit['name']);
                                    if( isset($saleUnit['calcKoef']) && isset($saleUnit['to_name_plural']) ){
                                        $packageStr = \WS\Override\Gateway\ProdUnits\ProdUnitStrings::packageString(
                                            $saleUnit['calcKoef'],
                                            [
                                                'pluralGenitive' => $saleUnit['to_name_plural'],
                                                'single' => $saleUnit['to_name'],
                                                'genitive' => $saleUnit['to_name_genitive']??null
                                            ]
                                        );
                                        $packageStr=iconv('utf-8', 'windows-1251', $packageStr);
                                        $packageStr=str_replace("<sup>","",$packageStr);
                                        $packageStr=str_replace("</sup>","",$packageStr);
                                        
                                        $packageStr=str_replace("&amp;","&",$packageStr);

                                        $package .= ', ' . $packageStr;
                                        /*
                                        $package=iconv('utf-8', 'windows-1251', $package);
                                        $package=str_replace("<sup>","",$package);
                                        $package=str_replace("</sup>","",$package);
                                        */
                                        //$package=iconv('utf-8', 'windows-1251', $package);

                                    }
                                }
                                
                                //Таблица
                                $pdf->SetTextColor(0);
                                $pdf->SetFillColor(240,240,240);
                                $pdf->SetFont('OpenSans','B',8); 
                                $pdf->Cell($w[0],6,iconv('utf-8', 'windows-1251', $product['name']),'LRB',0,'L',$fill);
                                $pdf->Cell($w[1],6,$package,'LRB',0,'C',$fill);
                                $pdf->Cell($w[2],6,number_format($product['price'], 2, '.', ' ').$rub,'LRB',0,'R',$fill);
                                $pdf->Cell($w[3],6,number_format($product['price_wholesale'], 2, '.', ' ').$rub,'LRB',0,'R',$fill);
                                $pdf->Ln();
                                $fill = !$fill;
                            }
                            $pdf->Cell('',0,'','T');
                            $pdf->Ln(6);
                        }    
                    }
                }else{
                    
                    //Заголовок
                    $pdf->SetFont('OpenSansBold','B',9); 
                    $pdf->SetTextColor(65,115,126);
                    $pdf->Cell(20,6,iconv('utf-8', 'windows-1251', $category_level1['name'].' > '.$category_level2['name']),'',0,'L');
                    $pdf->Ln(6);

                    if(isset($products_list[$category_level2['category_id']])){
                        //Шапка таблицы
                        $pdf->SetFillColor(213,171,129);
                        $pdf->SetTextColor(255,255,255);
                        $fill = false;
                        $pdf->SetLineWidth(.3);
                        $pdf->SetDrawColor(160,160,160);
                        $pdf->SetFont('OpenSansBold','B',9); 
                        $header=['Название','Упаковка','Цена розница','Цена опт'];
                        for($i=0;$i<count($header);$i++){
                            $pdf->Cell($w[$i],7,iconv('utf-8', 'windows-1251', $header[$i]),1,0,'C',true);
                        }
                        $pdf->Ln();
                        
                        foreach($products_list[$category_level2['category_id']] as $product){
                            
                                 
                            $package = '';
                            if( isset($saleUnits[$product['product_id']]) ){
                                $saleUnit = $saleUnits[$product['product_id']];
                                $package = iconv('utf-8', 'windows-1251', $saleUnit['name']);
                                
                                if( isset($saleUnit['calcKoef']) && isset($saleUnit['to_name_plural']) ){
                                    $packageStr = \WS\Override\Gateway\ProdUnits\ProdUnitStrings::packageString(
                                        $saleUnit['calcKoef'],
                                        [
                                            'pluralGenitive' => $saleUnit['to_name_plural'],
                                            'single' => $saleUnit['to_name'],
                                            'genitive' => $saleUnit['to_name_genitive']??null
                                        ]
                                    );
                                    $packageStr=iconv('utf-8', 'windows-1251', $packageStr);
                                    $packageStr=str_replace("<sup>","",$packageStr);
                                    $packageStr=str_replace("</sup>","",$packageStr);
                                    $packageStr=str_replace("&amp;","&",$packageStr);

                                    $package .= ', ' . $packageStr;
                                    //$package=iconv('utf-8', 'windows-1251', $package);
                                    //$package .= ', ' . $packageStr;
                                    //$package=iconv('utf-8', 'windows-1251', $package);
                                    //$package=str_replace("<sup>","",$package);
                                    //$package=str_replace("</sup>","",$package);
                                }
                            }
                            
                            //Таблица
                            $pdf->SetTextColor(0);
                            $pdf->SetFillColor(240,240,240);
                            $pdf->SetFont('OpenSans','B',8); 
                            $pdf->Cell($w[0],6,iconv('utf-8', 'windows-1251', $product['name']),'LRB',0,'L',$fill);
                            $pdf->Cell($w[1],6,$package,'LRB',0,'C',$fill);
                            $pdf->Cell($w[2],6,number_format($product['price'], 2, '.', ' ').$rub,'LRB',0,'R',$fill);
                            $pdf->Cell($w[3],6,number_format($product['price_wholesale'], 2, '.', ' ').$rub,'LRB',0,'R',$fill);
                            
                            $pdf->Ln();
                            $fill = !$fill;
                        }
                        $pdf->Cell('',0,'','T');
                        $pdf->Ln(6);
                    }
                }

                
                //print_r($products_list[$category_level2['category_id']]);
            }
        }
        

        //Сноски
        
        $pdf->SetTextColor(213,171,129);
        $pdf->Write(4,'*');
        $pdf->SetTextColor(0);
        $pdf->Write(4,iconv('utf-8', 'windows-1251', ' Цены на все стоительные, отделочные и расходные материалы указаны в рублях с учетом НДС;'));
        $pdf->Ln();

        $pdf->SetTextColor(213,171,129);
        $pdf->Write(4,'*');
        $pdf->SetTextColor(0);
        $pdf->Write(4,iconv('utf-8', 'windows-1251', ' Цены указаны с учетом самовывоза со складов поставщиков. Стоимость доставки уточняйте у менеджеров;'));
        $pdf->Ln();

        $pdf->SetTextColor(213,171,129);
        $pdf->Write(4,'*');
        $pdf->SetTextColor(0);
        $pdf->Write(4,iconv('utf-8', 'windows-1251', ' Оптовые цены действительны только при 100% предоплате;'));
        $pdf->Ln();

        $pdf->SetTextColor(213,171,129);
        $pdf->Write(4,'*');
        $pdf->SetTextColor(0);
        $pdf->Write(4,iconv('utf-8', 'windows-1251', ' Региональным и торгующим организациям предоставляются доп. скидки на некоторые группы товаров.'));
        $pdf->Ln();
        




        

/*
        $pdf->Write(5,"To find out what's new in this tutorial, click ");
        $link = $pdf->AddLink();
        $pdf->Write(5,'here',$link);
        $pdf->AddPage();
        
        $pdf->Write(5,'Ghbsrn');
        $pdf->Ln();        
        $pdf->Write(5,'Ghbsrn');
        $pdf->Ln();        
        $pdf->Write(5,'Ghbsrn');
        $pdf->Ln();
        $pdf->Write(5,'Ghbsrn');
        $pdf->Ln();
        $pdf->setLink($link,10);
        $pdf->Ln();
        $pdf->Cell(10,6,'teet','LR',0,'R',$fill,$link);
*/        
       
        $pdf->Output();
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