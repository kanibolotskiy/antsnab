<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <div class="article-content content-text">
            <?php echo $content_top; ?>
        </div>
        <?php if($main_video){?>
            <div class="main_video">
                <iframe width="817" height="476" src="<?php echo $main_video;?>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
        <?php }?>
        <div class="our-production">
            <h2>Наша продукция</h2>
            <ul>
                <?php foreach ($rootCategories as $category): ?>
                    <li>
                        <div class="production-block production-block_brand">
                            <a href="<?= $category['href'] ?>">
                                <span><?= $category['name'] ?></span>
                                <div class="img-production">                       
<picture>
    <source type="image/webp" srcset="<?= $category['image_webp'] ?>">
    <source type="image/jpeg" srcset="<?= $category['image'] ?>">
    <img src="<?= $category['image'] ?>" alt="<?= $category['name'] ?>" title="<?= $category['name'] ?>" />
</picture>
                                </div>
                                <div class="main_category_link">
                                    <!--<a href="<?= $category['href'] ?>" class="more">Смотреть все</a>-->
                                    <div class="more">Смотреть все</div>
                                </div>
                            </a>
                        </div>
                    </li>
                <?php endforeach ?>
            </ul>
            <div class="main_products_hit">
                <h2 class="title">Популярные товары</h2>
                <div class="main_pop_slider main_slider">
                    <div class="mentioned-products">
                        <ul class="main_ment_slider">
                            <?php foreach( $products_hit as $p){?>
                                <li>
                                    <?php if($p["labels"]){  ?>
                                        <div class="item_labels">
                                            <?php foreach($p["labels"] as $key=>$label){ ?>
                                                <div class="item_label <?php echo $key;?>" title="<?php echo $label['title'];?>"><?php echo $label['label'];?></div>
                                            <?php } ?>
                                        </div>
                                    <?php }?>
                                    <div class="products-block">
                                        
                                        <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>

                                        <a href="<?=$p['href']?>" class="img-production">
<picture>
    <source type="image/webp" srcset="<?=$p['thumb_webp']?>">
    <source type="image/jpeg" srcset="<?=$p['thumb']?>">
    <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
</picture>
                                        </a>
                                        
                                        <div class="main_ment_price"><?=$p['price']?> <div class="rur">i</div></div>
                                        <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                                    </div>
                                </li>
                                <!---->
                            <?php }?>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="main_products_accia">
                <h2 class="title">Акции</h2>
                <div class="main_pop_slider main_slider">
                    <div class="mentioned-products-accia">
                        <ul class="main_accia_slider">
                            <?php foreach( $products_accia as $p){?>
                                <li>
                                    <a href="<?=$p['href']?>" class="title-product-accia">
                                        <div class="wrp_acc_product">
                                        
                                            <div class="product-accia-block">
                                                <div class="product-accia-block_name">
                                                    <?=$p['name']?>
                                                </div>
                                                <div class="product-accia-block_prices">
                                                    <div class="product-accia-block_price">
                                                        <?=$p['price']?> <div class="rur">i</div>
                                                    </div>
                                                    <div class="product-accia-block_priceold">
                                                        <?=$p['price_old']?> <div class="rur">i</div>
                                                    </div>
                                                </div>
                                                <div class="wrp_product-accia-block_img">
                                                    <div class="product-accia-block_sale">-<?=$p['percent']?>%</div>
                                                    <div class="product-accia-block_img">
<picture>
    <source type="image/webp" srcset="<?=$p['thumb_webp']?>">
    <source type="image/jpeg" srcset="<?=$p['thumb']?>">
    <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
</picture>                                                    
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        
                                        </div>
                                    </a>
                                </li>
                            <?php }?>
                        </ul>
                        
                    </div>
                </div>
            </div>
            

            <h2 class="title">Товары по брендам</h2>
            <ul>
                <?php foreach ($rootCategoriesBrands as $category): ?>
                    <li>
                        <div class="production-block production-block_brand">
                            <a href="<?= $category['href'] ?>">
                                <div class="img-production">
<picture>
    <source type="image/webp" srcset="<?= $category['image_webp'] ?>">
    <source type="image/jpeg" srcset="<?= $category['image'] ?>">
    <img src="<?= $category['image'] ?>" alt="<?= $category['name'] ?>" title="<?= $category['name'] ?>" />
</picture>
                                </div>
                                <span><?= $category['name'] ?></span>
                            </a>
                        </div>
                    </li>
                <?php endforeach ?>
            </ul>

            <div class="main_products_accia">
                <h2 class="title">Новинки</h2>
                
                <div class="main_new_products">
                    <?php foreach( $products_new as $p){?>
                        <div class="main_new_product_item">
                            <a href="<?=$p['href']?>">
                                <div class="wrp_acc_product">
                                    <div class="wrp_new_product_info">
                                        <div class="new_product_info_img">
<picture>
    <source type="image/webp" srcset="<?=$p['thumb_webp']?>">
    <source type="image/jpeg" srcset="<?=$p['thumb']?>">
    <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
</picture>                                            
                                        </div>
                                        <div class="new_product_info">
                                            <div class="new_product_info_caption"><?=$p['name']?></div>
                                            <div class="product-accia-block_price">
                                                <?=$p['price']?> <div class="rur">i</div>
                                            </div>
                                            <div class="new_product_label">New</div>
                                        </div>

                                    </div>
                                </div>
                            </a>
                        </div>
                    <?php }?>
                </div>
        
            </div>

            <div class="content-text">
                <p>В разделе <a href="news/">новости</a> всегда можно узнать об изменениях в ассортименте, актуальных ценах и значимых событиях в жизни компании. Раздел <a href="articles/">статьи</a> постоянно пополняется интересными и нужными публикациями. А если вопросы все же останутся, то их всегда можно задать нашим <a href="contacts/">менеджерам.</a></p>
            </div>

            <h2 class="title">Статьи</h2>
            <ul class="main_articles">
                <?php  foreach ($articles as $article) : ?>
                    <?php include __DIR__ . "/../newsblog/partial/item_allarticles.tpl" ?> 
                <?php endforeach; ?>
            </ul>
            <div class="wrp_main_articles">
                <a href="articles/" class="more">Смотреть все</a>
            </div>

        </div>
        <div class="article-content content-text">
            <?php echo $content_bottom; ?>
        </div>
        <?php if($seo_text){ ?>
            <div class="bottom_text content-text"><?php echo $seo_text;?></div>
        <?php }?>
    </div>
</div>
<?= $footer ?>
