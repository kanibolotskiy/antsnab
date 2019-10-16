<li class="catalog_item_product" rel="<?= $p['product_id']?>" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
    <?php if($p['discount_label']){?>
        <div class="label_discount _label" title="Сегодня этот товар продается со скидкой"><?php echo $p['discount_label'];?>%</div>
    <?php }?>
    <a href="<?= $p['href'] ?>" class="full_item_link" title="<?= $p['name'] ?>">
    <div class="catalog-block" itemprop="item" itemscope itemtype="http://schema.org/Product">
        <?php if($p["rating"]){?>
            <div class="agg_rating"><?php echo $p["rating"];?></div>
        <?php }?>

        <div class="catalog-img">
            <img itemprop="image" src="<?= $p['thumb'] ?>" alt="<?= $p['name'] ?>" title="<?= $p['name'] ?>" itemprop="image" />
        </div>
        <div class="wrp_favorite">
            <div class=""></div>
            
            <div rel="<?= $p['product_id']?>" title="Добавить товар в избранное" class="favorite <?= $p['favorite'] ?>"></div>
        
        </div>
        <div class="clr"></div>

        <div class="catalog-description">
            <div class="catalog-block_caption" itemprop="name"><?= $p['name'] ?></div>
            <div class="description" itemprop="description"><p><?= $p['descriptionPreview'] ?></p></div>
            <div class="complement">
            
                <?php foreach ($p['properties'] as $prop): ?>
                    <span>
                        <?= $prop['name'] ?>:&nbsp;<span class="prop_unit"><?= $prop['val'] ?>&nbsp;<?= $prop['unit'] ?></span>
                    </span>
                <?php endforeach ?>
                
            </div>
            <span class="price cat_item_price">
                <div class="cat_item_price_caption">Цена от </div>
                <div class="cat_price_val <?php if($p["priceold"]){echo "_oldprice";}?>" content="<?=$p['price_val']?>">
                    <div class="cat_price_value">
                        <?=$p['price']?>
                    </div> <div class="rur">i</div>
                </div>
                <?php if($p["priceold"]){?>
                    <div class="cat_priceold"><?php echo $p["priceold"];?> <div class="rur">i</div></div>
                <?php }?>                
            </span>

            <div class="quantity-buy">
    
                <?php if(empty($p['unit_errors'])): ?>
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
                    <div title="Добавить в корзину" class="buy add-to-card add-to-card-catalog"
                        data-product_id="<?=$p['product_id']?>" 
                        data-sale_to_price_koef="<?=$p['sale_to_price_koef']?>">
                        Добавить в корзину
                    </div>
                    <div class="wrap_oneclick" title="Для быстрого заказа введите свой телефон">
                        <form action="#" id="oneclickform" class="oneclickform">
                            <input type="hidden" name="product" value="<?= $p['name'] ?>"/>
                            <input type="text" class="workemail" name="workemail"/>
                            <input type="tel" class="onclickInput" placeholder="Ваш телефон" name="phone"/>
                            <button title="Купить в 1 клик" type="submit" class="onclickButton" id="onclickButton">Купить<span> в 1 клик</span></button>
                        </form>
                    </div>

                <?php else: ?>
                    <?php foreach($p['unit_errors'] as $e): ?>
                        <?=$e . "<br/>"?>
                    <?php endforeach; ?>
                <?php endif;?>
            </div>
            <div class="more_product">Подробнее</div>
        </div>
    </div>
    </a>
</li>