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
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        <?php if( !empty($articles) ):?>
            <div class="news-container staty-container">
                <div class="title">Статьи</div>
                <?php if( !empty($subCats) ):?>
                <select id="seldef1" >
                    <?php foreach($subCats as $sc): ?>
                        <?php if($sc['active']):?>
                            <option selected="selected" value="<?=$sc['href']?>">
                                <a href="<?=$sc['href']?>"><?=$sc['name']?></a>
                            </option>
                        <?php else:?>
                            <option value="<?=$sc['href']?>">
                                <a href="<?=$sc['href']?>"><?=$sc['name']?></a>
                            </option>
                        <?endif;?>
                    <?php endforeach;?>
                </select>
                <script>
                    document.addEventListener('DOMContentLoaded', function(){
                        $('#seldef1').on('change', function(){
                            window.location.href = $(this).val();
                        });
                    });
                </script>
                <?php endif; ?>
                <div class="staty-list">
                    <ul id="lazy-load_container">
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
                                            <span><?=$article['cat_name']?></span>
                                        </div>
                                    <?php } ?>
                                    <div class="news-description">
                                        <a href="<?php echo $article['href']; ?>" class="title-news">
                                            <?php echo $article['name']; ?>
                                        </a>
                                        <p><?php echo strip_tags($article['preview']); ?></p>
                                        <a href="<?php echo $article['href']; ?>" class="more">Читать далее</a>
                                    </div>
                                </div>
                            </li>
                        <?php endforeach; ?>
                        <!--NEWSBLOCK template for lazy-load pagination-->
                        <script id="news-block" type="text/template">
                            <li style="display:none">
                                <div class="news-block">
                                        <div class="news-img">
                                            <a href="<%href%>">
                                                <img src="<%thumb%>" 
                                                     alt="<%name%>" 
                                                     title="<%name%>" />
                                            </a>
                                            <span><%cat_name%></span>
                                        </div>
                                    <div class="news-description">
                                        <a href="<%href%>" class="title-news">
                                            <%name%>
                                        </a>
                                        <p><%preview%></p>
                                        <a href="<%href%>" class="more">Читать далее</a>
                                    </div>
                                </div>
                            </li>
                        </script>
                    </ul>
                </div>
                
            </div>
            <?php echo $pagination; ?>
            <?php include __DIR__ . '/../partial/lazyload.tpl' ?>
        <?php else: ?>
            <h1>Статей не найдено</h1>
        <?php endif;?>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>