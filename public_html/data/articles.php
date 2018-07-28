<?php

include_once __DIR__ . '/bootstrap.php';
include_once 'admin/model/newsblog/article.php';

global $SRC_PRODUCT_DOCUMENT_TYPES;
$SRC_PRODUCT_DOCUMENT_TYPES = [259];

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

    $rows = $dstDB->query("select category_id from oc_newsblog_category where srcId = $srcParentId ")->rows;
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

function getArticles()
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

/* @todo */

function getPubTime($timestamp)
{
    if( !$timestamp ) {
        return date('Y-m-d H:i:s'); 
    }
    return date('Y-m-d H:i:s', $timestamp);
}

$dataConst = [
    'status' => '1',
    'article_store' => ['0'],
    'related' => '',
    'article_layout' => [''],
    'related_products' => '',
    'article_related' => [],
    'article_related_products' => [],
];

$dataMapping = [
    'date_available' => 'pub_time',
    'image' => 'img_art',
    'keyword' => 'document_url',
    'main_category_id' => 'document_parent_id',
];

$dataDescriptionMapping = [
    'name' => 'caption',
    'preview' => 'pre_txt',
    'description' => 'text',
    'meta_title' => 'title',
    'meta_h1' => 'caption',
    'meta_description' => 'description',
    'meta_keyword' => 'keywords',
];

$articles = getArticles();
$counter = 0;

global $articlesMapping;
$articlesMapping = [];

foreach ($articles as $srcData) {
    $dstData = [
        'article_description' => [
            DST_DEFAULT_LANGUAGE_ID => []
        ],
    ];

    $dstData['article_description'][DST_DEFAULT_LANGUAGE_ID]['tag'] = '';

    foreach ($dataDescriptionMapping as $key => $srcKey) {
        $dstData['article_description'][DST_DEFAULT_LANGUAGE_ID][$key] = trim($srcData[$srcKey]);
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
        } elseif ($key == 'date_available') {
            @$dstData[$key] = getPubTime($srcData[$srcKey]);
        } else {
            @$dstData[$key] = trim($srcData[$srcKey]);
        }
    }

    $counter++;
    $dstData['sort_order'] = $counter;

    $prodModel = new ModelNewsBlogArticle($registry);
    $productId = $prodModel->addArticle($dstData);

    //articles mapping, we will need it later
    $srcId = $srcData['document_id'];
    $articlesMapping['src_' . $srcId] = $productId;

    echo "\n migrated " . $counter . " articles ";

    /*if ($counter > 30) {
        break;
    }*/
}

//analogs and recomendations
$counter = 0;

function getDstRelatedArticle($srcId)
{
    global $articlesMapping;
    return (int) $articlesMapping['src_' . $srcId];
    //return $srcId;
}

global $productsMapping;
$productsMapping = null;

function getDstRelatedProduct($productSrcId)
{
    global $productsMapping, $dstDB;
    if (null === $productsMapping) {
        $result = $dstDB->query("select product_id, model from oc_product");
        $rows = $result->rows;
        foreach ($rows as $row) {
            $productsMapping['src_' . $row['model']] = $row['product_id'];
        }
    }
    if (isset($productsMapping['src_' . $productSrcId])){
       return (int) $productsMapping['src_' . $productSrcId];
    }
    else return null;
}

foreach ($articles as $article) {
    $article_id = getDstRelatedArticle($article['document_id']);
    $dstMentionedProducts = [];

    if (!empty($article['item_in_this_article']) && is_string($article['item_in_this_article'])) {
        $srcMentionedProducts = explode(',', $article['item_in_this_article']);
        $dstAnalogs = [];
        foreach ($srcMentionedProducts as $mentioned) {
            $dstMentioned = getDstRelatedProduct($mentioned);
            if (!empty($dstMentioned)) {
                $dstMentionedProducts[] = $dstMentioned;
            }
        }
    }

    global $dstDB;
    foreach ($dstMentionedProducts as $related_id) {
        $dstDB->query("DELETE FROM " . DB_PREFIX . "newsblog_article_related WHERE article_id = '" . (int) $article_id . "' AND related_id = '" . (int) $related_id . "' AND type=2");
        $dstDB->query("INSERT INTO " . DB_PREFIX . "newsblog_article_related SET article_id = '" . (int) $article_id . "', related_id = '" . (int) $related_id . "', type=2");
    }

    $counter++;
    echo "\n migrated " . $counter . " related products for articles ";

    /*if ($counter > 30) {
        break;
    }*/
}

$dstDB->query("DELETE FROM oc_newsblog_article_related where article_id = 0 or related_id = 0");






