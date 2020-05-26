<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        
        <?php echo $content_top; ?>
        <div class="content_inner">
            <h1 class="title"><?php echo $heading_title; ?></h1>
            
            <?php if($image){?>
                <div class="sale_banner_img">
                    <?php if(isset($accia_type)) { ?>
                        <?php if($accia_type==0) {?>
                            <time class="accia_time accia_time_enabled">Действует до <?=$date_end?></time>
                        <?php }?>
                        <?php if($accia_type==1) {?>
                            <time class="accia_time accia_time_disabled">Акция закончена</time>
                        <?php }?>
                    <?php }?>
                    <img src="<?php echo $image;?>" alt="<?php echo $heading_title;?>"/>
                </div>
            <?php }?>
            <div class="sale_content content-text">
                <?php echo $description; ?>
            </div>
            <?php if(count($products)){?>
                <h2>Товары, участвующие в акции:</h2>
                <div class="accia_products tab-block tab-block2 tab-block3"> 
                    <ul>
                        <?php foreach($products as $product){?>
                            <?php echo $product;?>
                        <?php }?>
                    </ul>
                </div>

            <?php }?>
            
            

        </div>
        
        
        <?php echo $content_bottom; ?>
        
    </div>
</div>
<?= $footer ?>