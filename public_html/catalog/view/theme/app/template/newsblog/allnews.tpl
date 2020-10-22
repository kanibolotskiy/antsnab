<?= $header ?>
<div class="container main">
    <?= $column_left ?>
        <div class="content">
            <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
            <?php echo $content_top; ?>
            
            <?php if( !empty($articles) ):?>
                <div class="news-container" id="lazy-load_container">
                    <h1 class="title">Новости</h1>

                    <?php if( !empty($years) ): ?>
                    <div class="month">
                        <ul id="lazy-load_container">
                            <?php foreach($years as $y): ?>
                                <?php if( $y['active'] ): ?>
                                <li><a class="active" href="<?=$y['href']?>"><?=$y['text']?></a></li>
                                <?php else: ?>
                                <li><a href="<?=$y['href']?>"><?=$y['text']?></a></li>
                                <?php endif;?>
                            <?php endforeach;?>
                        </ul>
                    </div>
                    <?php endif;?>

                    <?php foreach ($articles as $article) : ?>
                        <?php include __DIR__ . "/partial/item_allnews.tpl" ?> 
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
                                <div itemprop="description"><p><%preview%></p></div>
                                <a href="<%href%>" class="more">Читать далее</a>
                            </div>
                        </div>
                    </script>
                </div>
                <?php echo $paginationLazy;?>
                <?php echo $pagination;?>
            <?php else: ?>
                <h1>Новостей не найдено</h1>
            <?php endif;?>
            <?php echo $content_bottom; ?>
        </div>
   
</div>
<?= $footer ?>
