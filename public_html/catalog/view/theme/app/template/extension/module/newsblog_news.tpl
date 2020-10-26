<div class="news">
    <?php if ($heading_title) { ?>
        <a  href="<?php echo $link_to_category; ?>" class="title-news">
            <?= $heading_title ?>
        </a>
    <?php } ?>
    <ul>
        
        <?php foreach ($articles as $article) : ?>
            <li>
                <a href="<?php echo $article['href']; ?>">
                    <?php echo $article['name']; ?>
                </a>
                <?php if ($article['thumb']) : ?>
                    <a href="<?php echo $article['href']; ?>">
<picture>
    <source type="image/webp" srcset="<?=$article['thumb_webp'] ?>">
    <source type="image/jpeg" srcset="<?=$article['thumb'] ?>">
    <img src="<?=$article['thumb'] ?>" alt="<?= $article['name'] ?>" title="<?= $article['name'] ?>" />
</picture>                    
                        
                    </a>
                <?php endif; ?>
                <div class="news-text">
                    <?php echo $article['preview']; ?>
                </div>
            </li>
        <?php endforeach; ?>
    </ul>
</div>