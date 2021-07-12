<div class="card-product" id="product_id" product_id="<?=$product_id?>">
    <div class="hideval" id="discount_val" data-value="<?=$discount_percent?>"></div>
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

    <div class="title" itemprop="name"><?=$heading_title?></div>
    
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
            
            <meta itemprop="seller" content="<?php echo $manufacturer; ?>">
            
            
            <div class="left">
                <div class="tovar_main_image">
                    <?php if($labels){  ?>
                        <div class="item_labels">
                            <?php foreach($labels as $key=>$label){ ?>
                                <div class="item_label <?php echo $key;?>" title="<?php echo $label['title'];?>"><?php echo $label['label'];?></div>
                            <?php } ?>
                        </div>
                    <?php }?>
                    

                    <?php if ($thumb) { ?>
                        <img class="wrp_fly_image" id="main_popup_product_image" src="<?php echo $thumb; ?>"
                            title="<?php echo $heading_title; ?>"
                            alt="<?php echo $heading_title; ?>" />
                    <?php } ?>
                    
                </div>
                <div class="wrp_favorite">
                    <?php if($rating){?>
                        <div class="agg_rating">
                            <div class="agg_rating_ico"></div>
                            <div class="agg_rating_val"><?php echo $rating?></div>
                        </div>
                    <?php }?>
                    <div title="Добавить товар в избранное" class="favorite <?php echo $favorite;?>" rel="<?php echo $product_id;?>"></div>
                    <div title="Добавить товар в сравнение" class="compare <?php echo $compare;?>" rel="<?php echo $product_id;?>"></div>
                </div>
                <div class="thumb__nav">
                    <?php if ($images) { ?>
                    <div class="tovar_mini_gallery">
                        <?php $i=1; foreach ($images as $image) { ?>
                            <img src="<?php echo $image['popup'];?>" class="hideVal" />
                            <div class="tovar_mini_image <?php echo ($i==1?'active':'');?>" rel="<?php echo $image['popup'];?>">
                                
                                <img src="<?php echo $image['thumb']; ?>" 
                                    title="<?php echo $heading_title; ?>" 
                                    alt="<?php echo $heading_title; ?>" />
                        
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
                                        <?php if($pUnits[1]['force_step_by_one'] == 1){ ?>
                                            data-ui_step = "1"
                                        <?php } ?>
                                        
                                        <?php if (isset($pUnits[2])){ ?>
                                            <?php if (( $quantity_stock<=0) and ($pUnits[2]['denom']>$pUnits[2]['nom']) ){ ?>
                                                data-ui_step = "<?=$pUnits[2]['denom']?>"
                                            <?php }?>
                                        <?php }?>
                                        
                                        <?php if($dataui_min){?>
                                            data-ui_minimum=<?=$dataui_min ?>
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
                                        <?=$price_wholesaleold?> ₽
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
                                        <?=$priceold?> ₽
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
                            <div class="qnt-container-spec qnt-container-modal"></div>
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
                                <div class="state_stock_span">
                                <?php if($quantity_stock>0){?>
                                    <span class="stock1">Алтуфьево</span>
                                <?php }else{ ?>
                                    <span class="notinstock">Под заказ</span>
                                <?php }?>
                                </div>
                            </div>
                        </div>
                        <div class="state_stock_del"></div>
                        <div class="state_stock_col">
                            <div class="state_stock_col_info _delivery">
                                <div class="state_stock_cap">Доставка:</div>
                                <div class="state_stock_val" id="delivery_text"><?php echo $delivery_text;?></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    
    <div class="info-block info-block2" itemprop="description">
        <?=$description?>
    </div>
    <div class="model_product_hide"><span class="_modal_close">Закрыть</span></div>
</div>