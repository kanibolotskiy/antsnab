<div class="header_shadow">
    <div class="wrapper">
        <div class="header_container _flex _vcenter _between">
            <div class="header_logo">
                <div class="_flex _vcenter">
                    <div class="logo">
                        <img src="../catalog/view/theme/app/img/logo.svg" alt=""/>                                
                    </div>
                    <div class="logo_info">
                        <div class="logo_caption"></div>
                        <div class="logo_description"><?=$logotext?></div>
                    </div>
                </div>
            </div>
            <div class="header_info _flex _vcenter _between">
                <div class="header_email">
                    <a class="_noscroll" href="mailto:<?=$email_site?>"><?=$email_site?></a>
                </div>
                <div class="header_phones">
                    <div class="header_phone">
                        <a class="_noscroll" href="tel:<?=$telephone_link?>"><?=$telephone?></a>
                    </div>
                    <?php if($telephone2){?>
                        <div class="header_phone">
                            <a class="_noscroll" href="tel:<?=$telephone2_link?>"><?=$telephone2?></a>
                        </div>
                    <?php }?>
                </div>
                <div class="btn header_call _noscroll js_goal" data-goal="lp-zakaz-zvonka">
                    Заказать звонок
                </div>
                <div class="mob_menu">
                    <div class="mob_menu_line mob_menu_line1"></div>
                    <div class="mob_menu_line mob_menu_line2"></div>
                    <div class="mob_menu_line mob_menu_line3"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="wrp_mob_menu">
        <div class="mob_menu_close">
            <div class="mob_menu_close_line mob_menu_close_line1"></div>
            <div class="mob_menu_close_line mob_menu_close_line2"></div>
        </div>
        <div class="mob_menu_info">
            <div class="btn mob_menu_ordercall js_sbottom js_goal" data-goal="lp-zakaz-zvonka">Заказать звонок</div>
            <div class="menu_email">
                <a href="mailto:<?=$email_site?>"><?=$email_site?></a>
            </div>
            <div class="menu_address">
                г. Москва, Высоковольтный проезд, дом 1, стр. 43
            </div>
            <div class="menu_work">
                <div class="menu_work_caption">Мы работаем:</div>
                <div class="menu_work_line">Пн–Пт: с 9.00 до 18.00</div>
                <div class="menu_work_line">Сб–Вс: выходные дни</div>
            </div>
        </div>
    </div>
</div>

