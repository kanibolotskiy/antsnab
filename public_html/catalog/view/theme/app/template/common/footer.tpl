<footer class="footer">
    <div class="container">
        <div class="footer-left">
            <div class="soc">
                <span>Мы в соцсетях:</span>
                <ul>
                    <li>
                        <a target="_blank" href="https://vk.com/antsnab" rel="nofollow">
                            <img src="/catalog/view/theme/app/img/soc1.png" alt="img">
                        </a>
                    </li>
                    <li>
                        <a target="_blank" href="https://www.facebook.com/antsnab.tk" rel="nofollow">
                            <img src="/catalog/view/theme/app/img/soc2.png" alt="img">
                        </a>
                    </li>
                    <li>
                        <a target="_blank" href="https://twitter.com/antsnab" rel="nofollow">
                            <img src="/catalog/view/theme/app/img/soc3.png" alt="img">
                        </a>
                    </li>
                </ul>
            </div>
            <p>© ООО "Ант-Снаб", 2012-2018.</p>
            <a href="">Карта сайта</a>
            <a href="<?=$confidence?>">Политика конфиденциальности</a>
        </div>
        <div class="footer-right">
            <nav class="footer-nav">
                <ul>
                    <?php foreach ($top_menu as $item) : ?>
                        <?php $active = ($item['isactive']) ? 'class="active"' : ""; ?>
                        <?php if (isset($item['target']) && trim($item['target']) != "") { ?>
                            <li>
                                <a <?= $active ?> href="<?php echo $item['href']; ?>" target="<?php echo $item['target']; ?>">
                                    <?php echo $item['name']; ?>
                                </a>
                            </li>
                        <?php } else { ?>
                            <li>
                                <a <?= $active ?> href="<?php echo $item['href']; ?>">
                                    <?php echo $item['name']; ?>
                                </a>
                            </li>
                        <?php } ?>
                    <?php endforeach; ?>
                </ul>
            </nav>
            <div class="footer-info">

                <p class="address"><?= $address ?></p>
                <div class="call-us">
                    <span>позвоните нам:</span>
                    <a rel="nofollow" href="tel:<?= $telephone ?>"><?= $telephone ?></a>
                </div>
                <div class="line"></div>
                <?php if( !empty($telephone2) ):?>
                <div class="call-us call-us2">
                    <span>бесплатный звонок по России</span>
                    <a rel="nofollow" href="tel:<?= $telephone2 ?>"><?= $telephone2 ?></a>
                </div>
                <?php endif;?>
                <a rel="nofollow" href="mailto:<?= $email ?>" class="mail"><?= $email ?></a>
            </div>
        </div>
    </div>
</footer>
<script src="/catalog/view/javascript/app/common.js"></script>
<script src="/catalog/view/javascript/app/easyResponsiveTabs.js"></script>
<script src="/catalog/view/javascript/app/inputmask.min.js"></script>
<script src="/catalog/view/javascript/app/inputmask.phone.extensions.js"></script>

<?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
<?php } ?>
<!-- <script src="https://www.google.com/recaptcha/api.js"></script>-->
<!-- @task Счетчики, виджеты (comagic) -->
</body>
</html>
