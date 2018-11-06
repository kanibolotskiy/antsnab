<?php
//ssee 008.sql
use WS\Override\Gateway\ProdUnits\ProdUnitTemplates;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;

include_once __DIR__ . '/bootstrap.php';
include_once 'admin/model/newsblog/article.php';

define('SRC_DATABASE_NAME', 'antsnaborigin');
//other credentials are same as for OC base. change if not

define('DST_DEFAULT_LANGUAGE_ID', 1);

global $dstDB;
$dstDB = $registry->get('db');
$dstDB->query("delete from produnit_packagestr");
$dstDB->query("delete from produnit_unit");
$dstDB->query("delete from produnit_template");

global $srcDB;
$srcDB = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, SRC_DATABASE_NAME);

global $SRC_PRODUCT_DOCUMENT_TYPES;
$SRC_PRODUCT_DOCUMENT_TYPES = [253, 2547, 2555, 2556, 2557, 2558, 2559, 2560];

$DOCTYPE_DESCRIPTIONS = [
    253 => 'Рулонка', //++
    2547 => 'Краска,Мастики,Праймеры,Битум,Расходники', //++
    2556 => 'Баллончики', //++
    2558 => 'Фанера', //++
    2559 => 'Ламинированая Фанера', //++
    2557 => 'Геотекстиль,Planter', //++
    2560 => 'Теплоносители', //++
    2555 => 'Пергамин,Метизы',
];

global $unitFields;
$unitFields = [
    'document_type',
    'document_parent_id',
    'ed_izm', // ++name_price, базовая //первый в переключателе  
    'ed_izm2', // ++name_price //второй в переключателе коробку
    'norm_ed_izm_1', // ++name_plural //первый в нормах  напр коробок
    'norm_ed_izm_2', // ++name_plural // второй в нормах - хранится так,как выводится рулонов  шт.
    'price', //в соответствии c ed_izm //++какая цена первая - та и базовая для продажи
    'price_2', //
    'price_opt', //
    'price_opt_2', //
//'pack_price',
//'pack_price:text',
    'pack', // картридж, 30мл рулон, 10м2
    'pack_type', //рулон, 2,15 х 130 м
    'pack_type:text',
    'in_roll', //В картридже: 300 мл., '',  в мешке 25 кг, для метизов в коробке N штук, для теплоносителей пусто   
    'na_pallete', //На паллете: 1500 баллончиков!(шт), '', 60 мешков, 60 канистр
    'v_korobke', //В коробке: 15 баллончиков!(шт), В пачке 56 листов фанеры - только у баллончиков и фанек
    'upakovka',
    'listov', //'', в м3 листов 18.663 - параметр ТОЛЬКО у фанер
    'weight', //ФАНЕРА: вес м3 (оргалит м2), РУЛОНЫ: м2, для других нету 
    'roll_weight', //ФАНЕРА: вес листа, Рулоны: вес рулона для Метоизов: вес коробки
    'roll_size', //текстовка только у рулонки 10 м х 1 м
    'depth', //толщина в рулонке
    'f_lista', //только фанеры 2745 х 1220
    't_lista', //только фанеры толщина
    'norm_division', //иногда on ??
    'price2_action', //u умножение, d деление
    'price2_action:text',
    'rashod',
];

function getProducts($document_type = null)
{
    global $srcDB;
    global $SRC_PRODUCT_DOCUMENT_TYPES;
    global $unitFields;

    if (null == $document_type) {
        $document_type = implode(',', $SRC_PRODUCT_DOCUMENT_TYPES);
    }

    $sql = "select D.document_id, D.document_parent_id, D.document_level, D.document_sort, D.document_name, D.document_url, D.document_content, D.document_type, P.document_content as document_parent_content from documents as D "
        . " left join documents as P on P.document_id = D.document_parent_id "
        . " where D.document_type in (" . $document_type /* implode(',', $SRC_PRODUCT_DOCUMENT_TYPES) */ . ") and D.document_deleted = 0 order by D.document_parent_id, D.document_sort";
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
        $empty = [];
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
        foreach ($unitFields as $key) {
            $empty[$key] = '';
        }


        $product = array_merge($empty, $row, $srcParentClean, $srcSelfClean);
        $product['catOrigin'] = $srcParentClean;
        $product['prodOrigin'] = $srcSelfClean;
        $products[] = $product;
    }

    return $products;
}

function setBases($unit, $unitId, $registry)
{
    $gateway = new ProdUnits($registry);
    if (1 == $unit['isBasePrice']) {
        $gateway->setBase('isPriceBase', $unitId);
    }
    if (1 == $unit['isSalePrice']) {
        $gateway->setBase('isSaleBase', $unitId);
    }
    if (1 == $unit['isLoadingPrice']) {
        $gateway->setBase('isPackageBase', $unitId);
    }
}

$products = getProducts();
$counter = 0;
/* Debug proposes */
/*
  $dstDB->query('delete from _units_debug');
  foreach ( $products as $prod ) {
  $row = [
  'model' => $prod['document_id'],
  ];
  foreach ($unitFields as $k) {
  $row[$k] = '';
  }
  foreach( $prod as $key => $value ) {
  if(in_array($key, $unitFields)) {
  $row[$key] = $value;
  }
  }

  $valsAr = [];
  $valsAr['model'] = $row['model'];
  foreach($unitFields as $k) {
  $valsAr[] = $row[$k];
  }
  $dstDB->query("insert into _units_debug (`model`,`".implode('`,`',$unitFields)."`) "
  . "values ('".implode("','",$valsAr)."')");

  //$row is product


  $counter++;
  echo "\n migrated " . $counter . " products";
  }
  die(); */


