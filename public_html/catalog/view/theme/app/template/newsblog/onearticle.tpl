<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content content_visible">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        
        <div class="article" itemscope itemtype="http://schema.org/Article">
            <h1 class="title" itemprop="name"><?php echo $heading_title; ?></h1>
            <meta itemprop="datePublished" content="<?php echo date("Y-m-d",strtotime($date));?>"/> 
            <meta itemprop="dateModified" content="<?php echo date("Y-m-d",strtotime($date));?>"/>

            <meta itemprop="author" content='ООО "ТК Ант-Снаб"'/>
            <div style="display:none;" itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
                <div itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
                    <img itemprop="url image" src="https://ant-snab.ru/image/catalog/logo.jpg" alt="Ант-Снаб"/>
                    <meta itemprop="width" content="102">
                    <meta itemprop="height" content="94">
                </div>
                <meta itemprop="name" content='ООО "ТК Ант-Снаб"'>
                <meta itemprop="telephone" content="+7 (495) 255-01-37">
                <meta itemprop="address" content="127566, г. Москва, Высоковольтный проезд, дом 1, стр. 43">
            </div>
            <?php if ($thumb) { ?>
                <div class="img-article">
                    
<picture>
    <source type="image/webp" srcset="<?=$thumb_webp?>">
    <source type="image/jpeg" srcset="<?=$thumb?>">
    <img itemprop="image" src="<?=$thumb?>" title="<?=$heading_title ?>" alt="<?=$heading_title ?>" />
</picture>                    

                    <?php if ($show_cat_name): ?>
                        <span><?= $cat_name ?></span>
                        <!--<div class="time _hidden"><?= $date ?></div>-->
                    <?php else: ?>
                        <div class="time"><?= $date ?></div>
                    <?php endif; ?>
                </div>
            <?php } ?>
            <div class="article-content content-text" itemprop="articleBody">
                <?php echo $description; ?>
                <?php if($faq) {?>
                    <div class="clr"></div>
                    <div class="faqs" itemscope itemtype="https://schema.org/FAQPage">
                        <?php foreach($faq as $faq_item) {?>
                            <div class="faq_row" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
                                <div class="faq_question"><p>Вопрос: <span itemprop="name"><?=$faq_item['question']?></span></p></div>
                                <div class="faq_answer" itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
                                    <span class="faq_answer_caption">Ответ: </span><span itemprop="text"><?=html_entity_decode($faq_item['answer'])?></span>
                                </div>
                            </div>
                        <?php }?>
                    </div>

                <?php }?>
            </div>
            

            <?php if($images) {?>
                <div class="gallery">
                    <?php foreach($images as $image_item) {?>
                    <div class="gallery_item">
                        <a href="<?php echo $image_item['original'];?>" data-fancybox="gallery"><img src="<?php echo $image_item['thumb'];?>" /></a>
                    </div>
                    <?php }?>
                </div>
            <?php }?>
        </div>
        <script src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>
        <script src="//yastatic.net/share2/share.js"></script>
        <div style="margin: 20px 0px; text-align:right">
            Ваш, Ант-Снаб
        </div>
        <div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki,moimir,gplus,pocket,viber,whatsapp,skype,telegram"></div>
        <div style="clear:both; margin-bottom:40px"></div>

        <?php if( !empty($products) ):?>
        <div class="title">Упоминаемые товары:</div>
        <div class="mentioned-products mentioned-products2">
            
                
            <ul>
                <?php foreach( $products as $p):?>
                <li>
                    <div class="products-block">
                        <a href="<?=$p['href']?>" class="img-production">
                            
<picture>
<source type="image/webp" srcset="<?=$p['thumb_webp']?>">
<source type="image/jpeg" srcset="<?=$p['thumb']?>">
<img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
</picture>                                
                        </a>
                        <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>
                        <div class="article_product_price"><?=$p['price']?></div>
                        <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                    </div>
                </li>
                <?php endforeach;?>
            </ul>
        
        </div>

        <?php endif;?>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>