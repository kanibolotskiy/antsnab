<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content content_visible">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        
        <div class="article">
            <h1 class="title"><?php echo $heading_title; ?></h1>
            <?php if ($thumb) { ?>
                <div class="img-article">
                    
<picture>
    <source type="image/webp" srcset="<?=$thumb_webp?>">
    <source type="image/jpeg" srcset="<?=$thumb?>">
    <img src="<?=$thumb?>" title="<?=$heading_title ?>" alt="<?=$heading_title ?>" />
</picture>                     
                    <?php if ($show_cat_name): ?>
                        <span><?= $cat_name ?></span>
                        <div class="time _hidden"><?= $date ?></div>
                    <?php else: ?>
                        <div class="time"><?= $date ?></div>
                    <?php endif; ?>
                </div>
            <?php } ?>
            <div class="article-content content-text">
                <?php echo $description; ?>
            </div>
            
            <?php if($images) {?>
                <div class="gallery">
                    <?php foreach($images as $image_item) {?>
                    <div class="gallery_item">
                        <a href="<?php echo $image_item['original'];?>" data-fancybox="gallery"><img src="<?php echo $image_item['thumb'];?>" /></a>
                    </div>
                    <?php }?>
                </div>
            <?php }?>
        </div>
        <script src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>
        <script src="//yastatic.net/share2/share.js"></script>
        <div style="margin: 20px 0px; text-align:right">
            Ваш, Ант-Снаб
        </div>
        <div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki,moimir,gplus,pocket,viber,whatsapp,skype,telegram"></div>
        <div style="clear:both; margin-bottom:40px"></div>

        <?php if( !empty($products) ):?>
        <div class="title">Упоминаемые товары:</div>
        <div class="mentioned-products mentioned-products2">
            
                
            <ul>
                <?php foreach( $products as $p):?>
                <li>
                    <div class="products-block">
                        <a href="<?=$p['href']?>" class="img-production">
                            
<picture>
<source type="image/webp" srcset="<?=$p['thumb_webp']?>">
<source type="image/jpeg" srcset="<?=$p['thumb']?>">
<img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
</picture>                                
                        </a>
                        <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>
                        <div class="article_product_price"><?=$p['price']?></div>
                        <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                    </div>
                </li>
                <?php endforeach;?>
            </ul>
        
        </div>

        <?php endif;?>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>