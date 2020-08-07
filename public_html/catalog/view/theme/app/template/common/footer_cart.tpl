<footer class="footer">
    <div class="container" itemscope itemtype="http://schema.org/Organization">
        <div itemprop="url" href="<?php echo $home;?>" content="<?php echo $home;?>" style="display:none;"></div>
        <div itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
            <img itemprop="url image" src="<?php echo $logo;?>" style="display:none;"/>
            <meta itemprop="width" content="115">
            <meta itemprop="height" content="115">
        </div>

        

        <div class="footer-left">
            <div class="soc">
                <span>Мы в соцсетях:</span>
                <ul>
                    <li>
                        <a target="_blank" itemprop="sameAs" href="https://vk.com/antsnab" rel="nofollow">
                            <img src="/catalog/view/theme/app/img/soc1.png" alt="img">
                        </a>
                    </li>
                    <li>
                        <a target="_blank" itemprop="sameAs" href="https://www.facebook.com/antsnab.tk" rel="nofollow">
                            <img src="/catalog/view/theme/app/img/soc2.png" alt="img">
                        </a>
                    </li>
                    <li>
                        <a target="_blank" itemprop="sameAs" href="https://twitter.com/antsnab" rel="nofollow">
                            <img src="/catalog/view/theme/app/img/soc3.png" alt="img">
                        </a>
                    </li>
                    <li>
                        <a target="_blank" itemprop="sameAs" href="https://www.instagram.com/bitumman/" rel="nofollow">
                            <img src="/catalog/view/theme/app/img/insta.png" alt="img">
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
                <ul>
                    <?php foreach ($top_menu as $item) : ?>

                        <?php if($item['isactive']){?>
                            <li class="active">
                                <span><?php echo $item['name']; ?></span>
                            </li>
                        <?php }else{?>
                            <li class="menu_li">
                                <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                            </li>
                        <?php }?>

                        <!--
                        <?php $active = ($item['isactive']) ? 'class="active"' : ""; ?>
                        
                        <?php if (isset($item['target']) && trim($item['target']) != "") { ?>
                            <li>
                                <a <?= $active ?> href="<?php echo $item['href']; ?>" target="<?php echo $item['target']; ?>">
                                    <?php echo $item['name']; ?>
                                </a>
                            </li>
                        <?php } else { ?>
                            <li>
                                <a <?= $active ?> href="<?php echo $item['href']; ?>">
                                    <?php echo $item['name']; ?>
                                </a>
                            </li>
                        <?php } ?>
                        -->
                    <?php endforeach; ?>
                </ul>
            </nav>
            
            <div class="footer-info">
                <!--<?= $address ?>-->
                <p class="address" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                    <span itemprop="postalCode">127566</span>, <span itemprop="addressLocality">г. Москва</span>, <span itemprop="streetAddress">Высоковольтный проезд, дом 1, стр. 43</span>
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
                <a rel="nofollow" href="mailto:<?= $email_site ?>" class="mail"><span itemprop="email"><?= $email_site ?></span></a>
            </div>
        </div>
    </div>
</footer>
<script src="/catalog/view/theme/app/bundle/app2.js?v2.73"></script>
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
