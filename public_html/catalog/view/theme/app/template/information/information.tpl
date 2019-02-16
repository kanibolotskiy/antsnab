<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        
        <?php echo $content_top; ?>
        <div class="article content_inner content-text">
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
        <?php echo $content_bottom; ?>
        
    </div>
</div>
<?= $footer ?>