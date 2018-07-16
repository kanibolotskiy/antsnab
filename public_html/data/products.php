<?php

include_once __DIR__ . '/bootstrap.php';
include_once 'admin/model/catalog/product.php';

global $SRC_PRODUCT_DOCUMENT_TYPES;
$SRC_PRODUCT_DOCUMENT_TYPES = [253, 2547, 2555, 2556, 2557, 2558, 2559, 2560];

define('SRC_DATABASE_NAME', 'antsnaborigin');
//other credentials are same as for OC base. change if not

define('DST_DEFAULT_LANGUAGE_ID', 1);

global $dstDB;
$dstDB = $registry->get('db');

global $srcDB;
$srcDB = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, SRC_DATABASE_NAME);

function getDstParentId($srcParentId)
{
    global $dstDB;

    $rows = $dstDB->query("select category_id from oc_category where srcId = $srcParentId ")->rows;
    if (count($rows) == 0) {
        throw new Exception("Cant find parent with srcId: " . $srcParentId);
    } elseif (count($rows) > 1) {
        throw new Exception("Too mant parents with srcId: " . $srcParentId);
    }

    $row = $rows[0];
    $parent_id = (int) $row['category_id'];

    return $parent_id;
}

function getDstSeoKeword($srcSeo)
{
    return basename(trim($srcSeo));
}

function getImagePath($srcImage)
{
    return 'catalog' . trim($srcImage);
}

function getMetaKeyword($keywords, $keyword)
{
    if (is_string($keywords) && !empty($keywords)) {
        return trim($keywords);
    } elseif (is_string($keyword) && !empty($keyword)) {
        return trim($keyword);
    } else {
        return '';
    }
}

//@todo @ask
function getMiniDescription($full_text_itemprop)
{
    //???? то ли full_text_itemprop в категории то ли в товаре то ли вообще pr_text
}

function firstParagraph($text)
{
    
}

global $productsInCategoryCount;

function getShowInSummary($category_id)
{
    global $productsInCategoryCount;
    if (!isset($productsInCategoryCount['cat_' . $category_id])) {
        $productsInCategoryCount['cat_' . $category_id] = 0;
    }
    $productsInCategoryCount['cat_' . $category_id] += 1;

    return ($productsInCategoryCount['cat_' . $category_id] > 4 ) ? 0 : true;
}

function getManufacturerId($manufacturerName)
{
    global $dstDB;
    $man_id = 0;
    if (!empty($manufacturerName)) {
        $rows = $dstDB->query("select manufacturer_id from oc_manufacturer where name = '$manufacturerName' limit 1 ")->rows;

        if (!empty($rows)) {
            $row = $rows[0];
            $man_id = (int) $row['manufacturer_id'];
        }
    }

    return $man_id;
}

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

        //clean data from empty values
        $srcSelfClean = [];
        $srcParentClean = [];
        foreach ($srcSelf as $key => $val) {
            if (is_string($val) && !empty($val)) {
                $srcSelfClean[$key] = $val;
            }
        }
        foreach ($srcParent as $key => $val) {
            if (is_string($val) && !empty($val)) {
                $srcParentClean[$key] = $val;
            }
        }

        $product = array_merge($row, $srcParentClean, $srcSelfClean);
        $products[] = $product;
    }

    return $products;
}

$dataConst = [
    'upc' => '',
    'ean' => '',
    'jan' => '',
    'isbn' => '',
    'mpn' => '',
    'tax_class_id' => '0',
    'quantity' => '1',
    'minimum' => '1',
    'subtract' => '0',
    'stock_status_id' => '7',
    'shipping' => '1',
    'date_available' => date('Y-m-d'),
    'length' => '',
    'width' => '',
    'height' => '',
    'length_class_id' => '1',
    'weight' => '',
    'weight_class_id' => '1',
    'status' => '1',
    'produnit_template_id' => '',
    'filter' => '',
    'product_store' => ['0'],
    'points' => '',
    'product_reward' => ['1' => ['points' => '']],
    'product_layout' => [''],
    'download' => '',
    'related' => '',
    'option' => '',
    'wholesale_threshold' => null,
];

