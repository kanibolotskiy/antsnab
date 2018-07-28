<div class="news news3">
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

                <div class="news-text">
                    <?php echo $article['preview']; ?>
                </div>
            </li>
        <?php endforeach; ?>
    </ul>
</div>