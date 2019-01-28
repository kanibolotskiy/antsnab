<!doctype html>
<!--[if IE 9]><html lang="en" class="no-js ie9"><![endif]-->
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


        <link href="/catalog/view/theme/app/bundle/app2.css" rel="stylesheet">
        <?php if ($description) { ?>
            <meta name="description" content="<?php echo $description; ?>" />
        <?php } ?>
        <?php if ($keywords) { ?>
            <meta name="keywords" content= "<?php echo $keywords; ?>" />
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
    <body>
        <?php if (true === $thank_you): ?>
            <!-- Thank you form -->
            <div class="popup thank-you visible" >
                <div class="close"></div>
                <div class="popup-block">
                    <div class="popup-content">
                        <div class="close2"></div>
                        <span>Благодарим вас за обращение!</span>
                        <!--@task1 to css-->
                        <p style="text-align: center">Мы свяжемся с вами в ближайшее время!</p>
                    </div>
                </div>
            </div>
        <?php endif; ?>
        <?php $visible = (!empty($form_errors) ) ? 'visible' : ''; ?>
        <div class="popup <?= $visible ?>">
            <div class="close"></div>
            <div class="popup-block">
                <div class="popup-content">
                    <div class="close2"></div>
                    <form id="call_form" action="<?= $action ?>" method="post">
                        <input type="hidden" name="redirect" value="<?= $redirect ?>"/>

                        <span>Оставьте свои данные и сообщение, мы свяжемся с Вами в ближайшее время</span>

                        <?php if (isset($form_errors['name'])): ?>
                            <i class="error"><?= $form_errors['name'] ?></i>
                            <input value="<?= $form_data['name'] ?>" class="error" name="name" type="text" placeholder="Имя"/>
                        <?php else: ?>    
                            <input value="<?= $form_data['name'] ?>" name="name" type="text" placeholder="Имя"/>
                        <?php endif; ?>

                        <?php if (isset($form_errors['phone'])): ?>
                            <i class="error"><?= $form_errors['phone'] ?></i>
                            <input value="<?= $form_data['phone'] ?>" class="error" name="phone" type="text" placeholder="Телефон"/>
                        <?php else: ?>    
                            <input  value="<?= $form_data['phone'] ?>" name="phone" type="text" placeholder="Телефон"/>
                        <?php endif; ?>
                        

                        <input value="<?= $form_data['workemail'] ?>" name="workemail" type="text" placeholder="Рабочий email"/>

                        <?php if (isset($form_errors['text'])): ?>
                            <i class="error"><?= $form_errors['text'] ?></i>
                            <textarea placeholder="Сообщение" class="error" name="text"><?= $form_data['text'] ?></textarea>
                        <?php else: ?>    
                            <textarea placeholder="Сообщение" name="text"><?= $form_data['text'] ?></textarea>
                        <?php endif; ?>
                         <!--<input
                            type ="submit"
                            
                            data-callback="submitCallForm" value="Отправить"/>-->
                        <input
                            type ="submit"
                            class="g-recaptcha"
                            data-sitekey="<?= $captcha_key ?>"
                            data-callback="submitCallForm" value="Отправить"/>
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

        <a href="" class="up"></a>
        <header class="header container">

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

            <div class="tel">
                <a rel="nofollow" href="tel:<?php echo $telephone; ?>"><?php echo $telephone; ?></a>
                <a rel="nofollow" href="tel:<?= $telephone2 ?>"><?= $telephone2 ?></a>
                <a class="btn-request-call">Заказать звонок</a>
            </div>
            <div class="line"></div>
            <div class="schedule">
                <span>Мы работаем:</span>
                <p>
                    <?= $worktime ?>
                </p>
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
                    <?php $cnt = 0; $ttl = count($top_menu);?>
                    <?php foreach ($top_menu as $item) : ?>
                        <?php $active = ($item['isactive']) ? 'class="active"' : ""; ?>
                        <?php if (isset($item['target']) && trim($item['target']) != "") { ?>
                            <li>
                                <a <?= $active ?> href="<?php echo $item['href']; ?>" target="<?php echo $item['target']; ?>"><?php echo $item['name']; ?></a>
                            </li>
                        <?php } else { ?>
                            <li>
                                <a <?= $active ?> href="<?php echo $item['href']; ?>">
                                    <?php echo $item['name']; ?>
                                </a>
                            </li>
                        <?php } ?>
                        <?php $cnt++;?>
                        <?php if( $cnt != $ttl): ?>
                        <li class="separator"></li>
                        <?php endif;?>
                    <?php endforeach; ?>
                </ul>
            </nav>
        </div>

