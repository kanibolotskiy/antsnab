<?php

include_once __DIR__ . '/bootstrap.php';
include_once 'admin/model/newsblog/category.php';

define('SRC_ROOT_LEVEL_ID', 226);
define('SRC_CATEGORY_DOCUMENT_TYPE', 225);

define('SRC_DATABASE_NAME', 'antsnaborigin');
//other credentials are same as for OC base. change if not

define('DST_DEFAULT_LANGUAGE_ID', 1);
define('DST_DEFAULT_ROOT_CATEGORY', 1); //??

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

function insertAdditionalCategoryFields($srcID, $categoryId)
{
    global $dstDB;
    $dstDB->query("update oc_newsblog_category set srcId=$srcID where category_id = $categoryId");
}

$dataMapping = [
    'parent_id' => 'document_parent_id',
    'keyword' => 'document_url',
];

$dataConst = [
    'category_store' => ['0'],
    'image' => '',
    'image_size_width' => '207',
    'image_size_height' => '167',
    'status' => '1',
    'limit' => '9',
    'sort_by' => 'a.date_available',
    'sort_direction' => 'desc',
    'show_in_sitemap' => '1',
    'show_in_sitemap_articles' => '1',
    'template_category' => 'allnews.tpl',
    'template_article' => 'onearticle.tpl',
    'images_size_width' => '207',
    'images_size_height' => '167',
    'images_size_articles_big_width' => '330',
    'images_size_articles_big_height' => '220',
    'images_size_articles_small_width' => '330',
    'images_size_articles_small_height' => '220',
    'date_format' => 'd.m.Y',
    'category_layout' => ['17'],
    'show_comments_vk_id' => '',
    'show_comments_dq_id' => '',
    'show_in_top' => 0,
    'show_in_top_articles' => 0,
    'show_preview' => 0,
];

$dataDescriptionMapping = [
    'name' => 'document_name',
    'description' => 'description',
    'meta_title' => 'title',
    'meta_h1' => 'document_name',
    'meta_description' => 'description',
    'meta_keyword' => 'keywords',
];


//categories src request
$sql = "select document_id, document_parent_id, document_level, document_sort, document_name, document_url, document_content from documents where document_type = " . SRC_CATEGORY_DOCUMENT_TYPE . " and document_deleted = 0 and document_id <> " . SRC_ROOT_LEVEL_ID . " order by document_parent_id, document_id";
$rows = $srcDB->query($sql)->rows;

$counter = 0;
foreach ($rows as $row) {
    $srcDataDb = $row;

    @$XML = new SimpleXMLElement($srcDataDb['document_content']);
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
        } else {
            $dstData[$key] = trim($srcData[$srcKey]);
        }
    }

    foreach ($dataDescriptionMapping as $key => $srcKey) {
        $dstData['category_description'][DST_DEFAULT_LANGUAGE_ID][$key] = trim($srcData[$srcKey]);
    }

    foreach ($dataConst as $key => $value) {
        $dstData[$key] = $value;
    }

    $counter++;
    $dstData['sort_order'] = $counter;
    $catModel = new ModelNewsBlogCategory($registry);

    $settings_array['date_format'] = $dataConst['date_format'];
    $settings_array['image_size_width'] = $dataConst['image_size_width'];
    $settings_array['image_size_height'] = $dataConst['image_size_height'];
    $settings_array['images_size_articles_big_width'] = $dataConst['images_size_articles_big_width'];
    $settings_array['images_size_articles_big_height'] = $dataConst['images_size_articles_big_height'];
    $settings_array['images_size_articles_small_width'] = $dataConst['images_size_articles_small_width'];
    $settings_array['images_size_articles_small_height'] = $dataConst['images_size_articles_small_height'];
    $settings_array['images_size_width'] = $dataConst['images_size_width'];
    $settings_array['images_size_height'] = $dataConst['images_size_height'];
    $settings_array['limit'] = $dataConst['limit'];
    $settings_array['show_in_sitemap'] = $dataConst['show_in_sitemap'];
    $settings_array['show_in_sitemap_articles'] = $dataConst['show_in_sitemap_articles'];
    $settings_array['show_in_top'] = $dataConst['show_in_top'];
    $settings_array['show_in_top_articles'] = $dataConst['show_in_top_articles'];
    $settings_array['show_preview'] = $dataConst['show_preview'];
    $settings_array['sort_by'] = $dataConst['sort_by'];
    $settings_array['sort_direction'] = $dataConst['sort_direction'];
    $settings_array['template_article'] = $dataConst['template_article'];
    $settings_array['template_category'] = $dataConst['template_category'];
    $settings = serialize($settings_array);

    $lastCategoryId = $catModel->addCategory($dstData, $settings);

    insertAdditionalCategoryFields(
        trim($srcData['document_id']), $lastCategoryId
    );

    echo "\n migrated " . $counter . " news categories ";

}




