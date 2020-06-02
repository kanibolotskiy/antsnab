<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        
        <?php echo $content_top; ?>
        <div class="article content_inner">
            <h1 class="title"><?php echo $heading_title; ?></h1>
            <?php echo $description; ?>
        </div>
        <?php if(isset($files)) {?>
            <div class="tovar_files">
                <?php foreach($files as $file){?>
                    <a class="download" target="_blank" href="<?php echo $file['file_link'];?>"><?php echo $file['name'];?></a>
                <?php }?>
            </div>
        <?php }?>
        <?php if(isset($feedbackform)){ 
            if($feedbackform){
                include __DIR__ . '/../partial/feedbackform.tpl';
            }
        }?>

        <?php echo $content_bottom; ?>
        
    </div>
</div>
<?php if(isset($locations[0])):?>
    <?php $l = $locations[0]?>
    <div class="modal modal_map">
        <div class="modal-block">
            <div class="modal_overlay"></div>
            <div class="modal-content">
                <div class="modal_close"></div>
                <!--<span><?=$l['name']?></span>-->
                <div class="modal_caption"><?=$l['name']?></div>
                <div class="modal_text_map">
                    <p><?=$l['address']?></p>
                    <p><?=$l['open']?></p>
                    <p><?=$l['comment']?></p>
                    <p>Для вашего удобства можете <a target="_blank" href="<?php echo $l['files'][0]['file_link'];?>">скачать подробную схему проезда</a></p>
                </div>
                <div class="map_">
                    <?=$l['map']?>
                </div>
            </div>
        </div>
    </div>
<?php endif;?>

<?= $footer ?>