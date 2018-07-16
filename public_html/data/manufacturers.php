<?php

include_once __DIR__ . '/bootstrap.php';
include_once 'admin/model/catalog/manufacturer.php';

global $SRC_PRODUCT_DOCUMENT_TYPES;
$SRC_PRODUCT_DOCUMENT_TYPES = [253, 2547, 2555, 2556, 2557, 2558, 2559, 2560];

define('SRC_DATABASE_NAME', 'antsnaborigin');
//other credentials are same as for OC base. change if not

define('DST_DEFAULT_LANGUAGE_ID', 1);

global $dstDB;
$dstDB = $registry->get('db');

global $srcDB;
$srcDB = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, SRC_DATABASE_NAME);

$dataConst = [
    'keyword' => '',
    'image' => '',
    'sort_order' => '',
    'manufacturer_store' => ['0'],
];

$dataDescriptionMapping = [
    'name' => 'item_production',
];

function getProducts()
{
    global $srcDB;
    global $SRC_PRODUCT_DOCUMENT_TYPES;

    $sql = "select D.document_id, D.document_parent_id, D.document_level, D.document_sort, D.document_name, D.document_url, D.document_content, P.document_content as document_parent_content from documents as D "
        . " left join documents as P on P.document_id = D.document_parent_id "
        . " where D.document_type in (" . implode(',', $SRC_PRODUCT_DOCUMENT_TYPES) . ") and D.document_deleted = 0 order by D.document_parent_id, D.document_sort";
    $rows = $srcDB->query($sql)->rows;
    $products = [];

    foreach ($rows as $row) {
        @$XML_PARENT = new SimpleXMLElement($row['document_parent_content']);
        $srcParent = json_decode(
            json_encode(
                $XML_PARENT
            ), 1
        );

        @$XML_SELF = new SimpleXMLElement($row['document_content']);
        $srcSelf = json_decode(
            json_encode(
                $XML_SELF
            ), 1
        );

        $product = array_merge($row, $srcParent, $srcSelf);
        $products[] = $product;
    }

    return $products;
}

$products = getProducts();

$counter = 0;
$manufacturers = [];
foreach ($products as $row) {
    if( is_string($row['item_production']) ) {
        if (!in_array($row['item_production'], $manufacturers) && !empty(trim($row['item_production']))) {
            $manufacturers[] = $row['item_production'];
        }
    }
}

foreach ($manufacturers as $manufacturer) {

    $dstData = [
        'manufacturer_description' => [
            DST_DEFAULT_LANGUAGE_ID => []
        ],
    ];
    foreach ($dataConst as $key => $value) {
        $dstData[$key] = $value;
    }

    $dstData['manufacturer_description'][DST_DEFAULT_LANGUAGE_ID] = [
        'name' => $manufacturer,
        'description' => $manufacturer,
        'meta_title' => $manufacturer,
        'meta_h1' => $manufacturer,
        'meta_description' => $manufacturer,
        'meta_keyword' => $manufacturer,
    ];


    $manModel = new ModelCatalogManufacturer($registry);
    $manModel->addManufacturer($dstData);

    $counter++;
    echo "\n migrated " . $counter . " manufacturers ";
}




