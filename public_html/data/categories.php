<?php

include_once __DIR__ . '/bootstrap.php';
include_once 'admin/model/catalog/category.php';

define('SRC_ROOT_LEVEL_ID', 209);
define('SRC_CATEGORY_DOCUMENT_TYPE', 241);

global $SRC_PRODUCT_DOCUMENT_TYPES;
$SRC_PRODUCT_DOCUMENT_TYPES = [253, 2547, 2555, 2556, 2557, 2558, 2559, 2560];

define('SRC_DATABASE_NAME', 'antsnaborigin');
//other credentials are same as for OC base. change if not

define('DST_DEFAULT_LANGUAGE_ID', 1);
define('DST_DEFAULT_ROOT_CATEGORY', 71);

$tidyConf = [
    'indent' => true,
    //'output-xhtml' => true,
    'input-xml' => true,
    'bare' => true,
    'wrap' => 200
];

global $finalCategoriesCache;
$finalCategoriesCache = null;

global $dstDB;
$dstDB = $registry->get('db');

global $srcDB;
$srcDB = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, SRC_DATABASE_NAME);

function getDstParentId($srcParentId)
{
    global $dstDB;

    if ($srcParentId == SRC_ROOT_LEVEL_ID) {
        return DST_DEFAULT_ROOT_CATEGORY;
    }

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

function insertAdditionalDescriptionFields($srcBottomText, $srcKeyword2, $categoryId)
{
    global $dstDB;

    $sql = "update oc_category_description set description_bottom='$srcBottomText', meta_keyword2='$srcKeyword2' where category_id = $categoryId";

    $dstDB->query($sql);
}

function insertAdditionalCategoryFields($srcID, $categoryId)
{
    global $dstDB;
    $dstDB->query("update oc_category set srcId=$srcID where category_id = $categoryId");
}

function getDstSeoKeword($srcSeo)
{
    return basename(trim($srcSeo));
}

function getImagePath($srcImage)
{
    return 'catalog' . trim($srcImage);
}

function isFinal($srcDocumentId)
{
    global $srcDB;
    global $finalCategoriesCache;
    global $SRC_PRODUCT_DOCUMENT_TYPES;

    if (null === $finalCategoriesCache) {
        $rows = $srcDB->query("select distinct(document_parent_id) as catId from documents where document_type in (" . implode(',', $SRC_PRODUCT_DOCUMENT_TYPES) . ")" )->rows;
        foreach ($rows as $row) {
            $finalCategoriesCache[] = $row['catId'];
        }
    }
    return in_array($srcDocumentId, $finalCategoriesCache) ? 1 : 0;
}

function getMetaKeyword($keywords, $keyword)
{
    if ( is_string($keywords) && !empty($keywords) ) {
        return trim($keywords);        
    } elseif  ( is_string($keyword) && !empty($keyword) ) {
        return trim($keyword);
    } else {
        return '';
    }
}

$dataMapping = [
    'srcId' => 'document_id',
    'parent_id' => 'document_parent_id',
    'sort_order' => 'document_sort',
    'keyword' => 'document_url',
    'image' => 'img_part', // /images/products/Bitumnye-rulonnye-materialy_2031.jpg catalog/cart.png ?????
    'isfinal' => 'document_level',
];

$dataConst = [
    'status' => 1,
    'filter' => '',
    'top' => 1,
    'column' => 1,
    'category_store' => ['0'],
    'category_layout' => [''],
];

$dataDescriptionMapping = [
    'name' => 'document_name',
    'description' => 'full_text',
    'description_bottom_text' => 'txt_bottom',
    'meta_title' => 'title',
    'meta_h1' => 'caption_part',
    'meta_description' => 'description',
    'meta_keyword' => 'keywords',
    'meta_keyword2' => 'keyword',
];


//categories src request
$sql = "select document_id, document_parent_id, document_level, document_sort, document_name, document_url, document_content from documents where document_type = " . SRC_CATEGORY_DOCUMENT_TYPE . " and document_deleted = 0 order by document_level, document_parent_id";
$rows = $srcDB->query($sql)->rows;

$counter = 0;
foreach ($rows as $row) {
    $srcDataDb = $row;
//    libxml_use_internal_errors(true);

    /*$tidy = tidy_parse_string($srcDataDb['document_content'], $tidyConf, 'UTF8');
    $res = $tidy->cleanRepair();
    $tidy = preg_replace("/xmlns=\"[^\"]*\"/", "", $tidy);
    $str = (string) $tidy;*/
    @$XML = new SimpleXMLElement($srcDataDb['document_content']);

    /* if (!$XML) {
      echo "Ошибка загрузки XML для \n " . $row['document_id'];
      foreach (libxml_get_errors() as $error) {
      echo "\t", $error->message;
      }
      } */
    $srcMoreData = json_decode(
        json_encode(
            $XML
        ), 1
    );
    $srcData = array_merge($srcDataDb, $srcMoreData);

    $dstData = [
        'category_description' => [
            DST_DEFAULT_LANGUAGE_ID => []
        ],
    ];
    foreach ($dataMapping as $key => $srcKey) {
        if ($key == 'srcId') {
            continue;
        } elseif ($key == 'parent_id') {
            $dstData[$key] = getDstParentId($srcData[$srcKey]);
        } elseif ($key == 'keyword') {
            $dstData[$key] = getDstSeoKeword($srcData[$srcKey]);
        } elseif ($key == 'image') {
            $dstData[$key] = getImagePath($srcData[$srcKey]);
        } elseif ($key == 'isfinal') {
            $dstData[$key] = isFinal($srcData['document_id']);
        } else {
            $dstData[$key] = trim($srcData[$srcKey]);
        }
    }

    foreach ($dataDescriptionMapping as $key => $srcKey) {
        if ($key == 'description_bottom text' || $key == 'meta_keyword2') {
            continue;
        } elseif ($key == 'meta_keyword') {
            $dstData['category_description'][DST_DEFAULT_LANGUAGE_ID][$key] = getMetaKeyword($srcData['keywords'], $srcData['keyword']);
        } else {
            $dstData['category_description'][DST_DEFAULT_LANGUAGE_ID][$key] = trim($srcData[$srcKey]);
        }
    }

    foreach ($dataConst as $key => $value) {
        $dstData[$key] = $value;
    }

    $catModel = new ModelCatalogCategory($registry);
    $lastCategoryId = $catModel->addCategory($dstData);
    $catModel->afterAddCategory($dstData, $lastCategoryId);

    insertAdditionalDescriptionFields(
        trim($srcData['txt_bottom']), trim($srcData['keyword']), $lastCategoryId
    );
    insertAdditionalCategoryFields(
        trim($srcData['document_id']), $lastCategoryId
    );

    $counter++;
    echo "\n migrated " . $counter . " categories ";

 /*   if ($counter > 30) {
        break;
    }
*/
}




