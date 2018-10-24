<div class = "reviews-container">
<div class="container main">
    <div class="content">
        <div class="contacts-container">
            <a target="blank" href="<?=$rekviziti?>" class="requisites">Наши реквизиты</a>
            <div class="contacts-block">
                <ul>
                    <li>
                        <p>
                            <?php echo $open ?>
                        </p>
                    </li>
                    <li>
                        <p>
                            <?php echo $address ?>
                        </p>
                    </li>
                    <li>
                        <p><?= $telephone ?></p>
                        <?php if (!empty($fax)): ?>
                            <p><?= $fax ?> — бесплатный звонок по России</p>
                        <?php endif; ?>
                    </li>
                    <li>
                        <p>E-mail</p>
                        <a href="mailto:<?= $shop_email ?>"><?= $shop_email ?></a>
                    </li>
                </ul>
            </div>

            <?php if ($locations) : ?>
                <div class="contacts-tabs">
                    <div id="mtab1" class="tab">
                        <ul class="tabset multi-tabset">
                            <?php $cnt = 0 ?>
                            <?php foreach ($locations as $l): ?>
                                <?php if ($cnt === 0): ?>
                                    <li><a href="#m1tab<?= $cnt ?>" class="active"><?= $l['name'] ?></a></li>
                                <?php else: ?>
                                    <li><a href="#m1tab<?= $cnt ?>" ><?= $l['name'] ?></a></li>
                                <?php endif; ?>
                                <?php $cnt++ ?>
                            <?php endforeach; ?>
                        </ul>
                        <!-- @task1 to css replace #map -->
                        <style>
                            .map {
                                border: 2px solid #EFEEEC;
                                margin-top: 24px;
                                width: 100%;
                                height: 400px;
                                margin-bottom: 30px;
                            }
                        </style>
                        <div class="tab-list">
                            <?php $cnt = 0; ?>
                            <?php foreach ($locations as $l): ?>
                                <div id="m1tab<?= $cnt ?>" >
                                    <div class="contacts-tab">
                                        <p><?= $l['address'] ?></p>
                                        <p><?= $l['open'] ?></p>
                                        <?php if (!empty($l['latitude']) && !empty($l['longitude'])): ?>
                                            <div id="map<?= $cnt ?>" class="map">
                                            </div>
                                            <script>
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    ymaps.ready(init);
                                                    function init() {
                                                        var map = new ymaps.Map("map<?= $cnt ?>", {
                                                            center: [<?= $l['latitude'] ?>, <?= $l['longitude'] ?>],
                                                            zoom: 15
                                                        });
                                                        var myPlacemark = new ymaps.Placemark(
                                                                [<?= $l['latitude'] ?>,<?= $l['longitude'] ?>],
                                                                {hintContent: "<?=$l['name']?>"}
                                                        );
                                                        map.geoObjects.add(myPlacemark);
                                                    }
                                                });
                                            </script>
                                        <?php endif; ?>
                                        <!-- @task1 hardcoded -->
                                        <a target="_blank" href="/system/storage/download/sklad-a-plan.pdf.JDa4QZE4AmF8uHtfdkmwjUdNYVGJGEAd" class="download-map">Скачать подробную карту</a>
                                    </div>
                                </div>
                                <?php $cnt++ ?>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </div>
</div>
</div>