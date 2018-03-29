<div class="catalog-product">
    <a class="catalog-btn">Каталог продукции</a>
    <ul class="accordion simple-accordion">
        <?php foreach ($categories->toArray() as $parent) { ?>
            <?php if ($category_id == $parent->get('category_id')) { ?>
                <li class="active">
                <?php } else { ?>
                <li>
                <?php } ?>
                <?php if ($parent->get('categories')->isEmpty()) { ?>
                    <!--@task to scss-->
                    <span style="cursor:pointer" href="" class="opener"><?php echo $parent->get('name'); ?></span>
                <?php } else { ?>
                    <a href="#" class="opener"><?php echo $parent->get('name'); ?></a>
                    <div class="slide">
                        <ul>
                            <?php foreach ($parent->get('categories')->toArray() as $child) { ?>
                                <?php if ($child_id == $child->get('category_id')) { ?>
                                    <li class="active">
                                    <?php } else { ?>
                                    <li>
                                    <?php } ?>
                                    <a href="<?php echo $child->getHref($url); ?>"><?php echo $child->get('name'); ?></a>
                                    <!-- @task to scss remove and a.active impl too -->
                                    <?php if (!$child->get('categories')->isEmpty()) : ?>
                                        <ul style="margin-left:20px">
                                            <?php foreach ($child->get('categories')->toArray() as $sub) : ?>
                                                <?php if ($child_id == $sub->get('category_id')) { ?>
                                                    <li class="active">
                                                    <?php } else { ?>
                                                    <li>
                                                    <?php } ?>
                                                    <a href="<?php echo $sub->getHref($url); ?>"><?php echo $sub->get('name'); ?></a>
                                                <?php endforeach ?>
                                        </ul>
                                    <?php endif; ?>
                                </li>
                            <?php } ?>
                        </ul>
                    </div>
                <?php } ?>
            </li>
        <?php } ?>
    </ul>
</div>
<div class="catalog-product catalog-product2">
    <a class="catalog-btn">Каталог продукции</a>
    <ul class="accordion simple-accordion">
        <?php foreach ($categories->toArray() as $parent) { ?>
            <?php if ($category_id == $parent->get('category_id')) { ?>
                <li class="active">
                <?php } else { ?>
                <li>
                <?php } ?>
                <a href="#" class="opener"><?php echo $parent->get('name'); ?></a>
                <?php if (!$parent->get('categories')->isEmpty()) { ?>
                    <div class="slide">
                        <ul>
                            <?php foreach ($parent->get('categories')->toArray() as $child) { ?>
                                <?php if ($category_id == $child->get('category_id')) { ?>
                                    <li class="active">
                                    <?php } else { ?>
                                    <li>
                                    <?php } ?>
                                    <a href="<?php echo $child->getHref($url); ?>"><?php echo $child->get('name'); ?></a>
                                    <!-- @task to scss remove -->
                                    <?php if (!$child->get('categories')->isEmpty()) : ?>
                                        <ul style="margin-left:20px">
                                            <?php foreach ($child->get('categories')->toArray() as $sub) : ?>
                                                <?php if ($category_id == $child->get('category_id')) { ?>
                                                    <li class="active">
                                                    <?php } else { ?>
                                                    <li>
                                                    <?php } ?>
                                                    <a href="<?php echo $sub->getHref($url); ?>"><?php echo $sub->get('name'); ?></a>
                                                <?php endforeach ?>
                                        </ul>
                                    <?php endif; ?>
                                </li>
                            <?php } ?>
                        </ul>
                    </div>
                <?php } ?>
            </li>
        <?php } ?>
    </ul>
</div>
<div class="search-form">
    <form action="">
        <input type="text" value="Поиск по сайту...">
        <input type="submit" value="">
    </form>
</div>
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
