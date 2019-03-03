<?php echo $header; ?>
<div class="container main">
    <input type="hidden" id="product_id" value="<?=$product_id?>"/>
    <?= $column_left ?>
    <div class="content">
        <div class="breadcrumbs" vocab="http://schema.org/" typeof="BreadcrumbList">
            <?php $i=0;foreach ($breadcrumbs as $breadcrumb) { ?>
            <span class="itembread" property="itemListElement" typeof="ListItem">
                <meta property="position" content="<?php echo $i+1;?>">
                <?php if(!$i){?>
                    <a property="item" typeof="WebPage" href="<?php echo $breadcrumb['href'];?>">
                        <span class="bread_desc" property="name"><?php echo $breadcrumb['text'];?></span>
                        <span class="bread_mob bread_mob_home"></span>
                    </a>
                <?php } else{ ?>
                    <?php if($i!=(count($breadcrumbs)-1)){?>
                        <a property="item" typeof="WebPage" href="<?php echo $breadcrumb['href'];?>">
                            <span property="name"><?php echo $breadcrumb['text'];?></span>
                        </a>
                    <?php }else{ ?>
                        <span property="item" typeof="WebPage" href="<?php echo $breadcrumb['href'];?>">
                            <span property="name"><?php echo $breadcrumb['text'];?></span>
                        </span>
                    <?php }?>
                <?php }?>
            </span>	
            
            <?php $i++;} ?>
        </div>

        <?php echo $content_top; ?>
        <div class="item_card_product" itemscope itemtype="http://schema.org/Product">
            <div class="card-product">
                <h1 class="title" itemprop="name"><?=$heading_title?></h1>
                <img itemprop="image" src="<?php echo $popup; ?>" style="display:none;">
                
                
                <div itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating" style="display:none">
                    <meta itemprop="ratingValue" content="5" />
                    <meta itemprop="bestRating" content="5"/>
                    <meta itemprop="worstRating" content="1"/>
                    <meta itemprop="ratingCount" content="<?php echo count($reviews);?>" />
                    <meta itemprop="reviewCount" content="<?php echo count($reviews);?>" />
                </div>


                <div class="wrapper_product_cart">
                    <div class="manufacturer">
                        <p>
                            <span itemprop="sku"><?=$sku?></span>
                            <?php if ($manufacturer) { ?>
                                <span>Производитель:&nbsp<span><?php echo $manufacturer; ?></span></span>
                            <?php } ?>
                        </p>
                    </div>
                    <div class="card-product-container" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                        <?php if($quantity_stock>0){?>
                            <meta itemprop="availability" content="http://schema.org/InStock">
                        <?php } else{?>
                            <meta itemprop="availability" content="http://schema.org/PreOrder" />
                        <?php }?>

                        <meta itemprop="seller" content="<?php echo $manufacturer; ?>">
                        <div itemprop="url" href="<?php echo $product_link;?>" style="display:none;"><?php echo $product_link;?></div>
                        <div id="cart_preloader" class="ajax_loader">
                            <div class="loader-classic">
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </div> 

                        <div class="left">
                            <div class="tovar_main_image">
                                <?php if ($thumb) { ?>
                                    
                                    <a class="" data-fancybox="gallery" data-caption="<?php echo $heading_title.'. #1'; ?>"
                                    href="<?php echo $popup; ?>" 
                                    title="<?php echo $heading_title; ?>">
                                        <img src="<?php echo $thumb; ?>"
                                            title="<?php echo $heading_title; ?>"
                                            alt="<?php echo $heading_title; ?>" />
                                    </a>
                                <?php } ?>
                            </div>
                            
                            <div class="thumb__nav">
                                <?php if ($images) { ?>
                                <div class="tovar_mini_gallery">
                                    <?php $i=2; foreach ($images as $image) { ?>
                                        
                                        <div class="tovar_mini_image">
                                            <a data-fancybox="gallery" 
                                            href="<?php echo $image['popup']; ?>" 
                                            data-caption="<?php echo $heading_title.'. #'.$i; ?>">
                                                    <img src="<?php echo $image['thumb']; ?>" 
                                                        title="<?php echo $heading_title; ?>" 
                                                        alt="<?php echo $heading_title; ?>" />
                                            </a>
                                        </div>
                                    <?php $i++;} ?>
                                </div>
                                <?php }?>
                            </div>
                        </div>

                        <div class="right" id="prodRight">
                                <div class="description-price">
                                    <div class="description-mini">
                                        <?=$description_mini?>
                                    </div>
                                    <meta itemprop="priceCurrency" content="RUB"/>
                                    <span itemprop="priceSpecification" itemscope  itemtype="http://schema.org/PriceSpecification">
                                        <meta itemprop="priceCurrency" content="RUB"/>
                                        <meta itemprop="minPrice" content="<?php echo $price_wholesale;?>">                                        
                                        <meta itemprop="maxPrice" content="<?php echo $price;?>">
                                        
                                    </span>    
                                    <meta itemprop="price" content="<?php echo $price;?>">
                                    
                                    <div class="price-for">
                                        <span>Цена за:</span>
                                        
                                        <!--Переключатель цен-->
                                        <?php if($pUnitsErrors):?>
                                            <?= $pUnitsErrors ?>
                                        <?php else: ?>
                                            <ul id="priceSwitcher"
                                                data-currency_symbol="<?=$currencySymb?>"> 

                                                <li data-sale_to_ui_koef="<?=$pUnits[1]['sale_to_ui_koef']?>" 
                                                    <?php if($pUnits[1]['force_step_by_one'] == 1):?>
                                                    data-ui_minimum = "1"
                                                    data-ui_step = "1"
                                                    <?php endif; ?>
                                                    data-ui_name = "<?=$pUnits[1]['name']?>"
                                                    data-ui_name_plural = "<?=$pUnits[1]['name_plural']?>"
                                                    data-ui_name_genitive = "<?=$pUnits[1]['name_package_dimension']?>"
                                                    data-ui_descr="<?=$pUnits[1]['relStr']?>" class="active">
                                                    <a href="#"><?= $pUnits[1]['showName']?></a>
                                                </li>

                                                <?php if(isset($pUnits[2])):?>
                                                <li data-sale_to_ui_koef="<?=$pUnits[2]['sale_to_ui_koef']?>"
                                                    <?php if($pUnits[2]['force_step_by_one'] == 1):?>
                                                    data-ui_minimum = "1"
                                                    data-ui_step = "1"
                                                    <?php endif; ?>
                                                    data-ui_name = "<?=$pUnits[2]['name']?>"
                                                    data-ui_name_plural = "<?=$pUnits[2]['name_plural']?>"
                                                    data-ui_name_genitive = "<?=$pUnits[2]['name_package_dimension']?>"
                                                    data-ui_descr="<?=$pUnits[2]['relStr']?>">
                                                    <a href="#"><?= $pUnits[2]['showName']?></a>
                                                </li>
                                                <?php endif;?>

                                            </ul>
                                        <?php endif;?>
                                        <!-- // -->

                                    </div>

                                </div>
                                <div class="border"></div>
                                
                                <!-- Оптовая цена -->
                                <div class="wholesale">
                                    <div class="wholesale-price">
                                        <?php if($pUnitsErrors):?>
                                            HAS ERRORS, SEE ABOVE
                                        <?php else: ?>
                                        <div class="help_cont"> 
                                            <strong id="wholesale_price" data-value="<?=$price_wholesale?>">
                                            </strong>

                                            <b class="help_question">?<em>Оптовая цена действительна при единовременной оплате <span id="wholesale_threshold" data-value="<?=$wholesale_threshold?>"><?=$wholesale_threshold?></span>&nbsp;<span id="wholesale_unit" data-value="<?=$saleUnit['name_plural']?>"><?=$saleUnit['name_plural']?></span></em></b>
                                            
                                        </div>
                                        <span id="priceWholesaleDescr">
                                        </span>
                                        <?php endif;?>
                                    </div>
                                    <p>Оптом</p>
                                </div> 
                                <!-- // -->

                                <div class="border"></div>

                                <?php if($pUnitsErrors):?>
                                        HAS ERRORS, SEE ABOVE
                                <?php else: ?>

                                    <!-- Розничная цена -->
                                    <div class="wholesale wholesale2">
                                            <div class="wholesale-price">
                                                <strong id="price"  data-value="<?=$price?>">
                                                </strong><br/>
                                                <span id="priceDescr">
                                                </span>
                                            </div>
                                        <p>В розницу</p>
                                    </div>
                                    <!-- // -->

                                    <div class="quantity-buy">
                                        <div class="quantity-buy-block">
                                            <div class="qnt-container-spec"></div>
                                        </div>
                                        <a data-loading-text="Добавление..." 
                                        id="button-cart" 
                                        href="#" 
                                        data-product_id="<?=$product_id?>"
                                        data-sale_to_price_koef="<?=$sale_to_price_koef?>"
                                        class="buy add-to-card">Купить</a>
                                    </div>

                                <?php endif;?>
                            <!--</div>--> 

                            <div class="in-stock">
                                <?php if($quantity_stock>0){?>
                                <span><?php echo $stock;?></span>
                                <ul>
                                    <?php if(isset($locations[0])):?>
                                        <li class="stock1">
                                        <?=$locations[0]['name'];?> 
                                        </li>
                                    <?php endif;?>
                                    <?php if(isset($locations[1])):?>
                                        <li class="stock2">
                                        <?=$locations[1]['name'];?> 
                                        </li>
                                    <?php endif;?>
                                </ul>
                                <?php } else{?>
                                    <div class="notinstock"><?php echo $stock;?></div>
                                <?php }?>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="info-block info-block2" itemprop="description">
                    <?=$description?>
                </div>
            </div>
            
            <?php if(isset($locations[0])):?>
                <?php $l = $locations[0]?>
                <div class="popup2">
                    <div class="close3"></div>
                    <div class="popup-block2">
                        <div class="popup-content2">
                            <div class="close4"></div>
                            <span><?=$l['name']?></span>
                            <p><?=$l['address']?></p>
                            <p><?=$l['open']?></p>
                            <p><?=$l['comment']?></p>
                            <p>Для вашего удобства можете <a target="_blank" href="<?php echo $l["files"][0]['file_link'];?>">скачать подробную схему проезда</a></p>
                            <div class="map">
                                <?=$l['map']?>
                            </div>
                            <!--
                            <div id="prodmap2" 
                                class="map map-container prodmap"
                                data-longitude="<?=$l['longitude']?>"
                                data-latitude="<?=$l['latitude']?>"
                                data-name="<?=$l['name']?>" >
                            </div>
                            -->
                        </div>
                    </div>
                </div>
            <?php endif;?>

            <div id="demoTab">
                <ul class="resp-tabs-list vert">

                    <?php if(!empty($properties)): ?>
                        <li goal_data="card-description">Описание</li>
                    <?php endif;?>
                    <?php if($video_link) {?>
                        <li goal_data="card-video">Видео</li>
                    <?php }?>
                    <li goal_data="card-pack">Упаковка</li>
                    <li goal_data="card-calc">Калькулятор</li>
                    
                    <?php $i=0; foreach($tabs as $t){ ?>
                    <li goal_data="tabdat_<?php echo $i;?>"><?=$t['name']?></li>
                    <?php $i++; }?>

                    <?php if(count($reviews)>0):?>
                    <li goal_data="card-review">Отзывы (<?= count($reviews) ?>)</li>
                    <?php else: ?>
                    <li goal_data="card-review">Отзывы </li>
                    <?php endif; ?>
                </ul>

                <div class="resp-tabs-container vert">

                    <!--TAB Описание-->
                    <?php if(!empty($properties)): ?>
                    <div>
                        <div class="table table_desc">
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
                                        <td><?=htmlspecialchars_decode($p['name'],ENT_QUOTES)?></td>
                                        <td><?=htmlspecialchars_decode($p['val'],ENT_QUOTES)?></td>
                                        <td><?=htmlspecialchars_decode($p['unit'],ENT_QUOTES)?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                        <!--noindex-->
                        <?php if(isset($files)){ ?>
                            <div class="tovar_files">
                                <?php foreach($files as $file){ ?>
                                    <a rel="nofollow" class="download" target="_blank" href="<?php echo $file['href']; ?>"><?php if($file['title']) { echo $file['title'];}else{echo $file['name'];} ?></a>
                                <?php } ?>
                            </div>
                        <?php } ?>
                        <!--/noindex-->
                    </div>
                    
                    <?php endif;?>
                    <?php if($video_link) {?>
                        <div>
                            <div class="wrap_youtube_image">
                                <a href="<?php echo $video_link;?>" data-fancybox data-caption="<?php echo $heading_title;?>. #Видео">
                                    <div class="youtube_image">
                                        <img src="<?php echo $video_img;?>">
                                    </div>
                                </a>
                            </div>
                        </div>
                    <?php }?>
                    <!--TAB упаковка-->
                    <div>
                        <div class="packaging">
                            <?php /*<div class="title">Упаковка <?=$heading_title?></div>*/?>
                            <div class="table table_pack">
                                <table>
                                    <tbody>
                                        <?php foreach( $packageStrings as $s):?>
                                        <tr>
                                            <td><?=htmlspecialchars_decode($s['description'],ENT_QUOTES)?></td>
                                            <td><?=htmlspecialchars_decode($s['value'],ENT_QUOTES)?></td>
                                        </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            
                            <?php /* @task  Нормы загрузки
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
                            */?> 

                        </div>
                    </div>

                    <!-- TAB калькулятор -->
                    <div>
                        <div class="calculator">
                            <?php /*<div class="title">Калькулятор загрузки</div>*/?>
                            <p>В разработке</p>

                            <?php /* @task калькулятор
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
                                    </tbody>
                                </table>
                            </div>
                            <p>В таблице представлен расчет для устройства однослойного гидроизоляционного или кровельного покрытия.
                                Приведенные значения являются справочными, для более точного расчета необходимого количества материала и стоимости доставки обращайтесь к нашим сотрудникам.</p>
                            <a href="" class="print">Распечатать</a>
                            */?>
                        </div>
                    </div>
                
                    <!-- TAB кастомные -->
                    <?php foreach($tabs as $t): ?>
                    <div>
                        <div class="application">
                            <?=$t['text']?>
                        </div>
                    </div>
                    <?php endforeach;?>

                    <!-- TAB отзывы -->
                    <div>
                        <div class="reviews-container reviews-container2">
                            <?php if( count($reviews)>0): ?>
                                <?php foreach ($reviews as $r): ?>
                                    <div class = "review-block" itemscope itemtype="http://schema.org/Review" itemprop="review">
                                        <meta itemprop="itemReviewed" content="<?= $r['about_txt'] ?>"/>

                                        <span itemprop="reviewRating" itemscope="" itemtype="http://schema.org/Rating">
                                            <meta itemprop="ratingValue" content="5">
                                            <meta itemprop="worstRating" content="1">
                                            <meta itemprop="bestRating" content="5">
                                            
                                        </span>
                                        <div class = "review">
                                            <div class = "top">
                                                <span itemprop="author" itemscope itemtype="http://schema.org/Person">
                                                    <strong itemprop="name"><?= $r['author'] ?></strong> о <b>"<?= $r['about'] ?>"</b>
                                                </span>
                                                <p><?= $r['date_added'] ?></p>
                                            </div>
                                            <span itemprop="reviewBody"><?= $r['text'] ?></span>
                                        </div>
                                        <?php if (!empty($r['answer'])): ?>
                                            <div class = "review answer-review">
                                                <div class = "top">
                                                    <span><strong><?= $r['moderator'] ?></strong></span>
                                                </div>
                                                <em><?= $r['answer'] ?></em>
                                            </div>
                                        <?php endif; ?>
                                    </div>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <p style="font-size:14px">
                                    Никто еще не оставил отзыв об этом материале, Вы можете стать первым!
                                </p>
                                <br/>
                                <br/>
                            <?php endif; ?>
                            <div class="give-feedback">
                                <div class="title-give-feedback">Оставить отзыв</div>
                                <form id="form-review" method="post">
                                    <div class = "row">
                                        <span>Имя: 
                                            <i id="error_author" class="error"></i>
                                        </span>
                                        <input name="author" type = "text" placeholder="<?= $entry_author ?>" value="">
                                    </div>
                                    <div class = "row">
                                        <span>
                                            e-mail:
                                            <i id="error_email" class="error"></i>
                                        </span>
                                        <input value="" type = "text" name="email" placeholder="<?= $entry_email ?>">
                                    </div>
                                    <div class = "row">
                                        <span>Организация:
                                            <i id="error_company" class="error"></i>
                                        </span>
                                        <input value="" type = "text" name="company" placeholder="<?= $entry_company ?>">
                                    </div>
                                    <div class = "row">
                                        <span>Отзыв:
                                            <i id="error_text" class="error"></i>
                                        </span>
                                        <textarea  placeholder="<?= $entry_text ?>" name="text"></textarea>
                                    </div>
                                    <div class = "agreement">
                                        <input name="agree" type = "checkbox" id = "agree" value="1"/>
                                        <label for = "agree" id="agreeLabel">
                                            Я согласен с <a target="_blank" href = "<?=$rules?>">правилами</a>
                                            <i id="error_agree" class="error"></i>
                                        </label>
                                    </div>
                                    <div id="ajax_loader" class="ajax_loader">
                                        <div class="loader-classic">
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                        </div>
                                    </div> 
                                        
                                    <button 
                                        id="button-review"
                                        data-product_id="<?=$product_id?>"
                                        type="button"
                                        > Добавить отзыв</button>
                                    
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <?php if(isset($locations[1])):?>
                <?php $l = $locations[1]?>
                <div class="popup3">
                    <div class="close5"></div>
                    <div class="popup-block3">
                        <div class="popup-content3">
                            <div class="close6"></div>
                            <span><?=$l['name']?></span>
                            <p><?=$l['address']?></p>
                            <p><?=$l['open']?></p>
                            <p><?=$l['comment']?></p>
                            <p>Для вашего удобства можете <a href="">скачать подробную схему проезда</a></p>
                            <div id="prodmap3" 
                                class="map map-container prodmap"
                                data-longitude="<?=$l['longitude']?>"
                                data-latitude="<?=$l['latitude']?>"
                                data-name="<?=$l['name']?>" >
                            </div>
                        </div>
                    </div>
                </div>
            <?php endif;?>

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
                            <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                        </div>
                    </li>
                    <?php endforeach;?>
                </ul>
                <?php endif;?>
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<div class="popup thank-you">
    <div class="close"></div>
    <div class="popup-block">
        <div class="popup-content">
            <div class="close2"></div>
            <span><?=$text_thankyou_header?></span>
            <p class="popup-block_text"><?=$text_thankyou?></p>
        </div>
    </div>
</div>
<?= $footer ?>
