<?= $header ?>
<div class="container main">
    <?= $column_left ?>
        <div class="content">
            <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
            <?php echo $content_top; ?>
            <?php if( !empty($articles) ):?>
                <div class="news-container" id="lazy-load_container">
                    <div class="title">Новости</div>

                    <?php if( !empty($years) ): ?>
                    <div class="month">
                        <ul id="lazy-load_container">
                            <?php foreach($years as $y): ?>
                                <?php if( $current_year == $y['text'] ): ?>
                                <li><a class="active" href="<?=$y['href']?>"><?=$y['text']?></a></li>
                                <?php else: ?>
                                <li><a href="<?=$y['href']?>"><?=$y['text']?></a></li>
                                <?php endif;?>
                            <?php endforeach;?>
                        </ul>
                    </div>
                    <?php endif;?>

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
                                <p><?php echo $article['preview']; ?></p>
                                <a href="<?php echo $article['href']; ?>" class="more">Читать далее</a>
                            </div>
                        </div>
                    <?php endforeach; ?>
                    <!--NEWSBLOCK template for lazy-load pagination-->
                    <script id="news-block" type="text/template">
                        <div style="display:none"  class="news-block">
                                <div class="news-img">
                                    <a href="<%href%>">
                                        <img src="<%thumb%>" 
                                             alt="<%name%>" 
                                             title="<%name%>" />
                                    </a>
                                    <span><%date%></span>
                                </div>
                            <div class="news-description">
                                <a href="<%href%>" class="title-news">
                                    <%name%>
                                </a>
                                <p><%preview%></p>
                                <a href="<%href%>" class="more">Читать далее</a>
                            </div>
                        </div>
                    </script>
                </div>
                <?php echo $pagination; ?>
                <?php include __DIR__ . '/../partial/lazyload.tpl' ?>
            <?php else: ?>
                <h1>Новостей не найдено</h1>
            <?php endif;?>
            <?php echo $content_bottom; ?>
        </div>
   
</div>
<?= $footer ?>
