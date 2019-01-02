<?php
/* seo URL нужно прописать через тире! */
include_once __DIR__ . '/bootstrap.php';
include_once 'admin/model/newsblog/article.php';
include_once 'admin/model/catalog/product.php';

global $SRC_PRODUCT_DOCUMENT_TYPES;
$SRC_PRODUCT_DOCUMENT_TYPES = [275,2583];

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

function special_trim($val)
{
    $val = trim($val);
    $val = str_replace('div', 'p', $val);
    return $val;
}

function getImagePath($srcImage)
{
    return 'catalog' . trim($srcImage);
}

function getArticles()
{
    global $srcDB;
    global $SRC_PRODUCT_DOCUMENT_TYPES;

    $sql = "select D.document_id, D.document_publish_time, D.document_parent_id, D.document_level, D.document_sort, D.document_name, D.document_url, D.document_content, P.document_content as document_parent_content from documents as D "
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
        $product['catOrigin'] = $srcParentClean;
        $product['prodOrigin'] = $srcSelfClean;

        $products[] = $product;
    }

    return $products;
}

function firstParagraph($text)
{
   $textTagged = html_entity_decode($text);
   preg_match('/^(<p>)((.|\s)+)(<\/p>)/Ui', $textTagged, $matches);
   if( isset($matches[2]) ) {
       return $matches[2];
   }
   else {
       return $textTagged;
   }
}

/**
 * @deprecated @return DateTime
 */
function getNewsDateFromUrl($url)
{
    $pathParts = explode("/", $url);

    $count = count($pathParts);    
    $day = $pathParts[$count-3];
    $month = $pathParts[$count-4];
    $year = $pathParts[$count-5];
    $dateTime =  DateTime::createFromFormat('Y-m-d', $year . '-' . $month . '-' . $day);
    if(!$dateTime) {
        /*maybe slug is lost*/
        $day = $pathParts[$count-2];
        $month = $pathParts[$count-3];
        $year = $pathParts[$count-4];
        $dateTime = DateTime::createFromFormat('Y-m-d', $year . '-' . $month . '-' . $day);
    }

   return $dateTime; 
}

function getDstSlugFromUrl($url)
{
    $pathParts = explode("/", $url);
    $count = count($pathParts);
    $last = $pathParts[$count-2];
    if(is_numeric($last)) {
        //we lost slug and this is month
        $last = '';
        $count--;
    }
    $first = $pathParts[$count-4];
    $second = $pathParts[$count-3];

    return $first .  '-' . $second .  '-' . $last ;
}

/**
 * @return array 
 * не работает. забил. бывает вот так:
'item_in_this_news' =>
  string(354) "2059,2159,2160,2161,2162,2447,2975,2911,2976,2771,2977,2448,2978,2449,2979,2912,2980,2913,2981,2914,2982,2840,2450,2451,2685,2915,2916,3029,3030,3031,3032,2452,2453,2454,2455,3033,3034,2456,2457,2458,2459,2917,3035,3036,3037,3038,2460,2461,2462,2463,3039,3040,2772,2918,2919,2464,2773,2774,2920,2921,2775,3041,3042,3043,2465,2776,2922,2777,3022,2802,2801"
 или вот так:
 *  'good_1' =>
  string(4) "2159"
  'good_2' =>
  string(4) "2160"
  'good_3' =>
  string(4) "2161"
  'good_4' =>
  string(4) "2162"

 */
function getNewsProducts($srcData, $registry)
{
    $i = 1;
    $prodIds = [];
        var_dump($srcData);
    while( isset($srcData['good_' . $i]) ) {
        $prodIds[] = getDstRelatedProduct($srcData['good_' . $i]);
        $i++;
    }
    $prodNames = [];
    $prodModel = new ModelCatalogProduct($registry);   
    $products = $prodModel->getProducts($prodIds);
    foreach($products as $p) {
        $prodNames[] = $p['model'];
    }
    return $prodNames;
}

global $productsMapping;
$productsMapping = null;
/*Получает соответствия между id продукта в источнике и id в OC. в OC id источника хранится в model (1С id)*/
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

