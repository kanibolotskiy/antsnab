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
                <?= $products ?>
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
                <?php if(!empty($summary['rows'])): ?>
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
                <?php endif;?>
            </div>
            <div class="bottom_text">
                <?php echo $bottom_text; ?>
            </div>
        <?php else: ?>
            <h1>Товаров не найдено</h1>
        <?php endif; ?>

        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>
