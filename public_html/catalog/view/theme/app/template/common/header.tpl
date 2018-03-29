<!doctype html>
<!--[if IE 9]><html lang="en" class="no-js ie9"><![endif]-->
<!--[if (gte IE 9) | !(IE)]><!--><html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><?php echo $title; ?></title>
        <base href="<?php echo $base; ?>" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="/catalog/view/theme/app/css/main.css" rel="stylesheet">

        <?php if ($description) { ?>
            <meta name="description" content="<?php echo $description; ?>" />
        <?php } ?>
        <?php if ($keywords) { ?>
            <meta name="keywords" content= "<?php echo $keywords; ?>" />
        <?php } ?>
        <meta property="og:title" content="<?php echo $title; ?>" />
        <meta property="og:type" content="website" />
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
        <!-- @task Добавить поддержку иконок для телефонов -->
        <?php foreach ($scripts as $script) { ?>
            <script src="<?php echo $script; ?>" type="text/javascript"></script>
        <?php } ?>
    </head>
    <body>

        <a href="" class="up"></a>
        <header class="header container">
            <strong class="logo">
                <!-- @task переверстать лого (убрать background, растянуть изображение -->
                <?php if ($logo) { ?>
                    <?php if ($home == $og_url) { ?>
                        <img width="100%" src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>"/>
                    <?php } else { ?>
                        <a href="<?php echo $home; ?>">
                            <img width="100%" src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>"/>
                        </a>
                    <?php } ?>
                <?php } else { ?>
                    <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
                <?php } ?>
            </strong>
            <div class="tel">
                <a href="tel:<?php echo $telephone; ?>"><?php echo $telephone; ?></a>
                <a href="tel:8 (800) 775-28-31"><?= $telephone2 ?></a>
                <a class="btn-request-call">Заказать звонок</a>
            </div>
            <div class="line"></div>
            <div class="schedule">
                <span>Мы работем:</span>
                <?= $worktime ?>
            </div>
            <a class="btn-request-call">Заказать звонок</a>
            <?= $cart ?>
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
                <ul>
                <!-- @task исправить верстку (левый край выравн) -->
                <?php foreach ($top_menu as $item) : ?>
                    <?php $active = ($item['isactive'])?'class="active"':""; ?>
                    <?php if (isset($item['target']) && trim($item['target']) != "") { ?>
                        <li>
                            <a <?=$active?> href="<?php echo $item['href']; ?>" target="<?php echo $item['target']; ?>"><?php echo $item['name']; ?></a>
                        </li>
                    <?php } else { ?>
                        <li>
                            <a <?=$active?> href="<?php echo $item['href']; ?>">
                                <?php echo $item['name']; ?>
                            </a>
                        </li>
                    <?php } ?>
                <?php endforeach; ?>
                </ul>


                <!--<ul>
                    <li><a  href="">Главная</a></li>
                    <li class="separator"></li>
                    <li><a href="">О компании</a></li>
                    <li class="separator"></li>
                    <li><a href="">Прайс-лист</a></li>
                    <li class="separator"></li>
                    <li><a href="">Статьи</a></li>
                    <li class="separator"></li>
                    <li><a href="">Новости</a></li>
                    <li class="separator"></li>
                    <li><a href="">Отзывы</a></li>
                    <li class="separator"></li>
                    <li><a href="">Контакты</a></li>
                </ul>-->
            </nav>
        </div>

