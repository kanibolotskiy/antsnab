<?php
include_once __DIR__ . '/bootstrap.php';
include_once 'admin/model/newsblog/category.php';
include_once __DIR__ . '/../admin/model/catalog/review.php';

$reviewModel = new ModelCatalogReview($registry);
define('DEFAULT_PRODUCT_ID', 0); //product for company review marker
define('DEFAULT_RAITING', 5);
define('DEFAULT_STATUS', 0); 
define('DEFAULT_ABOUT_PRODUCT', '"Продукте"');
define('DEFAULT_ABOUT_COMPANY', '"Сервисе"');
define('DEFAULT_MODERATOR', 'Ант-Снаб');

define('SRC_DATABASE_NAME', 'antsnaborigin');

global $dstDB;
$dstDB = $registry->get('db');

global $srcDB;
$srcDB = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, SRC_DATABASE_NAME);

define('REVIEW_TYPE_WITH_ANSWERS', 296);
define('REVIEW_TYPE_COMMENT_ONLY', 785);

function getData($row)
{
    if($row['document_type'] == REVIEW_TYPE_WITH_ANSWERS) return getDataFrom296($row);
    return getDataFrom785($row);
}

function parseXML($xml)
{
    @$XML_PARENT = new SimpleXMLElement($xml);
    $src = json_decode(
        json_encode(
            $XML_PARENT
        ), 1
    );
    return $src;
}

function getXMLVal($data, $key)
{
    if (isset($data[$key])) {
        if (is_string($data[$key])) {
            return $data[$key];
        }
    }
    return '';
}

/** impl */
function getDataFrom296($row)
{
    $src = parseXML($row['document_content']);

    $text_comment = getXMLVal($src, 'text_comment');
    $text_comment = empty($text_comment)?getXMLVal($src, 'u_comment'):$text_comment;

    $about = ($row['document_link3']==0)?DEFAULT_ABOUT_COMPANY:DEFAULT_ABOUT_PRODUCT;

    $status = getXMLVal($src, 'comment_show');
    $status = ($status=='on')?1:DEFAULT_STATUS;

    if( $row['document_link3']!=0 ) {
        //try to find $productId
        $productId = getDstProductId($row['document_link3']);
        if(is_null($productId)) {
            //product not found - save, but not show
            $productId = DEFAULT_PRODUCT_ID;
            $status = 0;
        }
    } else {
        $productId = DEFAULT_PRODUCT_ID; //company review
    }

    $moderator = getXMLVal($src, 'ansver_from');
    $moderator = empty($moderator)?DEFAULT_MODERATOR:$moderator;

    return [
        'about' => $about,
        'answer'=> getXMLVal($src, 'ansver'), 
        'moderator'=>$moderator,
        'email' =>getXMLVal($src, 'u_email'),
        'company'=> '',
        'author'=> getXMLVal($src,'u_name'),
        'product_id'=>$productId,
        'text'=>$text_comment,
        'rating'=> DEFAULT_RAITING,
        'status'=> $status,
        'date_added'=>( new DateTime() )
                ->setTimestamp($row['document_create_time']) 
                ->format('Y-m-d')
    ];
}

/** impl */
function getDataFrom785($row)
{
    $src = parseXML($row['document_content']);

    $about = ($row['document_link3']==0)?DEFAULT_ABOUT_COMPANY:DEFAULT_ABOUT_PRODUCT;

    $status = getXMLVal($src, 'show_comment');
    $status = ($status=='on')?1:DEFAULT_STATUS;

    if( $row['document_link3']!=0 ) {
        //try to find $productId
        $productId = getDstProductId($row['document_link3']);
        if(is_null($productId)) {
            //product not found - save, but not show
            $productId = DEFAULT_PRODUCT_ID;
            $status = 0;
        }
    } else {
        $productId = DEFAULT_PRODUCT_ID; //company review
    }


    $moderator = getXMLVal($src, 'ansver_from');
    $moderator = empty($moderator)?DEFAULT_MODERATOR:$moderator;

    return [
        'about' => $about,
        'answer'=>'', 
        'moderator'=>'',
        'email' =>getXMLVal($src, 'email'),
        'company' => getXMLVal($src, 'organozation'),
        'author'=> getXMLVal($src,'author'),
        'product_id'=>$productId,
        'text'=>getXMLVal($src, 'text_comment'),
        'rating'=> getXMLVal($src, 'rating_tovar'),
        'status'=> DEFAULT_STATUS,
        'date_added'=>( new DateTime() )
                ->setTimestamp($row['document_create_time']) 
                ->format('Y-m-d')
    ];
}

/** impl */
function getDstProductId($srcId)
{
    $val = null;
    global $dstDB;
    $sql = "select product_id from oc_product where model = " . $srcId . " limit 1";
    $rows = $dstDB->query($sql)->rows;
    if( count($rows) == 1) {
        $val = $rows[0]['product_id'];
    }
    return $val;
}

$sql = "select document_id, document_type, document_create_time, document_link3, document_content from documents where document_type in (" . REVIEW_TYPE_WITH_ANSWERS . "," . REVIEW_TYPE_COMMENT_ONLY .") 
     order by document_create_time, document_id";

$rows = $srcDB->query($sql)->rows;
$counter = 1;
foreach ($rows as $row) {
    $review = getData($row);
    $reviewId = $reviewModel->addReview($review);
    $output = '';
    $reviewModel->afterEditReview($reviewId, $review, $output);

    echo "\n migrated " . $counter . " reviews ";
    $counter++;
}


/* Внимательно проверь перенесены ли отзывы 

отзыв о товаре
document_type=785
document_link3 - связь на продукт
document_create_time=1471270151

785
<root>
    <author>
    Иван Сергеевич
    </author>
    <email>das@bk.ru<
    /email>
    <organozation>
        паровоз
    </organozation>
    <rating_tovar>5</rating_tovar>
    <show_comment>on</show_comment>
    <text_comment>
         Делал ремонт крыши на гараже, стал искать, чем лучше приклеить рубероид. Почитал здесь на сайте, по всем показателям мне подошла мастика МБК-Г.  Цена и качество хорошее.   
    </text_comment>
</root>

отзыв о компании или вопрос о товаре
document_type=296
document_create_time=1471270151
все о сервисе

296
<root>
    <ansver>
        &lt;p&gt;Такая возможность очень скоро появится, но пока отгрузку осуществляется
только со склада Пушкино.&lt;/p&gt;
    </ansver>
    <ansver_from>
        Дмитриева Ирина
    </ansver_from>
    <comment_show>on</comment_show>
    <text_comment>Можно ли приобрести горячую кровельную мастику на складе Высоковольтный?
    </text_comment>
    <u_comment>Можно ли приобрести горячую кровельную мастику на складе Высоковольтный?
    </u_comment>
    <u_email>
        zapravshik007@mail.ru
    </u_email>
    <u_name>Пончик</u_name>
</root>
Логика:
- добавить отзывы о компании вперемешку с вопросами - сам разберется ( по type=296)  отсортировать по document_create_time
- сделать выборку по type=296 и type=785 где document_link3 <> 0, отсортировать по document_create_time
циклом добавлять отзывы. разбор в зависимости от типа (две функции)*/

