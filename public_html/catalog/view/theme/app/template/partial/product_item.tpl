<li class="catalog_item_product wrp_fly" rel="<?= $p['product_id']?>" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
    
    <?php if($p["labels"]){  ?>
        <div class="item_labels">
            <?php foreach($p["labels"] as $key=>$label){ ?>
                
                <?php if($key=="_accia"){?>
                    <div class="item_label <?php echo $key;?>"><?php echo $label['label'];?></div>
                <?php }elseif($key=="_discount") {?>
                <div class="item_label <?php echo $key;?>"><a title="<?php echo $label['title'];?>" href="sales/discounts/"><?php echo $label['label'];?></a></div>
                <?php }else{?>
                    <div class="item_label <?php echo $key;?>" title="<?php echo $label['title'];?>"><?php echo $label['label'];?></div>
                <?php }?>
            <?php } ?>
        </div>
    <?php }?>

    <div class="catalog-block" itemprop="item" itemscope itemtype="http://schema.org/Offer">
        <?php if(isset($p["labels"]["_accia"])){?>
            <div class="product_accia_text">
                <div class="icon_del close_accia_info"></div>
                <div class="product_accia_info">
                    <?php foreach($p["labels"]["_accia"]["items"] as $accia) {?>
                        <div class="product_accia_row">
                            <div class="product_accia_caption"><?php echo $accia['title'];?></div>
                            <div class="product_accia_content"><?php echo $accia['text'];?></div>
                            <div class="product_accia_link">
                                <a href="<?php echo $accia['url'];?>" target="_blank">Перейти к акции</a>
                            </div>
                        </div>
                    <?php }?>
                </div>
            </div>
        <?php }?>
        
        <!--<a href="<?= $p['href'] ?>" class="full_item_link" title="<?= $p['name'] ?>">-->
        <?php if($p["rating"]){?>
            <div class="agg_rating">
                <div class="agg_rating_ico"></div>
                <div class="agg_rating_val"><?php echo $p["rating"];?></div>
            </div>
        <?php }?>
        <a href="<?= $p['href'] ?>" class="full_item_link" title="<?= $p['name'] ?>">
            <div class="catalog-img">
                <div class="fast_preview">
                    <div class="fast_preview_caption">
                        <span class="fast_preview_span with_goal" goal="quick-view">Быстрый просмотр</span>
                    </div>
                </div>
                
<picture >
    <source type="image/webp" srcset="<?= $p['thumb_webp'] ?>">
    <source type="image/jpeg" srcset="<?= $p['thumb'] ?>">
    <img class="wrp_fly_image" itemprop="image" src="<?= $p['thumb'] ?>" alt="<?= $p['name'] ?>" title="<?= $p['name'] ?>" itemprop="image" />
