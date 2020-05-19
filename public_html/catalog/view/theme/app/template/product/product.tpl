<?php echo $header; ?>
<div class="container main l_product">
    <?= $column_left ?>
    <div class="content">
        <ul class="breadcrumbs" itemscope itemtype="http://schema.org/BreadcrumbList">

            <?php $i=0;foreach ($breadcrumbs as $breadcrumb) { ?>
            
            <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                <meta itemprop="position" content="<?php echo $i+1;?>" />
                <?php if(!$i){?>
                    <a itemprop="item" href="<?php echo $breadcrumb['href'];?>">
                
                        <span class="bread_desc" itemprop="name"><?php echo $breadcrumb['text'];?></span>
                        <span class="bread_mob bread_mob_home"></span>
                    </a>
                <?php } else{ ?>
                    <?php if($i!=(count($breadcrumbs)-1)){?>
                        <a itemprop="item" href="<?php echo $breadcrumb['href'];?>">
                            <span itemprop="name"><?php echo $breadcrumb['text'];?></span>
                        </a>
                    <?php }else{ ?>
                        <span itemprop="name">
                            <?php echo $breadcrumb['text'];?>
                        </span>

                        
                    <?php }?>
                <?php }?>
            </li>	
            
            <?php $i++;} ?>
        </ul>

        <?php echo $content_top; ?>
        <div class="item_card_product" itemscope itemtype="http://schema.org/Product">
            <div class="card-product" id="product_id" product_id="<?=$product_id?>">
                <h1 class="title" itemprop="name"><?=$heading_title?></h1>
                <img itemprop="image" src="<?php echo $popup; ?>" style="display:none;">
                
                <?php if($ratingSum){?>
                    <div itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating" style="display:none">
                        <meta itemprop="ratingValue" content="<?=$ratingValue?>" />
                        <meta itemprop="bestRating" content="5"/>
                        <meta itemprop="worstRating" content="1"/>
                        <meta itemprop="ratingCount" content="<?php echo count($reviews);?>" />
                        <meta itemprop="reviewCount" content="<?=$ratingSum?>" />
                    </div>
                <?php }?>


                <div class="wrapper_product_cart wrp_fly">
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
        
                                <?php if($labels){  ?>
                                    <div class="item_labels">
                                        <?php foreach($labels as $key=>$label){ ?>
                                            <div class="item_label <?php echo $key;?>" title="<?php echo $label['title'];?>"><?php echo $label['label'];?></div>
                                        <?php } ?>
                                    </div>
                                <?php }?>

                                <?php if($rating){?>
                                    <div class="agg_rating">
                                        <div class="agg_rating_ico"></div>
                                        <div class="agg_rating_val"><?php echo $rating?></div>
                                    </div>
                                <?php }?>

                                <?php if ($thumb) { ?>
                                    
                                    <a class="" data-fancybox="gallery" data-caption="<?php echo $heading_title.'. #1'; ?>"
                                    href="<?php echo $popup; ?>" 
                                    title="<?php echo $heading_title; ?>">
                                        <img class="wrp_fly_image" src="<?php echo $thumb; ?>"
                                            title="<?php echo $heading_title; ?>"
                                            alt="<?php echo $heading_title; ?>" />
                                    </a>
                                <?php } ?>
                                <div class="wrp_favorite">
                                    <div title="Добавить товар в избранное" class="favorite <?php echo $favorite;?>" rel="<?php echo $product_id;?>"></div>
                                    <div title="Добавить товар в сравнение" class="compare <?php echo $compare;?>" rel="<?php echo $product_id;?>"></div>
                                </div>
                                
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
                                    <div class="wrap_price-for">

                                        <div class="price-for">
                                            <span>Цена за:</span>
                                            
                                            <!--Переключатель цен-->
                                            <?php if($pUnitsErrors):?>
                                                <?= $pUnitsErrors ?>
                                            <?php else: ?>

                                            
                                            
                                                <ul id="priceSwitcher"
                                                    data-currency_symbol="<?=$currencySymb?>" data-base_vol="<?=$baseVol?>" data-base_weight="<?=$baseWeight?>" data-opt_limit="<?=$optLimit?>" data-rosn_limit="<?=$mincount?>"> 

                                                    <li class="unitpack1" data-sale_to_ui_koef="<?=$pUnits[1]['sale_to_ui_koef']?>" 
                                                        <?php if($pUnits[1]['force_step_by_one'] == 1):?>
                                                        data-ui_step = "1"
                                                        <?php endif; ?>
                                                        <?php if (isset($pUnits[2])){ ?>
                                                            <?php if (( $quantity_stock<=0) and ($pUnits[2]['denom']>$pUnits[2]['nom']) ){ ?>
                                                                data-ui_step = "<?=$pUnits[2]['denom']?>"
                                                                <?php if($pUnits[1]['mincount']<$pUnits[2]['denom']){ ?>
                                                                    data-ui_minimum = "<?=$pUnits[2]['denom']?>"
                                                                <?php }else{ ?>
                                                                    data-ui_minimum = "<?=$pUnits[1]['mincount']?>"
                                                                <?php } ?>
                                                            <?php }else{ ?>
                                                                    data-ui_minimum = "<?=$pUnits[1]['mincount']?>"
                                                            <?php }?>

                                                        <?php }else{?>
                                                            data-ui_minimum = "<?=$pUnits[1]['mincount']?>"
                                                        <?php }?>
                                                        data-nom=<?=$pUnits[1]['nom']?>
                                                        data-denom=<?=$pUnits[1]['denom']?>
                                                        
                                                        data-ui_name = "<?=$pUnits[1]['name']?>"
                                                        data-ui_name_plural = "<?=$pUnits[1]['name_plural']?>"
                                                        data-ui_name_genitive = "<?=$pUnits[1]['name_package_dimension']?>"
                                                        data-ui_descr="<?=$pUnits[1]['relStr']?>" class="active">
                                                        <a href="#"><?= $pUnits[1]['showName']?></a>
                                                    </li>

                                                    <?php if(isset($pUnits[2])):?>
                                                    <li class="unitpack2" data-sale_to_ui_koef="<?=$pUnits[2]['sale_to_ui_koef']?>"
                                                        <?php if($pUnits[2]['force_step_by_one'] == 1):?>
                                                        data-ui_step = "1"
                                                        <?php endif; ?>
                                                        data-nom=<?=$pUnits[2]['nom']?>
                                                        data-denom=<?=$pUnits[2]['denom']?>
                                                        
                                                        data-ui_minimum = "<?=$pUnits[2]['mincount']?>"
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
                                        <?php if($discount_form){?>
                                        <div class="price_disc">
                                            <div class="js_modal with_goal" goal="<?php echo $discount_goal;?>" data-modal="modal_discount">Получить скидку</div>
                                        </div>
                                        <?php }?>
                                    </div>

                                </div>
                                <div class="border"></div>
                                
                                <!-- Оптовая цена -->
                                <div class="wholesale">
                                    <div class="wholesale-price">
                                        <?php if($pUnitsErrors):?>
                                            HAS ERRORS, SEE ABOVE
                                        <?php else: ?>

                                        <div class="help_cont <?php if($price_wholesaleold){echo "_oldprice";}?>"> 
                                            <div class="wrp_price_i">
                                                <strong class="price_i" id="wholesale_price" data-value="<?=$price_wholesale?>"><?=$price_wholesale_val?>
                                                </strong>
                                                <?php if($price_wholesaleold){?>
                                                    <div class="product_old_price product_old_price1">
                                                        <?=$price_wholesaleold?> <div class="rur">i</div>
                                                    </div>
                                                <?php }?>
                                            </div>
                                        </div>
                                        
                                        <span id="priceWholesaleDescr">
                                        </span>
                                        <?php endif;?>
                                    </div>
                                    <div class="count_limit">
                                        <p>Оптом</p>
                                        <p id="opt_limit"></p>
                                    </div>
                                </div> 
                                <!-- // -->

                                <div class="border"></div>

                                <?php if($pUnitsErrors):?>
                                        HAS ERRORS, SEE ABOVE
                                <?php else: ?>

                                    <!-- Розничная цена -->
                                    <div class="wholesale wholesale2">
                                        <div class="wholesale-price <?php if($priceold){echo "_oldprice";}?>">
                                            <div class="wrp_price_i">
                                                <strong class="price_i" id="price"  data-value="<?=$price?>"><?=$price_val?>
                                                </strong>
                                                <?php if($priceold){?>
                                                    <div class="product_old_price product_old_price2">
                                                        <?=$priceold?> <div class="rur">i</div>
                                                    </div>
                                                <?php }?>
                                            </div>
                                            <br/>
                                            <span id="priceDescr">
                                            </span>
                                        </div>
                                        <div class="count_limit">
                                            <p>В розницу</p>
                                            <p id="rosn_limit"></p>
                                        </div>
                                    </div>
                                    <!-- // -->
                                    
                                    <div class="quantity-buy quantity-buy_product">
                                        
                                        <div class="quantity-buy-block mincount_container">
                                            <div class="min_count_hint" id="min_count_hint"><span>минимально для заказа</span></div>
                                            <div class="qnt-container-spec"></div>
                                        </div>
                                        <a data-loading-text="Добавление..." 
                                        id="button-cart" 
                                        href="#" 
                                        data-product_id="<?=$product_id?>"
                                        data-sale_to_price_koef="<?=$sale_to_price_koef?>"
                                        class="buy add-to-card add-to-card-product">В корзину</a>
                                    </div>
                                    <div class="wrap_oneclick">
                                        <div class="oneclick_product_thanks">Спасибо за обращение. Мы Вам перезвоним.</div>
                                        <form action="#" class="oneclickform">
                                            <input type="hidden" name="product" value="<?=$heading_title?>"/>
                                            <input type="text" class="workemail" name="workemail"/>
                                            <input type="tel" class="onclickInputMain" placeholder="Введите телефон" name="phone"/>
                                            <button type="submit" class="onclickButton">Купить в 1 клик</button>
                                        </form>
                                    </div>
                                    

                                <?php endif;?>
                            <!--</div>--> 
                            <div class="wrap_state_stock">
                                <div class="state_stock">

                                    <div class="state_stock_col">
                                        <div class="state_stock_col_info _avail">
                                            <div class="state_stock_cap">Наличие на складе:</div>
                                            <div class="state_stock_val">
                                            <?php if($quantity_stock>0){?>
                                                <!--<span class="stock1 with_goal" goal="in-stock">Алтуфьево</span>-->
                                                <span class="js_modal with_goal" goal="in-stock" data-modal="modal_map">Алтуфьево</span>
                                            <?php }else{ ?>
                                                <span class="notinstock js_modal with_goal" goal="pre-order" data-modal="modal_delivery">Под заказ</span>
                                            <?php }?>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="state_stock_del"></div>
                                    <div class="state_stock_col">
                                        <div class="state_stock_col_info  _delivery">
                                            <div class="state_stock_cap">Доставка:</div>
                                            <div class="state_stock_val js_modal with_goal" goal="delivery" data-modal="modal_delivery_cost" id="delivery_text"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="state_stock_link js_modal with_goal" goal="payment-receipt" data-modal="modal_delivery_pay">Способы оплаты и получения товара</div>
                            </div>

                            <!--
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
                            -->
                        </div>
                    </div>
                </div>
                
                <?php if($benefits) {?>
                    <div class="benefits">
                        <?php foreach($benefits as $benefit){ ?>
                            <div class="bene_item with_goal" goal="<?php echo $benefit['goal'];?>">
                                <div class="bene_item_ico"><img src="<?php echo $benefit['filename'];?>"/></div>
                                <div class="bene_item_val"><?php echo $benefit['name'];?></div>
                                <div class="bene_item_desc"><?php echo $benefit['description'];?></div>
                            </div>
                        <?php }?>
                    </div>
                <?php }?>
                <div class="info-block info-block2" itemprop="description">
                    <?=$description?>
                </div>
            </div>
            

            <div id="demoTab">
                <ul class="resp-tabs-list vert">

                    <?php if(!empty($properties)): ?>
                        <li goal_data="card-description">Описание</li>
                    <?php endif;?>
                    <?php if($video_link) {?>
                        <li goal_data="card-video">Видео</li>
                    <?php }?>
                    <li goal_data="card-pack">Упаковка</li>
                    
                    <?php if($calculator){ ?>
                        <li goal_data="card-calc">Калькулятор</li>
                    <?php }?>
                    
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
                                <nofollow>
                                    <a rel="nofollow" href="<?php echo $video_link;?>" data-fancybox data-caption="<?php echo $heading_title;?>. #Видео">
                                        <div class="youtube_image">
                                            <img src="<?php echo $video_img;?>">
                                        </div>
                                    </a>
                                </nofollow>
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
                            
                        </div>

                        <?php if(isset($pUnits[2])) {?>
                            <h2>Нормы загрузки в автотранспорт</h2>
                            <div class="content-text">
                                <p>Чтобы рассчитать какое количество материала можно безболезненно загрузить, выберите тип автомобиля.</p>
                            </div>
                            

                            <div class="tipe">
                                <!--<span>Выберите тип автомобиля:</span>-->
                                <select class="nice-select" id="courier_select">
                                    <option value="0" selected>Выберите тип автомобиля...</option>

                                    <?php foreach($couriers as $courier){ if ($baseWeight<=$courier['weight']){?>
                                        <option value="<?php echo $courier['weight']?>"><?php echo $courier['name']?></option>
                                    <?php }}?>
                                    
                                </select>
                            </div>
                            
                            <div class="wrap_table_data">
                            <table class="table_data">
                                <thead>
                                    <tr><th><?= $pUnits[1]['name']?></th><th><?= $pUnits[2]['name']?></th></tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td id="unitpack1_str">-</td>
                                        <td id="unitpack2_str">-</td>
                                    </tr>
                                </tbody>
                            </table>
                            </div>
                            <div class="content-text">
                                <p>Нормы загрузки материалов приведены справочно. Для точного расчета обращайтесь к <a target="_blank" title="Контакты" href="contacts/">нашим сотрудникам</a></p>
                            </div>
                        <?php }?>
                    </div>
                    
                    <!-- TAB калькулятор -->
                    
                    <?php if($calculator){echo $calculator;}?>
                    
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
                                            <meta itemprop="ratingValue" content="<?= $r['rating'] ?>">
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
                                            
                                            <div class="rating_stars _reviews">
                                                
                                                <?php for($i=1;$i<=5;$i++){?>
                                                    
                                                    <?php if($i<=$r['rating']){?>
                                                        <div class="star_block"></div>
                                                    <?php }else{?>
                                                        <div class="star_block _hide"></div>
                                                    <?php }?>

                                                <?php }?>
                                            </div>

                                            <div class="reviewBody" itemprop="reviewBody"><?= $r['text'] ?></div>
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
                                        <div class="wrp_star">
                                            
                                            <span>Отзыв:
                                                <i id="error_text" class="error"></i>
                                            </span>
                                            <div class="wrp_star_rating">
                                                <input type="hidden" name="rating" value="5" id="star_value"/>
                                                <span class="rating_caption">Рейтинг:</span>
                                                <div class="rating_stars">
                                                    <div class="star_block rating_star _rate" rel="1"></div>
                                                    <div class="star_block rating_star _rate" rel="2"></div>
                                                    <div class="star_block rating_star _rate" rel="3"></div>
                                                    <div class="star_block rating_star _rate" rel="4"></div>
                                                    <div class="star_block rating_star _rate" rel="5"></div>
                                                </div>
                                                <div class="rating_stars_value">(<span id="rating_stars_value">5</span>)</div>
                                            </div>
                                        </div>
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


            

            <div class="mentioned-products mentioned-products2 wrp_mentioned_slider">
                <?php if( $products):?>

                <div class="mentioned_products_captions">
                    <div class="wrp_mentioned_products_captions">
                        <div id="mentioned_active_line" class="mentioned_active_line"></div>
                        <?php if(count($products[0])){ ?>
                            <div class="mentioned_products_caption active" rel="1">Аналоги</div>
                        <?php }?>
                        <?php if(count($products[1])){ ?>
                            <div class="mentioned_products_caption" rel="2">Сопутствующие</div>
                        <?php }?>
                    </div>
                </div>

                <!--<div class="title">Аналоги и сопутствующие товары</div>-->

                <div class="mentioned_sliders">
                    <div class="wrapper_mentioned_sliders">
                        <?php if(count($products[0])){ ?>
                            <div class="mentioned_slider active" rel="1">
                                <ul class="ment_slider">
                                    <?php foreach( $products[0] as $p):?>
                                    <li>
                                        <?php if($p["labels"]){  ?>
                                            <div class="item_labels">
                                                <?php foreach($p["labels"] as $key=>$label){ ?>
                                                    <div class="item_label <?php echo $key;?>" title="<?php echo $label['title'];?>"><?php echo $label['label'];?></div>
                                                <?php } ?>
                                            </div>
                                        <?php }?>
                                        <div class="products-block">
                                            <?php if($p["rating"]){?>
                                                <div class="agg_rating"><?php echo $p["rating"];?></div>
                                            <?php }?>
                                            
                                            <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>

                                            <a href="<?=$p['href']?>" class="img-production">
                                                <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
                                            </a>
                                            
                                            <strong><?=$p['price']?> <div class="rur">i</div></strong>
                                            <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                                        </div>
                                    </li>
                                    <?php endforeach;?>
                                    <?php foreach( $products[0] as $p):?>
                                    <li>
                                        <?php if($p["labels"]){  ?>
                                            <div class="item_labels">
                                                <?php foreach($p["labels"] as $key=>$label){ ?>
                                                    <div class="item_label <?php echo $key;?>" title="<?php echo $label['title'];?>"><?php echo $label['label'];?></div>
                                                <?php } ?>
                                            </div>
                                        <?php }?>
                                        <div class="products-block">
                                            <?php if($p["rating"]){?>
                                                <div class="agg_rating"><?php echo $p["rating"];?></div>
                                            <?php }?>
                                            
                                            <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>

                                            <a href="<?=$p['href']?>" class="img-production">
                                                <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
                                            </a>
                                            
                                            <strong><?=$p['price']?> <div class="rur">i</div></strong>
                                            <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                                        </div>
                                    </li>
                                    <?php endforeach;?>
                                </ul>
                            </div>
                        <?php } ?>

                        <?php if(count($products[1])){ ?>
                            <div class="mentioned_slider second" rel="2">
                                <ul class="ment_slider">
                                    <?php foreach( $products[1] as $p):?>
                                    <li>
                                        <?php if($p["labels"]){  ?>
                                            <div class="item_labels">
                                                <?php foreach($p["labels"] as $key=>$label){ ?>
                                                    <div class="item_label <?php echo $key;?>" title="<?php echo $label['title'];?>"><?php echo $label['label'];?></div>
                                                <?php } ?>
                                            </div>
                                        <?php }?>
                                        <div class="products-block">
                                            <?php if($p["rating"]){?>
                                                <div class="agg_rating"><?php echo $p["rating"];?></div>
                                            <?php }?>
                                            
                                            <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>

                                            <a href="<?=$p['href']?>" class="img-production">
                                                <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
                                            </a>
                                            
                                            <strong><?=$p['price']?> <div class="rur">i</div></strong>
                                            <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                                        </div>
                                    </li>
                                    <?php endforeach;?>
                                    <?php foreach( $products[1] as $p):?>
                                    <li>
                                        <?php if($p["labels"]){  ?>
                                            <div class="item_labels">
                                                <?php foreach($p["labels"] as $key=>$label){ ?>
                                                    <div class="item_label <?php echo $key;?>" title="<?php echo $label['title'];?>"><?php echo $label['label'];?></div>
                                                <?php } ?>
                                            </div>
                                        <?php }?>
                                        <div class="products-block">
                                            <?php if($p["rating"]){?>
                                                <div class="agg_rating"><?php echo $p["rating"];?></div>
                                            <?php }?>
                                            
                                            <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>

                                            <a href="<?=$p['href']?>" class="img-production">
                                                <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
                                            </a>
                                            
                                            <strong><?=$p['price']?> <div class="rur">i</div></strong>
                                            <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                                        </div>
                                    </li>
                                    <?php endforeach;?>
                                </ul>
                            </div>
                        <?php } ?>
                    </div>
                </div>

                
                <?php endif;?>
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<!--
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

