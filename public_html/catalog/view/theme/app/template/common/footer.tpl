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
                    <li>
                        <a target="_blank" itemprop="sameAs" href="https://vk.com/antsnab" rel="nofollow noopener">
                            <div class="soc_ico soc_ico_vk"></div>
                            <!--
                            <img src="/catalog/view/theme/app/img/soc1.png" alt="ВКонтакте">
                            -->
                        </a>
                    </li>
                    <li>
                        <a target="_blank" itemprop="sameAs" href="https://www.facebook.com/antsnab.tk" rel="nofollow noopener">
                            <div class="soc_ico soc_ico_fb"></div>
                            <!--<img src="/catalog/view/theme/app/img/soc2.png" alt="Facebook">-->
                        </a>
                    </li>
                    <li>
                        <a target="_blank" itemprop="sameAs" href="https://twitter.com/antsnab" rel="nofollow noopener">
                            <div class="soc_ico soc_ico_tw"></div>
                            <!--<img src="/catalog/view/theme/app/img/soc3.png" alt="Twitter">-->
                        </a>
                    </li>
                    <li>
                        <a target="_blank" itemprop="sameAs" href="https://www.instagram.com/bitumman/" rel="nofollow noopener">
                            <div class="soc_ico soc_ico_in"></div>
                            <!--<img src="/catalog/view/theme/app/img/insta.png" alt="Instagram">-->
                        </a>
                    </li>
                </ul>
            </div>
            <p>© <span itemprop="name">ООО "ТК Ант-Снаб"</span>, 2012-<?php echo date("Y");?>.</p>
            <a href="<?=$sitemap?>">Карта сайта</a>
            <a href="<?=$confidence?>">Политика конфиденциальности</a>
        </div>
        <div class="footer-right">
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
            </nav>

            <time style="display:none;" itemprop="openingHours" datetime="Mo-Fr 09:00−19:00">
                Пн-Пт: 09.00 до 19.00, Сб-Вс: Выходные дни
            </time>
            <meta itemprop="priceRange" content="<?php echo $priceRange;?>">
            <div class="footer-info">
                <!--<?= $address ?>-->
                <p class="address" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                    <span itemprop="postalCode">127566</span>, <span itemprop="addressLocality">г. Москва</span>, <span itemprop="streetAddress">Высоковольтный проезд, дом 1, стр. 43</span>
                    <meta itemprop="addressCountry" content="RU">
                </p>
                <div class="call-us">
                    <span>позвоните нам:</span>
                    <a rel="nofollow" href="tel:<?= $telephone ?>"><span class="footer_phone_v" itemprop="telephone"><?= $telephone ?></span></a>
                </div>
                <div class="line"></div>
                <?php if( !empty($telephone2) ):?>
                <div class="call-us call-us2">
                    <span>бесплатный звонок по России</span>
                    <a rel="nofollow" href="tel:<?= $telephone2 ?>"><span class="footer_phone_v" itemprop="telephone"><?= $telephone2 ?></span></a>
                </div>
                <?php endif;?>
                <div class="footer_mailto">
                    <a rel="nofollow" href="mailto:<?= $email_site ?>" class="mail"><span itemprop="email"><?= $email_site ?></span></a>
                    <!--<a rel="nofollow" class="js-call with_goal" href="#" goal="callme">Заказать звонок</a>-->
                    <div class="prehead_call">
                        <span class="prehead_val order_call js_modal" data-modal="modal_call">Заказать звонок</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>
<script src="/catalog/view/theme/app/bundle/app2.js?v0.3"></script>
<!--<script src="https://www.google.com/recaptcha/api.js"></script>-->

    <!-- @task1 Счетчики, виджеты (comagic) -->
<?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
<?php } ?>
</body>
</html>
