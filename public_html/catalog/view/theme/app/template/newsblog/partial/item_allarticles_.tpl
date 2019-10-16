<?php print_r($article);?>
<li itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem">
    <div class="news-block" itemprop="item" itemscope="" itemtype="http://schema.org/NewsArticle">
        <meta itemprop="author" content='ООО "ТК Ант-Снаб"'/>
        <div style="display:none;" itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
            <div itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
                <img itemprop="url image" src="https://ant-snab.ru/image/catalog/logo.jpg"/>
                <meta itemprop="width" content="102">
                <meta itemprop="height" content="94">
            </div>
            <meta itemprop="name" content='ООО "ТК Ант-Снаб"'>
            <meta itemprop="telephone" content="+7 (495) 255-01-37">
            <meta itemprop="address" content="127566, г. Москва, Высоковольтный проезд, дом 1, стр. 43">
        </div>
        <meta itemprop="datePublished" content="<?php echo date("Y-m-d",strtotime($article['date']));?>"/> 
        <meta itemprop="dateModified" content="<?php echo date("Y-m-d",strtotime($article['date']));?>"/>

        <?php if ($article['thumb']) { ?>
            <div class="news-img">
                <a itemprop="mainEntityOfPage" href="<?php echo $article['href']; ?>">
                    <img itemprop="image" src="<?php echo $article['thumb']; ?>"
                            alt="<?php echo $article['name']; ?>"
                            title="<?php echo $article['name']; ?>" />
                </a>
                <span><?=$article['cat_name']?></span>
            </div>
        <?php } ?>
        <div class="news-description">
            <a href="<?php echo $article['href']; ?>" class="title-news" itemprop="headline">
                <?php echo $article['name']; ?>
            </a>
            <p><?php echo strip_tags($article['preview']); ?></p>
            <a href="<?php echo $article['href']; ?>" class="more">Читать далее</a>
        </div>
    </div>
</li>