foreach ($SRC_PRODUCT_DOCUMENT_TYPES as $document_type) {
    $products = getProducts($document_type);
    foreach ($products as $product) {
        /* if( in_array($product['document_id'], [2184,2185,2186]) ) {
          var_dump($product);
          die();
          } */
        switch ($document_type) {
            case 253:
                process253($product, $registry);
                break;
            case 2547:
                process2547($product, $registry);
                break;
            case 2556:
                process2556($product, $registry);
                break;
            case 2559:
                process2559($product, $registry);
                break;
            case 2558:
                process2558($product, $registry);
                break;
            case 2557:
                process2557($product, $registry);
                break;
            case 2560:
                process2560($product, $registry);
                break;
            case 2555:
                process2555($product, $registry);
                break;
            default:
                die('NOTHING');
        }
        $counter++;
        echo "\n migrated " . $counter . " product (units) ";
    }
}

function getRollSizes($src)
{
    $ar = explode('х', $src);
    $dst = ['length' => $ar[0], 'width' => $ar[1]];
    return $dst;
}

function process253($product, $registry)
{
    global $dstDB;
    $dstTemplateData = [
        'name' => $product['document_name'],
        'description' => '',
    ];
    $tplGateWay = new ProdUnitTemplates($registry);
    $tplId = $tplGateWay->add($dstTemplateData);

    $unitGateWay = new ProdUnits($registry);
//1st unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'м<sup>2</sup>';

    $dstUnitData['isBasePrice'] = 1;
    $dstUnitData['switchSortOrder'] = 1;
    if ($product['ed_izm'] == 'рулон') {
        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 2;
    }
    $dstUnitData['isSalePrice'] = 0;
    $dstUnitData['isLoadingPrice'] = 0;
    $dstUnitData['weight'] = $product['weight'];
    $dstUnitData['loadingSortOrder'] = 1;


    $dstUnitData['name_price'] = 'м<sup>2</sup>';
    $dstUnitData['name_plural'] = 'м<sup>2</sup>';
    $dstUnitData['name_package_dimension'] = 'м<sup>2</sup>';
    $dstUnitData['name_in_package'] = 'В м<sup>2</sup>';

    $dstUnitData['package_width'] = '';
    $dstUnitData['package_length'] = '';
    $dstUnitData['package_height'] = $product['depth'] . ' мм';

    $dstUnitData['calcKoef'] = '';
    $dstUnitData['calcRel'] = '';
    $NstId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NstId, $registry);

//2nd unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'рулон';

    $dstUnitData['isBasePrice'] = 0;
    $dstUnitData['switchSortOrder'] = 2;
    if ($product['ed_izm'] == 'рулон') {
        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
    }
    $dstUnitData['isSalePrice'] = 1;
    $dstUnitData['isLoadingPrice'] = 1;
    $dstUnitData['weight'] = $product['roll_weight'];
    $dstUnitData['loadingSortOrder'] = 2;

    $dstUnitData['name_price'] = 'рулон';
    $dstUnitData['name_plural'] = 'рулонов';
    $dstUnitData['name_package_dimension'] = 'рулона';
    $dstUnitData['name_in_package'] = 'В рулоне';

    $sizes = getRollSizes($product['roll_size']);
    $dstUnitData['package_width'] = $sizes['width'];
    $dstUnitData['package_length'] = $sizes['length'];
    $dstUnitData['package_height'] = '';

    $dstUnitData['calcKoef'] = $product['in_roll'];
    $dstUnitData['calcRel'] = $NstId;

    $NndId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NndId, $registry);
//3nd unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'паллета';

    $dstUnitData['isBasePrice'] = 0;
    $dstUnitData['switchSortOrder'] = 0;
    $dstUnitData['isSalePrice'] = 0;
    $dstUnitData['isLoadingPrice'] = 0;
    $dstUnitData['weight'] = '';
    $dstUnitData['loadingSortOrder'] = 0;

    $dstUnitData['name_price'] = 'паллету';
    $dstUnitData['name_plural'] = 'паллет';
    $dstUnitData['name_package_dimension'] = 'паллеты';
    $dstUnitData['name_in_package'] = 'На паллете';

    $dstUnitData['package_width'] = '';
    $dstUnitData['package_length'] = '';
    $dstUnitData['package_height'] = '';

    $dstUnitData['calcKoef'] = $product['na_pallete'];
    $dstUnitData['calcRel'] = $NndId;

    $NrdId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NrdId, $registry);


    //generate strings
    $prodStrings = new ProdUnitStrings($registry);
    $strings = $prodStrings->generate($tplId);
    $prodStrings->saveAll($tplId, $strings);

//product manipulations
    $dstDB->query("update oc_product set produnit_template_id = " . $tplId . ", price='" . $product['price'] . "', price_wholesale=" . $product['price_opt'] . " where model = '" . $product['document_id'] . "'");
}