<div class="modal modal_thank-you">
    <div class="modal-block">
        <div class="modal_overlay"></div>
        <div class="modal-content">
            <div class="modal_close"></div>
            <div class="modal_caption"><?=$text_thankyou_header?></div>
            <div class="modal_text content-text">
                <?=$text_thankyou?>
            </div>
        </div>
    </div>
</div>
-->
<div class="modal modal_delivery_cost">
    <div class="modal-block">
        <div class="modal_overlay"></div>
        <div class="modal-content">
            <div class="modal_close"></div>
            <div class="modal_caption" id="caption_delivery"></div>
            <div class="modal_text content-text" id="text_delivery"></div>
        </div>
    </div>
</div>

<div class="modal modal_delivery_pay">
    <div class="modal-block">
        <div class="modal_overlay"></div>
        <div class="modal-content">
            <div class="modal_close"></div>
            <div class="modal_caption"><?=$delivery_cost_caption?></div>
            <div class="modal_text content-text"><?=$delivery_cost_text?></div>
        </div>
    
    </div>
</div>
<?php if(isset($locations[0])):?>
    <?php $l = $locations[0]?>
    <!--<div class="popup2">
        <div class="close3"></div>
        <div class="popup-block2">
        -->
    <div class="modal modal_map">
        <div class="modal-block">
            <div class="modal_overlay"></div>
            <div class="modal-content">
                <div class="modal_close"></div>
                <!--<span><?=$l['name']?></span>-->
                <div class="modal_caption"><?=$l['name']?></div>
                <div class="modal_text_map">
                    <p><?=$l['address']?></p>
                    <p><?=$l['open']?></p>
                    <p><?=$l['comment']?></p>
                    <p>Для вашего удобства можете <a target="_blank" href="<?php echo $l['files'][0]['file_link'];?>">скачать подробную схему проезда</a></p>
                </div>
                <div class="map">
                    <?=$l['map']?>
                </div>
            </div>
        </div>
    </div>
