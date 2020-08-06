<div class = "reviews-container">
    <div class="contacts-container">
        <!--<a target="blank" href="<?=$rekviziti?>" class="requisites">Наши реквизиты</a>-->
        <div class="contacts-block">
            <div class="contacts-block_wrapper">
                <address class="left_contacts">
                    <div class="contacts_phone">
                        <div class="contacts_phone_line">
                            <a href="tel:<?= $telephone ?>"><?= $telephone ?></a>
                        </div>
                        <?php if (!empty($fax)): ?>
                            <div class="contacts_phone_line2">
                                <a href="tel:<?= $fax ?>"><?= $fax ?></a> — <span class="contacts_phone_hint">бесплатно по РФ</span>
                            </div>
                        <?php endif; ?>
                    </div>
                    <div class="contacts_email">
                        <a href="mailto:<?= $email_site ?>"><?= $email_site ?></a>
                    </div>
                    <div class="contacts_address">
                        <?php echo $address ?>
                    </div>
                    <div class="contacts_time">
                        <?php echo $open ?>
                    </div>
                </address>
                
                <div class="right_contacts">
                    <div class="contacts_messengers">
                        <div class="right_contacts_row">
                            <div class="right_contacts_row_cap">Связаться через мессенджеры:</div>
                            <div class="right_contacts_row_list">
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
                        </div>
                        <div class="right_contacts_row">
                            <div class="right_contacts_row_cap">Связаться через соцсети:</div>
                            <div class="right_contacts_row_list">
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
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>

        <div class="wrp_sklads">
            <h2>Офисы и склады</h2>
            <?php if ($locations) : ?>
                <div class="contacts-tabs">
                    <div id="mtab1" class="tab">
                        <ul class="tabset multi-tabset">
                            <?php $cnt = 0 ?>
                            <?php foreach ($locations as $l): ?>
                                <?php if ($cnt === 0): ?>
                                    <li>
                                        <div class="map_tab active" rel="m1tab<?= $cnt ?>"><?= $l['name'] ?></div>
                                    </li>
                                <?php else: ?>
                                    <li>
                                        <div class="map_tab" rel="m1tab<?= $cnt ?>"><?= $l['name'] ?></div>
                                    </li>
                                <?php endif; ?>
                                <?php $cnt++ ?>
                            <?php endforeach; ?>
                        </ul>
                        <div class="tab-list">
                            <?php $cnt = 0; ?>
                            <?php foreach ($locations as $l): ?>
                                <div class="map_block" id="m1tab<?= $cnt ?>" style='<?php echo ($cnt==0?"display:block;":"display:none;"); ?>'>
                                    <div class="contacts-tab">
                                        <div class="contacts-tab_wrapper">
                                            <div class="contacts-tab_info">
                                                <p class="contacts-tab_address"><span>Адрес: </span><?= $l['address'] ?></p>
                                                <p class="contacts-tab_time"><span>Время работы: </span><?= $l['open'] ?></p>
                                            </div>
                                        </div>
                                        <div class="map map_data">
                                            <?php echo trim($l['map']);?>
                                        </div>
                                        
                                        <?php foreach($l['files'] as $locaction_file){ ?>
                                            <a target="_blank" href="<?php echo $locaction_file['file_link'];?>" class="download-map">Скачать подробную карту</a>
                                        <?php }?>
                                        <div class="wrapper_contact_slider">
                                            <div class="contact_slider_arrows"></div>
                                            <div class="wrp_contact_slider">
                                                <ul class="contact_slider" id="contact_slider">
                                                    <?php foreach($sklads as $sklad) {?>
                                                        <li class="contacts_slide">
                                                            <a data-caption="<?php echo $sklad['title'];?>" data-fancybox="sklad" href="<?php echo $sklad['image'];?>" class="">
                                                                <div class="contacts_slide_img" style="background-image:url(<?php echo $sklad['thumb'];?>)"></div>
                                                            </a>
                                                        </li>
                                                    <?php }?>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?php $cnt++ ?>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
            <?php endif; ?>
        </div>
        
        <?php if($requisites){?>
            <div class="wrp_requisites">
                <?php echo $requisites;?>
            </div>
        <?php }?>
        <div class="tovar_files">
            <a class="download" target="_blank" href="https://ant-snab.ru/files/rek_ant-snab.pdf">Скачать реквизиты</a>
        </div>
        <div class="wrp_feedback">
            <h2>Обратная связь</h2>

            <form class="feedbackform" id="feedbackform" action="#" method="post">
                <div id="ajax_loader_feedback" class="ajax_loader" style="display: none;">
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
                <input value="" name="workemail" type="text" placeholder="Рабочий email">

                <div class="row">
                    <div class="row_cap">Имя:<i class="error name"></i></div>
                    <input value="" name="name" type="text" placeholder="Введите Ваше имя">
                </div>
                <div class="row">
                    <div class="row_cap">Телефон:<i class="error phone"></i></div>
                    <input value="" name="phone" type="tel" placeholder="Введите телефон" im-insert="true">
                </div>
                <div class="row">
                    <div class="row_cap">Email:</div>
                    <input value="" name="email" type="text" placeholder="Введите email" im-insert="true">
                </div>
                <div class="row">
                    <div class="row_cap">Сообщение:</div>
                    <textarea placeholder="Введите Ваше сообщение" name="text"></textarea>
                </div>
                <div class="row_cap">
                    <p>Нажимая на кнопку Отправить, я даю <a target="_blank" href="agreement/">согласие на обработку персональных данных</a></p>
                </div>
                <div id="feedback_submit" class="call_submit">Отправить</div>
            </form>
        </div>

    </div>
</div>
