<?php echo $header; ?>
<div class="container main">
    <?php /*@task move to css, ниже в скрипте + плохо что не видно текущее число товара в корзине*/ ?>
    <style>
        .notify {
            /*position: absolute;
            width: 100%;top: -121px;*/

            text-align: center;

            font-size: 16px;
            font-weight: bold;
            color: #ff8001;
            visibility: hidden;
        }
        .notify.active {
            visibility: visible;
        }
        .container.main {
            position:relative;
        }
    </style>

    <input type="hidden" id="product_id" value="<?=$product_id?>"/>
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        <div class="card-product"  itemprop="offers" itemscope itemtype="http://schema.org/Offer">
            <div class="title" itemprop="name"><?=$heading_title?></div>
            <div class="card-product-container">
                <div class="left">
                    <div class="manufacturer">
                        <span>ТУ/ГОСТ&nbsp;<?=$sku?></span>
                        <?php if ($manufacturer) { ?>
                        <p itemprop="seller"><?php echo $manufacturer; ?></p>
                        <?php } ?>
                    </div>
                    <div class="fade thumb__list">
                        <?php if ($thumb) { ?>
                            <a class="thumbnail thumb__link" 
                               href="<?php echo $popup; ?>" 
                               title="<?php echo $heading_title; ?>">
                                <img itemprop="image" src="<?php echo $thumb; ?>"
                                     title="<?php echo $heading_title; ?>"
                                     alt="<?php echo $heading_title; ?>" />
                            </a>
                        <?php } ?>
                    </div>
                </div>
                <div class="right">
                    <script>
                        document.addEventListener("DOMContentLoaded", function(){
                            window._antSnabMeta = $.parseJSON('<?php echo $priceMetaJSON?>');
                        });
                    </script>
                    <div class="description-price">
                        <div class="description-mini">
                            <?=$description_mini?>
                        </div>
                        <div class="price-for">
                            <input type="hidden" id="currencySymb" value="<?=$currencySymb?>"/>
                            <span>Цена за:</span>
                            <ul>
                                        <li>
                                            <a data-unit="<?=$firstPriceMeta['name']?>" class="active" href="#">
                                                <?= $firstPriceMeta['name_price'] ?>
                                            </a>
                                        </li>
                                        <?php if($secondPriceMeta['name_price']):?>
                                        <li>
                                            <a data-unit="<?=$secondPriceMeta['name']?>" href="#">
                                                <?= $secondPriceMeta['name_price'] ?>
                                            </a>
                                        </li>
                                        <?php endif;?>
                            </ul>
                        </div>
                    </div>
                    <div class="border"></div>
                    
                    <div class="wholesale">
                        <div class="wholesale-price">
                            <?php if( $firstPriceMeta):?>
                            <strong> 
                                <span id="wholesalePrice">
                                <?=$firstPriceMeta['price_wholesale_str']?>
                                </span>

                                <b class="help_question">?
                                    <em>
                                        <?php if( $basePriceMeta): ?>
                                            Оптовая цена действительна при единовременной оплате <?=$basePriceMeta['wholesale_threshold']. ' ' . $basePriceMeta['name_plural'] ?>
                                        <?php endif;?>
                                    </em>
                                </b>
                                
                            </strong>
                            <span id="priceWholesaleDescr">
                                    <?=$firstPriceMeta['name']?>
                                    <?php if( $firstPriceMeta['calcKoef'] != null && $firstPriceMeta['calcRelString'] != null ):?>
                                        <?php echo ', ' . (int)$firstPriceMeta['calcKoef'] . ' ' . $firstPriceMeta['calcRelString'];?>
                                    <?php endif;?>
                            </span>
                            
                            <?php endif;?>
                        </div>
                        <p>Оптом</p>
                    </div>
                    <div class="border"></div>
                    <?php if($firstPriceMeta):?>
                        <div class="wholesale wholesale2">
                                <div class="wholesale-price">
                                    <strong id="price"><?=$firstPriceMeta['price_str']?></strong>
                                    <span id="priceDescr"><?=$firstPriceMeta['name']?></span>
                                </div>
                            <p>В розницу</p>
                        </div>
                        <div class="quantity-buy">
                            <div class="quantity-buy-block">
                                <div class="OutputContainer">
                                    <input 
                                           data-factInterval="<?=$firstPriceMeta['salePackageStep']?>" 
                                           data-visualInterval="<?=$firstPriceMeta['visualStep']?>"
                                           data-name="<?=$firstPriceMeta['name_price']?>"
                                           class="spinner" type="text"  name="name" value="0">
                                </div>
                            </div>
                            <script>
                                document.addEventListener("DOMContentLoaded", function(){
                                    $('.spinner').SpinnerControl();
                                });
                            </script>
                            <a data-loading-text="Добавление..." id="button-cart" href="#" class="buy">Купить</a>
                        </div>
                    <?php endif;?>
                    <div class="notify">Товар добавлен в корзину</div>
                </div>

                <div class="space"></div>
                <div class="thumb__nav">
                    <?php if ($images) { ?>
                    <div class="thumb__list">
                        <?php foreach ($images as $image) { ?>
                            <div class="thumb__item">
                                <a class="thumb__link" 
                                   href="<?php echo $image['popup']; ?>" 
                                   title="<?php echo $heading_title; ?>">
                                        <img src="<?php echo $image['thumb']; ?>" 
                                             title="<?php echo $heading_title; ?>" 
                                             alt="<?php echo $heading_title; ?>" />
                                </a>
                            </div>
                        <?php } ?>
                    <?php }?>
                    </div>
                </div>
                <div class="in-stock">
                    <span>Товар в наличии</span>
                    <ul>
                        <li class="stock1">
                            Алтуфьево
                        </li>
                        <li class="stock2">
                            Щелково

                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="info-block info-block2">
            <?=$description?>
        </div>
        <div class="contacts-tabs card-product-tabs">
            <div id="mtab1" class="tab">
                <ul class="tabset multi-tabset">
                    <li>
                        <a href="#m1tab1" class="active">Описание</a>
                    </li>
                    <li><a href="#m1tab2">Упаковка</a></li>
                    <li><a href="#m1tab3">Калькулятор</a></li>
                    
                    <?php foreach($tabs as $t): ?>
                    <li><a href="#m1tab_<?=$t['id']?>"><?=$t['name']?></a></li>
                    <?php endforeach;?>
                    <li><a href="#m1tab7">Отзывы</a></li>
                </ul>

                <div class="tab-list">
                    <!--Описание-->
                    <div id="m1tab1">
                        <div class="table">
                            <table>
                                <thead>
                                    <tr>
                                        <td>Показатель</td>
                                        <td>Значение</td>
                                        <td>Ед. измерения</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach( $properties as $p):?>
                                    <tr>
                                        <td><?=$p['name']?></td>
                                        <td><?=$p['val']?></td>
                                        <td><?=$p['unit']?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                        <!--@task скачивания-->
                        <!--<div class="download">
                            <ul>
                                <li>
                                    <a href="">Скачать подробную карту</a>
                                </li>
                                <li>
                                    <a href="">Скачать сертификаты</a>
                                </li>
                            </ul>
                        </div>-->
                    </div>
                    <div id="m1tab2">
                        <div class="packaging">
                            <div class="title">Упаковка <?=$heading_title?></div>
                            <div class="table">
                                <table>
                                    <tbody>
                                        <?php foreach( $packageStrings as $s):?>
                                        <tr>
                                            <td><?=$s['description']?></td>
                                            <td><?=$s['value']?></td>
                                        </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
