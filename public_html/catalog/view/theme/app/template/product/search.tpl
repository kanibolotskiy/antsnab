<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        <div class="content">
            <h1><?php echo $heading_title; ?></h1>
            <h2><?php echo $text_search; ?></h2>
            <?php if ($products) { ?>
            <div class="catalog-tab catalog-tab2">
                <div class="row">
                    <?php /* @task OUR FILTERS HERE */ ?>
                </div>
                <?= $products ?>
                <?= $pagination ?>
            </div>
            <?php } else { ?>
                <p><?php echo $text_empty; ?></p>
            <?php } ?>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>