function process2547($product, $registry)
{
    global $dstDB;
    $vedra = [
        'bo' => [
            'name' => 'бочка',
            'name_price' => 'шт.',
            'name_plural' => 'бочек',
            'name_package_dimension' => 'бочки',
            'name_in_package' => 'В бочке',
        ],
        'br' => [
            'name' => 'брикет',
            'name_price' => 'шт.',
            'name_plural' => 'брикетов',
            'name_package_dimension' => 'брикета',
            'name_in_package' => 'В брикете',
        ],
        'm' => [
            'name' => 'мешок',
            'name_price' => 'шт.',
            'name_plural' => 'мешков',
            'name_package_dimension' => 'мешка',
            'name_in_package' => 'В мешке',
        ],
        'v' => [
            'name' => 'ведро',
            'name_price' => 'шт.',
            'name_plural' => 'вёдер',
            'name_package_dimension' => 'ведра',
            'name_in_package' => 'В ведре',
        ]
    ];

    $dstTemplateData = [
        'name' => $product['document_name'],
        'description' => '',
    ];
    $tplGateWay = new ProdUnitTemplates($registry);
    $tplId = $tplGateWay->add($dstTemplateData);

    $unitGateWay = new ProdUnits($registry);

    $kgVedroSubType = false;
    $rastvoritelSubType = false;
    $shtOnlySubType = false;

    if (!empty($product['pack_type'])) {
        $kgVedroSubType = true; //кг лежит в какой то хуйне
    } elseif (in_array($product['document_id'], [2133, 3189])) {
        $rastvoritelSubType = true; //ёбаная специфическая хуйня
    } else {
        $shtOnlySubType = true; //только штуки 
    }

    if ($kgVedroSubType) {
        $categoriesWhereKgIsBase = [2705];
//1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'кг';

        $dstUnitData['isBasePrice'] = in_array($product['document_parent_id'], $categoriesWhereKgIsBase) ? 1 : 0;
        $dstUnitData['switchSortOrder'] = 2;
        if ($product['ed_izm'] == 'кг') {
            $dstUnitData['switchSortOrder'] = 1;
        }
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 1;


        $dstUnitData['name_price'] = 'кг';
        $dstUnitData['name_plural'] = 'кг';
        $dstUnitData['name_package_dimension'] = 'кг';
        $dstUnitData['name_in_package'] = '';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

//2nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = $vedra[$product['pack_type']]['name'];

        $dstUnitData['isBasePrice'] = in_array($product['document_parent_id'], $categoriesWhereKgIsBase) ? 0 : 1;
        $dstUnitData['switchSortOrder'] = 1;
        if ($product['ed_izm'] == 'кг') {
            $dstUnitData['switchSortOrder'] = 2;
        }
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 1;
        $dstUnitData['weight'] = $product['roll_weight'];
        $dstUnitData['loadingSortOrder'] = 2;

        $dstUnitData['name_price'] = $vedra[$product['pack_type']]['name_price'];
        $dstUnitData['name_plural'] = $vedra[$product['pack_type']]['name_plural'];
        $dstUnitData['name_package_dimension'] = $vedra[$product['pack_type']]['name_package_dimension'];
        $dstUnitData['name_in_package'] = $vedra[$product['pack_type']]['name_in_package'];

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['roll_weight'];
        $dstUnitData['calcRel'] = $NstId;

        $NndId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NndId, $registry);
    }

    if ($shtOnlySubType) {
//1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'шт.';

        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 1;


        $dstUnitData['name_price'] = 'шт.';
        $dstUnitData['name_plural'] = 'шт.';
        $dstUnitData['name_package_dimension'] = 'шт.';
        $dstUnitData['name_in_package'] = '';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

//2nd unit
        $match = preg_match('/\d./', $product['upakovka'], $matches);
        if ($match) {
            $dstUnitData['templateId'] = $tplId;
            $dstUnitData['name'] = 'упаковка';

            $dstUnitData['isBasePrice'] = 0;
            $dstUnitData['switchSortOrder'] = 0;
            $dstUnitData['isSalePrice'] = 0;
            $dstUnitData['isLoadingPrice'] = 0;
            $dstUnitData['weight'] = '';
            $dstUnitData['loadingSortOrder'] = 2;


            $dstUnitData['name_price'] = 'упаковку';
            $dstUnitData['name_plural'] = 'упаковок';
            $dstUnitData['name_package_dimension'] = 'упаковки';
            $dstUnitData['name_in_package'] = 'В упаковке';

            $dstUnitData['package_width'] = '';
            $dstUnitData['package_length'] = '';
            $dstUnitData['package_height'] = '';


            $dstUnitData['calcKoef'] = $matches[0];
            $dstUnitData['calcRel'] = $NstId;

            $NndId = $unitGateWay->addUnit($dstUnitData);
            setBases($dstUnitData, $NndId, $registry);
        }
    }

    if ($rastvoritelSubType) {
//1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'литр';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 0;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 0;


        $dstUnitData['name_price'] = 'литр';
        $dstUnitData['name_plural'] = 'литров';
        $dstUnitData['name_package_dimension'] = 'литра';
        $dstUnitData['name_in_package'] = '';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

//2nd unit
        $butilkaId = 2133;
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = ($product['document_id'] == $butilkaId) ? 'бутылка' : 'канистра';

        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 1;
        $dstUnitData['weight'] = ($product['document_id'] == $butilkaId) ? 1 : 10;
        $dstUnitData['loadingSortOrder'] = 1;


        $dstUnitData['name_price'] = 'шт.';
        $dstUnitData['name_plural'] = ($product['document_id'] == $butilkaId) ? 'бутылок' : 'канистр';
        $dstUnitData['name_package_dimension'] = ($product['document_id'] == $butilkaId) ? 'бутылки' : 'канистры';
        $dstUnitData['name_in_package'] = ($product['document_id'] == $butilkaId) ? 'в бутылке' : 'в канистре';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = ($product['document_id'] == $butilkaId) ? 1 : 10;
        $dstUnitData['calcRel'] = $NstId;

        $NndId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NndId, $registry);
    }

    if (!empty($product['na_pallete'])) {
//3nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'паллета';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 0;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 0;

        $dstUnitData['name_price'] = 'паллету';
        $dstUnitData['name_plural'] = 'паллет';
        $dstUnitData['name_package_dimension'] = 'паллеты';
        $dstUnitData['name_in_package'] = 'На паллете';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['na_pallete'];
        $dstUnitData['calcRel'] = $NndId;

        $NrdId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NrdId, $registry);
    }

    //generate strings
    $prodStrings = new ProdUnitStrings($registry);
    $strings = $prodStrings->generate($tplId);
    $prodStrings->saveAll($tplId, $strings);
