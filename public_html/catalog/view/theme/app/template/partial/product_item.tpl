<li itemscope itemtype="http://schema.org/Offer">
    <div class="catalog-block">
        <div class="catalog-img">
            <a href="<?= $p['href'] ?>"><img src="<?= $p['thumb'] ?>" alt="<?= $p['name'] ?>" itemprop="image"></a>
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
                <span>Цена от <strong itemprop="price"><?=$p['price']?></strong></span>
            </div>
            <meta itemprop="priceCurrency" content="RUB">
            <div class="quantity-buy">
                <div class="qnt-container" data-ui_name="<?=$p['sale_unit_name']?>"></div>
                <a href="" class="buy"
                    data-product_id="<?=$p['product_id']?>" 
                    data-sale_to_price_koef="<?=$p['sale_to_price_koef']?>">
                    Купить
                </a>
            </div>
        </div>
    </div>
</li>