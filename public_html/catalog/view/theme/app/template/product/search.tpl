<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        
        <h1><?php echo $heading_title; ?></h1>
        <h2><?php echo $text_search; ?></h2>
        <?php if ($products) { ?>
            <div class="catalog-tab">
                <?php /* <div class="row">
                    @task OUR FILTERS HERE 
                </div> */ ?>
                <div class="wrap_select_view">
                    <ul class="select_view_switch">
                        <li class="select_view select_view1 <?php echo $cat_view1;?>" rel="view1"></li>
                        <li class="select_view select_view2 <?php echo $cat_view2;?>" rel="view2"></li>
                    </ul>
                </div>
                
                <div class="tab-list">
                    <div class="tab-block tab-block3 <?php echo $cat_view_class;?>" >
                        <ul id="lazy-load_container">
                            <?php foreach ($products as $p): ?>
                                <?php include __DIR__ . '/../partial/product_item.tpl' ?>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                </div>
                
                <?php echo $pagination; ?>

            </div>
        <?php } else { ?>
            <p><?php echo $text_empty; ?></p>
        <?php } ?>
    
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>