//product manipulations
    $dstDB->query("update oc_product set produnit_template_id = " . $tplId . ", price='" . $product['price'] . "', price_wholesale=" . $product['price_opt'] . " where model = '" . $product['document_id'] . "'");
}

function process2556($product, $registry)
{
    global $dstDB;
    $dstTemplateData = [
        'name' => $product['document_name'],
        'description' => '',
    ];
    $tplGateWay = new ProdUnitTemplates($registry);
    $tplId = $tplGateWay->add($dstTemplateData);

    $unitGateWay = new ProdUnits($registry);

//ведро
    if ($product['pack_type'] == 'v') {
//1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'кг';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 2;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 1;


        $dstUnitData['name_price'] = 'кг';
        $dstUnitData['name_plural'] = 'кг';
        $dstUnitData['name_package_dimension'] = 'кг';
        $dstUnitData['name_in_package'] = '';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

//2nd unit
        $dstUnitData['name'] = 'ведро';
        $dstUnitData['templateId'] = $tplId;

        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 1;
        $dstUnitData['weight'] = $product['roll_weight'];
        $dstUnitData['loadingSortOrder'] = 2;


        $dstUnitData['name_price'] = 'шт.';
        $dstUnitData['name_plural'] = 'вёдер';
        $dstUnitData['name_package_dimension'] = 'ведра';
        $dstUnitData['name_in_package'] = 'В ведре';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['in_roll'];
        $dstUnitData['calcRel'] = $NstId;
        $NndId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NndId, $registry);

//3nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'паллета';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 0;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 0;

        $dstUnitData['name_price'] = 'паллету';
        $dstUnitData['name_plural'] = 'паллет';
        $dstUnitData['name_package_dimension'] = 'паллеты';
        $dstUnitData['name_in_package'] = 'На паллете';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['na_pallete'];
        $dstUnitData['calcRel'] = $NndId;

        $NrdId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NrdId, $registry);
    }

//рулон
    if ($product['pack_type'] == 'ru') {
//1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'м';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 0;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 0;


        $dstUnitData['name_price'] = 'м';
        $dstUnitData['name_plural'] = 'м';
        $dstUnitData['name_package_dimension'] = 'м';
        $dstUnitData['name_in_package'] = 'В метре';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

//2nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'рулон';

        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 1;
        $dstUnitData['weight'] = $product['roll_weight'];
        $dstUnitData['loadingSortOrder'] = 1;

        $dstUnitData['name_price'] = 'шт.';
        $dstUnitData['name_plural'] = 'рулонов';
        $dstUnitData['name_package_dimension'] = 'рулона';
        $dstUnitData['name_in_package'] = 'В рулоне';

        $dstUnitData['package_width'] = '15 см';
        $dstUnitData['package_length'] = $product['in_roll'] . ' м';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['in_roll'];
        $dstUnitData['calcRel'] = $NstId;

        $NndId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NndId, $registry);

//3nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'коробка';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 2;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 2;

        $dstUnitData['name_price'] = 'коробку';
        $dstUnitData['name_plural'] = 'коробок';
        $dstUnitData['name_package_dimension'] = 'коробки';
        $dstUnitData['name_in_package'] = 'В коробке';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['v_korobke'];
        $dstUnitData['calcRel'] = $NndId;

        $NrdId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NrdId, $registry);

//4nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'паллета';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 0;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 0;

        $dstUnitData['name_price'] = 'паллету';
        $dstUnitData['name_plural'] = 'паллет';
        $dstUnitData['name_package_dimension'] = 'паллеты';
        $dstUnitData['name_in_package'] = 'На паллете';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['na_pallete'];
        $dstUnitData['calcRel'] = $NndId;

        $N4thId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $N4thId, $registry);
    }

//колбасы, картриджи
    if ($product['pack_type'] == 'ko' || $product['pack_type'] == 'ka' || $product['pack_type'] == 'b' ||
        empty($product['pack_type'])) {
//1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'мл.';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 0;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = $product['weight'];
        $dstUnitData['loadingSortOrder'] = 0;


        $dstUnitData['name_price'] = 'мл.';
        $dstUnitData['name_plural'] = 'мл.';
        $dstUnitData['name_package_dimension'] = 'мл.';
        $dstUnitData['name_in_package'] = 'В мл.';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

//2nd unit
        $dstUnitData['templateId'] = $tplId;

        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 1;
        $dstUnitData['weight'] = $product['roll_weight'];
        $dstUnitData['loadingSortOrder'] = 1;

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['in_roll'];
        $dstUnitData['calcRel'] = $NstId;

//есть один товарчик без pack_type  - и он колбаса деловая.
        if ($product['pack_type'] == 'ko' || empty($product['pack_type'])) {
            $dstUnitData['name'] = 'колбаса';
            $dstUnitData['name_price'] = 'шт.';
            $dstUnitData['name_plural'] = 'колбас';
            $dstUnitData['name_package_dimension'] = 'колбасы';
            $dstUnitData['name_in_package'] = 'В колбасе';
        }
        if ($product['pack_type'] == 'ka') {
            $dstUnitData['name'] = 'картридж';
            $dstUnitData['name_price'] = 'шт.';
            $dstUnitData['name_plural'] = 'картриджей';
            $dstUnitData['name_package_dimension'] = 'картриджа';
            $dstUnitData['name_in_package'] = 'В картридже';
        }
        if ($product['pack_type'] == 'b') {
            $dstUnitData['name'] = 'баллон';
            $dstUnitData['name_price'] = 'шт.';
            $dstUnitData['name_plural'] = 'баллонов';
            $dstUnitData['name_package_dimension'] = 'баллона';
            $dstUnitData['name_in_package'] = 'В баллоне';
        }

        $NndId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NndId, $registry);

