<div class="basket-row">
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
                <?php echo $product['meta_h1']; ?>
            </a>
            <p><?=$product['location']?></p>
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
                data-ui_name_plural="<?=$product['priceUnit']['name_plural']?>"
                data-ui_name_genitive="<?=$product['priceUnit']['name_package_dimension']?>"
                data-price_quantity="<?php echo $product['quantity']; ?>">
            </div>
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
</div>