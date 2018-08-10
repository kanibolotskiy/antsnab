<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="container container-nav">
        <nav class="nav">

            <ul>
                <li><a class="active" href="">Главная</a></li>
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
            </ul>
        </nav>
    </div>
    <div class="container main">
        <div class="content">
            <div class="bread-crumbs">
                <ul>
                    <li class="home"><a href=""><i class="material-icons">home</i></a></li>
                    <li>
                        <a href="">Главная</a>
                    </li>
                    <li class="interval">...</li>
                    <li>Прайс-лист</li>
                </ul>
            </div>
            <div class="price-list">
                <div class="title">Прайс-лист</div>
                <p>На этой странице можно посмотреть или скачать свежий прайс-лист ООО «ТК Ант-Снаб».

                    Цены на сайте всегда актуальны. Обновление происходит, как правило, в пятницу.</p>
                <div class="download download3">
						<span>Скачать прайс-лист:
</span>
                    <ul>
                        <li>
                            <a href=""></a>
                        </li>
                        <li>
                            <a href=""></a>
                        </li>
                    </ul>
                </div>
                <div class="select-list">
                    <ul>
                        <li>
                            <strong>Выберите категорию:</strong>
                            <select id="seldef50" title="Выберите категорию:">
                                <option>Выберите категорию:</option>
                            </select>
                        </li>
                        <li>
                            <strong>Выберите товар:</strong>
                            <select id="seldef51" title="Выберите товар:">
                                <option>Выберите товар:</option>
                            </select>
                        </li>
                        <li>
                            <strong>Выберите цену:</strong>
                            <select id="seldef52" title="Выберите цену:">
                                <option>Выберите цену:</option>
                            </select>
                        </li>
                    </ul>
                </div>
                <div class="dop-title">Битумные рулонные материалы > Рязанский КРЗ</div>
                <div class="table table4">
                    <div class="top-table">
                        <div class="top-table-block">
                            <table>
                                <thead>
                                <tr>
                                    <th>Продукт</th>
                                    <th class="hide_on_mobile">Упаковка</th>			                    <th class="column-price column-price-1" style="display: table-cell;">Цена за м<sup>2</sup></th>
                                    <th class="column-price column-price-1" style="display: table-cell;">Оптовая цена<br>за м<sup>2</sup><b>? <em>Оптовая цена на мастику действительна при единовременной оплате 100 шт</em></b></th>
                                    <th class="column-price column-price-2" style="display: none;">Цена за рулон</th>
                                    <th class="column-price column-price-2" style="display: none;">Оптовая цена<br>за рулон<b>? <em>Оптовая цена на мастику действительна при единовременной оплате 100 шт</em></b></th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <table class="fix-header">
                        <thead>
                        <tr>
                            <th>Продукт</th>
                            <th class="hide_on_mobile">Упаковка</th>			                    <th class="column-price column-price-1" style="display: table-cell;">Цена за м<sup>2</sup></th>
                            <th class="column-price column-price-1" style="display: table-cell;">Оптовая цена<br>за м<sup>2</sup><b>? <em>Оптовая цена на мастику действительна при единовременной оплате 100 шт</em></b></th>
                            <th class="column-price column-price-2" style="display: none;">Цена за рулон</th>
                            <th class="column-price column-price-2" style="display: none;">Оптовая цена<br>за рулон<b>? <em>Оптовая цена на мастику действительна при единовременной оплате 100 шт</em></b></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td colspan="4" class="text-row">
                                <h3><a href="/products/roll/krz/elastoizol-premium/">Эластоизол Премиум</a></h3>
                            </td>
                        </tr>
                        <?php foreach ($products as $product) {  ?>
                        <tr>
                            <td><a href="/products/roll/krz/elastoizol-premium/ekp-50/" class="no-formated"><?php echo $product['name']; ?></a></td>
                            <td class="hide_on_mobile"><?php echo $product['nameI'] . ' ' . number_format($product['calcKoef'], 2, ',', '') . ' ' . $product['nameR']; ?></td>
                            <td class="column-price column-price-1" style="display: table-cell;"><?php echo number_format($product['price'], 2, ',', ''); ?> р.</td>
                            <td class="column-price column-price-1" style="display: table-cell;"><?php echo number_format($product['price_wholesale'], 2, ',', ''); ?> р.</td>
                            <td class="column-price column-price-2" style="display: none;">1 466.60 р.</td>
                            <td class="column-price column-price-2" style="display: none;">1 398.10 р.</td>
                        </tr>
                        <?php } ?>
                        </tbody>
                    </table>
                </div>
                <div class="discounts">
                    <span>С 3 февраля 2016 года снизились цены на рулонные кровельные материалы ТехноНиколь:</span>
                    <ul>
                        <li>Цены на рулонные материалы Рязанского КРЗ указаны в рублях с учетом НДС;</li>
                        <li>Цены указаны с учетом самовывоза с завода в г. Рязань. Стоимость доставки уточняйте у менеджеров;</li>
                        <li>Оптовые цены действительны только при 100% предоплате;</li>
                        <li>Возможно производство наплавляемых материалов с посыпкой различных цветов;</li>
                        <li>Некоторые позиции производятся под заказ, наличие и актуальность цен уточняйте в офисе.</li>
                    </ul>
                </div>
            </div>
            <div class="news news2">
                <div class="title-news">Свежие новости</div>
                <ul>
                    <li>
                        <a href="">Снизились цены на гидроизол
                            и OSB</a>
                        <img src="img/img1.jpg" alt="img">
                        <div class="news-text">
                            <span>14.03.2016</span>
                            <p>С 1 февраля на
                                рулонные кровельные
                                материалы
                                действовали скидки.</p>
                        </div>
                    </li>
                    <li>
                        <a href="">Снизились цены на фанеру</a>
                        <img src="img/img2.jpg" alt="img">
                        <div class="news-text">
                            <span>26.02.2016</span>
                            <p>Новость сегодня
                                неоднозначная.
                                Наверняка, по
                                картинке все уже...</p>
                        </div>
                    </li>
                    <li>
                        <a href="">Снижение цен на рулонные
                            кровельные материалы</a>
                        <img src="img/img3.jpg" alt="img">
                        <div class="news-text">
                            <span>14.03.2016</span>
                            <p>С 1 февраля на
                                рулонные кровельные
                                материалы
                                действовали скидки.</p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
<?= $footer ?>