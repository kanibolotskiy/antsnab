<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <div class="bread-crumbs">
            <ul>
                <!--<li class="home"><a href=""><i class="material-icons">home</i></a></li>-->
                <?php foreach ($breadcrumbs as $b): ?>
                    <li>
                        <a href="<?= $b['href'] ?>">
                            <?= $b['text'] ?>
                        </a>
                    </li>
                <?php endforeach; ?>
                <!--<li class="interval">...</li>-->
            </ul>
        </div>
        <?php echo $content_top; ?>
        <div class="article">
            <div class="title"><?php echo $heading_title; ?></div>
            IN DEVELOPMENT, WILL BE SOON
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>