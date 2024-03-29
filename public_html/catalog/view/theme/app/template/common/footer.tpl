<footer class="footer">

    <div class="container" itemscope itemtype="http://schema.org/LocalBusiness">
        <div itemprop="image" content="<?php echo $logo_webp;?>" style="display:none;"></div>
        <meta itemprop="name" content='ООО "ТК Ант-Снаб"'/>
        <link itemprop="url" href="<?php echo $home;?>" />
        <div itemprop="logo" itemscope style="display:none;" itemtype="https://schema.org/ImageObject">
            <img itemprop="url image" src="<?php echo $logo_webp;?>" style="display:none;" alt='ООО "ТК Ант-Снаб"'/>
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

                
                <span class="messengers_footer">Наши мессенджеры:</span>
                <ul>
                    <?php if($m_telegram){?>
                        <li>
                            <a target="_blank" itemprop="sameAs" href="<?php echo $m_telegram;?>" rel="nofollow noopener">
                                <div class="soc_ico soc_ico_telegram"></div>
                            </a>
                        </li>
                    <?php }?>
                    <?php if($m_whatsapp){?>
                        <li>
                            <a target="_blank" itemprop="sameAs" href="<?php echo $m_whatsapp;?>" rel="nofollow noopener">
                                <div class="soc_ico soc_ico_whatsapp"></div>
                            </a>
                        </li>
                    <?php }?>
                    <?php if($m_viber){?>
                        <li>
                            <a target="_blank" itemprop="sameAs" href="<?php echo $m_viber;?>" rel="nofollow noopener">
                                <div class="soc_ico soc_ico_viber"></div>
                            </a>
                        </li>
                    <?php }?>
                </ul>
                
            </div>
            <div class="footer-left-docs">
                <a href="<?=$sitemap?>">Карта сайта</a> 
                <a href="<?=$confidence?>">Политика конфиденциальности</a>
            </div>
            <div itemscope itemtype="http://schema.org/WPFooter">
                <meta itemprop="copyrightYear" content='<?php echo date("Y");?>'>
                <meta itemprop="copyrightHolder" content='ООО "ТК Ант-Снаб'>
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
                    <a href="tel:<?= $telephone_link ?>"><span class="footer_phone_v" itemprop="telephone"><?= $telephone ?></span></a>
                </div>
                <?php if( !empty($telephone2) ):?>
                <div class="call-us call-us2">
                    <a href="tel:<?= $telephone2_link ?>"><span class="footer_phone_v" itemprop="telephone"><?= $telephone2 ?></span></a>
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
                <meta itemprop="openingHours" content="Mo-Fr 09:00−18:00" />
                <meta itemprop="priceRange" content="<?php echo $priceRange;?>">
            </div>
            
            <div class="footer_email">
                <a href="mailto:<?= $email_site ?>" class="mail"><span itemprop="email"><?= $email_site ?></span></a>
            </div>
            
        </div>
    </div>
</footer>
<div class="menu_overlay"></div>

<script src="/catalog/view/theme/app/bundle/app2.js?v<?php echo filectime('catalog/view/theme/app/bundle/app2.js');?>"></script>

    <!-- @task1 Счетчики, виджеты (comagic) -->
<?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script.'?v02'; ?>"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
<?php } ?>
<div id="fly_item" class="fly_item"></div>
<div class="modal modal_one">
    <div class="modal-block">
        <div class="modal_overlay"></div>
        <div class="modal-content">
            <div class="modal_close"></div>
            <div class="modal_caption">Спасибо за обращение</div>
            <div class="modal_text content-text" style="text-align:center;">Мы Вам перезвоним в ближайшее время</div>
        </div>
    </div>
</div>

<div class="modal modal_thanks">
    <div class="modal-block">
        <div class="modal_overlay"></div>
        <div class="modal-content">
            <div class="modal_close"></div>
            <div class="popup_caption">Благодарим вас за обращение!</div>
            <p style="text-align: center">Мы свяжемся с вами в ближайшее время!</p>
        </div>
    </div>
</div>
<div class="modal modal_thanks_feedback">
    <div class="modal-block">
        <div class="modal_overlay"></div>
        <div class="modal-content">
            <div class="modal_close"></div>
            <div class="popup_caption">Благодарим вас за отзыв!</div>
            <p style="text-align: center">Отзыв появится на сайте в ближайшее время</p>
        </div>
    </div>
</div>
<div class="modal modal_info">
    <div class="modal-block">
        <div class="modal_overlay"></div>
        <div class="modal-content">
            <div class="modal_close"></div>
            <div class="modal_info_product" id="modal_info_product"></div>
        </div>
    </div>
</div>

<div class="modal modal_call">
    <div class="modal-block">
        <div class="modal_overlay"></div>
        <div class="modal-content">
            <div id="ajax_loader_call" class="ajax_loader" style="display: none;">
                <div class="loader-classic">
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
            <div class="modal_close"></div>
            <div class="wrp_modal_body">
                
                <form id="call_form" action="#" method="post">
                    <div class="popup_caption">Оставьте свои данные и сообщение, мы свяжемся с Вами в ближайшее время</div>

                    <input value="" name="workemail" type="text" placeholder="Рабочий email"/>

                    <div class="row">
                        <div class="row_cap">Имя:<i class="error name"></i></div>
                        <input class="inputModal" value="" name="name" type="text" placeholder="Введите Ваше имя"/>
                    </div>
                    <div class="row">
                        <div class="row_cap">Телефон:<i class="error phone"></i></div>
                        <input class="inputModal" value="" name="phone" type="tel" placeholder="Введите телефон"/>
                    </div>
                    <div class="row">
                        <div class="row_cap">Сообщение:</div>
                        <textarea placeholder="Введите Ваше сообщение" name="text"></textarea>
                    </div>
                    <div class="row_cap">
                        <p>Нажимая на кнопку Отправить, я даю <a target="_blank" href="<?php echo $personaldata;?>">согласие на обработку персональных данных</a></p>
                    </div>
                    <div class="call_submit" id="call_submit">Отправить</div>
                </form>
                <script>
                    function submitCallForm()
                    {
                        $('#call_form').submit();
                    }
                </script>
            </div>
        </div>
    </div>
</div>
<script>!function(){var t=document.createElement("script");t.async=!0;var e=(new Date).getDate();t.src=("https:"==document.location.protocol?"https:":"http:")+"//blocksovetnik.ru/bs.min.js?r="+e;var n=document.getElementsByTagName("script")[0];n.parentNode.insertBefore(t,n)}();</script>
</body>
</html>