//3nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'коробка';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 2;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 2;

        $dstUnitData['name_price'] = 'коробку';
        $dstUnitData['name_plural'] = 'коробок';
        $dstUnitData['name_package_dimension'] = 'коробки';
        $dstUnitData['name_in_package'] = 'В коробке';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['v_korobke'];
        $dstUnitData['calcRel'] = $NndId;

        $NrdId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NrdId, $registry);

//4nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'паллета';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 0;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 0;

        $dstUnitData['name_price'] = 'паллету';
        $dstUnitData['name_plural'] = 'паллет';
        $dstUnitData['name_package_dimension'] = 'паллеты';
        $dstUnitData['name_in_package'] = 'На паллете';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['na_pallete'];
        $dstUnitData['calcRel'] = $NndId;

        $N4thId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $N4thId, $registry);
    }

    //generate strings
    $prodStrings = new ProdUnitStrings($registry);
    $strings = $prodStrings->generate($tplId);
    $prodStrings->saveAll($tplId, $strings);
//product manipulations
    $dstDB->query("update oc_product set produnit_template_id = " . $tplId . ", price='" . $product['price'] . "', price_wholesale=" . $product['price_opt'] . " where model = '" . $product['document_id'] . "'");
}

function process2558($product, $registry)
{

    global $dstDB;
    $dstTemplateData = [
        'name' => $product['document_name'],
        'description' => '',
    ];
    $tplGateWay = new ProdUnitTemplates($registry);
    $tplId = $tplGateWay->add($dstTemplateData);

    $unitGateWay = new ProdUnits($registry);
//1st unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'лист';

    $dstUnitData['isBasePrice'] = 1;
    $dstUnitData['switchSortOrder'] = 1;
    $dstUnitData['isSalePrice'] = 1;
    $dstUnitData['isLoadingPrice'] = 1;
    $dstUnitData['weight'] = $product['roll_weight'];
    $dstUnitData['loadingSortOrder'] = 2;


    $dstUnitData['name_price'] = 'лист';
    $dstUnitData['name_plural'] = 'листов';
    $dstUnitData['name_package_dimension'] = 'листа';
    $dstUnitData['name_in_package'] = 'В листе';

    $sizes = getRollSizes($product['f_lista']);
    $width = $sizes['width'] . ' мм';
    $length = $sizes['length'] . ' мм';
    $dstUnitData['package_width'] = $width;
    $dstUnitData['package_length'] = $length;
    $dstUnitData['package_height'] = $product['t_lista'] . ' мм';

    $dstUnitData['calcKoef'] = '';
    $dstUnitData['calcRel'] = '';
    $NstId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NstId, $registry);

//2nd unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'м<sup>3</sup>';

    $dstUnitData['isBasePrice'] = 0;
    $dstUnitData['switchSortOrder'] = 2;
    $dstUnitData['isSalePrice'] = 0;
    $dstUnitData['isLoadingPrice'] = 0;
    $dstUnitData['weight'] = $product['weight'];
    $dstUnitData['loadingSortOrder'] = 1;

    $dstUnitData['name_price'] = 'м<sup>3</sup>';
    $dstUnitData['name_plural'] = 'м<sup>3</sup>';
    $dstUnitData['name_package_dimension'] = 'м<sup>3</sup>';
    $dstUnitData['name_in_package'] = 'В м<sup>3</sup>';

    $dstUnitData['package_width'] = '';
    $dstUnitData['package_length'] = '';
    $dstUnitData['package_height'] = '';

    $dstUnitData['calcKoef'] = $product['listov'];
    $dstUnitData['calcRel'] = $NstId;

    $NndId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NndId, $registry);

//3nd unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'пачка';

    $dstUnitData['isBasePrice'] = 0;
    $dstUnitData['switchSortOrder'] = 0;
    $dstUnitData['isSalePrice'] = 0;
    $dstUnitData['isLoadingPrice'] = 0;
    $dstUnitData['weight'] = '';
    $dstUnitData['loadingSortOrder'] = 0;

    $dstUnitData['name_price'] = 'пачку';
    $dstUnitData['name_plural'] = 'пачек';
    $dstUnitData['name_package_dimension'] = 'пачки';
    $dstUnitData['name_in_package'] = 'В пачке';

    $dstUnitData['package_width'] = '';
    $dstUnitData['package_length'] = '';
    $dstUnitData['package_height'] = '';

    $dstUnitData['calcKoef'] = $product['v_korobke'];
    $dstUnitData['calcRel'] = $NstId;

    $NrdId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NrdId, $registry);

    //generate strings
    $prodStrings = new ProdUnitStrings($registry);
    $strings = $prodStrings->generate($tplId);
    $prodStrings->saveAll($tplId, $strings);
//product manipulations
    $dstDB->query("update oc_product set produnit_template_id = " . $tplId . ", price='" . $product['price'] . "', price_wholesale=" . $product['price_opt'] . " where model = '" . $product['document_id'] . "'");
}