$dataMapping = [
    'model' => 'document_id',
    'sku' => 'tu_code',
    'location' => 'preview_text',
    'keyword' => 'document_url',
    'sort_order' => 'document_sort',
    'price' => 'price',
    'price_wholesale' => 'price_opt',
    'wholesale_threshold' => 'opt_size',
    'main_category_id' => 'document_parent_id',
    'image' => 'img_part',
    'manufacturer_id' => 'item_production',
];

$dataDescriptionMapping = [
    'name' => 'short_name',
    'description' => 'full_text_itemprop',
    'meta_title' => 'title',
    'meta_h1' => 'document_name',
    'meta_description' => 'description',
    'meta_keyword' => 'keyword',
    'product_description_mini' => 'pr_text' // ??
];

$products = getProducts();
$counter = 0;

global $productsMapping;
$productsMapping = [];
foreach ($products as $srcData) {

    //?? $productDescriptionMini = getMiniDescription($srcData[$dataDescriptionMapping['product_description_mini']]);
    $productDescriptionMini = $srcData[$dataDescriptionMapping['product_description_mini']];
    $dstData = [
        'product_description' => [
            DST_DEFAULT_LANGUAGE_ID => []
        ],
        'product_description_mini' => [
            DST_DEFAULT_LANGUAGE_ID => $productDescriptionMini,
        ],
        'product_image' => [],
    ];

    $dstData['product_description'][DST_DEFAULT_LANGUAGE_ID]['tag'] = '';

    foreach ($dataDescriptionMapping as $key => $srcKey) {
        if ($key == 'tag' || $key == 'product_description_mini') {
            continue;
        } elseif ($key == 'meta_keyword') {
            $dstData['product_description'][DST_DEFAULT_LANGUAGE_ID][$key] = getMetaKeyword($srcData['keywords'], $srcData['keyword']);
        } else {
            $dstData['product_description'][DST_DEFAULT_LANGUAGE_ID][$key] = trim($srcData[$srcKey]);
        }
    }

    foreach ($dataConst as $key => $value) {
        $dstData[$key] = $value;
    }

    foreach ($dataMapping as $key => $srcKey) {
        if ($key == 'main_category_id') {
            $dstData[$key] = getDstParentId($srcData[$srcKey]);
        } elseif ($key == 'keyword') {
            $dstData[$key] = getDstSeoKeword($srcData[$srcKey]);
        } elseif ($key == 'image') {
            $dstData[$key] = getImagePath($srcData[$srcKey]);
        } elseif ($key == 'manufacturer_id') {
            @$dstData[$key] = getManufacturerId($srcData[$srcKey]);
        } else {
            @$dstData[$key] = trim($srcData[$srcKey]);
        }
    }

    $dstData['showInSummary'] = getShowInSummary($dstData['main_category_id']);

    //additional images
    if (isset($srcData['full_img_1'])) {
        $dstData['product_image'][] = [
            'image' => getImagePath($srcData['full_img_1']),
            'sort_order' => 1,
            'alt' => isset($srcData['alt_1']) ? $srcData['alt_1'] : '',
        ];
    }
    if (isset($srcData['full_img_2'])) {
        $dstData['product_image'][] = [
            'image' => getImagePath($srcData['full_img_2']),
            'sort_order' => 2,
            'alt' => isset($srcData['alt_2']) ? $srcData['alt_2'] : '',
        ];
    }
    if (isset($srcData['full_img_3'])) {
        $dstData['product_image'][] = [
            'image' => getImagePath($srcData['full_img_3']),
            'sort_order' => 3,
            'alt' => isset($srcData['alt_3']) ? $srcData['alt_3'] : '',
        ];
    }
    if (isset($srcData['full_img_4'])) {
        $dstData['product_image'][] = [
            'image' => getImagePath($srcData['full_img_4']),
            'sort_order' => 4,
            'alt' => isset($srcData['alt_4']) ? $srcData['alt_4'] : '',
        ];
    }
    if (isset($srcData['full_img_5'])) {
        $dstData['product_image'][] = [
            'image' => getImagePath($srcData['full_img_5']),
            'sort_order' => 5,
            'alt' => isset($srcData['alt_5']) ? $srcData['alt_5'] : '',
        ];
    }
    if (isset($srcData['full_img_6'])) {
        $dstData['product_image'][] = [
            'image' => getImagePath($srcData['full_img_6']),
            'sort_order' => 6,
            'alt' => isset($srcData['alt_6']) ? $srcData['alt_6'] : '',
        ];
    }
    if (isset($srcData['full_img_7'])) {
        $dstData['product_image'][] = [
            'image' => getImagePath($srcData['full_img_7']),
            'sort_order' => 7,
            'alt' => isset($srcData['alt_7']) ? $srcData['alt_7'] : '',
        ];
    }

    $prodModel = new ModelCatalogProduct($registry);
    $productId = $prodModel->addProduct($dstData);
    $prodModel->afterAddProduct($dstData, $productId);

    //product mapping, we will need it later
    $srcId = $srcData['document_id'];
    $productsMapping['src_' . $srcId] = $productId;

    $counter++;
    echo "\n migrated " . $counter . " products ";

    /*if ($counter > 30) {
        break;
    }*/
}

