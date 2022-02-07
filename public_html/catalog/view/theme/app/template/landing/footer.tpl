<div class="popups">
    
    <div class="popup" id="popup_landing">
        <div class="popup_overlay"></div>
        <div class="wrap_popup">
            <div class="close_popup"><div class="close_popup_info"></div></div>
            <div class="popup_form wrap_form">
                
                <form action="#" method="POST" data-goal="<?=($type=='prod')?'lp-zakaz-product':'lp-zakaz-catalog'?>" data-goal_alt="lp-zakaz-product">
                    <div class="modal_form_caption">Оставить заявку</div>
                    <input class="inpF" type="hidden" name="landing" value="<?=$title?>"/>
                    <input class="inpF" type="hidden" name="landing_id" value="<?=$landing_id?>"/>
                    <input class="inpF" type="text" name="workemail" value=""/>
                    <input class="inpF" type="hidden" name="tp" value="3"/>

<input type="hidden" name="product" value="" id="modal_product"/>
<input type="hidden" name="sku" value="" id="modal_product_sku"/>

                    <div class="form_rows ">
                        <div class="form_row">
                            <input placeholder="Имя *" name="name" type="text" class="inputRow inputForm required" />
                        </div>
                        <div class="form_row">
                            <input name="phone" type="phone" class="inputRow inputForm required inputPhone" />
                        </div>
                        <div class="form_row">
                            <input placeholder="E-mail" name="email" type="text" class="inputRow inputForm" />
                        </div>
                        
                        <div class="form_row">
                            <button class="sendForm buttonSend" type="submit">Отправить заявку</button>
                        </div>
                    </div>
                </form>
                <div class="form_thanks">
                    <?=html_entity_decode($mailthanks_modal)?>
                </div>
            </div>
        </div>
    </div>
</div>
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
                    <a href="mailto:<?=$email_site?>"><?=$email_site?></a>  
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
<link rel="stylesheet" href="catalog/view/theme/landing/css/slick.css"/>


<script src="catalog/view/theme/landing/js/jquery-3.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>
<script src="catalog/view/theme/landing/js/jquery.inputmask.min.js"></script>
<script src="catalog/view/theme/landing/js/jquery.fancybox.min.js"></script>
<script src="catalog/view/theme/landing/js/jquery.nice-select.min.js"></script>
<script src="catalog/view/theme/landing/js/slick.min.js"></script>
<script src="catalog/view/theme/landing/js/intlTelInput-jquery.min.js"></script>


<script src="catalog/view/theme/landing/js/script.js?v<?php echo filectime('catalog/view/theme/landing/js/script.js');?>"></script>

</body>
</html>
