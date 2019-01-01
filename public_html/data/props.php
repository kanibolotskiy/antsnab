<?php
use WS\Override\Gateway\ProdProperties;

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

$previewProps = [
    'osnova' => 'Основа', // products/teplonositeli/propilenglikol/termostrim-eco-10kg/ 
    'material' => 'Верхнее покрытие', // products/roll/orgkrovlya/steklokrom/p-30-stekloholst/
    'p2' => 'Плотность'
];

$dstDB->query("delete from product_prodproperty");
$dstDB->query("delete from category_prodproperty");

function getXMLVal($data, $key)
{
    if (isset($data[$key])) {
        if (is_string($data[$key])) {
            return $data[$key];
        }
    }
    return '';
}

function special_empty($val){
    if ( $val === '0' || $val === 0) {
        return false;
    }
    return empty($val);
}

$counter = 0;
foreach ($dstFinalCategories as $dstFinalCategory) {
    $categorySrcId = $dstFinalCategory['srcId'];
    $categoryDstId = $dstFinalCategory['category_id'];
    $query2 = "select document_id, document_content from documents where document_id = " . $categorySrcId . " limit 1";
    $rows = $srcDB->query($query2)->rows;
    $srcFinalCategory = $rows[0];

    /* @$XML_PARENT = new SimpleXMLElement($srcFinalCategory['document_content']);
      $srcFinalCategoryData = json_decode(
      json_encode(
      $XML_PARENT
      ), 1
      );
      $srcFinalProducts = []; */

    $dstFinalCatProperties = [];
    $query3 = "select document_id, document_content, document_name from documents where document_parent_id = " . $srcFinalCategory['document_id'];
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
        $srcName = $srcFinalProduct['document_name'];
        $i = 1;
        //свойства для сводных таблиц
        while (!empty($srcFinalProductData['h' . $i])) {
            $propertyName = $srcFinalProductData['h' . $i];
            $propertyUnit = !empty($srcFinalProductData['he' . $i]) ? $srcFinalProductData['he' . $i] : '';
            $propertyValue = !special_empty($srcFinalProductData['hv' . $i]) ? $srcFinalProductData['hv' . $i] : '';

            //заполним родительскую категорию первыми попавшимися значениями
            if (!isset($dstFinalCatProperties[$propertyName])) {
                $dstFinalCatProperties[$propertyName] = [
                    'name' => $propertyName,
                    'category_id' => $categoryDstId,
                    'type_id' => 1,
                    'showInProdTab' => 0,
                    'unit' => '',
                    'default' => '',
                    'showInProdPreview' => 0, //????
                    'showInSummary' => 1,
                    'sortOrder' => $i,
                ];
            }
            if (empty($dstFinalCatProperties[$propertyName]['unit']) && !empty($propertyUnit)) {
                $dstFinalCatProperties[$propertyName]['unit'] = $propertyUnit;
            }
            if (special_empty($dstFinalCatProperties[$propertyName]['default']) && !special_empty($propertyValue)) {
                $dstFinalCatProperties[$propertyName]['default'] = $propertyValue;
            }
            
            if( $propertyValue != $dstFinalCatProperties[$propertyName]['default']) { 
                $dstFinaProdProperties[$srcId][$propertyName] = [
                    'val' => $propertyValue,
                    'sortOrder' => $i,
                    'hide' => 0, 
                ];
            }

            $i++;
        }

        $previewPropsData = array_intersect_key($srcFinalProductData, $previewProps);
        foreach ($previewPropsData as $propertyKey => $propertyValue) {
            $propertyName = $previewProps[$propertyKey];
            $propertyUnit = '';
            if ($propertyKey == 'p2') {
                $propertyUnit = 'г/м<sup>2</sup>';//не работает с тегами хз почему
            }

            //заполним родительскую категорию первыми попавшимися значениями
            if (!isset($dstFinalCatProperties[$propertyName])) {
                $dstFinalCatProperties[$propertyName] = [
                    'name' => $propertyName,
                    'category_id' => $categoryDstId,
                    'type_id' => 1,
                    'showInProdTab' => 0,
                    'unit' => '',
                    'default' => '',
                    'showInProdPreview' => 1,
                    'showInSummary' => 0,
                    'sortOrder' => $i,
                ];
            }
            if (empty($dstFinalCatProperties[$propertyName]['unit']) && !empty($propertyUnit)) {
                $dstFinalCatProperties[$propertyName]['unit'] = $propertyUnit;
            }
            if (empty($dstFinalCatProperties[$propertyName]['default']) && !empty($propertyValue)) {
                $dstFinalCatProperties[$propertyName]['default'] = $propertyValue;
            }

            if( $propertyValue != $dstFinalCatProperties[$propertyName]['default']) { 
                $dstFinaProdProperties[$srcId][$propertyName] = [
                    'val' => $propertyValue,
                    // 'sortOrder' => $i,
                    'sortOrder' => '',
                    'hide' => 0,
                ];
            }

            $i++;
        }
    }

    //запишем свойства категории
    $propModel = new ProdProperties($registry);
    foreach ($dstFinalCatProperties as $propName => $prop) {
        $propId = $propModel->addProperty($prop);
        foreach ($dstFinaProdProperties as $model => $productProps) {
            if (!isset($productProps[$propName])) {
                continue;
            }
            $category_prodproperty_id = $propId;
            $val = $productProps[$propName]['val'];
            $sortOrder = $productProps[$propName]['sortOrder'];
            $hide = $productProps[$propName]['hide'];


            $sql = "insert into product_prodproperty  (category_prodproperty_id, product_id, val, sortOrder, hide) values "
                . "(:category_prodproperty_id, (select product_id from oc_product where model=:model), :val, :sortOrder, :hide) ";

            $dstDB->query($sql, [
                ':category_prodproperty_id' => $category_prodproperty_id,
                ':model' => $model,
                ':val' => ( '' === trim($val) ) ? null : $val,
                ':sortOrder' => ( '' === trim($sortOrder) ) ? null : (int) $sortOrder,
                ':hide' => ( isset($hide) ) ? $hide : 0
            ]);
        }
    }

    echo "\n migrated " . $counter . " final categories ";
    $counter++;
    /* echo('<h1>Category:</h2>');
      echo('<pre>');
      print_r($dstFinalCatProperties);
      echo('</pre>');
      echo('<h2>Products start, total:'.count($dstFinaProdProperties).'</h2>');
      echo('<pre>');
      print_r($dstFinaProdProperties);
      echo('</pre>');
      if ( $counter > 10 ) {
      die();
      } */
}