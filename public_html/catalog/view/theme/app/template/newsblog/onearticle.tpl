<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        <div class="article">
            <div class="title"><?php echo $heading_title; ?></div>
            <?php if ($thumb) { ?>
                <div class="img-article">
                    <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                    <?php if ($show_cat_name): ?>
                        <span><?= $cat_name ?></span>
                    <?php else: ?>
                        <span><?= $date ?></span>
                    <?php endif; ?>
                </div>
            <?php } ?>
            <?php echo $description; ?>
        </div>
        <script src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>
        <script src="//yastatic.net/share2/share.js"></script>
        <div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki,moimir,gplus,pocket,viber,whatsapp,skype,telegram"></div>
        <div style="clear:both; margin-bottom:40px"></div>
        <?php if( !empty($products) ):?>
        <div class="mentioned-products">
            <div class="title">Упоминаемые товары:</div>
            <ul>
                <?php foreach($products as $p): ?>
                <li>
                    <div class="products-block">
                        <div class="img-production">
                            <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>">
                        </div>
                        <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>
                        <div class="moregroup">
                            <strong><?=$p['price']?></strong>
                            <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                        </div>
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