<?php endif;?>

<div class="modal modal_delivery">
    <div class="modal-block">
        <div class="modal_overlay"></div>
        <div class="modal-content">
            <div class="modal_close"></div>
            <div class="modal_caption"><?=$nostock_caption?></div>
            <div class="modal_text content-text">
                <?=$nostock_text?>
            </div>
        </div>
    </div>
</div>
<?php if($benefits) {?>
    <div class="modal modal_benefits">
        <div class="modal-block">
            <div class="modal_overlay"></div>
            <div class="modal-content">
                <div class="modal_close"></div>
                <div class="modal_caption" id="caption_benefit"></div>
                <div class="modal_text content-text" id="text_benefit"></div>
            </div>
        </div>
    </div>
<?php }?>
<?php if($discount_form){?>
    <div class="modal modal_discount">
        <div class="modal-block">
            <div class="modal_overlay"></div>
            <div class="modal-content">
                <div class="modal_close"></div>
                <div class="wrp_modal_body">
                    <div class="modal_caption"><?=$discount_caption?></div>
                    <div class="modal_text content-text">
                        <?=$discount_text?>
                    </div>
                    
                    <div class="modal_form">
                        <form id="discount_form" action="#" method="post" enctype="multipart/form-data">
                        <input name="label" type="hidden" placeholder="" value="<?php echo $discount_label;?>"/>
                        <input name="product" type="hidden" placeholder="" value="<?php echo $heading_title;?>"/>

                        <div class="modal_form_group">
                            <div class="modal_form_row">
                                <i class="error">Необходимо заполнить</i>
                                <input class="inputModal required" name="name" type="text" placeholder="Ваше имя"/>
                            </div>

                            <div class="modal_form_row">
                                <i class="error">Необходимо заполнить</i>
                                <input class="inputModal required" name="company" type="text" placeholder="Название организации"/>
                            </div>
                        </div>

                        <div class="modal_form_group">
                            <div class="modal_form_row">
                                <i class="error">Необходимо заполнить</i>
                                <input class="inputModal required" name="phone" type="tel" placeholder="Телефон"/>
                            </div>
                            <div class="modal_form_row">
                                <i class="error">Некорректный Email</i>
                                <input class="inputModal required" name="email" type="text" placeholder="E-mail"/>
                            </div>
                        </div>
                        <div class="modal_form_group">
                            <div class="modal_form_row">
                                <input class="inputModal" name="site" type="text" placeholder="Сайт"/>
                            </div>
                        </div>
                        
                        <div class="modal_form_row">
                            <i class="error">Необходимо заполнить</i>
                            <div class="file">
                                <div class="file-block">
                                    <div id="filename">Прикрепить реквизиты</div>
                                    <input id="file" type="file" value="" name="download">
                                </div>
                            </div>
                            
                        </div>
                        

                        <input value="" name="workemail" type="text" placeholder="Рабочий email"/>
                        <div class="modal_form_link">
                            <p>Нажимая на кнопку Отправить, я даю <a target="_blank" href="agreement/">согласие на обработку персональных данных</a></p>
                        </div>

                        <input
                            type ="submit"
                            class="g-recaptcha"
                            data-sitekey="<?= $captcha_key ?>"
                            data-callback="submitDiscountForm" value="Отправить"/>
                            
                        

                        </form>
                    </div>
                </div>
                <div class="wrp_modal_thsnk">
                    <div class="modal_caption">Благодарим вас за обращение!</div>
                    <div class="content-text">
                        <p style="text-align: center">Мы свяжемся с вами в ближайшее время!</p>
                    </div>
                </div>
                <script type="text/javascript">
                    function submitDiscountForm(){ 
                        $('#discount_form').submit();
                    }
                </script>
                
                </div>
                
            </div>
        </div>
    </div>
<?php }?>
<?= $footer ?>
