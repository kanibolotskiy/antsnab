<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php echo $content_top; ?>

        <div class="our-production">
            <h1 >Наша продукция</h1>
            <ul>
                <?php foreach ($rootCategories as $category): ?>
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
            <h1>Товары по брендам</h1>
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
        </div>
        <!-- @task1 как управлять мобильными из админки? - только кэш или переверстывать двойная нагрузка на сервер -->
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>