function process2559($product, $registry)
{

    global $dstDB;
    $dstTemplateData = [
        'name' => $product['document_name'],
        'description' => '',
    ];
    $tplGateWay = new ProdUnitTemplates($registry);
    $tplId = $tplGateWay->add($dstTemplateData);

    $unitGateWay = new ProdUnits($registry);
//1st unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'м<sup>2</sup>';

    $dstUnitData['isBasePrice'] = 0;
    $dstUnitData['switchSortOrder'] = 2;
    $dstUnitData['isSalePrice'] = 0;
    $dstUnitData['isLoadingPrice'] = 0;
    $dstUnitData['weight'] = $product['weight'];
    $dstUnitData['loadingSortOrder'] = 1;


    $dstUnitData['name_price'] = 'м<sup>2</sup>';
    $dstUnitData['name_plural'] = 'м<sup>2</sup>';
    $dstUnitData['name_package_dimension'] = 'м<sup>2</sup>';
    $dstUnitData['name_in_package'] = 'В м<sup>2</sup>';

    $dstUnitData['package_width'] = '';
    $dstUnitData['package_length'] = '';
    $dstUnitData['package_height'] = '';

    $dstUnitData['calcKoef'] = '';
    $dstUnitData['calcRel'] = '';
    $NstId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NstId, $registry);

//2nd unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'лист';

    $dstUnitData['isBasePrice'] = 1;
    $dstUnitData['switchSortOrder'] = 1;
    $dstUnitData['isSalePrice'] = 1;
    $dstUnitData['isLoadingPrice'] = 1;
    $dstUnitData['weight'] = $product['roll_weight'];
    $dstUnitData['loadingSortOrder'] = 1;


    $dstUnitData['name_price'] = 'лист';
    $dstUnitData['name_plural'] = 'листов';
    $dstUnitData['name_package_dimension'] = 'листа';
    $dstUnitData['name_in_package'] = 'В листе';

    $sizes = getRollSizes($product['f_lista']);
    $width = $sizes['width'] . ' мм';
    $length = $sizes['length'] . ' мм';
    $dstUnitData['package_width'] = $width;
    $dstUnitData['package_length'] = $length;
    $dstUnitData['package_height'] = $product['t_lista'] . ' мм';

    $dstUnitData['calcKoef'] = $product['listov'];
    $dstUnitData['calcRel'] = $NstId;
    $NndId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NndId, $registry);

//3nd unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'пачка';

    $dstUnitData['isBasePrice'] = 0;
    $dstUnitData['switchSortOrder'] = 0;
    $dstUnitData['isSalePrice'] = 0;
    $dstUnitData['isLoadingPrice'] = 0;
    $dstUnitData['weight'] = '';
    $dstUnitData['loadingSortOrder'] = 0;

    $dstUnitData['name_price'] = 'пачку';
    $dstUnitData['name_plural'] = 'пачек';
    $dstUnitData['name_package_dimension'] = 'пачки';
    $dstUnitData['name_in_package'] = 'В пачке';

    $dstUnitData['package_width'] = '';
    $dstUnitData['package_length'] = '';
    $dstUnitData['package_height'] = '';

    $dstUnitData['calcKoef'] = $product['v_korobke'];
    $dstUnitData['calcRel'] = $NndId;

    $NrdId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NrdId, $registry);

    //generate strings
    $prodStrings = new ProdUnitStrings($registry);
    $strings = $prodStrings->generate($tplId);
    $prodStrings->saveAll($tplId, $strings);
//product manipulations
    $dstDB->query("update oc_product set produnit_template_id = " . $tplId . ", price='" . $product['price'] . "', price_wholesale=" . $product['price_opt'] . " where model = '" . $product['document_id'] . "'");
}

function process2557($product, $registry)
{
    $miniRolls = [2472, 2473];

    global $dstDB;
    $dstTemplateData = [
        'name' => $product['document_name'],
        'description' => '',
    ];
    $tplGateWay = new ProdUnitTemplates($registry);
    $tplId = $tplGateWay->add($dstTemplateData);
    $unitGateWay = new ProdUnits($registry);

    /* обычные рулоны */
    if (!in_array($product['document_id'], $miniRolls)) {

        //1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'м<sup>2</sup>';

        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 1;


        $dstUnitData['name_price'] = 'м<sup>2</sup>';
        $dstUnitData['name_plural'] = 'м<sup>2</sup>';
        $dstUnitData['name_package_dimension'] = 'м<sup>2</sup>';
        $dstUnitData['name_in_package'] = 'В м<sup>2</sup>';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

        //2nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'рулон';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 2;
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 1;
        $dstUnitData['weight'] = $product['roll_weight'];
        $dstUnitData['loadingSortOrder'] = 2;

        $dstUnitData['name_price'] = 'рулон';
        $dstUnitData['name_plural'] = 'рулонов';
        $dstUnitData['name_package_dimension'] = 'рулона';
        $dstUnitData['name_in_package'] = 'В рулоне';

        $sizes = getRollSizes($product['pack']);
        /* это не ошибка */
        $dstUnitData['package_width'] = str_replace('рулон, ', '', $sizes['length']);
        $dstUnitData['package_length'] = $sizes['width'];
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['in_roll'];
        $dstUnitData['calcRel'] = $NstId;

        $NndId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NndId, $registry);


        //3nd unit
        if (!empty($product['na_pallete'])) {
            $dstUnitData['templateId'] = $tplId;
            $dstUnitData['name'] = 'паллета';

            $dstUnitData['isBasePrice'] = 0;
            $dstUnitData['switchSortOrder'] = 0;
            $dstUnitData['isSalePrice'] = 0;
            $dstUnitData['isLoadingPrice'] = 0;
            $dstUnitData['weight'] = '';
            $dstUnitData['loadingSortOrder'] = 0;

            $dstUnitData['name_price'] = 'паллету';
            $dstUnitData['name_plural'] = 'паллет';
            $dstUnitData['name_package_dimension'] = 'паллеты';
            $dstUnitData['name_in_package'] = 'На паллете';

            $dstUnitData['package_width'] = '';
            $dstUnitData['package_length'] = '';
            $dstUnitData['package_height'] = '';

            $dstUnitData['calcKoef'] = $product['na_pallete'];
            $dstUnitData['calcRel'] = $NndId;

            $NrdId = $unitGateWay->addUnit($dstUnitData);
            setBases($dstUnitData, $NrdId, $registry);
        }
    } else {
        //мини-рулончики
        //1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'м';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 0;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 0;


        $dstUnitData['name_price'] = 'м';
        $dstUnitData['name_plural'] = 'м';
        $dstUnitData['name_package_dimension'] = 'м';
        $dstUnitData['name_in_package'] = 'м';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

//2nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'рулон';

        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 1;
        $dstUnitData['weight'] = $product['roll_weight'];
        $dstUnitData['loadingSortOrder'] = 1;

        $dstUnitData['name_price'] = 'шт.';
        $dstUnitData['name_plural'] = 'рулонов';
        $dstUnitData['name_package_dimension'] = 'рулона';
        $dstUnitData['name_in_package'] = 'В рулоне';

        $sizes = getRollSizes($product['pack']);
        $dstUnitData['package_width'] = $sizes['width'];
        $dstUnitData['package_length'] = $sizes['length'];
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = 10;
        $dstUnitData['calcRel'] = $NstId;

        $NndId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NndId, $registry);

