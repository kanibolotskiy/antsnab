<?php

include_once __DIR__ . '/bootstrap.php';
include_once 'admin/model/newsblog/article.php';

define('SRC_DATABASE_NAME', 'antsnaborigin');
//other credentials are same as for OC base. change if not

define('DST_DEFAULT_LANGUAGE_ID', 1);

global $dstDB;
$dstDB = $registry->get('db');

global $srcDB;
$srcDB = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, SRC_DATABASE_NAME);

$query = "select category_id, srcId from oc_category where isfinal = 1";
$dstFinalCategories = $dstDB->query($query)->rows;


var_dump(count($dstFinalCategories));

$counter = 0;
foreach ($dstFinalCategories as $dstFinalCategory) {
    $categorySrcId = $dstFinalCategory['srcId'];
    $query2 = "select document_id, document_content from documents where document_id = " . $categorySrcId . " limit 1";
    $rows = $srcDB->query($query2)->rows;
    $srcFinalCategory = $rows[0];

    /*@$XML_PARENT = new SimpleXMLElement($srcFinalCategory['document_content']);
    $srcFinalCategoryData = json_decode(
        json_encode(
            $XML_PARENT
        ), 1
    );
    $srcFinalProducts = [];*/
    
    $dstFinalCatProperties = [];
    $query3 = "select document_id, document_content from documents where document_parent_id = " . $srcFinalCategory['document_id'];
    $rows = $srcDB->query($query3)->rows;

    $dstFinaProdProperties = [];
    foreach ($rows as $srcFinalProduct) {
        @$XML_PRODUCT = new SimpleXMLElement($srcFinalProduct['document_content']);
        $srcFinalProductData = json_decode(
            json_encode(
                $XML_PRODUCT
            ), 1
        );

        $srcId = $srcFinalProduct['document_id'];
        $i=1;
        while( isset($srcFinalProductData['h'.$i]) ) {
            $propertyName = $srcFinalProductData['h'.$i];
            $propertyUnit = isset($srcFinalProductData['he'.$i])?$srcFinalProductData['he'.$i]:'';
            $propertyValue = isset($srcFinalProductData['hv'.$i])?$srcFinalProductData['hv'.$i]:'';

            //заполним родительскую категорию первыми попавшимися значениями
            if(!isset( $dstFinalCatProperties[$propertyName] ) ) {
               $dstFinalCatProperties[$propertyName] = [
                   'unit' => '',
                   'default' => '',
                   'showInProdPreview' => 0, //????
                   'showInSummary' => 1,
                   'sortOrder' => $i, 
               ];
            }
            if( empty($dstFinalCatProperties[$propertyName]['unit']) && !empty($propertyUnit) ) {
                $dstFinalCatProperties[$propertyName]['unit'] = $propertyUnit;    
            } 
            if( empty($dstFinalCatProperties[$propertyName]['default']) && !empty($propertyValue) ) {
                $dstFinalCatProperties[$propertyName]['default'] = $propertyValue;
            }

            $dstFinaProdProperties[$srcId][$propertyName] = [
                'val' => $propertyValue,
                'sortOrder' => $i,
                'hide' => 0, //???
            ];

            $i++;
        }

        //$srcFinalProducts[] = $srcFinalProductData;
    }
   
    
    echo('<h1>Category:</h2>');
    echo('<pre>');
    print_r($dstFinalCatProperties);
    echo('</pre>');
    echo('<h2>Products start, total:'.count($dstFinaProdProperties).'</h2>');
    echo('<pre>');
    print_r($dstFinaProdProperties);
    echo('</pre>');
    $counter++;
    if ( $counter > 10 ) {
        die();
    }
}