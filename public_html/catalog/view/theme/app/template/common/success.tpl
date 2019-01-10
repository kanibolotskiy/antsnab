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
                <!--
                <p align="center">&nbsp;</p>
                <p align="center"><span style="FONT-SIZE: 16px"><br>
                        В&nbsp;ближайшее время, чтобы уточнить&nbsp;все детали,&nbsp;с Вами
                        свяжется&nbsp;дежурный битуммэн или его помощники.<br>
                        <br>
                        <strong><font color="#FF8000">Это займет не&nbsp;более 10
                            минут.</font></strong></span></p>
                -->
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>