<!--
                            <div class="title">Нормы загрузки</div>
                            <div class="tipe">
                                <span>Выберите тип автомобиля:</span>
                                <select id="seldef5" title="Каблучок (600 кг)">
                                    <option>Газель (1,5 тонны)</option>
                                    <option>Бычок (3 тонны)</option>
                                    <option>Камаз (10 тонн)</option>
                                </select>
                            </div>
                            <div class="table2">
                                <table>
                                    <tbody><tr class="text-row">
                                            <th rowspan="2">Продукт</th>
                                            <th colspan="2" class="car-norm car-norm-2576" style="display: table-cell;">
                                                Загрузка в Каблучок (600 кг)
                                            </th>
                                            <th colspan="2" class="car-norm car-norm-2577" style="display: none;">
                                                Загрузка в Газель (1,5 тонны)
                                            </th>
                                            <th colspan="2" class="car-norm car-norm-2578" style="display: none;">
                                                Загрузка в Бычок (3 тонны)
                                            </th>
                                            <th colspan="2" class="car-norm car-norm-2579" style="display: none;">
                                                Загрузка в ЗИЛ (5 тонн)
                                            </th>
                                            <th colspan="2" class="car-norm car-norm-2580" style="display: none;">
                                                Загрузка в Камаз (10 тонн)
                                            </th>
                                            <th colspan="2" class="car-norm car-norm-2581" style="display: none;">
                                                Загрузка в Камаз (20 тонн)
                                            </th>
                                        </tr>
                                        <tr class="two-col">
                                            <th>м<sup>2</sup></th>
                                            <th>рулонов</th>
                                        </tr>
                                        <tr class="text-row">
                                            <td class="w50p">Эластоизол Премиум ЭКП-5,0</td>
                                            <td class="car-norm car-norm-2576 w25p" style="display: table-cell;">120</td>
                                            <td class="car-norm car-norm-2576 w25p" style="display: table-cell;">12</td>
                                            <td class="car-norm car-norm-2577 w25p" style="display: none;">300</td>
                                            <td class="car-norm car-norm-2577 w25p" style="display: none;">30</td>
                                            <td class="car-norm car-norm-2578 w25p" style="display: none;">600</td>
                                            <td class="car-norm car-norm-2578 w25p" style="display: none;">60</td>
                                            <td class="car-norm car-norm-2579 w25p" style="display: none;">1 000</td>
                                            <td class="car-norm car-norm-2579 w25p" style="display: none;">100</td>
                                            <td class="car-norm car-norm-2580 w25p" style="display: none;">2 000</td>
                                            <td class="car-norm car-norm-2580 w25p" style="display: none;">200</td>
                                            <td class="car-norm car-norm-2581 w25p" style="display: none;">4 000</td>
                                            <td class="car-norm car-norm-2581 w25p" style="display: none;">400</td>
                                        </tr>
                                    </tbody></table>
                            </div>
