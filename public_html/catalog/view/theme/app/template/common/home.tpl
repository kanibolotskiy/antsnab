<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php echo $content_top; ?>


        <div class="our-production">
            <div class="title">Наша продукция</div>
            <ul>
                <?php foreach ($allCategories->toArray() as $category): ?>
                    <li>
                        <div class="production-block">
                            <a href="<?= $category->getHref($url) ?>">
                                <div class="img-production">
                                    <img src="<?= $category->getImageUrl($imageTool, $width, $height) ?>" alt="img">
                                </div>
                                <span><?= $category->get('name') ?></span>
                            </a>
                        </div>
                    </li>
                <?php endforeach ?>
            </ul>
        </div>
        <!-- @task как управлять мобильными из админки? - только кэш или переверстывать двойная нагрузка на сервер -->
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>
