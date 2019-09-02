<div class="basket-row">
    <?php if(!$product['stock']){?>
        <div class="basket-row_info">
            <p>Нет в наличии</p>
            <p class="cart_del">Доставка 1-3 дня</p>
        </div>
    <?php }?>
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
                        <?= $prop['name'] ?>:&nbsp;<strong><?= $prop['val'] ?>&nbsp;<?= $prop['unit'] ?></strong>
                    </span>
                <?php endforeach ?>            
            </div>
        </li>
        <li>

            <?php if ($product['isWholesale']): ?>
                <span class="cart_price_caption_opt" style="display:block;">Цена опт</span>
                <span class="cart_price_caption_rozn" style="display:none;">Цена</span>
                <strong class="cart_price_val"><?= $product['price_wholesale']; ?></strong>
            <?php else: ?>
                <span class="cart_price_caption_opt" style="display:none;">Цена опт</span>
                <span class="cart_price_caption_rozn" style="display:block;">Цена</span>
                <strong class="cart_price_val"><?= $product['price']; ?></strong>
            <?php endif; ?>
        </li>
        <li>
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
            <div class="opt_limit_notification">добавьте еще <span class="opt_limit_notification_value"></span>, цена снизится</div>
        </li>
        <li>
            <span>Сумма</span>
            <strong class="recalc"><?php echo $product['total']; ?></strong>
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
                    <div class="cart_similar_cap"><a target="_blank" title="<?=$product_result['href']?>" href="<?=$product_result['href']?>"><?=$product_result['name']?></a></div>
                    <div class="cart_similar_info">
                        <div class="cart_similar_img">
                            <a target="_blank" title="<?=$product_result['href']?>" href="<?=$product_result['href']?>">
                                <!--<img src="<?=$product_result['image']?>" />-->
                                <img src="https://ant-snab.ru/image/cache/catalog/images/products/mastics/cold/mastika-proof/mastikapruf-120x1203.jpg" />
                                

                            </a>
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