//analogs and recomendations
$counter = 0;
function getDstRelatedProduct($srcId) {
    global $productsMapping;
    return (int) $productsMapping['src_' . $srcId];
    //return $srcId;
}
foreach ($products as $product) {
    $product_id = getDstRelatedProduct($product['document_id']);
    $srcAnalogs = [];
    $dstAnalogs = [];
    
    if( !empty( $product['analogs'] ) && is_string($product['analogs']) ) {
        $srcAnalogs = explode(',', $product['analogs']);
        $dstAnalogs = [];
        foreach ($srcAnalogs as $srcAnalog) {
            $dstAnalogs[] = getDstRelatedProduct($srcAnalog); 
        }
    }

    if( !empty( $product['recomend'] ) && is_string($product['recomend']) ) {
        $srcRecomends = explode(',' , $product['recomend']);
        $dstRecomends = [];
        foreach ($srcRecomends as $srcRecomend) {
            $dstRecomends[] = getDstRelatedProduct($srcRecomend); 
        }
    }

    $dstRecomendsAndAnalogs = array_merge($dstAnalogs, $dstRecomends);

    global $dstDB;

    foreach ($dstRecomendsAndAnalogs as $related_id) {
        $dstDB->query("DELETE FROM oc_product_related WHERE product_id = '" . (int) $product_id . "' AND related_id = '" . (int) $related_id . "'");
        $dstDB->query("INSERT INTO oc_product_related SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");
        $dstDB->query("DELETE FROM oc_product_related WHERE product_id = '" . (int) $related_id . "' AND related_id = '" . (int) $product_id . "'");
        $dstDB->query("INSERT INTO oc_product_related SET product_id = '" . (int) $related_id . "', related_id = '" . (int) $product_id . "'");
    }

    foreach ($dstAnalogs as $related_id) {
        $dstDB->query("DELETE FROM oc_product_analogs WHERE product_id = '" . (int) $product_id . "' AND related_id = '" . (int) $related_id . "'");
        $dstDB->query("INSERT INTO oc_product_analogs SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");
        $dstDB->query("DELETE FROM oc_product_analogs WHERE product_id = '" . (int) $related_id . "' AND related_id = '" . (int) $product_id . "'");
        $dstDB->query("INSERT INTO oc_product_analogs SET product_id = '" . (int) $related_id . "', related_id = '" . (int) $product_id . "'");
    }

    foreach ($dstRecomends as $related_id) {
        $dstDB->query("DELETE FROM oc_product_recomends WHERE product_id = '" . (int) $product_id . "' AND related_id = '" . (int) $related_id . "'");
        $dstDB->query("INSERT INTO oc_product_recomends SET product_id = '" . (int) $product_id . "', related_id = '" . (int) $related_id . "'");
        $dstDB->query("DELETE FROM oc_product_recomends WHERE product_id = '" . (int) $related_id . "' AND related_id = '" . (int) $product_id . "'");
        $dstDB->query("INSERT INTO oc_product_recomends SET product_id = '" . (int) $related_id . "', related_id = '" . (int) $product_id . "'");
    }


    $counter++;
    echo "\n migrated " . $counter . " analogs and recomends for products ";

    /*if ($counter > 30) {
        break;
    }*/
}
    $dstDB->query("DELETE FROM oc_product_recomends where product_id = 0 or related_id = 0");
    $dstDB->query("DELETE FROM oc_product_analogs where product_id = 0 or related_id = 0");
    $dstDB->query("DELETE FROM oc_product_related where product_id = 0 or related_id = 0");






