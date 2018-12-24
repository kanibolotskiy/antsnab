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
                <div class="catalog-tab" style="padding-top:60px">
                    <?php /* <div class="row">
                        @task OUR FILTERS HERE 
                    </div> */ ?>

                    <ul class="tabset">
                        <li><a id="prodgrid" href="#" class="active"></a></li>
                        <li><a id="prodlist" href="#"></a></li>
                    </ul>

                    <div class="tab-list">
                        <div class="tab-block tab-block2 tab-block3" >
                            <ul id="lazy-load_container">
                                <?php foreach ($products as $p): ?>
                                    <?php include __DIR__ . '/../partial/product_item.tpl' ?>
                                <?php endforeach; ?>
                            </ul>
                        </div>
                    </div>
                    
                    <?php echo $paginationLazy ?>
                    <?php echo $pagination; ?>
                </div>
            <?php } else { ?>
                <p><?php echo $text_empty; ?></p>
            <?php } ?>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>
