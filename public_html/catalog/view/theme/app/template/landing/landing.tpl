<?=$head?>
<header class="_grad">
    <?=$header?>        
</header>

<div class="empty_block"></div>

    <!--Блок1-->
    <?php if(isset($block1_status) and $block1_status) {?>
    <section class="_grad block1 ">
        <div class="wrapper">
        
            <div class="_flex _vcenter wrapper_block1">
                <div class="block1_text">
                    
                    
                    <div class="block1_text_info ">
                        <div class="main_caption"><?=$block1_caption?></div>
                        <div class="block1_form">
                            <?php if(isset($block1_form_status) and $block1_form_status) {?>
                                <div class="main_discount">
                                    <?=$block1_form_caption?> 
                                    <div><span><?=$block1_form_text?></span></div>
                                </div>
                            <?php }?>
                            <?php if(isset($block1_form_status) and $block1_form_status) {?>
                            <div class="main_block1_form wrap_form" >
                                <form action="#" method="POST" data-goal="lp-send-form-up">
                                    <div class="wrap_form_phone _flex _between">
                                        <input class="inpF" type="hidden" name="landing" value="<?=$title?>"/>
                                        <input class="inpF" type="hidden" name="landing_id" value="<?=$landing_id?>"/>
                                        <input class="inpF" type="hidden" name="gf" value="1"/>
                                        <input class="inpF" type="text" name="workemail" value=""/>
                                        <input type="hidden" name="tp" value="1"/>
                                        <input type="phone" name="phone" class="inputForm inputPhone required" />                                            
                                        <button class="sendForm btn _orange phoneButton" type="submit">Получить предложение</button>
                                    </div>
                                </form>
                                <div class="form_thanks">
                                    <?=html_entity_decode($mailthanks)?>
                                </div>
                            </div>
                            <?php }?>
                        </div>
                    </div>
                    
                    
                </div>
                <div class="block1_img">
                    <div class="wrapper_block1_img">
                        <img class="lazyload" data-src="image/<?=$block1_image?>" />
                    </div>
                </div>
            </div>
        </div>
    </section>
    <?php }?>
    <?php if(isset($block2_status) and $block2_status) {?>
        <section class="container container_block2">
            <div class="wrapper">
                <div class="_flex wrapper_block2">
                    <div class="block2_img">
                        <div class="wrapper_block2_img">
                            <img class="lazyload" data-src="image/<?=$block2_image?>" />
                        </div>
                    </div>
                    <div class="block2_text">
                        <div class="block2_info">
                            <div class="block_caption"><?=$block2_caption?></div>
                            <div class="block_text">
                                <?=html_entity_decode($block2_text)?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    <?php }?>

    <?php if(isset($block3_status) and $block3_status) {?>
        <section class="container">
            <div class="wrapper">
                <div class="block_caption"><?=$block3_caption?></div>
                <div class="benefit_items _flex _wrap">
                    <?php foreach($block3_benefits as $block3_benefit){ ?>
                        <div class="benefit_itm">
                            <div class="benefit_itm_info">
                                <div class="benefit_ico"><img src="image/<?=$block3_benefit['image']?>" /></div>
                                <div class="benefit_text">
                                <?=html_entity_decode($block3_benefit['text'])?></div>
                            </div>
                        </div>
                    <?php }?>
                </div>
            </div>
        </section>
    <?php }?>
    <?php if(isset($tab)){ ?>
    <section class="container">
        <div class="wrapper">
            <div class="products_blocks">
                
                <?php foreach($tab as $key=>$tab_item){?>
                    <?php if(isset($products[$key])){ ?>
                        <div class="products_block">
                            <div class="product_caption_block _flex _between _vcenter">
                                <div class="block_caption"><?=$tab_item['caption']?></div>
                                <?php if($tab_item['file']) {?>
                                    <div class="block_down_button">
                                        <a class="js_goal" data-goal="lp-catalog-download" href="files/landing/<?=$tab_item['file']?>" download><?=$tab_item['button']?></a>
                                    </div>
                                <?php }?>
                            </div>
                        
                            <div class="product_items _flex _wrap">
                                <?php foreach($products[$key] as $product) {?>
                                
                                    <div class="product_itm">
                                        <div class="product_itm_info">
                                            <div class="product_img">
                                                <a href="<?=$product['alias']?>" title="<?=$product['name']?>">
                                                    <img src="<?=$product['thumb']?>" alt="<?=$product['name']?>"/>
                                                </a>
                                            </div>
                                            <div class="product_title">
                                                <a href="<?=$product['alias']?>" title="<?=$product['name']?>">
                                                    <?=$product['name']?>
                                                </a>
                                            </div>
                                            <div class="product_desc">
                                                 <?=html_entity_decode($product['description_mini'])?>
                                            </div>
                                            
                                            <div class="_flex _center pack_items _wrap">
                                                <?php foreach($product['products_links'] as $key=>$products_link){ ?>
                                                    <?php foreach($products_link as $product_link){?>
                                                        <?php if($key==1){?>
                                                            <div class="_flex _vcenter change_itm pack_itm color_itm <?=$product_link['product_id']==$product['product_id']?'active':''?>" data-id="<?=$product_link['product_id']?>">
                                                                <?php if($product_link['code']){?>
                                                                    <div class="color_block" style="background-color:#<?=$product_link['code']?>"></div>
                                                                <?php }else{?>
                                                                    <div class="color_block _transparent"></div>
                                                                <?php }?>
                                                                <div class="link_block_name"><?=$product_link['name']?></div>
                                                            </div>
                                                        <?php }else{?>
                                                            <div class="change_itm pack_itm <?=$product_link['product_id']==$product['product_id']?'active':''?>" data-id="<?=$product_link['product_id']?>">
                                                                <?=$product_link['name']?>
                                                            </div>
                                                        <?php }?>
                                                    <?php }?>
                                                <?php }?>
                                            </div>
                                            <?php if($product['price_str']){?>
                                                <div class="product_price"><?=$product['price_str']?></div>
                                            <?php }?>

                                            <?php if($prod_butt){ ?>
                                                <div class="wrap_blue_btn">
                                                    <div class="blue_btn open_popup_product js_goal" data-goal="lp-zayavka-catalog"><?=$prod_butt?></div>
                                                </div>
                                            <?php }?>
                                        </div>
                                    </div>
                                <?php }?>
                            </div>
                        </div>
                    <?php }?>
                <?php }?>
                
            </div>
        </div>
    </section>
    <?php }?>
    <?php if(isset($block_video_status) and $block_video_status) {?>
        <section class="_grey container">
            <div class="wrapper">
                <div class="block_caption"><?=$block_video_caption?></div>
                <div class="video_wrap">
                    <div class="_flex _wrap">
                        <?php foreach($video as $video_item){?>
                            <div class="video_itm">
                                <div class="video_itm_info">
                                    <a rel="nofollow" href="<?=$video_item['video']?>" data-fancybox="video" data-caption="<?=$video_item['video_caption']?>. #Видео">
                                        <div class="youtube_image">
                                            <img src="<?=$video_item['image']?>" />
                                        </div>
                                    </a>
                                    <div class="video_itm_caption"><?=$video_item['video_caption']?></div>
                                </div>
                            </div>
                        <?php }?>
                    </div>
                </div>
            </div>
        </section>
    <?php }?>

    <?php if(isset($block_cert_status) and $block_cert_status) {?>
        <section class="_grey container certificates_container">
            <div class="wrapper">
                
                <div class="_flex wrap_certificates">
                    <div class="cert_column_files">
                        <div class="block_caption"><?=$block_cert_caption?></div>
                        <div class="cert_rows">
                            <?php if($block_cert1_image){?>
                                <div class="cert_row _flex _vcenter">
                                    <div class="cert_row_info _flex _vcenter">
                                        <div class="cert_row_image">
                                            <a class="js_goal" data-goal="lp-sertifikat" href="image/<?=$block_cert1_image?>" data-fancybox="" data-caption="<?=$block_cert1_caption?>">
                                                <img src="image/<?=$block_cert1_image?>" />
                                            </a>
                                        </div>
                                        
                                    </div>
                                    <div class="wrp_row_caption _flex _between _vcenter">
                                        <div class="cert_row_caption"><?=$block_cert1_caption?></div>
                                        <div class="cert_row_open btn">
                                            <a class="js_goal" data-goal="lp-sertifikat" href="image/<?=$block_cert1_image?>" data-fancybox="certificates" data-caption="<?=$block_cert1_caption?>">Открыть</a>
                                        </div>
                                    </div>
                                </div>
                            <?php }?>
                            <?php if($block_cert2_image){?>
                                <div class="cert_row _flex _vcenter">
                                    <div class="cert_row_info _flex _vcenter">
                                        <div class="cert_row_image" >
                                            <a class="js_goal" data-goal="lp-sertifikat" href="image/<?=$block_cert2_image?>" data-fancybox="certificates" data-caption="<?=$block_cert2_caption?>">
                                                <img src="image/<?=$block_cert2_image?>" />
                                            </a>
                                        </div>                                        
                                        
                                    </div>
                                    <div class="wrp_row_caption _flex _between _vcenter">
                                        <div class="cert_row_caption"><?=$block_cert2_caption?></div>
                                        <div class="cert_row_open btn ">
                                            <a class="js_goal" data-goal="lp-sertifikat" href="image/<?=$block_cert2_image?>" data-fancybox="" data-caption="<?=$block_cert2_caption?>">Открыть</a>
                                        </div>
                                    </div>
                                </div>
                            <?php }?>
                        </div>
                    </div>
                    <div class="cert_column_bg">
                        <div class="wrapper_cert_img">
                            <img class="lazyload" data-src="image/<?=$block_cert_image?>" />
                        </div>
                    </div>
                </div>
            </div>
        </section>
    <?php }?>
    <?php if(isset($block_map_status) and $block_map_status) {?>
        <section class="_grey container wrap_map">
            <div class="wrapper">
                <div class="_flex map_container">
                    <div class="map_block_caption"><?=$block_map_caption?></div>
                    <div class="map_text">
                        <div class="block_caption"><?=$block_map_caption?></div>
                        <div class="map_content">
                            <?=html_entity_decode($block_map_text)?>
                        </div>
                    </div>
                    <div class="map_img">
                        <img src="image/<?=$block_map_image?>" />
                    </div>
                </div>
            </div>
        </section>
    <?php }?>
    <?php if(isset($block_sot_status) and $block_sot_status) {?>
        <section class="_grey container sot_container">
            <div class="wrapper">
                <div class="_flex _between coop">
                    <div class="coop_left">
                        <div class="block_caption"><?=$block_sot_caption?></div>
                        <div class="coop_caption"><?=$block_sot_subcaption?></div>
                    </div>
                    <div class="coop_right">
                        <div class="coop_text">
                            <?=html_entity_decode($block_sot_text)?>
                        </div>
                    </div>
                    <div class="coop_caption_mob"><?=$block_sot_subcaption?></div>
                </div>
            </div>
            <?php if($about){?>
                <div class="product_images _flex _center">
                    <?php foreach($about as $itm){ ?>
                        <div class="product_itm_image">
                            <img src="<?=$itm['image']?>" alt="<?=$itm['name']?>"/>
                        </div>
                    <?php }?>
                </div>
            <?php }?>
        </section>
    <?php }?>
    <?php if(isset($block_bform_status) and $block_bform_status) {?>
        <section class="container container_bottom_form" id="bottom_form">
            <div class="wrapper">
                <?=$bform?>
            </div>
        </section>
    <?php }?>
<div style="display:none;" id="landing_id" data-id="<?=$landing_id?>"></div>
<?=$footer?>



                                    
                                    