//3nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'коробка';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 2;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 2;

        $dstUnitData['name_price'] = 'коробку';
        $dstUnitData['name_plural'] = 'коробок';
        $dstUnitData['name_package_dimension'] = 'коробки';
        $dstUnitData['name_in_package'] = 'В коробке';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['v_korobke'];
        $dstUnitData['calcRel'] = $NndId;

        $NrdId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NrdId, $registry);

//4nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'паллета';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 0;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 0;

        $dstUnitData['name_price'] = 'паллету';
        $dstUnitData['name_plural'] = 'паллет';
        $dstUnitData['name_package_dimension'] = 'паллеты';
        $dstUnitData['name_in_package'] = 'На паллете';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['na_pallete'];
        $dstUnitData['calcRel'] = $NndId;

        $N4thId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $N4thId, $registry);
    }

    //generate strings
    $prodStrings = new ProdUnitStrings($registry);
    $strings = $prodStrings->generate($tplId);
    $prodStrings->saveAll($tplId, $strings);
//product manipulations
    $dstDB->query("update oc_product set produnit_template_id = " . $tplId . ", price='" . $product['price'] . "', price_wholesale=" . $product['price_opt'] . " where model = '" . $product['document_id'] . "'");
}

function process2560($product, $registry)
{
    global $dstDB;
    $dstTemplateData = [
        'name' => $product['document_name'],
        'description' => '',
    ];
    $tplGateWay = new ProdUnitTemplates($registry);
    $tplId = $tplGateWay->add($dstTemplateData);

    $unitGateWay = new ProdUnits($registry);
//1st unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'кг.';

    $dstUnitData['isBasePrice'] = 0;
    $dstUnitData['switchSortOrder'] = 2;
    $dstUnitData['isSalePrice'] = 0;
    $dstUnitData['isLoadingPrice'] = 0;
    $dstUnitData['weight'] = '';
    $dstUnitData['loadingSortOrder'] = 0;


    $dstUnitData['name_price'] = 'кг';
    $dstUnitData['name_plural'] = 'кг';
    $dstUnitData['name_package_dimension'] = 'кг';
    $dstUnitData['name_in_package'] = '';

    $dstUnitData['package_width'] = '';
    $dstUnitData['package_length'] = '';
    $dstUnitData['package_height'] = '';

    $dstUnitData['calcKoef'] = '';
    $dstUnitData['calcRel'] = '';
    $NstId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NstId, $registry);

//2nd unit
    $butilkaId = 2133;
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'канистра';

    $dstUnitData['isBasePrice'] = 1;
    $dstUnitData['switchSortOrder'] = 1;
    $dstUnitData['isSalePrice'] = 1;
    $dstUnitData['isLoadingPrice'] = 1;
    $dstUnitData['weight'] = $product['roll_weight'];
    $dstUnitData['loadingSortOrder'] = 1;


    $dstUnitData['name_price'] = 'шт';
    $dstUnitData['name_plural'] = 'канистр';
    $dstUnitData['name_package_dimension'] = 'канистры';
    $dstUnitData['name_in_package'] = 'В канистре';

    $dstUnitData['package_width'] = '';
    $dstUnitData['package_length'] = '';
    $dstUnitData['package_height'] = '';

    $dstUnitData['calcKoef'] = $product['roll_weight'];
    $dstUnitData['calcRel'] = $NstId;

    $NndId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NndId, $registry);

