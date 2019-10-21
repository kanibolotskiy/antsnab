<div class="basket-row fav_row" data-product_id="<?=$product['product_id']?>" price="<?=$product['price_val']?>" price_opt="<?=$product['price_wholesale_val']?>">
    <ul>
        <li>
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
        <li>
            <div 
                class="qnt-container-cart without_input"
                data-el_name="quantity"
                data-sale_to_price_koef="<?=$product['saleToPriceKoef']?>" 
                data-ui_name="<?=$product['priceUnit']['name']?>"
                data-ui_step = "<?=$product['step']?>"
                data-ui_minimum = "<?=$product['mincount']?>"
                data-ui_name_plural="<?=$product['priceUnit']['name_plural']?>"
                data-ui_name_genitive="<?=$product['priceUnit']['name_package_dimension']?>"
                data-wholesale_threshold="<?=$product['wholesale_threshold']?>"
                data-price_quantity="<?php echo $product['quantity']; ?>">
            </div>
            <div class="opt_limit_notification">добавьте еще <span class="opt_limit_notification_value"></span>, цена снизится</div>
        </li>
        <li>
            <span>Сумма</span>
            <div class="recalc"><span class="recal_tll"><?php echo $product['total']; ?></span> <div class="rur">i</div></div>
        </li>
        <li>
            <div class="cart_favorite_button">+<div>

                </div>
                <div class="cart_similar_info_add">
                    
                </div>
            </div>
            
            <div class="favdel del">
                <i class="fa fa-close fa-xs"></i>
            </div>
            
        </li>
    </ul>
    
</div>