-->
                        </div>
                    </div>
                    <div id="m1tab3">
                        <div class="calculator">
                            <div class="title">Калькулятор кровельных материалов</div>
                            <p>В разработке</p>
<!--
                            <p>Чтобы узнать сколько материала Эластоизол Премиум ЭКП-5,0 вам понадобится введите площадь изолируемой поверхности в квадратных метрах:</p>
                            <div class="calculator-block">
                                <form action="">
                                    <input type="text" value="Площадь">
                                    <span>м <sup>2</sup></span>
                                    <input type="submit" value="Рассчитать">
                                </form>
                            </div>
                            <p>Расчет необходимого количества материала Эластоизол Премиум ЭКП-5,0 на площадь 1 м2:</p>
                            <div class="table">
                                <table>
                                    <thead>
                                        <tr>
                                            <td>Показатель</td>
                                            <td>Значение</td>
                                            <td>Ед. измерения</td>
                                        </tr>
                                    </thead>
                                    <tbody><tr>
                                            <td>Теплостойкость в течение 3 ч., не менее</td>
                                            <td>30</td>
                                            <td>°С</td>
                                        </tr>
                                        <tr>
                                            <td>Прочность сцепления с бетоном</td>
                                            <td>0,15 (1,5)</td>
                                            <td>Мпа (кгс/см²)</td>
                                        </tr>
                                        <tr>
                                            <td>Гибкость на стержне диаметром 10 мм. при температуре</td>
                                            <td>-20</td>
                                            <td>°С</td>
                                        </tr>
                                        <tr>
                                            <td>Содержание пылевидного наполнителя</td>
                                            <td>0</td>
                                            <td>% по массе</td>
                                        </tr>
                                        <tr>
                                            <td>Температурный диапазон применения</td>
                                            <td>от +5 до +40</td>
                                            <td>°С</td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <p>В таблице представлен расчет для устройства однослойного гидроизоляционного или кровельного покрытия.
                                Приведенные значения являются справочными, для более точного расчета необходимого количества материала и стоимости доставки обращайтесь к нашим сотрудникам.</p>
                            <a href="" class="print">Распечатать</a>
