<li itemscope itemtype="http://schema.org/Offer">
    <div class="catalog-block">
        <div class="catalog-img">
            <a href="<?= $p['href'] ?>"><img itemprop="image" src="<?= $p['thumb'] ?>" alt="<?= $p['name'] ?>" itemprop="image"></a>
        </div>
        <div class="catalog-description">
            <a class="title-product" href="<?= $p['href'] ?>" itemprop="name">
                <?= $p['name'] ?>
            </a>
            <div class="description" itemprop="description"><p><?= $p['descriptionPreview'] ?></p></div>
            <div class="complement">
               
                <?php foreach ($p['properties'] as $prop): ?>
                    <span>
                        <?= $prop['name'] ?>:&nbsp;<strong><?= $prop['val'] ?>&nbsp;<?= $prop['unit'] ?></strong>
                    </span>
                <?php endforeach ?>
                
            </div>
            <div class="price">
                <span>Цена от <strong itemprop="price" content="<?=$p['price_val']?>"><?=$p['price']?></strong></span>
                
            </div>
            <meta itemprop="priceCurrency" content="RUB">
            <div class="quantity-buy">
                <?php if(empty($p['unit_errors'])): ?>
                    <div class="qnt-container"
                        data-sale_to_ui_koef="<?=$p['sale_to_ui_koef']?>"
                        data-ui_name="<?=$p['ui_unit_name']?>"
                        data-ui_name_plural="<?=$p['ui_unit_name_plural']?>"
                        data-ui_name_genitive="<?=$p['ui_unit_name_genitive']?>"
                        
                        <?php if($p['ui_unit_force_step_by_one'] == 1):?>
                        data-ui_minimum="1"
                        data-ui_step= 1"
                        <?php endif; ?>
                    >
                    </div>
                    <a href="" class="buy add-to-card add-to-card-catalog"
                        data-product_id="<?=$p['product_id']?>" 
                        data-sale_to_price_koef="<?=$p['sale_to_price_koef']?>">
                        Купить
                    </a>
                <?php else: ?>
                    <?php foreach($p['unit_errors'] as $e): ?>
                        <?=$e . "<br/>"?>
                    <?php endforeach; ?>
                <?php endif;?>
            </div>
        </div>
    </div>
</li>