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
        <div class="news-container">
            <div class="title">Новости</div>
            <div class="month">
                <ul>
                    <li><a href="">Апрель</a></li>
                    <li><a href="">Март</a></li>
                    <li><a href="">Февраль</a></li>
                    <li><a href="">Январь</a></li>
                </ul>
            </div>
            <?php foreach ($articles as $article) : ?>
                <div class="news-block">
                    <?php if ($article['thumb']) { ?>
                        <div class="news-img">
                            <a href="<?php echo $article['href']; ?>">
                                <img src="<?php echo $article['thumb']; ?>" 
                                     alt="<?php echo $article['name']; ?>" 
                                     title="<?php echo $article['name']; ?>" />
                            </a>
                            <span><?php echo $article['date']?></span>
                        </div>
                    <?php } ?>
                    <div class="news-description">
                        <a href="<?php echo $article['href']; ?>" class="title-news">
                            <?php echo $article['name']; ?>
                        </a>
                        <p><?php echo strip_tags($article['preview']); ?></p>
                        <a href="<?php echo $article['href']; ?>" class="more">Подробнее</a>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
        <a href="" class="show-more">Показать еще</a>
        <div class="page-navigation page-navigation2">
            <?php echo $pagination; ?>
        </div>
    </div>
    <?php echo $content_bottom; ?>
</div>
</div>
<?= $footer ?>