-->
                        </div>
                    </div>

                    <?php foreach($tabs as $t): ?>
                    <div id="m1tab_<?=$t['id']?>">
                        <div class="application">
                            <?=$t['text']?>
                        </div>
                    </div>
                    <?php endforeach;?>

                    <div class="popup2">
                        <div class="close3"></div>
                        <div class="popup-block2">
                            <div class="popup-content2">
                                <div class="close4"></div>
                                <span>Склад Алтуфьево</span>
                                <p><b>Адрес:</b> г. Москва, Высоковольтный проезд, дом 1, строение 43</p>
                                <p><b>График работы:</b> с 8.30 до 18.30 с понедельника по пятницу</p>
                                <p><b>Без обеда</b></p>
                                <p>Для вашего удобства можете <a href="">скачать подробную схему проезда</a></p>
                                <div id="map">
                                    <script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3A0f697f340e451a2655a9f6348161cf5b312de4f5fd7d29cd06dcfbb8856e845d&amp;width=100%25&amp;height=400&amp;lang=ru_RU&amp;scroll=false"></script>
                                </div>
                            </div>
                        </div>
                    </div>





                    <div class="popup3">
                        <div class="close5"></div>
                        <div class="popup-block3">
                            <div class="popup-content3">
                                <div class="close6"></div>
                                <span>Склад Щелково</span>
                                <p><b>Адрес:</b> Московская область, г. Щелково, ул. Заводская, д. 2, территория завода "Щелково Агрохим"</p>
                                <p><b>График работы:</b> с 8.30 до 18.30 с понедельника по пятницу</p>
                                <p><b>Без обеда</b></p>
                                <p>Для вашего удобства можете <a href="">скачать подробную схему проезда</a></p>
                                <div id="map2">
                                    <script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3A8b8d059edfefdc578640ce1901d9addd8bec5873733b011f3c403a3b0a01eb1c&amp;width=100%25&amp;height=400&amp;lang=ru_RU&amp;scroll=false"></script>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div id="m1tab7">
                        <div class="reviews-container reviews-container2">
                            <div class="review-block">
                                <div class="review">
                                    <div class="top">
                                        <span><strong>Алексей</strong> о <b>“Продукции”</b></span>
                                        <p>14.03.2016</p>
                                    </div>
                                    <em>Порадовало отношение к покупателю: надёжность, ответственность и, при этом, доля юмора - вот моё впечатление о работе с компанией Ант-Снаб!</em>
                                </div>
                                <div class="review answer-review">
                                    <div class="top">
                                        <span><strong>Ирина Дмитриева
                                            </strong></span>
                                    </div>
                                    <em>Надежда, спасибо Вам за хороший отзыв, надеемся на продолжение сотрудничества!</em>
                                </div>
                            </div>
                            <div class="review-block">
                                <div class="review">
                                    <div class="top">
                                        <span><strong>Елена</strong> о <b>“Сервисе”</b></span>
                                        <p>14.03.2016</p>
                                    </div>
                                    <em>Продукция хорошего качества.Хочется отметить оперативность обработки заявок,а также своевремменое поступление документов. Надеюсь на дальнейшее взаимовыгодное</em>
                                </div>
                                <div class="review answer-review">
                                    <div class="top">
                                        <span><strong>Ант-Снаб
                                            </strong></span>
                                    </div>
                                    <em>Азиз, большое спасибо за отзыв. Постараемся и в наступающем году удерживать планку на заданной высоте!</em>
                                </div>
                            </div>
                            <div class="review-block">
                                <div class="review">
                                    <div class="top">
                                        <span><strong>Алексей</strong> о <b>“Продукции”</b></span>
                                        <p>14.03.2016</p>
                                    </div>
                                    <em>Порадовало отношение к покупателю: надёжность, ответственность и, при этом, доля юмора - вот моё впечатление о работе с компанией Ант-Снаб!</em>
                                </div>
                                <div class="review answer-review">
                                    <div class="top">
                                        <span><strong>Латипов Олег
                                            </strong></span>
                                    </div>
                                    <em>Алексей, спасибо за лестный отзыв. Мы всегда стараемся окружить любовью и заботой наших покупателей.</em>
                                </div>
                            </div>
                            <div class="give-feedback">
                                <div class="title-give-feedback">Оставить отзыв</div>
                                <form action="">
                                    <div class="row">
                                        <span>Имя:</span>
                                        <input type="text" value="Ведите Ваше имя">
                                    </div>
                                    <div class="row">
                                        <span>E-mail:</span>
                                        <input type="text" value="Введите Ваш e-mail">
                                    </div>
                                    <div class="row">
                                        <span>Организация:</span>
                                        <input type="text" value="Введите название организации">
                                    </div>
                                    <div class="row">
                                        <span>Отзыв:</span>
                                        <textarea>Напишите Ваш отзыв</textarea>
                                    </div>
                                    <div class="agreement">
                                        <input type="checkbox" id="1" value="Я согласен с правилами">
                                        <label for="1">Я согласен с <a href="">правилами</a></label>
                                    </div>
                                    <input type="submit" value="Добавить отзыв">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="mentioned-products mentioned-products2">
            <?php if( $products):?>
            <div class="title">Аналоги и сопутствующие товары</div>
            <ul>
                <?php foreach( $products as $p):?>
                <li>
                    <div class="products-block">
                        <a href="<?=$p['href']?>" class="img-production">
                            <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
                        </a>
                        <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>
                        <strong><?=$p['price']?></strong>
                        <a href="<?=$p['href']?>" class="order-btn">Купить</a>
                    </div>
                </li>
                <?php endforeach;?>
            </ul>
            <?php endif;?>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function(){
        $('.thumb__list').magnificPopup({
            type:'image',
            delegate: 'a',
            gallery: {
                enabled:true
            }
        });

        $('#button-cart').on('click', function(e) {
            e.preventDefault();
            var quantityInPackages = $('.spinner').SpinnerControl('getFactValue'),
                toPriceQuantityKoef = _antSnabMeta.priceMeta[_antSnabMeta.bases.sale ].toPriceUnitsKoef,
                quantityInPriceUnits = quantityInPackages*toPriceQuantityKoef;
            $.ajax({
                url:  'index.php?route=checkout/cart/add',
                type: 'post',
                data: {
                           quantity: quantityInPriceUnits,
                           product_id: $('#product_id').val(), 
                      },
                dataType: 'json',
                beforeSend: function() {
                    $('#button-cart').button('loading');
                },
                complete: function() {
                    $('#button-cart').button('reset');
                },
                success: function(json) {
                    //@task - сбросить таймаут

                    if (json['success']) {
                        $('.notify').html(json['success']);
                        $('.basket').html(json['total']);
                        $('html, body').animate({ scrollTop: 0 }, 'slow');
                        //добавить норм анимацию
                        $('.notify').addClass('active');
                        setTimeout(function() { $('.notify').removeClass('active') }, 3000 );
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        });
    });
</script>

<?= $footer ?>
