<footer>
    <div class="wrapper">
        <div class="_flex footer_top _between">
            <div class="footer_soc_links">
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
            <div class="footer_contacts _flex">
                <div class="footer_phones">
                    <div class="footer_phone">
                        <a href="tel:<?=$telephone_link?>"><?=$telephone?></a>
                    </div>
                    <?php if($telephone2){?>
                        <div class="footer_phone">
                            <a href="tel:<?=$telephone2_link?>"><?=$telephone2?></a>
                        </div>
                    <?php }?>
                </div>
                <div class="footer_email">
                    <a href="mailto:info@ant-snab.ru">info@ant-snab.ru</a>  
                </div>
                <div class="footer_address">
                    127566, г. Москва,<br/>Высоковольтный<br/>проезд, дом 1, стр. 43
                </div>
            </div>
        </div>
        <div class="footer_bottom _flex _between">
            <div class="footer_copy">© ООО "ТК Ант-Снаб", 2012-<?php echo date("Y");?></div>
            <div class="footer_links _flex">
                <div class="footer_link"><a target="_blank" href="sitemap/" title="Карта сайта">Карта сайта</a></div>
                <div class="footer_link"><a target="_blank" href="politika-konfidencialnosti/" title="Политика конфиденциальности">Политика конфиденциальности</a></div>
            </div>
        </div>
    </div>
</footer>
<link rel="stylesheet" href="catalog/view/theme/landing/css/jquery.fancybox.min.css"/>
<link rel="stylesheet" href="catalog/view/theme/landing/css/nice-select.css"/>
<link rel="stylesheet" href="catalog/view/theme/landing/css/intlTelInput.min.css"/>

<script src="catalog/view/theme/landing/js/jquery-3.2.1.min.js"></script>

<script src="catalog/view/theme/landing/js/jquery.inputmask.min.js"></script>
<script src="catalog/view/theme/landing/js/jquery.fancybox.min.js"></script>
<script src="catalog/view/theme/landing/js/jquery.nice-select.min.js"></script>
<script src="catalog/view/theme/landing/js/intlTelInput-jquery.min.js"></script>


<script src="catalog/view/theme/landing/js/script.js?v<?php echo filectime('catalog/view/theme/landing/js/script.js');?>"></script>

</body>
</html>
