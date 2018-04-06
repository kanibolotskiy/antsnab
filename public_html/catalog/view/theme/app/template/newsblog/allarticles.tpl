<!--@task to css move-->
<style>
    .staty-container .staty-list ul li .news-block .news-description a.title-news {
        height: 62px !important;
    }
</style>
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
        <div class="news-container staty-container">
            <div class="title">Статьи</div>
            <select id="seldef1" title="Общие статьи">
                <option>Общие статьи</option>
                <option>Общие статьи</option>
                <option>Общие статьи</option>
                <option>Общие статьи</option>
            </select>
            <div class="staty-list">
                <ul>
                    <?php foreach ($articles as $article) : ?>
                        <li>
                            <div class="news-block">
                                <?php if ($article['thumb']) { ?>
                                    <div class="news-img">
                                        <a href="<?php echo $article['href']; ?>">
                                            <img src="<?php echo $article['thumb']; ?>" 
                                                 alt="<?php echo $article['name']; ?>" 
                                                 title="<?php echo $article['name']; ?>" />
                                        </a>
                                        <span>Кровля и материалы</span>
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
                        </li>
                    <?php endforeach; ?>
                </ul>
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