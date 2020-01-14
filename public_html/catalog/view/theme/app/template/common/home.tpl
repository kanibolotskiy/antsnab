<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php echo $content_top; ?>
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
                        <div class="production-block">
                            <a href="<?= $category['href'] ?>">
                                <span><?= $category['name'] ?></span>
                                <div class="img-production">
                                    <img src="<?= $category['image'] ?>" alt="<?= $category['name'] ?>" title="<?= $category['name'] ?>" />
                                </div>
                                <div class="main_category_link">
                                    <a href="<?= $category['href'] ?>" class="more">Смотреть все</a>
                                </div>
                            </a>
                        </div>
                    </li>
                <?php endforeach ?>
            </ul>
            <h2 class="title">Товары по брендам</h2>
            <ul>
                <?php foreach ($rootCategoriesBrands as $category): ?>
                    <li>
                        <div class="production-block">
                            <a href="<?= $category['href'] ?>">
                                <div class="img-production">
                                    <img src="<?= $category['image'] ?>" alt="<?= $category['name'] ?>" title="<?= $category['name'] ?>" />
                                </div>
                                <span><?= $category['name'] ?></span>
                            </a>
                        </div>
                    </li>
                <?php endforeach ?>
            </ul>

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
        <?php echo $content_bottom; ?>
        <?php if($seo_text){ ?>
            <div class="bottom_text content-text"><?php echo $seo_text;?></div>
        <?php }?>
    </div>
</div>
<?= $footer ?>
