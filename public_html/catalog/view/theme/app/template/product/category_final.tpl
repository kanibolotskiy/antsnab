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

            <?php if(isset($categories_isseo)) {?>
                <?php if(count($categories_isseo)) {?>
                    <div class="pick-up">
                        <span>Подобрать:</span>
                        <ul>    
                            <?php foreach($categories_isseo as $item) {?>
                                <li><a href="<?php echo $item['href'];?>"><?php echo $item['name']?></a></li>
                            <?php }?>
                        </ul>
                    </div>
                <?php }?>
            <?php }?>

            <div class="catalog-tab" style="padding-top:60px">

                <form method="GET" style="position:absolute;top:0">
                    <select  name="sort" id="seldef1" title="Cортировка" onchange="this.form.submit()">
                        <option <?php if($sort_selected==0) echo 'selected';?>value="">сортировать...</option>
                        <option <?php if($sort_selected==1) echo 'selected';?> value="price|ASC">от дешевых к дорогим</option>
                        <option <?php if($sort_selected==2) echo 'selected';?> value="price|DESC">от дорогих к дешевым</option>
                    </select>
                </form>

                <ul class="tabset">
                    <li><a id="prodgrid" href="#" class="active"></a></li>
                    <li><a id="prodlist" href="#"></a></li>
                </ul>

                <div class="tab-list">
                    <div class="tab-block tab-block2 tab-block3" >
                        <ul id="lazy-load_container">
                            <?php foreach ($products as $p): ?>
                                <?php include __DIR__ . '/../partial/product_item.tpl' ?>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                </div>
                
                <?php echo $paginationLazy ?>
                <?php echo $pagination; ?>

                
                <?php if(!empty($summary['rows'])): ?>
                <div class="title">Технические характеристики</div>
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