$dataConst = [
    'status' => '1',
    'article_store' => ['0'],
    'related' => '',
    'article_layout' => [''],
    'related_products' => '',
    'article_related' => [],
    'article_related_products' => [],
];

/*это просто для себя, на алгоритм ниже не влияет*/
/*$dataMapping = [
    'date_available' => 'pub_time',//нет таких
    'keyword' => 'document_url',//строить по дате
    'image' => 'img',
    'main_category_id' => 'document_parent_id',
];

$dataDescriptionMapping = [
    'name' => 'caption', //либо caption либо document_name
    'preview' => 'pr_txt',//1й абзац и похуй либо pr_txt
    'description' => 'text',//
    'meta_title' => 'title',//либо document_name
    'meta_h1' => 'caption',//либо document_name
    'meta_description' => 'description',//либо 1й абзац
    'meta_keyword' => 'keywords',//document_name + продукты
];*/

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
    
    //description array
    $dstData['article_description'][DST_DEFAULT_LANGUAGE_ID]['tag'] = '';

    $dstData['article_description'][DST_DEFAULT_LANGUAGE_ID]['name'] = 
        (!empty($srcData['prodOrigin']['caption']))?$srcData['prodOrigin']['caption']:$srcData['document_name'];

    /* preview просто сделаем пустым, тк у нас есть толковая обработка, а в новостях наблюдается хаос */
    $dstData['article_description'][DST_DEFAULT_LANGUAGE_ID]['preview'] ='';     
        /*(!empty($srcData['prodOrigin']['pr_txt']))?$srcData['prodOrigin']['pr_txt']:special_trim(firstParagraph($srcData['prodOrigin']['text']));*/

    @$dstData['article_description'][DST_DEFAULT_LANGUAGE_ID]['description'] = special_trim($srcData['prodOrigin']['text']);    

    $dstData['article_description'][DST_DEFAULT_LANGUAGE_ID]['meta_title'] =
        (!empty($srcData['prodOrigin']['title']))?$srcData['prodOrigin']['title']:$srcData['document_name'];

    $dstData['article_description'][DST_DEFAULT_LANGUAGE_ID]['meta_h1'] = 
        (!empty($srcData['prodOrigin']['caption']))?$srcData['prodOrigin']['caption']:$srcData['document_name'];

    $dstData['article_description'][DST_DEFAULT_LANGUAGE_ID]['meta_description'] = 
        (!empty($srcData['prodOrigin']['description']))?$srcData['prodOrigin']['description']:firstParagraph($srcData['prodOrigin']['text']);  

    $dstData['article_description'][DST_DEFAULT_LANGUAGE_ID]['meta_keyword'] = 
        (!empty($srcData['prodOrigin']['keywords']))?$srcData['prodOrigin']['keywords']:$srcData['keywords'];

    //constants
    foreach ($dataConst as $key => $value) {
        $dstData[$key] = $value;
    }

    /*url end must be in format ... Y/m/d/slug/ to get date*/

    //$dateFromUrl = getNewsDateFromUrl($srcData['document_url']);
    //$date = ($dateFromUrl)?$dateFromUrl->format('Y-m-d H:i:s'):(new DateTime())->format('Y-m-d H:i:s');
    $date = (new DateTime())->setTimestamp($srcData['document_publish_time'])->format('Y-m-d H:i:s');
    $dstData['date_available'] = $date;

    $dstData['keyword'] = getDstSlugFromUrl( $srcData['document_url'] ); 

    @$dstData['image'] = getImagePath( $srcData['img'] );
    $dstData['main_category_id'] = getDstParentId($srcData['document_parent_id']);

    $counter++;
    $dstData['sort_order'] = $counter;

    $prodModel = new ModelNewsBlogArticle($registry);
    $productId = $prodModel->addArticle($dstData);

    //articles mapping, we will need it later
    $srcId = $srcData['document_id'];
    $articlesMapping['src_' . $srcId] = $productId;

    echo "\n migrated " . $counter . " news ";

    /*if ($counter > 30) {
        break;
    }*/
}







