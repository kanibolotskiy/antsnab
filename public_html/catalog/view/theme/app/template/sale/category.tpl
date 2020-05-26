<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        
        <?php echo $content_top; ?>
        <div class="content_inner news-container staty-container">
            <h1 class="title"><?php echo $heading_title; ?></h1>
            <select id="seltype" style="display: none;" data-href="sales/">
                <option value="" <?php if($select==0){echo 'selected="selected"';}?>  >
                    Все акции
                </option>
                <option value="&active=1" <?php if($select==1){echo 'selected="selected"';}?>>
                    Активные акции
                </option>
                <option value="&active=0" <?php if($select==2){echo 'selected="selected"';}?>>
                    Неактивные акции
                </option>
            </select>
            
            <div class="staty-list sales_list">
                <?php foreach($sales as $sale){?>
                    <div class="news-block accia-block" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem">
                        <div class="wrp_news-block" itemprop="item" itemscope="" itemtype="http://schema.org/NewsArticle">
                            <meta itemprop="author" content='ООО "ТК Ант-Снаб"'/>
                            
                            <div style="display:none;" itemprop="publisher" itemscope="" itemtype="https://schema.org/Organization">
                                <div itemprop="logo" itemscope="" itemtype="https://schema.org/ImageObject">
                                    <img itemprop="url image" src="https://ant-snab.ru/image/catalog/logo.jpg">
                                    <meta itemprop="width" content="102">
                                    <meta itemprop="height" content="94">
                                </div>
                                <meta itemprop="name" content="ООО &quot;ТК Ант-Снаб&quot;">
                                <meta itemprop="telephone" content="+7 (495) 255-01-37">
                                <meta itemprop="address" content="127566, г. Москва, Высоковольтный проезд, дом 1, стр. 43">
                            </div>

                            
                            <div class="news-img">
                                <a itemprop="mainEntityOfPage" href="<?php echo $sale['href']; ?>">
                                    <img itemprop="image" src="<?php echo $sale['thumb']; ?>" alt="<?php echo $sale['title']; ?>" title="<?php echo $sale['title']; ?>">
                                </a>
                                <?php if($sale['accia_type']==0) {?>
                                    <time class="accia_time_enabled">Действует до <?=$sale["date_end"]?></time>
                                <?php }?>
                                <?php if($sale['accia_type']==1) {?>
                                    <time class="accia_time_disabled">Акция закончена</time>
                                <?php }?>
                                <?php if($sale['accia_type']==2) {?>
                                    <time class="accia_time_discount">Текущие скидки</time>
                                <?php }?>


                            </div>
                            <div class="news-description">
                                
                                <a href="<?php echo $sale['href']; ?>" class="title-news" itemprop="headline"><?php echo $sale['title']; ?></a>
                                <p><?php echo $sale['shorttext']; ?></p>
                                <a href="<?php echo $sale['href']; ?>" class="more">Читать далее</a>
                            </div>
                        </div>
                    </div>
                <?php }?>
            </div>
        
            <?php //echo $paginationLazy;?>
            <?php //echo $pagination;?>
            
            

        </div>
        
        
        <?php echo $content_bottom; ?>
        
    </div>
</div>
<?= $footer ?>