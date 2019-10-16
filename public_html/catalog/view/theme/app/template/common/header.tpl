<!doctype html>
<!--[if IE 9]><html lang="en" xmlns:og="http://ogp.me/ns#" class="no-js ie9"><![endif]-->
<!--[if (gte IE 9) | !(IE)]><!--><html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><?php echo $title; ?></title>
        <base href="<?php echo $base; ?>" />

        <link rel="shortcut icon" href="/favicon.ico" >
        <link rel="icon" type="image/png" href="/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="/favicon-16x16.png" sizes="16x16">
        <link rel="manifest" href="/manifest.json">
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
        <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5">

        <meta name="robots" content="noyaca" />


        <link href="/catalog/view/theme/app/bundle/app2.css?v1.05" rel="stylesheet">
        <?php if ($description) { ?>
            <meta name="description" content="<?php echo $description; ?>" />
        <?php } ?>
        <?php if ($keywords) { ?>
            <meta name="keywords" content= "<?php echo $keywords; ?>" />
        <?php } ?>

        <?php if (isset($noindex)) { ?>
            <?php echo $noindex;?>
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
    <body class="<?=$class?>">
        <!--
        <div class="popup thank-you" >
            <div class="close"></div>
            <div class="popup-block">
                <div class="popup-content">
                    <div class="close2"></div>
                    <span>Благодарим вас за обращение!</span>
                    <p style="text-align: center">Мы свяжемся с вами в ближайшее время!</p>
                </div>
            </div>
        </div>
        -->

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
                                <input value="<?= $form_data['name'] ?>" name="name" type="text" placeholder="Введите Ваше имя"/>
                            </div>
                            <div class="row">
                                <div class="row_cap">Телефон:<i class="error phone"></i></div>
                                <input value="<?= $form_data['phone'] ?>" name="phone" type="tel" placeholder="Введите телефон"/>
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

        <!--
        <div class="popup popup_call">
            <div class="close"></div>
            <div class="popup-block">
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
                <div class="popup-content">
                    <div class="close2"></div>
                    <form id="call_form" action="<?= $action ?>" method="post">
                        <div class="popup_caption">Оставьте свои данные и сообщение, мы свяжемся с Вами в ближайшее время</div>

                        <input value="<?= $form_data['workemail'] ?>" name="workemail" type="text" placeholder="Рабочий email"/>

                        <div class="row">
                            <div class="row_cap">Имя:<i class="error name"></i></div>
                            <input value="<?= $form_data['name'] ?>" name="name" type="text" placeholder="Введите Ваше имя"/>
                        </div>
                        <div class="row">
                            <div class="row_cap">Телефон:<i class="error phone"></i></div>
                            <input value="<?= $form_data['phone'] ?>" name="phone" type="tel" placeholder="Введите телефон"/>
                        </div>
                        <div class="row">
                            <div class="row_cap">Сообщение:</div>
                            <textarea placeholder="Введите Ваше сообщение" name="text"><?= $form_data['text'] ?></textarea>
                        </div>
                        <div class="row_cap">
                            <p>Нажимая на кнопку Отправить, я даю <a target="_blank" href="<?php echo $personaldata;?>">согласие на обработку персональных данных</a></p>
                        </div>
                        <div class="call_submit">Отправить</div>
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
        -->

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
                        <div class="preheader_divider"></div>
                        <div class="prehead_work">
                            <span class="prehead_cap">Мы работаем:</span>
                            <span class="prehead_val"><?= $worktime ?></span>
                        </div>
                        <div class="preheader_divider _second"></div>
                        <a href="#" class="js-call with_goal" rel="nofollow" goal="callme">
                            <div class="prehead_call">
                                <span class="prehead_val order_call js_modal" data-modal="modal_call">Заказать звонок</span>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        <?php }?>

        <header class="header container">
            
            <div class="wrap_logo">
                <strong class="logo">
                    <?php if ($logo) { ?>
                        <?php if ($home == $og_url) { ?>
                            <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
                        <?php } else { ?>
                            <a href="<?php echo $home; ?>" title="<?php echo $name; ?>">
                                <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
                            </a>
                        <?php } ?>

                    <?php } else { ?>
                        <?php if ($home == $og_url) { ?>
                            <div class="logo_bg"></div>
                        <?php } else { ?>
                            <a href="<?php echo $home; ?>"><div class="logo_bg"></div></a>
                        <?php } ?>
                    <?php } ?>
                </strong>
                <div class="logo_slogan">
                    Производство и продажа<br/>стройматериалов
                </div>
            </div>

            <div class="tel">
                <a rel="nofollow" href="tel:<?php echo $telephone; ?>"><?php echo $telephone; ?></a>
                <?php if($telephone2){ ?>
                    <a rel="nofollow" href="tel:<?= $telephone2 ?>">&nbsp;&nbsp;<?= $telephone2 ?></a>
                <?php }?>
                
            </div>

            <?php if($class != "checkout-cart"){ ?>
                <div class="header_email">
                    <a href="mailto:<?= $email_site ?>"><?= $email_site ?></a>
                </div>
            <?php }?>
            <!--
            <div class="line"></div>
            <div class="schedule">
                <span>Мы работаем:</span>
                <p>
                    <?= $worktime ?>
                </p>
            </div>
            
            <a class="btn-request-call">Заказать звонок</a>
            -->
            <?php if($class != "checkout-cart"){ ?>
                <?= $cart ?>
            <?php }?>
            
            <a class="btn-nav">
                <span>
                    <b></b>
                    <b></b>
                    <b></b>
                </span>
            </a>
        </header>
        <div class="container container-nav">
            <nav class="nav">
                <ul itemscope itemtype="http://www.schema.org/SiteNavigationElement">
                    <?php $cnt = 0; $ttl = count($top_menu);?>
                    <?php foreach ($top_menu as $item) : ?>
                        <?php 
                            if (isset($item['target']) && trim($item['target']) != "") {
                                $target=" target=".$item['target'];
                            }else{
                                $target="";
                            }
                        ?>
                        
                        <?php if($item['isactive']){?>
                            <li class="active" itemprop="name">
                                <span><?php echo $item['name']; ?></span>
                            </li>
                        <?php }else{?>
                            <li class="menu_li" itemprop="name">
                                <a itemprop="url" href="<?php echo $item['href']; ?>" <?php echo $target; ?>><?php echo $item['name']; ?></a>
                            </li>
                        <?php }?>

                        <?php $cnt++;?>
                        <?php if( $cnt != $ttl): ?>
                        <li class="separator"></li>
                        <?php endif;?>
                    <?php endforeach; ?>
                </ul>
            </nav>
        </div>

