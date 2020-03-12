<div class="basket-row">
    <?php if(!$product['stock']){?>
        <div class="basket-row_info">
            <p>Под заказ</p>
            <p class="cart_del">Доставка 1-3 дня</p>
        </div>
    <?php }?>
    <ul>
        <li class="basket_image">
            <?php if ($product['thumb']) { ?>
                <a target="_blank" href="<?php echo $product['href']; ?>">
                    <img src="<?php echo $product['thumb']; ?>" 
                            alt="<?php echo $product['name']; ?>" 
                            title="<?php echo $product['name']; ?>" 
                            class="img-thumbnail" />
                </a>
            <?php } ?>
        </li>
        <li>
            <a target="_blank" class="prod-name" href="<?php echo $product['href']; ?>">
                <?php echo $product['name']; ?>
            </a>

            <p><?=$product['location']?></p>
            <div class="complement">
                <?php foreach ($product['properties'] as $prop): ?>
                    <span>
                        <?= $prop['name'] ?>:&nbsp;<span class="_bold"><?= $prop['val'] ?>&nbsp;<?= $prop['unit'] ?></span>
                    </span>
                <?php endforeach ?>            
            </div>
        </li>
        <li>

            <?php if ($product['isWholesale']): ?>
                <span class="cart_price_caption_opt" style="display:block;">Цена опт</span>
                <span class="cart_price_caption_rozn" style="display:none;">Цена</span>
                <div class="cart_price_val"><?= $product['price_wholesale']; ?></div>
                
            <?php else: ?>
                <span class="cart_price_caption_opt" style="display:none;">Цена опт</span>
                <span class="cart_price_caption_rozn" style="display:block;">Цена</span>
                <div class="cart_price_val"><?= $product['price']; ?></div>
                
            <?php endif; ?>
        </li>
        <li class="quantity-buy">
            <div 
                class="qnt-container-cart without_input"
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
            <div class="opt_limit_notification">добавьте еще <span class="opt_limit_notification_value"></span>, цена снизится</div>
        </li>
        <li>
            <span>Сумма</span>
            <div class="recalc"><?php echo $product['total']; ?></div>
        </li>
        <li>
            <div
                data-cartid="<?php echo $product['cart_id']; ?>"
                class="actionbutton del">
                <i class="fa fa-close fa-xs"></i>
            </div>
        </li>
    </ul>
    <div class="cart_similar_block">
        <div class="similar_block_caption">Вам может пригодиться:</div>
        <ul class="cart_similar_block_products">
            <?php foreach($product['product_related'] as $product_result){?>
                <li>
                    <div class="cart_similar_cap">
                        <?=$product_result['name']?>
                    </div>
                    <div class="cart_similar_info">
                        <div class="cart_similar_img">
                            <img src="<?=$product_result['image']?>" />
                        </div>
                        <div class="cart_similar_price"><?=$product_result['price']?></div>
                        <div class="cart_similar_button buy" data-product_id="<?=$product_result['product_id']?>">+<div>

                    </div>
                    <div class="cart_similar_info_add">
                        
                    </div>
                </li>
            <?php }?>
        </ul>
    </div>
</div>