<!doctype html>
<!--[if IE 9]><html lang="en" xmlns:og="http://ogp.me/ns#" class="no-js ie9"><![endif]-->
<!--[if (gte IE 9) | !(IE)]><!--><html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><?php echo $title; ?></title>
        <base href="<?php echo $base; ?>" />

        <link rel="shortcut icon" href="/favicon.ico" >
        <link rel="icon" type="image/png" href="/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="/favicon-16x16.png" sizes="16x16">
        <link rel="manifest" href="/manifest.json">
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
        <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5">

    

        <link href="/catalog/view/theme/app/bundle/app2.css?v2.16" rel="stylesheet">
        <?php if ($description) { ?>
            <meta name="description" content="<?php echo $description; ?>" />
        <?php } ?>
        <?php if ($keywords) { ?>
            <meta name="keywords" content= "<?php echo $keywords; ?>" />
        <?php } ?>

        <?php if (isset($noindex)) { ?>
            <meta name="robots" content="noindex,nofollow" />
        <?php }else{ ?>
            <meta name="robots" content="noyaca" />
        <?php } ?>

        <meta property="og:title" content="<?php echo $title; ?>" />
        <meta property="og:type" content="article" />
        <meta property="og:locale" content="ru_RU" />
        <meta property="og:url" content="<?php echo $og_url; ?>" />
        <?php if ($og_image) { ?>
            <meta property="og:image" content="<?php echo $og_image; ?>" />
        <?php } else { ?>
            <meta property="og:image" content="<?php echo $logo; ?>" />
        <?php } ?>
        <meta property="og:site_name" content="<?php echo $name; ?>" />
        <?php foreach ($styles as $style) { ?>
            <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
        <?php } ?>
        <?php foreach ($links as $link) { ?>
            <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
        <?php } ?>
        
    </head>
    <body class="<?=$class?> <?php echo ($class == 'checkout-cart'?'_hmenu _hfixed':'');?>">
      

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

        <div class="modal modal_info">
            <div class="modal-block">
                <div class="modal_overlay"></div>
                <div class="modal-content">
                    <div class="modal_close"></div>
                    <div class="modal_info_product" id="modal_info_product">
                        
                    </div>
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
                        
                        <form id="call_form" action="<?= $action ?>" method="post">
                            <div class="popup_caption">Оставьте свои данные и сообщение, мы свяжемся с Вами в ближайшее время</div>

                            <input value="<?= $form_data['workemail'] ?>" name="workemail" type="text" placeholder="Рабочий email"/>

                            <div class="row">
                                <div class="row_cap">Имя:<i class="error name"></i></div>
                                <input class="inputModal" value="<?= $form_data['name'] ?>" name="name" type="text" placeholder="Введите Ваше имя"/>
                            </div>
                            <div class="row">
                                <div class="row_cap">Телефон:<i class="error phone"></i></div>
                                <input class="inputModal" value="<?= $form_data['phone'] ?>" name="phone" type="tel" placeholder="Введите телефон"/>
                            </div>
                            <div class="row">
                                <div class="row_cap">Сообщение:</div>
                                <textarea placeholder="Введите Ваше сообщение" name="text"><?= $form_data['text'] ?></textarea>
                            </div>
                            <div class="row_cap">
                                <p>Нажимая на кнопку Отправить, я даю <a target="_blank" href="<?php echo $personaldata;?>">согласие на обработку персональных данных</a></p>
                            </div>
                            <div class="call_submit" id="call_submit">Отправить</div>
                        </form>
                        <script type="text/javascript">
                            function submitCallForm()
                            {
                                $('#call_form').submit();
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div>

        

        <a href="#" class="up" rel="nofollow"></a>
        
        <?php if($class != "checkout-cart"){ ?>
            <div class="preheader">
                <div class="container">
                    <div class="preheader_info">
                        <a href="contacts/" >
                            <div class="prehead_address">
                                <span class="prehead_cap">Офис:</span>
                                <span class="prehead_val">г. Москва<span class="hide_mb">, Высоковольтный проезд, дом 1, стр. 43</span></span>
                            </div>
                        </a>
                        <!--<div class="preheader_divider"></div>-->
                        <div class="prehead_work">
                            <span class="prehead_cap">Мы работаем:</span>
                            <span class="prehead_val"><?= $worktime ?></span>
                        </div>
                        
                    </div>
                </div>
            </div>
        <?php }?>
        <div class="wrp_header">
            <header class="header container">
                
                <div class="wrap_logo">
                    <strong class="logo">
                        <?php if ($home == $og_url) { ?>
                            <div class="logo_bg"></div>
                            <div class="logo_cap"></div>
                            <div class="logo_caption">строительные материалы</div>
                        <?php } else { ?>
                            <a href="<?php echo $home; ?>">
                                <div class="logo_bg"></div>
                                <div class="logo_cap"></div>
                                <div class="logo_caption">строительные материалы</div>
                            </a>
                        <?php } ?>
                    </strong>
                </div>
                <?php if($class != "checkout-cart"){ ?>
                    <div class="header_email">
                        <a href="mailto:<?= $email_site ?>"><?= $email_site ?></a>
                    </div>
                <?php }?>
                <div class="tel">
                    <a rel="nofollow" href="tel:<?php echo $telephone; ?>"><?php echo $telephone; ?></a>
                    <?php if($telephone2){ ?>
                        <a rel="nofollow" href="tel:<?= $telephone2 ?>">&nbsp;&nbsp;<?= $telephone2 ?></a>
                    <?php }?>
                    
                </div>
                <a href="#" class="js-call with_goal" rel="nofollow" goal="callme">
                    <div class="prehead_call">
                        <span class="prehead_val order_call js_modal" data-modal="modal_call">Заказать звонок</span>
                    </div>
                </a>
                
                <?php if($class != "checkout-cart"){ ?>
                    <?= $cart ?>
                <?php }?>
                <div class="mob_menu">
                    <div class="mob_menu_block"></div>
                </div>
                <!--
                <a class="btn-nav">
                    <span>
                        <b></b>
                        <b></b>
                        <b></b>
                    </span>
                </a>
                -->
            </header>
        </div>
        <div class="table_block_header">
            <div class="table_block_header_info">
                <div class="table_catalog"><span>Каталог</span></div>
            </div>
        </div>
        <div class="empty_block_header"></div>

        <div class="container container-nav">
            <div class="container-nav_close"></div>
            <nav class="nav">
                <ul itemscope itemtype="http://www.schema.org/SiteNavigationElement">
                    <?php $cnt = 0; $ttl = count($top_menu);?>
                    <?php foreach ($top_menu as $item) : ?>
                        <?php if($item["position"]==0){?>
                            <?php if($item["href"]=='/sales/'){$classMenu='<div class="_menu_accia"></div>';?>
                            <?php }else{$classMenu='';}?>
                            <?php 
                                if (isset($item['target']) && trim($item['target']) != "") {
                                    $target=" target=".$item['target'];
                                }else{
                                    $target="";
                                }
                            ?>
                            
                            <?php if($item['isactive']){?>
                                <li class="active" itemprop="name">
                                    <?php echo $classMenu;?>
                                    <span><?php echo $item['name']; ?></span>
                                </li>
                            <?php }else{?>
                                <li class="menu_li" itemprop="name">
                                    <?php echo $classMenu;?>
                                    <a itemprop="url" href="<?php echo $item['href']; ?>" <?php echo $target; ?>><span><?php echo $item['name']; ?></span></a>
                                </li>
                            <?php }?>

                            <?php $cnt++;?>
                            <?php if( $cnt != $ttl): ?>
                            <li class="separator"></li>
                                
                        
                            <?php endif;?>
                        <?php }?>
                    <?php endforeach; ?>
                </ul>
                <div class="mobmenu_contacts">
                    <div class="mobmenu_contacts_call">
                        <span class="prehead_val order_call js_modal" data-modal="modal_call">Заказать звонок</span>
                    </div>
                    <div class="mobmenu_contacts_email">
                        <a href="mailto:<?= $email_site ?>"><?= $email_site ?></a>
                    </div>

                    <div class="mobmenu_contacts_address">
                        <a href="contacts/">г. Москва<span class="hide_mb">, Высоковольтный проезд, дом 1, стр. 43</span></a>
                    </div>
                    <div class="mobmenu_contacts_workcap">
                        Мы работаем:
                    </div>
                    <div class="mobmenu_contacts_workval">
                        <?= $worktime ?>
                    </div>
                </div>

            </nav>
        </div>

