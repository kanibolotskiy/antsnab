<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        
        <?php echo $content_top; ?>
        <div class="article-content content-text">
            <h1 class="title"><?php echo $heading_title; ?></h1>
            <div class="wrapper_about">
                <?php foreach($about_block as $key_row=>$row_block){ ?>
                    <div class="row_about">
                        <div class="left_about">
                            <?php if($row_block['data']['image']){?>
                                <img src="image/<?=$row_block['data']['image']?>" alt="<?=$row_block['data']['caption']?>" title="<?=$row_block['data']['caption']?>"/>
                            <?php }?>
                        </div>
                        <div class="content_about">
                            <div class="content_about_inf">
                                <?php if($row_block['data']['caption']) {?>
                                    <div class="content_about_caption"><span><?=$row_block['data']['caption']?></span></div>
                                <?php }?>
                                
                                <div class="content_about_text">
                                    <?= html_entity_decode($row_block['data']['text'], ENT_COMPAT, 'UTF-8')?>
                                </div>
                                <div class="content_about_mcaption">
                                    <?= $row_block['data']['subcaption']?>
                                </div>
                            </div>
                            <?php if($row_block['list']){?>
                                <div class="history_captions">  
                                    <?php foreach($row_block['list'] as $key=>$row){?>
                                        <div class="history_caption <?=!$key?'active':''?>" rel="<?php echo $key_row.'_'.$key;?>">
                                            <?= $row['caption']?>
                                        </div>
                                    <?php } ?>
                                </div>
                                <div class="history_blocks">
                                    <?php foreach($row_block['list'] as $key=>$row){?>
                                        <div class="m_block">
                                            <div class="mob_caption <?=!$key?'active':''?>" rel="<?php echo $key_row.'_'.$key;?>">
                                                <?=$row['caption']?>
                                            </div>
                                            <div class="history_block <?=!$key?'active active_mob':''?>" rel="<?php echo $key_row.'_'.$key;?>">
                                                <?= html_entity_decode($row['text'], ENT_COMPAT, 'UTF-8')?>
                                            </div>
                                        </div>
                                    <?php } ?>
                                </div>
                            <?php }?>
                        </div>
                    </div>
                <?php }?>

                <?=$description?>
                
                <?php if($customers){?>
                    <h2>Наши сотрудники</h2>
                    <div class="wrap_media_slider">
                        <div class="media_slider">
                                <?php foreach($customers as $customer){?>
                                    <div class="media_slider_row">
                                        <div class="customers_row">
                                            <div class="customers_row_image">
                                                
<picture>
    <source type="image/webp" srcset="<?=$customer['thumb_webp']?>">
    <source type="image/jpeg" srcset="<?=$customer['thumb']?>">
    <img src="<?=$customer['thumb']?>" alt="<?=$customer['fio']?>" title="<?=$customer['fio']?>"/>
</picture>
                                            </div>
                                            <div class="customers_row_info">
                                                <div class="customers_row_ttl"><?=$customer['fio']?></div>
                                                <div class="customers_row_pos"><?=$customer['position']?></div>
                                                <div class="customers_row_phone">
                                                    <div class="customers_row_phone_val"><?=$customer['phone']?></div>
                                                    <?php if($customer['code']){ ?>
                                                        <div class="customers_row_phone_code"> доб.<?=$customer['code']?></div>
                                                    <?php }?>
                                                </div>
                                                <?php if($customer['email']) { ?>
                                                    <div class="customers_row_email">
                                                        <a href="mailto:<?=$customer['email']?>"><?=$customer['email']?></a>
                                                    </div>
                                                <?php }?>
                                            </div>
                                        </div>
                                    </div>
                                <?php }?>
                        </div>
                    </div>
                    <div class="media_text content-text">
                        <?=$content_cust?>
                    </div>
                <?php }?>
                
                <?php if($off){?>
                    <h2>Наш офис</h2>
                    <div class="wrap_media_slider">
                        <div class="media_slider media_slider_height">
                        <?php foreach($off as $off_row){?>
                            <div class="media_slider_row">
                                <div class="off_row <?php echo ($off_row['video']?'_video':'');?>">
                                    <a href="<?=$off_row['url']?>" data-fancybox="office" data-caption="<?=$off_row['caption']?>">
                                        <div class="off_image">
<picture>
    <source type="image/webp" srcset="<?=$off_row['thumb_webp']?>">
    <source type="image/jpeg" srcset="<?=$off_row['thumb']?>">
    <img src="<?=$off_row['thumb']?>" alt="<?=$off_row['caption']?>" title="<?=$off_row['caption']?>"/>
</picture>
                                            
                                        </div>
                                    </a>
                                </div>
                            </div>
                        <?php }?>
                        </div>
                    </div>
                    <div class="media_text content-text">
                        <?=$content_off?>
                    </div>
                <?php }?>

                <?php if($man){?>
                    <h2>Производство</h2>
                    <div class="wrap_media_slider">
                        <div class="media_slider media_slider_height">
                        <?php foreach($man as $man_row){?>
                            <div class="media_slider_row">
                                <div class="off_row <?php echo ($man_row['video']?'_video':'');?>">
                                    <a href="<?=$man_row['url']?>" data-fancybox="manufacture" data-caption="<?=$man_row['caption']?>">
                                        <div class="off_image">
                                            
<picture>
    <source type="image/webp" srcset="<?=$man_row['thumb_webp']?>">
    <source type="image/jpeg" srcset="<?=$man_row['thumb']?>">
    <img src="<?=$man_row['thumb']?>" alt="<?=$man_row['caption']?>" title="<?=$man_row['caption']?>"/>
</picture>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        <?php }?>
                        </div>
                    </div>
                    <div class="media_text content-text">
                        <?=$content_man?>
                    </div>
                <?php }?>
                
                <?php if($sklad){?>
                    <h2>Склады</h2>
                    <div class="wrap_media_slider">
                        <div class="media_slider media_slider_height">
                        <?php foreach($sklad as $sklad_row){?>
                            <div class="media_slider_row">
                                <div class="off_row <?php echo ($sklad_row['video']?'_video':'');?>">
                                    <a href="<?=$sklad_row['url']?>" data-fancybox="sklad" data-caption="<?=$sklad_row['caption']?>">
                                        <div class="off_image">
<picture>
    <source type="image/webp" srcset="<?=$sklad_row['thumb_webp']?>">
    <source type="image/jpeg" srcset="<?=$sklad_row['thumb']?>">
    <img src="<?=$sklad_row['thumb']?>" alt="<?=$sklad_row['caption']?>" title="<?=$sklad_row['caption']?>"/>
</picture>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        <?php }?>
                        </div>
                    </div>
                    <div class="media_text content-text">
                        <?=$content_sklad?>
                    </div>
                <?php }?>
                
                <h2>Наши сертификаты</h2>
                <div class="masonry" id="masonry">
                    <?php foreach($sert as $sert_row) {?>
                        <div class="masonry_item">
                            <a href="<?=$sert_row['image']?>" data-fancybox="sert" data-caption="<?=$sert_row['caption']?>">
                                
<picture>
    <source type="image/webp" srcset="<?=$sert_row['thumb_webp']?>">
    <source type="image/jpeg" srcset="<?=$sert_row['thumb']?>">
    <img src="<?=$sert_row['thumb']?>" title="<?=$sert_row['caption']?>" alt="<?=$sert_row['caption']?>">
</picture>                                
                            </a>
                        </div>
                    <?php }?>
                </div>
                <h2>Наши реквизиты и документы</h2>
                <div class="media_text content-text">
                    <?=$content_req?>
                </div>
                <?php if(isset($files)) {?>
                    <div class="tovar_files">
                        <?php foreach($files as $file){?>
                            <a class="download" target="_blank" href="<?php echo $file['file_link'];?>"><?php echo $file['name'];?></a>
                        <?php }?>
                    </div>
                <?php }?>
                <?php if(isset($feedbackform)){ 
                    if($feedbackform){
                        include __DIR__ . '/../partial/feedbackform.tpl';
                    }
                }?>


                
            </div>
        </div>
        
       

        <?php echo $content_bottom; ?>
        
    </div>
</div>


<?= $footer ?>