<li class="catalog_item_product wrp_fly <?=$class_hide?>">
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

    <div class="catalog-block">
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

        <div class="catalog-img">
            <a target="_blank" href="<?= $p['href'] ?>" class="full_item_link" title="<?= $p['name'] ?>" >
                <picture >
                    <source type="image/webp" srcset="<?= $p['thumb_webp'] ?>">
                    <source type="image/jpeg" srcset="<?= $p['thumb'] ?>">
                    <img class="wrp_fly_image" itemprop="image" src="<?= $p['thumb'] ?>" alt="<?= $p['meta_h1'] ?>" title="<?= $p['meta_h1'] ?>" />
                </picture>
                <?php if($p["color_name"]){?>
                    <?php if($p['color_code']){?>
                        <div class="wrp_product_color " style="background-color:#<?=$p['color_code']?>">
                    <?php }else {?>
                        <div class="wrp_product_color _transparent">
                    <?php }?>
                        <div class="product_color_hint">
                            <div class="product_color_hint_caption">Цвет:</div>
                            <div class="product_color_hint_val"><?=$p["color_name"]?></div>
                        </div>
                    </div>
                <?php }?>
            </a>
        </div>

        <div class="catalog-description">
            
            <div class="catalog-block_caption">
                <a target="_blank" href="<?= $p['href'] ?>" class="full_item_link" title="<?= $p['name'] ?>">
                    <?= $p['name'] ?></div>
                </a>
                <div class="catalog_lsi description">
                    <div class="wrp_catalog_lsi">
                        <?= $p['descriptionPreview'] ?>
                    </div>
                </div>
                <div class="wrapper_count_line">
                
                    <?php if($p["notavail"]){ ?>
                        <div class="prod_cnt _notavail">Нет в наличии</div>
                    <?php }else{ ?>
                        <?php if($p['quantity']>5){ ?>
                            <div class="prod_cnt _mnogo">На складе</div>
                        <?php }?>
                        <?php if($p['quantity']>0 and $p['quantity']<=5){ ?>
                            <div class="prod_cnt _malo">Мало</div>
                        <?php }?>
                        <?php if($p['quantity']==0){ ?>
                            <div class="prod_cnt _podzakaz">Под заказ</div>
                        <?php }?>
                    <?php }?>
                </div>
            </div>

            <?php if($cnt) {?>
                <div class="youneed">
                    <div class="youneed_caption">Вам понадобится:</div>
                    <div class="youneed_value"><?=$rashod?></div>
                </div>
            <?php }?>

            <div class="calc_product_add">

                <div class="complement">
                    <?php foreach ($p['properties'] as $prop): ?>
                        <span>
                            <?= $prop['name'] ?>:&nbsp;<span class="prop_unit"><?= $prop['val'] ?>&nbsp;<?= $prop['unit'] ?></span>
                        </span>
                    <?php endforeach ?>
                    
                </div>
            
                <div class="price cat_item_price" itemscope itemtype="http://schema.org/Offer" itemprop="offers">
                    <meta itemprop="priceCurrency" content="RUB">
                    <?php if($p["notavail"]){ ?>
                        <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                    <?php }else{?>
                        <link itemprop="availability" href="http://schema.org/InStock"/>
                    <?php }?>

                    <div class="wrapper_price_line">
                        <?php if($p['price'] and !$p['notavail']){ ?>
                            <div class="cat_item_price_caption">от</div> 
                            
                            <div class="cat_price_val <?php if($p["priceold"]){echo "_oldprice";}?>" content="<?=$p['price_val']?>" itemprop="price">
                                <div class="cat_price_value" >
                                    <?=$p['price']?>
                                </div><span class="cat_item_price_curr"> ₽</span>
                            </div>
                            <?php if($p["priceold"]){?>
                                <div class="cat_priceold"><?php echo $p["priceold"];?> ₽</div>
                            <?php }?>
                        <?php }?>
                    </div>
                    
                </div>
                <div class="quantity-buy">
        
                    <?php if(empty($p['unit_errors'])): ?>
                        <div class="wrp_qnt-container mincount_container">
                            <div class="wrapper_product_hint">
                                <div class="qnt-container"
                                    data-sale_to_ui_koef="<?=$p['sale_to_ui_koef']?>"
                                    data-ui_name="<?=$p['ui_unit_name']?>"
                                    data-ui_name_plural="<?=$p['ui_unit_name_plural']?>"
                                    data-ui_name_genitive="<?=$p['ui_unit_name_genitive']?>"
                                    
                                    data-ui_minimum="<?=$p['mincount']?>"
                                    data-ui_step="<?=$p['step']?>"
                                    data-cnt="<?=$cnt?>"
                                    
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
                    <?php else: ?>
                        <?php foreach($p['unit_errors'] as $e): ?>
                            <?=$e . "<br/>"?>
                        <?php endforeach; ?>
                    <?php endif;?>
                </div>
            </div>

        </div>

    </div>
</li>