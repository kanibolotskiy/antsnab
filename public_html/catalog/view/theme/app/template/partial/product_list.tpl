<div id="mtab1" class="tab">
    <ul class="tabset multi-tabset">
        <li><a href="#m1tab1"></a></li>
        <li><a href="#m1tab2" class="active"></a></li>
    </ul>
    <div class="tab-list">
        <div id="m1tab1">
            <div class="tab-block tab-block2 tab-block3">
                <ul>
                    <?php foreach ($products as $p): ?>
                        <li>
                            <div class="catalog-block">
                                <div class="catalog-img">
                                    <img src="<?= $p['thumb'] ?>" alt="<?= $p['name'] ?>">
                                </div>
                                <div class="catalog-description">
                                    <a class="title-product" href="<?= $p['href'] ?>">
                                        <?= $p['name'] ?>
                                    </a>
                                    <div class="complement">
                                        <?php foreach ($p['properties'] as $prop): ?>
                                            <span>
                                                <?= $prop['name'] ?>:&nbsp;<strong><?= $prop['val'] ?>&nbsp;<?= $prop['unit'] ?></strong>
                                            </span>
                                        <?php endforeach ?>
                                    </div>
                                    <div class="price">
                                        <span>Цена от <strong></strong></span>
                                    </div>
                                    <div class="quantity-buy">
                                        <div class="OutputContainer">
                                            <input type="text" class="spinner" name="name" value=" ">
                                        </div>
                                        <span>коробка</span>
                                        <a href="" class="buy">Купить</a>
                                    </div>
                                </div>
                            </div>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        </div>
        <div id="m1tab2">
            <div class="tab-block">
                <ul>
                    <?php foreach ($products as $p): ?>
                        <li itemscope itemtype="http://schema.org/Offer">
                            <div class="catalog-block">
                                <div class="catalog-img">
                                    <img src="<?= $p['thumb'] ?>" alt="<?= $p['name'] ?>" itemprop="image">
                                </div>
                                <div class="catalog-description">
                                    <a class="title-product" href="<?= $p['href'] ?>" itemprop="name">
                                        <?= $p['name'] ?>
                                    </a>
                                    <div itemprop="description"><p><?= $p['descriptionPreview'] ?></p></div>
                                    <div class="complement">
                                        <?php foreach ($p['properties'] as $prop): ?>
                                            <span>
                                                <?= $prop['name'] ?>:&nbsp;<strong><?= $prop['val'] ?>&nbsp;<?= $prop['unit'] ?></strong>
                                            </span>
                                        <?php endforeach ?>
                                    </div>
                                    <div class="price">
                                        <span>Цена от <strong itemprop="price"></strong></span>
                                    </div>
                                    <meta itemprop="priceCurrency" content="RUB">
                                    <div class="quantity-buy">
                                        <div class="OutputContainer">
                                            <input type="text" class="spinner" class="spinner" name="name" value=" ">
                                        </div>
                                        <span>коробка</span>
                                        <a href="" class="buy">Купить</a>
                                    </div>
                                </div>
                            </div>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        </div>
    </div>
</div>
