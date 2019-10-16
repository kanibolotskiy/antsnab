<div class = "reviews-container">

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
                        <p><a class="telephone_link" href="tel:<?= $telephone ?>"><?= $telephone ?></a></p>
                        <?php if (!empty($fax)): ?>
                            <p><a class="telephone_link" href="tel:<?= $fax ?>"><?= $fax ?></a> — бесплатно по РФ</p>
                        <?php endif; ?>
                    </li>
                    <li>
                        <p>E-mail</p>
                        <a href="mailto:<?= $email_site ?>"><?= $email_site ?></a>
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
                                        <p><?= $l['address'] ?></p>
                                        <p><?= $l['open'] ?></p>
                                        
                                        <div class="map map_data">
                                            <?php echo trim($l['map']);?>
                                        </div>
                                        
                                        <?php foreach($l['files'] as $locaction_file){ ?>
                                            <a target="_blank" href="<?php echo $locaction_file['file_link'];?>" class="download-map">Скачать подробную карту</a>
                                        <?php }?>

                                    </div>
                                </div>
                                <?php $cnt++ ?>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
            <?php endif; ?>
            
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
                        <p>Нажимая на кнопку Отправить, я даю <a target="_blank" href="http://antsnab.cp06038.tmweb.ru/agreement/">согласие на обработку персональных данных</a></p>
                    </div>
                    <div id="feedback_submit" class="call_submit">Отправить</div>
                </form>
            </div>

        </div>
    </div>
</div>
