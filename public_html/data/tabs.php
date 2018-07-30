<?php

use WS\Override\Gateway\ProdTabs;

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

$dstDB->query("delete from product_prodtab");
$dstDB->query("delete from category_prodtab");

function getXMLVal($data, $key)
{
    if (isset($data[$key])) {
        if (is_string($data[$key])) {
            return $data[$key];
        }
    }
    return '';
}

function specialMerge($catData, $prodData)
{
    //clean data from empty values
    $srcSelfClean = [];
    $srcParentClean = [];
    foreach ($prodData as $key => $val) {
        if (is_string($val) && !empty($val)) {
            $srcSelfClean[$key] = $val;
        }
    }
    foreach ($catData as $key => $val) {
        if (is_string($val) && !empty($val)) {
            $srcParentClean[$key] = $val;
        }
    }

    $product = array_merge($prodData, $srcParentClean, $srcSelfClean);
    $product['catOrigin'] = $srcParentClean;
    $product['prodOrigin'] = $srcSelfClean;

    return $product;
}

$counter = 0;
foreach ($dstFinalCategories as $dstFinalCategory) {
    $categorySrcId = $dstFinalCategory['srcId'];
    $categoryDstId = $dstFinalCategory['category_id'];
    $query2 = "select document_id, document_content from documents where document_id = " . $categorySrcId . " limit 1";
    $rows = $srcDB->query($query2)->rows;
    $srcFinalCategory = $rows[0];

    @$XML_PARENT = new SimpleXMLElement($srcFinalCategory['document_content']);
    $srcFinalCategoryData = json_decode(
        json_encode(
            $XML_PARENT
        ), 1
    );
    $srcFinalProducts = [];

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

        $srcFinalProductData = specialMerge($srcFinalCategoryData, $srcFinalProductData);

        $srcId = $srcFinalProduct['document_id'];
        $srcName = $srcFinalProduct['document_name'];

        //применение
        $propertyName = 'Применение'; 
        @$propertyValue = $srcFinalProductData['primenenie'];
        if( !empty($propertyValue) ) {
            if (!isset($dstFinalCatProperties[$propertyName])) {
                $dstFinalCatProperties[$propertyName] = [
                    'name' => $propertyName,
                    'category_id' => $categoryDstId,
                    'default' => $propertyValue,
                    'sortOrder' => 0,
                ];
            }

            if ($propertyValue != $dstFinalCatProperties[$propertyName]['default']) {
                $dstFinaProdProperties[$srcId][$propertyName] = [
                    'val' => $propertyValue,
                    'sortOrder' => 0,
                    'hide' => 0,
                ];
            }
        }

        //хранение
        $propertyName = 'Хранение'; 
        @$propertyValue = $srcFinalProductData['hranenie'];
        if( !empty($propertyValue) ) {
            if (!isset($dstFinalCatProperties[$propertyName])) {
                $dstFinalCatProperties[$propertyName] = [
                    'name' => $propertyName,
                    'category_id' => $categoryDstId,
                    'default' => $propertyValue,
                    'sortOrder' => 1,
                ];
            }

            if ($propertyValue != $dstFinalCatProperties[$propertyName]['default']) {
                $dstFinaProdProperties[$srcId][$propertyName] = [
                    'val' => $propertyValue,
                    'sortOrder' => 1,
                    'hide' => 0,
                ];
            }
        }

        //скидки
        $propertyName = 'Скидки'; 
        @$propertyValue = $srcFinalProductData['sale'];
        if( !empty($propertyValue) ) {
            if (!isset($dstFinalCatProperties[$propertyName])) {
                $dstFinalCatProperties[$propertyName] = [
                    'name' => $propertyName,
                    'category_id' => $categoryDstId,
                    'default' => $propertyValue,
                    'sortOrder' => 2,
                ];
            }

            if ($propertyValue != $dstFinalCatProperties[$propertyName]['default']) {
                $dstFinaProdProperties[$srcId][$propertyName] = [
                    'val' => $propertyValue,
                    'sortOrder' => 2,
                    'hide' => 0,
                ];
            }
        }
    }

    //запишем свойства категории
    $propModel = new ProdTabs($registry);
    foreach ($dstFinalCatProperties as $propName => $prop) {
        $propId = $propModel->addTab($prop); 

        foreach ($dstFinaProdProperties as $model => $productProps) {
            if (!isset($productProps[$propName])) {
                continue;
            }
            $category_prodproperty_id = $propId;
            $val = $productProps[$propName]['val'];
            $sortOrder = $productProps[$propName]['sortOrder'];
            $hide = $productProps[$propName]['hide'];


            $sql = "insert into product_prodtab  (category_prodtab_id, product_id, val, sortOrder, hide) values "
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

    echo "\n migrated " . $counter . " tabs in final categories ";
    $counter++;
}