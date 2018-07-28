<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        <div class="article">
            <h1><?php echo $heading_title; ?></h1>
            <?php echo $description; ?>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>