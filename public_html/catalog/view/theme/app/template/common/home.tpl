<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php echo $content_top; ?>
        
        <!--
        <div class="wrp_benefits_main">
            <div class="benefits_main_caption">С нами работают, потому что</div>
            <div class="benefits_main">
                <div class="benefits_main_row">
                    <div class="benefits_main_row_info">
                        <div class="benefits_main_row_img"><img src="http://antsnab.cp06038.tmweb.ru/image/cache/no_image-160x200.png"/></div>
                        <div class="benefits_main_row_cap">Преимущество</div>
                    </div>
                </div>
                <div class="benefits_main_row">
                    <div class="benefits_main_row_info">
                        <div class="benefits_main_row_img"><img src="http://antsnab.cp06038.tmweb.ru/image/cache/no_image-160x200.png"/></div>
                        <div class="benefits_main_row_cap">Преимущество</div>
                    </div>
                </div>
                <div class="benefits_main_row">
                    <div class="benefits_main_row_info">
                        <div class="benefits_main_row_img"><img src="http://antsnab.cp06038.tmweb.ru/image/cache/no_image-160x200.png"/></div>
                        <div class="benefits_main_row_cap">Преимущество</div>
                    </div>
                </div>
                <div class="benefits_main_row">
                    <div class="benefits_main_row_info">
                        <div class="benefits_main_row_img"><img src="http://antsnab.cp06038.tmweb.ru/image/cache/no_image-160x200.png"/></div>
                        <div class="benefits_main_row_cap">Преимущество</div>
                    </div>
                </div>
            </div>
        </div>
        -->
        <div class="our-production">
            <h1 >Наша продукция</h1>
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
            <h2 class="title">Статьи</h2>
            <ul class="main_articles">
                <?php  foreach ($articles as $article) : ?>
                    <?php include __DIR__ . "/../partial/item_allarticles.tpl" ?> 
                <?php endforeach; ?>
            </ul>
            <div class="wrp_main_articles">
                <a href="articles/" class="more">Смотреть все</a>
            </div>

        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>
