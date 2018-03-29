<?=$header?>
<div class="container main">
    <?=$column_left?>
    <div class="content">
        <?php echo $content_top; ?>
       
       
        <div class="our-production">
            <div class="title">Наша продукция</div>
            <ul>
            <?php foreach($allCategories->toArray() as $category):?>
                <li>
                    <div class="production-block">
                        <a href="<?=$category->getHref($url)?>">
                            <div class="img-production">
                                <img src="<?=$category->get('realImage')?>" alt="img">
                            </div>
                            <span><?=$category->get('name')?></span>
                        </a>
                    </div>
                </li>
            <?php endforeach ?>
            </ul>
        </div>

         <?php echo $content_bottom; ?>
        <div class="news">
            <div class="title-news">Свежие новости</div>
            <ul>
                <li>
                    <a href="">Снизились цены на гидроизол
                        и OSB</a>
                    <img src="img/img1.jpg" alt="img">
                    <div class="news-text">
                        <span>14.03.2016</span>
                        <p>С 1 февраля на
                            рулонные кровельные
                            материалы
                            действовали скидки.</p>
                    </div>
                </li>
                <li>
                    <a href="">Снизились цены на фанеру</a>
                    <img src="img/img2.jpg" alt="img">
                    <div class="news-text">
                        <span>26.02.2016</span>
                        <p>Новость сегодня
                            неоднозначная.
                            Наверняка, по
                            картинке все уже...</p>
                    </div>
                </li>
                <li>
                    <a href="">Снижение цен на рулонные
                        кровельные материалы</a>
                    <img src="img/img3.jpg" alt="img">
                    <div class="news-text">
                        <span>14.03.2016</span>
                        <p>С 1 февраля на
                            рулонные кровельные
                            материалы
                            действовали скидки.</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<?=$footer?>
