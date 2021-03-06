<!doctype html>
<!--[if IE 9]><html lang="ru" xmlns:og="http://ogp.me/ns#" class="no-js ie9"><![endif]-->
<!--[if (gte IE 9) | !(IE)]><!--><html lang="ru" class="no-js"><!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><?php echo $title; ?></title>
        <base href="<?php echo $base; ?>" />

        <!--
        <link rel="shortcut icon" href="/favicon.ico" >
        <link rel="icon" type="image/png" href="/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="/favicon-16x16.png" sizes="16x16">
        <link rel="manifest" href="/manifest.json">
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
        <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5">
        -->
        <link rel="shortcut icon" href="/favicon.ico" >
<link rel="apple-touch-icon" sizes="57x57" href="/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-icon-180x180.png">
<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5">
<link rel="icon" type="image/png" sizes="192x192"  href="/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
<link rel="manifest" href="/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">

    
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;1,300&display=swap" rel="stylesheet">
<!--
        <link href="../catalog/view/theme/app/fonts/rouble-webfont.eot" rel="preload" as="font" type="font/eot" crossorigin>
        <link href="../catalog/view/theme/app/fonts/rouble-webfont.woff2" rel="preload" as="font" type="font/woff2" crossorigin>
        <link href="../catalog/view/theme/app/fonts/rouble-webfont.woff" rel="preload" as="font" type="font/woff" crossorigin>
        <link href="../catalog/view/theme/app/fonts/rouble-webfont.ttf" rel="preload" as="font" type="font/ttf" crossorigin>
-->
        <link rel="preload" as="style" href="/catalog/view/theme/app/bundle/app2.css" >
        <link rel="preload" as="script" href="catalog/view/theme/app/bundle/app2.js" >

        <link rel="stylesheet" href="/catalog/view/theme/app/bundle/app2.css?v<?php echo filectime('catalog/view/theme/app/bundle/app2.css');?>">

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
                    <div class="logo">
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
                    </div>
                </div>
                <?php if($class != "checkout-cart"){ ?>
                    <div class="header_email">
                        <a href="mailto:<?= $email_site ?>"><?= $email_site ?></a>
                    </div>
                <?php }?>
                <div class="tel">
                    <a href="tel:<?= $telephone_link ?>"><?php echo $telephone; ?></a>
                    <?php if($telephone2){ ?>
                        <a href="tel:<?= $telephone2_link ?>">&nbsp;&nbsp;<?= $telephone2 ?></a>
                    <?php }?>
                    
                </div>
                <div class="js-call with_goal" data-goal="callme">
                    <div class="prehead_call">
                        <span class="prehead_val order_call js_modal" data-modal="modal_call">Заказать звонок</span>
                    </div>
                </div>
                
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
                            <?php if($item["href"]=='/sales/'){$classMenu='_menu_accia';?>
                            <?php }else{$classMenu='';}?>
                            <?php 
                                if (isset($item['target']) && trim($item['target']) != "") {
                                    $target=" target=".$item['target'];
                                }else{
                                    $target="";
                                }
                            ?>
                            
                            <?php if($item['isactive']){?>
                                <li class="active <?=$classMenu?>" itemprop="name">
                                    <span><?php echo $item['name']; ?></span>
                                </li>
                            <?php }else{?>
                                <li class="menu_li <?=$classMenu?>" itemprop="name">
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

