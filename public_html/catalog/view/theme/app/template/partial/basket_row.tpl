<div class="basket-row">
    
    <div class="wrapper_basket-row">
        <div class="basket_image">
            <?php if ($product['thumb']) { ?>
                <a target="_blank" href="<?php echo $product['href']; ?>">
<picture>
    <source type="image/webp" srcset="<?=$product['thumb_webp']?>">
    <source type="image/jpeg" srcset="<?=$product['thumb']?>">
    <img src="<?=$product['thumb']?>" alt="<?=$product['name'] ?>" title="<?=$product['name'] ?>" class="img-thumbnail" />
</picture>
                    
                </a>
            <?php } ?>
        </div>
        <div class="basket_info">
            <a target="_blank" class="prod-name" href="<?php echo $product['href']; ?>">
                <?php echo $product['name']; ?>
            </a>

            <p><?=$product['location']?></p>
            <div class="complement">
                <?php foreach ($product['properties'] as $prop): ?>
                    <span>
                        <?= $prop['name'] ?>:&nbsp;<span class="complement_value"><?= $prop['val'] ?>&nbsp;<?= $prop['unit'] ?></span>
                    </span>
                <?php endforeach ?>            
            </div>
        </div>
        <div class="basket_info_empty"></div>
        <div class="basket_info_columns">
            <div class="basket_price">
                <?php if ($product['isWholesale']): ?>
                    <span class="cart_price_caption cart_price_caption_opt" style="display:block;">Цена опт</span>
                    <span class="cart_price_caption cart_price_caption_rozn" style="display:none;">Цена</span>
                    <div class="cart_price_val"><?= $product['price_wholesale']; ?></div>
                    
                <?php else: ?>
                    <span class="cart_price_caption cart_price_caption_opt" style="display:none;">Цена опт</span>
                    <span class="cart_price_caption cart_price_caption_rozn" style="display:block;">Цена</span>
                    <div class="cart_price_val"><?= $product['price']; ?></div>
                    
                <?php endif; ?>
            </div>
            <div class="quantity-buy">
                <div class="wrapper_product_hint">
                    <div 
                        class="qnt-container-cart without_input"
                        data-cnt="<?=$product['quantity_in_store']?>"
                        data-el_name="quantity[<?php echo $product['cart_id']; ?>]"
                        data-sale_to_price_koef="<?=$product['saleToPriceKoef']?>" 
                        data-ui_name="<?=$product['priceUnit']['name']?>"
                        data-ui_step = "<?=$product['step']?>"
                        data-ui_minimum = "<?=$product['mincount']?>"
                        data-ui_name_plural="<?=$product['priceUnit']['name_plural']?>"
                        data-ui_name_genitive="<?=$product['priceUnit']['name_package_dimension']?>"
                        data-wholesale_threshold="<?=$product['wholesale_threshold']?>"
                        data-price_quantity="<?php echo $product['quantity']; ?>">
                    </div>
                    <div class="min_count_hint" <?php if(($product['quantity']>1) and ($product['mincount']>1) and ($product['mincount']==$product['quantity'])){echo "style='display:block;'";}?>><span>минимально для заказа</span></div>
                </div>
                    <div class="basket-row_info _unavail" <?php echo (!$product['stock'])?'style="display:block;"':''?> >
                        <p>Под заказ. Доставка 1-3 дня</p>
                    </div>
                    <div class="basket-row_info _avail" <?php echo ($product['stock'])?'style="display:block;"':''?> >
                        <p>В наличии</p>
                    </div>
                    
                <div class="opt_limit_notification">добавьте еще <span class="opt_limit_notification_value"></span>, цена снизится</div>
            </div>
            <div class="basket_summa">
                <span>Сумма</span>
                <div class="recalc"><?php echo $product['total']; ?></div>
                <div class="basket_summa_empty"></div>
            </div>
        </div>
        <div class="basket_del actionbutton del" data-cartid="<?php echo $product['cart_id']; ?>"></div>
    
    </div>
    <div class="cart_similar_block <?php echo (isset($product['num']) and $product['num']==0)?'':'active';?>">
        <div class="similar_block_caption">
            <div class="wrp__block_caption">
                <span>Сопутствующие товары:</span>
            </div>
        </div>
        <div class="wrapper_similar_slider">
            <div class="wrp_cart_similar_block_products">
                <div class="cart_similar_block_products">
                    <?php foreach($product['product_related'] as $product_result){?>
                        <div class="similar_slide_row">
                            <div class="similar_slide_row_info">
                                <div class="cart_similar_img">
<picture>
    <source type="image/webp" srcset="<?=$product_result['image_webp']?>">
    <source type="image/jpeg" srcset="<?=$product_result['image']?>">
    <img src="<?=$product_result['image']?>" alt="<?=$product_result['name']?>" title="<?=$product_result['name']?>"/>
</picture>                                
                                    
                                </div>
                                <div class="similar_slide_info">
                                    <div class="similar_slide_cap"><?=$product_result['name']?></div>
                                    <div class="cart_similar_price"><?=$product_result['price']?></div>
                                </div>
                                <div class="cart_similar_button buy" data-product_id="<?php echo $product_result['product_id']; ?>"></div>
                            </div>
                        </div>
                    <?php }?>
                </div>
            </div>
        </div>
    </div>
</div>