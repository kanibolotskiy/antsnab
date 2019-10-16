<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <h1 class="title">Избранное</h1>
        <div class="basket-block">
            <div class="favorite-container">
                <?php foreach ($products as $product) { ?> 
                    <?php include __DIR__ . '/../partial/favorite_row.tpl' ?>
                <?php } ?>
                <div class="content-text empty_favorite_text" style="<?php echo (count($products)?'display:none':'display:block')?>">
                    <p>В избранном пока ничего нет.</p>
                    <p>Мы уверены, что в <a href="products/">каталоге продукции</a> Вы найдете для себя что-то интересное.</p>
                </div>
            </div>
        </div>
        <div id="wrp_add_all_favorites" style="<?php echo (count($products)?'display:block':'display:none')?>">
            <div class="add_all_favorites" id="add_all_favorites">
                Добавить все товары в корзину
            </div>
        </div>
        <div class="favorite_content content-text">
            <?php echo $favorite_content;?>
        </div>
    </div>
</div>

<?= $footer ?>