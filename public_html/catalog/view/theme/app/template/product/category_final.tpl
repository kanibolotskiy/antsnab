<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>

        <?php if (!empty($products)): ?>
            <div class="catalog-info">
                <div class="title"><?= $heading_title ?></div>
                <?= $description ?>
            </div>
            <div class="pick-up">
                <span>Подобрать:</span>
                <ul>
                    <li><a href="">для дерева</a></li>
                    <li><a class="active" href="">для плитки</a></li>
                    <li><a href="">для внутренних работ</a></li>
                    <li><a href="">для пола</a></li>
                    <li><a href="">для потолка</a></li>
                </ul>
            </div>
            <div class="catalog-tab catalog-tab2">
                <select id="seldef1" title="от дешевых к дорогим">
                    <option>от дешевых к дорогим</option>
                    <option>от дешевых к дорогим</option>
                    <option>от дешевых к дорогим</option>
                    <option>от дешевых к дорогим</option>
                </select>
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
                <?php echo $pagination; ?>
                <?php //include __DIR__ . '/../partial/lazyload.tpl' ?>
                <!--@task1 move to css-->
                <style>
                    .summary tr th {
                        color: #000;
                        font-size: 14px;
                        font-weight: 700;
                        vertical-align: middle !important;
                        text-align: center;
                    }
                    .summary tr td {
                        text-align: center
                    }
                    .summary tr td.left {
                        text-align: left;
                    }
                    .summary tr th.grey {
                        background-color: #f9f9f9;
                    }
                </style>
                <div class="wrapper_adaptive_table">
                    <table class="summary table table-bordered table-striped table-responsive">
                        <thead>
                            <tr>
                                <th rowspan="2">Показатель</th>
                                <th colspan="<?= count($summary['header']) ?>">Значение</th>
                                <th rowspan="2">Единица измерения</th>
                            </tr>
                            <tr>
                                <?php foreach ($summary['header'] as $h): ?>
                                    <th class="grey"><?= $h['name'] ?></th>
                                <?php endforeach; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <tr></tr>
                            <?php foreach ($summary['rows'] as $row): ?>
                                <tr>
                                    <td class="left"><?= $row['name'] ?></td>
                                    <?php foreach ($summary['header'] as $prodKey => $h): ?>
                                        <?php if (isset($row['products'][$prodKey])): ?>
                                            <td><?= $row['products'][$prodKey]['val'] ?></td>
                                        <?php else: ?>
                                            <td>--</td>
                                        <?php endif; ?>
                                    <?php endforeach; ?>
                                    <td><?= $row['unit'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        <?php else: ?>
            <h1>Товаров не найдено</h1>
        <?php endif; ?>

        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>
