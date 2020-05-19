<footer class="footer">

    <div class="container" itemscope itemtype="http://schema.org/LocalBusiness">
        <div itemprop="image" content="<?php echo $logo;?>" style="display:none;"></div>

        <div itemprop="url" href="<?php echo $home;?>" content="<?php echo $home;?>" style="display:none;"></div>
        <div itemprop="logo" itemscope style="display:none;" itemtype="https://schema.org/ImageObject">
            <img itemprop="url image" src="<?php echo $logo;?>" style="display:none;"/>
            <meta itemprop="width" content="115">
            <meta itemprop="height" content="115">
        </div>

        

        <div class="footer-left">
            <div class="soc">
                <span>Мы в соцсетях:</span>
                <ul>
                    <?php if($link_vk){?>
                        <li>
                            <a target="_blank" itemprop="sameAs" href="<?php echo $link_vk;?>" rel="nofollow noopener">
                                <div class="soc_ico soc_ico_vk"></div>
                            </a>
                        </li>
                    <?php }?>
                    <?php if($link_fb){?>
                        <li>
                            <a target="_blank" itemprop="sameAs" href="<?php echo $link_fb;?>" rel="nofollow noopener">
                                <div class="soc_ico soc_ico_fb"></div>
                            </a>
                        </li>
                    <?php }?>
                    <?php if($link_tw){?>
                        <li>
                            <a target="_blank" itemprop="sameAs" href="<?php echo $link_tw;?>" rel="nofollow noopener">
                                <div class="soc_ico soc_ico_tw"></div>
                            </a>
                        </li>
                    <?php }?>
                    <?php if($link_in){?>
                        <li>
                            <a target="_blank" itemprop="sameAs" href="<?php echo $link_in;?>" rel="nofollow noopener">
                                <div class="soc_ico soc_ico_in"></div>
                            </a>
                        </li>
                    <?php }?>
                </ul>
            </div>
            <div class="footer-left-docs">
                <a href="<?=$sitemap?>">Карта сайта</a> 
                <a href="<?=$confidence?>">Политика конфиденциальности</a>
            </div>
            <p>© <span itemprop="name">ООО "ТК Ант-Снаб"</span>, 2012-<?php echo date("Y");?>.</p>
        </div>
        <div class="footer-column footer-column2">
            <nav class="footer-nav">
                <ul class="simple-accordion"  itemscope itemtype="http://www.schema.org/SiteNavigationElement">
                    <?php foreach ($top_menu as $item) : ?>

                        <?php if($item['isactive']){?>
                            <li class="active" itemprop="name">
                                <span><?php echo $item['name']; ?></span>
                            </li>
                        <?php }else{?>
                            <li class="menu_li" itemprop="name">
                                <a itemprop="url" href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                            </li>
                        <?php }?>
                    <?php endforeach; ?>
                </ul>
                
                
            </nav>

            
        </div>
        <div class="footer-column footer-column3">
            <div class="wrap_footer_catalog">
                <div class="footer_catalog_caption"><a href="products/" title="Каталог">Каталог</a></div>
                <ul class="footer_catalog"  itemscope itemtype="http://www.schema.org/SiteNavigationElement">
                    <?php foreach ($foot_categories as $item) { ?>
                        <li class="footer_menu_li" itemprop="name">
                            <a itemprop="url" href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                        </li>
                    <?php }?>
                </ul>
            </div>
        </div>
        <div class="footer-column footer-column4">
            <div class="footer_phone">
                <div class="call-us">
                    <a rel="nofollow" href="tel:<?= $telephone ?>"><span class="footer_phone_v" itemprop="telephone"><?= $telephone ?></span></a>
                </div>
                <?php if( !empty($telephone2) ):?>
                <div class="call-us call-us2">
                    <a rel="nofollow" href="tel:<?= $telephone2 ?>"><span class="footer_phone_v" itemprop="telephone"><?= $telephone2 ?></span></a>
                    <div>бесплатный звонок по России</div>
                </div>
                <?php endif;?>
            </div>
            
            <div class="footer_order_call order_call js_modal" data-modal="modal_call"><div>Заказать звонок</div></div>

            <div class="footer_address">
                <a href="contacts/">
                    <p class="address" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                        
                        <span itemprop="postalCode">127566</span>, <span itemprop="addressLocality">г. Москва</span>, <span itemprop="streetAddress">Высоковольтный проезд, дом 1, стр. 43</span>
                        <meta itemprop="addressCountry" content="RU">
                    </p>
                </a>
                <time style="display:none;" itemprop="openingHours" datetime="Mo-Fr 09:00−19:00">
                    Пн-Пт: 09.00 до 19.00, Сб-Вс: Выходные дни
                </time>
                <meta itemprop="priceRange" content="<?php echo $priceRange;?>">
            </div>
            
            <div class="footer_email">
                <a rel="nofollow" href="mailto:<?= $email_site ?>" class="mail"><span itemprop="email"><?= $email_site ?></span></a>
            </div>
            
        </div>
    </div>
</footer>
<script src="/catalog/view/theme/app/bundle/app2.js?v2.17"></script>
<!--<script src="https://www.google.com/recaptcha/api.js"></script>-->

    <!-- @task1 Счетчики, виджеты (comagic) -->
<?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
<?php } ?>
<div id="fly_item" class="fly_item"></div>
</body>
</html>