</picture>                
                <div class="wrp_favorite">
                    <div rel="<?= $p['product_id']?>" title="Добавить товар в избранное" class="favorite <?= $p['favorite'] ?>"></div>        
                    <div rel="<?= $p['product_id']?>" title="Добавить товар в сравнение" class="compare <?= $p['compare'] ?>"></div>
                </div>
            </div>
        </a>
        <div class="clr"></div>

        <div class="catalog-description">
            <a href="<?= $p['href'] ?>" class="full_item_link" title="<?= $p['name'] ?>">
                <div class="catalog-block_caption" itemprop="name"><?= $p['name'] ?></div>
            </a>
            <div class="catalog_lsi description" itemprop="description">
                <div class="wrp_catalog_lsi">
                    <?= $p['descriptionPreview'] ?>
                </div>
            </div>
            <div class="complement">
            
                <?php foreach ($p['properties'] as $prop): ?>
                    <span>
                        <?= $prop['name'] ?>:&nbsp;<span class="prop_unit"><?= $prop['val'] ?>&nbsp;<?= $prop['unit'] ?></span>
                    </span>
                <?php endforeach ?>
                
            </div>
            
            <span class="price cat_item_price">
                <div class="wrapper_price_line">
                    <div class="cat_item_price_caption">от</div>
                    <div class="cat_price_val <?php if($p["priceold"]){echo "_oldprice";}?>" content="<?=$p['price_val']?>">
                        <div class="cat_price_value">
                            <?=$p['price']?>
                        </div> <div class="rur">i</div>
                    </div>
                    <?php if($p["priceold"]){?>
                        <div class="cat_priceold"><?php echo $p["priceold"];?> <div class="rur">i</div></div>
                    <?php }?>
                </div>
                <div class="wrapper_count_line">
                    <?php echo $p['quantity']; ?>

                    <?php if($p['quantity']>5){ ?>
                        <div class="prod_cnt _mnogo">На складе</div>
                    <?php }?>
                    <?php if($p['quantity']>0 and $p['quantity']<=5){ ?>
                        <div class="prod_cnt _malo">Мало</div>
                    <?php }?>
                    <?php if($p['quantity']==0){ ?>
                        <div class="prod_cnt _podzakaz">Под заказ</div>
                    <?php }?>
                </div>
            </span>

            <div class="quantity-buy">
    
                <?php if(empty($p['unit_errors'])): ?>
                    <div class="wrp_qnt-container mincount_container">
                        <div class="wrapper_product_hint">
                            <div class="qnt-container"
                                data-sale_to_ui_koef="<?=$p['sale_to_ui_koef']?>"
                                data-ui_name="<?=$p['ui_unit_name']?>"
                                data-ui_name_plural="<?=$p['ui_unit_name_plural']?>"
                                data-ui_name_genitive="<?=$p['ui_unit_name_genitive']?>"
                                
                                data-ui_step = "<?=$p['step']?>"
                                data-ui_minimum = "<?=$p['mincount']?>"

                                <?php if($p['ui_unit_force_step_by_one'] == 1):?>
                                data-ui_minimum="1"
                                data-ui_step= 1"
                                <?php endif; ?>

                            >
                            </div>

                            <div class="min_count_hint" <?php if($p['mincount']>1){echo 'style="display:block"';} ?>><span>минимально для заказа</span></div>
                        </div>
                        <div title="Добавить в корзину" class="buy add-to-card add-to-card-catalog"
                            data-product_id="<?=$p['product_id']?>" 
                            data-sale_to_price_koef="<?=$p['sale_to_price_koef']?>">
                            Добавить в корзину
                        </div>
                    </div>
                    
                    <div class="wrap_oneclick" title="Для быстрого заказа введите свой телефон">
                        
                        <div class="oneclick_hover">
                            <div class="oneclick_hover_ok"></div>
                            <span>Купить в 1 клик
                            <div class="oneclick_loader">
                                <div class="loader-sonar">
                                    <span></span>
                                    <span></span>
                                </div>
                            </div>
                        </div>
                        <div class="oneclick_thanks">Спасибо за обращение</div>
                        <form action="#" class="oneclickform">
                            <input type="hidden" name="product" value="<?= $p['name'] ?>"/>
                            <input type="text" class="workemail" name="workemail"/>
                            <input type="tel" class="onclickInput" placeholder="Ваш телефон" name="phone"/>
                            <!--<button title="Купить в 1 клик" type="submit" class="onclickButton">Купить<span> в 1 клик</span></button>-->
                        </form>
                    </div>
                <?php else: ?>
                    <?php foreach($p['unit_errors'] as $e): ?>
                        <?=$e . "<br/>"?>
                    <?php endforeach; ?>
                <?php endif;?>
            </div>
            <div class="clr_buy"></div>
            <a href="<?= $p['href'] ?>" class="full_item_link" title="<?= $p['name'] ?>">
                <div class="more_product">Подробнее</div>
            </a>
        </div>
        <!--</a>-->
    </div>
    
</li>