//3nd unit
    $dstUnitData['templateId'] = $tplId;
    $dstUnitData['name'] = 'паллета';

    $dstUnitData['isBasePrice'] = 0;
    $dstUnitData['switchSortOrder'] = 0;
    $dstUnitData['isSalePrice'] = 0;
    $dstUnitData['isLoadingPrice'] = 0;
    $dstUnitData['weight'] = '';
    $dstUnitData['loadingSortOrder'] = 0;

    $dstUnitData['name_price'] = 'паллету';
    $dstUnitData['name_plural'] = 'паллет';
    $dstUnitData['name_package_dimension'] = 'паллеты';
    $dstUnitData['name_in_package'] = 'На паллете';

    $dstUnitData['package_width'] = '';
    $dstUnitData['package_length'] = '';
    $dstUnitData['package_height'] = '';

    $dstUnitData['calcKoef'] = $product['na_pallete'];
    $dstUnitData['calcRel'] = $NndId;

    $NrdId = $unitGateWay->addUnit($dstUnitData);
    setBases($dstUnitData, $NrdId, $registry);

    //generate strings
    $prodStrings = new ProdUnitStrings($registry);
    $strings = $prodStrings->generate($tplId);
    $prodStrings->saveAll($tplId, $strings);
    //product manipulations
    $dstDB->query("update oc_product set produnit_template_id = " . $tplId . ", price='" . $product['price'] . "', price_wholesale=" . $product['price_opt'] . " where model = '" . $product['document_id'] . "'");
}

function process2555($product, $registry)
{
    global $dstDB;
    $dstTemplateData = [
        'name' => $product['document_name'],
        'description' => '',
    ];
    $tplGateWay = new ProdUnitTemplates($registry);
    $tplId = $tplGateWay->add($dstTemplateData);

    $unitGateWay = new ProdUnits($registry);

    //рулонка обычная
    if ($product['pack_type'] == 'ru') {
        //1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'м<sup>2</sup>';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 2;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 1;

        $dstUnitData['name_price'] = 'м<sup>2</sup>';
        $dstUnitData['name_plural'] = 'м<sup>2</sup>';
        $dstUnitData['name_package_dimension'] = 'м<sup>2</sup>';
        $dstUnitData['name_in_package'] = 'В м<sup>2</sup>';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

        //2nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'рулон';

        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 1;
        $dstUnitData['weight'] = $product['roll_weight'];
        $dstUnitData['loadingSortOrder'] = 2;

        $dstUnitData['name_price'] = 'рулон';
        $dstUnitData['name_plural'] = 'рулонов';
        $dstUnitData['name_package_dimension'] = 'рулона';
        $dstUnitData['name_in_package'] = 'В рулоне';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['in_roll'];
        $dstUnitData['calcRel'] = $NstId;

        $NndId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NndId, $registry);
    }

    //коробки
    if ($product['pack_type'] == 'ko') {
        //1st unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'шт.';

        $dstUnitData['isBasePrice'] = 0;
        $dstUnitData['switchSortOrder'] = 2;
        $dstUnitData['isSalePrice'] = 0;
        $dstUnitData['isLoadingPrice'] = 0;
        $dstUnitData['weight'] = '';
        $dstUnitData['loadingSortOrder'] = 1;


        $dstUnitData['name_price'] = 'шт.';
        $dstUnitData['name_plural'] = 'шт.';
        $dstUnitData['name_package_dimension'] = 'шт.';
        $dstUnitData['name_in_package'] = '';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = '';
        $dstUnitData['calcRel'] = '';
        $NstId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NstId, $registry);

//2nd unit
        $dstUnitData['templateId'] = $tplId;
        $dstUnitData['name'] = 'коробка';

        $dstUnitData['isBasePrice'] = 1;
        $dstUnitData['switchSortOrder'] = 1;
        $dstUnitData['isSalePrice'] = 1;
        $dstUnitData['isLoadingPrice'] = 1;
        $dstUnitData['weight'] = $product['roll_weight'];
        $dstUnitData['loadingSortOrder'] = 2;


        $dstUnitData['name_price'] = 'упаковку';
        $dstUnitData['name_plural'] = 'коробок';
        $dstUnitData['name_package_dimension'] = 'коробки';
        $dstUnitData['name_in_package'] = 'В коробке';

        $dstUnitData['package_width'] = '';
        $dstUnitData['package_length'] = '';
        $dstUnitData['package_height'] = '';

        $dstUnitData['calcKoef'] = $product['in_roll'];
        $dstUnitData['calcRel'] = $NstId;

        $NndId = $unitGateWay->addUnit($dstUnitData);
        setBases($dstUnitData, $NndId, $registry);
    }

    //generate strings
    $prodStrings = new ProdUnitStrings($registry);
    $strings = $prodStrings->generate($tplId);
    $prodStrings->saveAll($tplId, $strings);
    //product manipulations
    $dstDB->query("update oc_product set produnit_template_id = " . $tplId . ", price='" . $product['price'] . "', price_wholesale=" . $product['price_opt'] . " where model = '" . $product['document_id'] . "'");
}

$dstDB->query("update produnit_packagestr set description='Толщина:' where description like 'Толщина%'");
$dstDB->query("delete from produnit_packagestr where description like 'упаковка%' and `value` like '%аллет%'");
$dstDB->query("delete from produnit_packagestr where description like 'упаковка%' and `value` like '%короб%'");
$dstDB->query("delete from produnit_packagestr where description like 'упаковка%' and `value` like '%Упаковка%'");
$dstDB->query("delete from produnit_packagestr where description like 'упаковка%' and `value` like '%м<sup>3</sup>%'");
$dstDB->query("delete from produnit_packagestr where description like 'В ведре%' or description like 'В мешке%' or description like 'В брикете%' or description like 'В бочке%' or description like 'В рулоне%' or description like 'В картридже%' or description like 'В колбасе%' or description like 'В баллоне%' or description like 'В пачке%' or description like 'В канистре%'");
