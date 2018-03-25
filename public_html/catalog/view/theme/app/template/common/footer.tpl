<footer class="footer">
    <div class="container">
        <div class="footer-left">
            <div class="soc">
                <span>Мы в соцсетях:</span>
                <ul>
                    <li><a href=""><img src="/catalog/view/theme/app/img/soc1.png" alt="img"></a></li>
                    <li><a href=""><img src="/catalog/view/theme/app/img/soc2.png" alt="img"></a></li>
                    <li><a href=""><img src="/catalog/view/theme/app/img/soc3.png" alt="img"></a></li>
                    <li><a href=""><img src="/catalog/view/theme/app/img/soc4.png" alt="img"></a></li>
                </ul>
            </div>
            <p>© ООО "Ант-Снаб", 2012-2016.</p>
            <a href="">Карта сайта</a>
        </div>
        <div class="footer-right">
            <nav class="footer-nav">
                <ul>
                    <li><a href="">Главная</a></li>
                    <li><a href="">Каталог</a></li>
                    <li><a href="">О компании</a></li>
                    <li><a href="">Прайс-лист</a></li>
                    <li><a href="">Статьи</a></li>
                    <li><a href="">Новости</a></li>
                    <li><a href="">Отзывы</a></li>
                    <li><a href="">Контакты</a></li>
                </ul>
            </nav>
            <div class="footer-info">
                <p class="address">127566, г. Москва,
                    Высоковольтный проезд,
                    дом 1, строение 43</p>
                <div class="call-us">
                    <span>позвоните нам:</span>
                    <a href="tel:+7 (495) 255-01-37"> +7 (495) 255-01-37</a>
                </div>
                <div class="line"></div>
                <div class="call-us call-us2">
                    <span>бесплатный звонок по России</span>
                    <a href="tel:8 (800) 775-28-31">8 (800) 775-28-31</a>
                </div>
                <a href="mailto:info@ant-snab.ru" class="mail">info@ant-snab.ru</a>
            </div>
        </div>
    </div>
</footer>


<div class="popup">
    <div class="close"></div>
    <div class="popup-block">
        <div class="popup-content">
            <div class="close2"></div>
            <form action="">
                <span>Оставьте свои данные и сообщение, мы свяжемся с Вами в ближайшее время</span>
                <input type="text" value="Имя">
                <input type="text" value="Телефон">
                <textarea>Сообщение</textarea>
                <input type="submit" value="Отправить">
            </form>
        </div>
    </div>
</div>

<script src="/catalog/view/javascript/app/common.js"></script>
<?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
<?php } ?>
<!-- @task Счетчики, виджеты (comagic) -->
</body>
</html>
