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
                        <p><?= $telephone ?></p>
                        <?php if (!empty($fax)): ?>
                            <p><?= $fax ?> — бесплатно по РФ</p>
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
            
            <?php  
                include __DIR__ . '/../partial/feedbackform.tpl';
            ?>

        </div>
    </div>
</div>
