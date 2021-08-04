<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        
        <?php echo $content_top; ?>
        <div class>
            <h1 class="title"><?php echo $heading_title; ?></h1>
            <div class="article-content content-text"><?php echo $description; ?></div>
        </div>
        <div class="wrap_diler_link">
            <div class="diler_link">
                <a rel="nofollow" target="_blank" href="<?php echo $link; ?>"><?php echo $link_caption; ?></a>
            </div>
        </div>
        <?php if(isset($feedbackform)){ 
            if($feedbackform){
                include __DIR__ . '/../partial/feedbackform.tpl';
            }
        }?>

        <?php echo $content_bottom; ?>
        
    </div>
</div>


<?= $footer ?>