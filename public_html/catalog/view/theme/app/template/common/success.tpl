<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php echo $content_top; ?>
        <div class="about-us">
            <h1><?php echo $heading_title; ?></h1>
            <div class="text fix-p">
                <div class="done_order_number">Номер вашего заказа: <?php echo $order_id;?></div>
                <div class="success_content">    
                    <?php echo $content; ?>
                </div>
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>