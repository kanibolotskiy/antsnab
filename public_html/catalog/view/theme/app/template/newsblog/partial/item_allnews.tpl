<div class="news-block">
    <?php if ($article['thumb']) { ?>
        <div class="news-img">
            <a href="<?php echo $article['href']; ?>">
                <img src="<?php echo $article['thumb']; ?>" 
                        alt="<?php echo $article['name']; ?>" 
                        title="<?php echo $article['name']; ?>" />
            </a>
            <time><?php echo $article['date']?></time>
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