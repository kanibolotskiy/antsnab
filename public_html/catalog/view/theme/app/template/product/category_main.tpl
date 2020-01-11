<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>

        <?php if (!empty($categories)): ?>
            <div class="catalog-info">
                <h1 class="title"><?= $heading_title ?></h1>
                <?= $description ?>
            </div>
            <?php if(isset($categories_isseo)) {?>
                <?php if(count($categories_isseo)) {?>
                    <div class="pick-up">
                        <ul>    
                            <li><span>Подборки:</span></li>
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
                    <div class="wrap_select_view">
                        <ul class="select_view_switch">
                            <li class="select_view select_view1 <?php echo $cat_view1;?>" rel="view1"></li>
                            <li class="select_view select_view2 <?php echo $cat_view2;?>" rel="view2"></li>
                        </ul>
                    </div>
                    
                    <div class="tab-list">
                        <div id="m1tab1">
                            <div class="tab-block <?php echo $cat_view_class;?>">
                               
                                <ul>
                                    <?php foreach ($categories as $c): ?>
                                        <li>
                                            <div class="catalog-block">
                                                <div class="catalog-img">
                                                    <a href="<?= $c['href'] ?>"><img src="<?= $c['thumb'] ?>" title="<?= $c['name']?>" alt="<?= $c['name']?>"></a>
                                                </div>
                                                <div class="catalog-description">
                                                    <a class="title-product" href="<?= $c['href'] ?>">
                                                         <?= $c['name'] ?>
                                                    </a> 
                                                    <div class="cat-desc">
                                                        <p>
                                                        <?= $c['description'] ?>
                                                        </p>
                                                    </div>
                                                    <div class="tags">
                                                        <?php foreach( $c['sub'] as $sub ): ?>
                                                            <a href="<?=$sub['href']?>">
                                                                <?=$sub['name']?>
                                                            </a>
                                                        <?php endforeach;?>
                                                    </div> 
                                                    
                                                </div> 
                                                <a href="<?= $c['href'] ?>" class="more">Смотреть все</a> 
                                            </div> 
                                        </li>
                                    <?php endforeach; ?>
                                </ul>
                                
                            </div>
                        </div> 
                       
                    </div>
                </div>
            </div>
            <div class="bottom_text content-text">
                <?php echo $bottom_text; ?>
            </div>
        <?php else: ?>
            <h1>Категорий не найдено</h1>
        <?php endif; ?>

        <?php echo $content_bottom; ?>
        
        

    </div>
</div>
<?= $footer ?>