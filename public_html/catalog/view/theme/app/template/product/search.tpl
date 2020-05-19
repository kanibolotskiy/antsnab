<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        
        <h1><?php echo $heading_title; ?></h1>
        
        <?php if ($products) { ?>
            <h2><?php echo $text_search; ?></h2>

            <div class="catalog-tab">
                <div class="wrap_select_view">
                    <ul class="select_view_switch">
                        <li class="select_view select_view1 <?php echo $cat_view1;?>" rel="view1"></li>
                        <li class="select_view select_view2 <?php echo $cat_view2;?>" rel="view2"></li>
                    </ul>
                </div>
                
                <div class="tab-list">
                    <div class="tab-block tab-block3 <?php echo $cat_view_class;?>" >
                        <ul id="lazy-load_container">
                            <?php foreach ($products as $p): ?>
                                <?php include __DIR__ . '/../partial/product_item.tpl' ?>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                </div>
                
                <?php echo $pagination; ?>

            </div>
        <?php } else { ?>
            <h2>К сожалению по вашему запросу ничего не найдено</h2>
            <div class="content-text emptysearch-text">
                <p>Мы сожалеем, но нам не удалось найти в <a href="products/">каталоге</a> товары, соответствующие вашему запросу.</p>
                <p>Пожалуйста проверьте правильность запроса и попробуйте еще раз.</p>
            </div>

            <?php if($products_popular){ ?>
            <h2>Популярные товары</h2>
                <div class="mentioned-products mentioned-products2">
                    <ul>
                        <?php foreach ($products_popular as $p): ?>
                            <li>
                                <?php if($p['discount']){?>
                                    <div class="label_discount _label"><?php echo $p['discount'];?>%</div>
                                <?php }?>
                                <div class="products-block">
                                    <?php if($p["rating"]){?>
                                        <div class="agg_rating"><?php echo $p["rating"];?></div>
                                    <?php }?>
                                    
                                    <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>

                                    <a href="<?=$p['href']?>" class="img-production">
                                        <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
                                    </a>
                                    
                                    <strong><?=$p['price']?> <div class="rur">i</div></strong>
                                    <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                                </div>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            <?php }?>
        <?php } ?>
    
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>
