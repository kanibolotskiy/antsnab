<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>

        <?php if (!empty($categories)): ?>
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
            <div class="catalog-tab">
                <!--@task1 move to css-->
                <style>
                    #mtab1 {
                        min-height: 30px;
                    }
                </style>
                
                <div id="mtab1" class="tab">
                    <ul class="tabset multi-tabset">
                        <li><a href="#m1tab1" class="active"></a></li>
                        <li><a href="#m1tab2"></a></li>
                    </ul>
                    <div class="tab-list">
                        <div id="m1tab1">
                            <div class="tab-block tab-block2">
                                <div class="title-catalog">
                                    &nbsp;<!--Рулонные материалы-->
                                </div>
                                <ul>
                                    <?php foreach ($categories as $c): ?>
                                        <li>
                                            <div class="catalog-block">
                                                <div class="catalog-img">
                                                    <a href="<?= $c['href'] ?>"><img src="<?= $c['thumb'] ?>" alt="img"></a>
                                                </div>
                                                <div class="catalog-description">
                                                    <a class="title-product" href="<?= $c['href'] ?>">
                                                         <?= $c['name'] ?>
                                                    </a> 
                                                    <div class="tags">
                                                        <?php foreach( $c['sub'] as $sub ): ?>
                                                            <a href="<?=$sub['href']?>">
                                                                <?=$sub['name']?>
                                                            </a>
                                                        <?php endforeach;?>
                                                    </div> 
                                                </div> 
                                                <a href="<?= $c['href'] ?>" class="more">Подробнее</a> 
                                            </div> 
                                        </li>
                                    <?php endforeach; ?>
                                </ul>
                                <!--<div class="title-catalog">
                                   Мастики, праймеры, битум 
                                </div>
                                <ul><li></li></ul> 
                                -->
                            </div>
                        </div> 
                        <div id="m1tab2">
                            <div class="tab-block">
                                <div class="title-catalog">
                                    &nbsp;<!--Рулонные материалы-->
                                 </div>
                                <ul>
                                    <?php foreach ($categories as $c): ?>
                                        <li>
                                            <div class="catalog-block">
                                                <div class="catalog-img">
                                                    <a href="<?= $c['href'] ?>"><img src="<?= $c['thumb'] ?>" alt="<?=$c['name']?>"></a>
                                                </div>
                                                <div class="catalog-description">
                                                    <a class="title-product" href="<?= $c['href'] ?>">
                                                        <?= $c['name'] ?>
                                                    </a>
                                                    <p>
                                                    <?= $c['description'] ?>
                                                    </p>
                                                    <div class="tags">
                                                        <?php foreach( $c['sub'] as $sub ): ?>
                                                            <a href="<?=$sub['href']?>">
                                                                <?=$sub['name']?>
                                                            </a>
                                                        <?php endforeach;?>
                                                    </div> 
                                                </div> 
                                                <a href="<?= $c['href'] ?>" class="more">Подробнее</a> 
                                            </div> 
                                        </li>
                                    <?php endforeach; ?>
                                </ul>
                                <!--<div class="title-catalog">
                                    Мастики, праймеры, битум 
                                 </div>
                                 <ul><li></li></ul> 
                                -->
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        <?php else: ?>
            <h1>Категорий не найдено</h1>
        <?php endif; ?>

        <?php echo $content_bottom; ?>
        
        

    </div>
</div>
<?= $footer ?>