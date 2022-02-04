<?=$head?>
<header class="_grad">
    <?=$header?>        
</header>
<div class="empty_block"></div>
<section>
    <div class="wrapper">


<ul id="priceSwitcher" style="display:none;"
    data-base_vol="<?=$baseVol?>" 
    data-base_weight="<?=$baseWeight?>" 
    > 

    <li class="unitpack1" 
        data-sale_to_ui_koef="<?=$pUnits[1]['sale_to_ui_koef']?>" 
        
        data-nom=<?=$pUnits[1]['nom']?>
        data-denom=<?=$pUnits[1]['denom']?>
        
        data-ui_name = "<?=$pUnits[1]['name']?>"
        data-ui_name_plural = "<?=$pUnits[1]['name_plural']?>"
        data-ui_name_genitive = "<?=$pUnits[1]['name_package_dimension']?>"
        data-ui_descr="<?=$pUnits[1]['relStr']?>" >
        <a href="#"><?= $pUnits[1]['showName']?></a>
    </li>

    <?php if(isset($pUnits[2])):?>
    <li class="unitpack2" data-sale_to_ui_koef="<?=$pUnits[2]['sale_to_ui_koef']?>"
        <?php if($pUnits[2]['force_step_by_one'] == 1):?>
        data-ui_step = "1"
        <?php endif; ?>
        data-nom=<?=$pUnits[2]['nom']?>
        data-denom=<?=$pUnits[2]['denom']?>
        
        data-ui_minimum = "<?=$pUnits[2]['mincount']?>"
        data-ui_name = "<?=$pUnits[2]['name']?>"
        data-ui_name_plural = "<?=$pUnits[2]['name_plural']?>"
        data-ui_name_genitive = "<?=$pUnits[2]['name_package_dimension']?>"
        data-ui_descr="<?=$pUnits[2]['relStr']?>">
        <a href="#"><?= $pUnits[2]['showName']?></a>
    </li>
    <?php endif;?>
</ul>


        <div class="_flex wrapper_product">
            <div class="product_image">
                <div class="wrapper_product_image">
                    <div class="back_link">
                        <a href="<?=$landing_alias?>">Вернуться назад</a>
                    </div>
                    <div class="main_product_image">
                        <a data-fancybox="gallery" class="fancybox" data-caption="<?=$name?>" href="<?=$images[0]['image']?>"><img src="<?=$images[0]['big']?>" alt="<?=$name?>"/></a>
                    </div>
                    <div class="main_product_gallery _flex _wrap _center">
                        <?php foreach($images as $key=>$image){?>
                            <?php if($key){?>
                                <div class="product_gallery_item">
                                    <a data-fancybox="gallery" data-caption="<?=$name?>. Фото #<?=($key+1)?>" class="fancybox" href="<?=$image['image']?>" >
                                        <img src="<?=$image['mini']?>" />
                                    </a>
                                </div>
                            <?php }?>
                        <?php }?>
                    </div>
                    <?php if(isset($block1_form_status) and $block1_form_status) {?>
                        <div class="product_form">
                            <div class="product_form_info _flex _vcenter _between">
                                <div class="product_form_caption">
                                    <?=$block1_form_caption?> <?=$block1_form_text?>
                                </div>
                                <div class="product_form_button js_sbottom js_goal" data-goal="lp-zayavka-product">
                                    Получить предложение
                                </div>
                            </div>
                        </div>
                    <?php }?>
                </div>
            </div>
            <div class="product_info">
                <div class="block_caption"><?=$name?></div>
                <div class="_flex _center pack_items _wrap pack_items_product">
                    <?php foreach($products_links as $key=>$products_link){ ?>
                        <?php foreach($products_link as $product_link){?>
                            <?php if($key==1){?>
                                
                                <a href="<?=$product_link['link']?>" class="_flex _vcenter pack_itm color_itm <?=$product_link['product_id']==$product_id?'active':''?>" data-id="<?=$product_link['product_id']?>">
                                    <div class="color_block" style="background-color:#<?=$product_link['code']?>"></div>
                                    <?=$product_link['name']?>
                                </a>
                            <?php }else{?>
                                <a href="<?=$product_link['link']?>" class="pack_itm <?=$product_link['product_id']==$product_id?'active':''?>" data-id="<?=$product_link['product_id']?>">
                                    <?=$product_link['name']?>
                                </a>
                            <?php }?>
                        <?php }?>
                    <?php }?>
                </div>
                <!--
                <div class="_flex pack_items pack_items_product _wrap">
                    <div class="change_itm pack_itm active" data-id="746">ведро, 16 кг</div>
                    <div class="change_itm pack_itm " data-id="1015">ведро, 10кг</div>
                    <div class="change_itm pack_itm " data-id="1016">ведро, 5 кг</div>
                </div>
                -->
                <div class="product_price product_product_price"><?=$price_str?></div>
                <div class="product_text"><?=html_entity_decode($text)?></div>

                <?php if(isset($block_benefit_pr_status) and $block_benefit_pr_status) {?>
                    
                    <div class="product_benefts">
                        <div class="benefit_items _flex _wrap">
                            <?php foreach($block_benefit_pr as $block3_benefit){ ?>
                                <div class="benefit_itm_product">
                                    <div class="benefit_itm_info">
                                        <div class="benefit_ico"><img src="image/<?=$block3_benefit['image']?>" /></div>
                                        <div class="benefit_text"><?=$block3_benefit['text']?></div>
                                    </div>
                                </div>
                            <?php }?>
                        </div>
                    </div>
                
                <?php }?>
                <!--
                <div class="product_benefits">
                    Преимущества
                </div>pa
                -->

                <div class="wrap_prop_block active">
                    <div class="properties_caption">Параметры</div>
                    <div class="wrapper_properties prop_block">
                    <div class="wrap_properties ">
                        <?php
                            foreach($filter_params as $itm) {
                                $selected_str="";
                                $selected_params_str="";
                                switch ($itm['type_param']){
                                    case 0:
                                        $selected_params=[];
                                        foreach($itm["list"] as $itm_param){
                                            if($itm_param['selected']){
                                                $selected_params[]=htmlspecialchars_decode($itm_param['param_value'],ENT_QUOTES);
                                            }                                            
                                            $selected_params_str=implode(", ", $selected_params);
                                        }

                                    break;

                                    case 2:
                                        $selected_params=[];
                                        foreach($itm["list"] as $itm_param){
                                            if($itm_param['selected']){
                                                $selected_params[]=htmlspecialchars_decode($itm_param['param_value'],ENT_QUOTES);
                                            }                                            
                                            $selected_params_str=implode(", ", $selected_params);
                                        }

                                    break;

                                    case 1:
                                        $param_link="";

                                        if($itm['list']['value1']){
                                            //$param_link='param[temp-prim_start][min]=-14&param[temp-prim_start][max]=3';
                                            $param_link='param['.$itm['translit'].'][min]='.$itm['list']['value1'];
                                            $selected_str='от '.$itm['list']['value1']." ";
                                        }
                                        if($itm['list']['value2']){
                                            $selected_str.='до '.$itm['list']['value2'];
                                            $param_link.=($param_link?'&':'').'param['.$itm['translit'].'][max]='.$itm['list']['value2'];
                                        }
                                        if($selected_str){
                                            $selected_params_str=$selected_str;
                                        }
                                    break;
                                }

                                if($selected_params_str) {
                                    echo '<div class="property_item">
                                        <div class="property_caption">'.htmlspecialchars_decode($itm['name'],ENT_QUOTES).'</div>
                                        <div class="property_value">'.$selected_params_str.'</div>
                                    </div>';
                                }
                            }
                        ?>
                    </div>
                    <div class="wrap_properties_more">
                        <div class="properties_more">Посмотреть технические характеристики</div>

                        <div class="wrapper_props">
                            <div class="wrapp_props_table">
                                <div class="wrapper_props_table">
                                    <div class="props_table_row props_table_row_head">
                                        <div class="props_table_cell _head">Показатель</div>
                                        <div class="props_table_cell _center _head">Значение</div>
                                        <div class="props_table_cell _center _head">Ед. измерения</div>
                                    </div>
                                    <?php foreach( $properties as $p):?>
                                        <div class="props_table_row">
                                            <div class="props_table_cell props_table_cell_name"><?=htmlspecialchars_decode($p['name'],ENT_QUOTES)?></div>
                                            <div class="props_table_cell props_table_cell_val1 _center"><?=htmlspecialchars_decode($p['val'],ENT_QUOTES)?></div>
                                            <div class="props_table_cell props_table_cell_val2 _center"><?=htmlspecialchars_decode($p['unit'],ENT_QUOTES)?></div>
                                        </div>
                                    <?php endforeach; ?>                                
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                </div>

                
                <!-- TAB кастомные -->
                <?php foreach($tabs as $t): ?>
                <div>
                    <div class="application">
                        <?=$t['text']?>
                    </div>
                </div>
                <?php endforeach;?>

                <div class="wrap_prop_block ">
                    <div class="properties_caption">Упаковка</div>
                    <div class="prop_block">
                        
                        <?php foreach( $packageStrings as $s):?>
                            <div class="property_item">
                                <div class="property_caption"><?=htmlspecialchars_decode($s['description'],ENT_QUOTES)?></div>
                                <div class="property_value"><?=htmlspecialchars_decode($s['value'],ENT_QUOTES)?></div>
                            </div>                       
                        <?php endforeach; ?>
                    </div>
                </div>

                <div class="wrap_prop_block">
                    <div class="properties_caption">Норма загрузки в автотранспорт</div>
                    <div class="prop_block">
                        <div class="wrap_tipe">
                            <div class="tipe">
                                <!--<span>Выберите тип автомобиля:</span>-->
                                <select class="nice-select" id="courier_select">
                                    <!--<option value="0" selected>Выберите тип автомобиля...</option>-->

                                    <?php foreach($couriers as $key=>$courier){ if ($baseWeight<=$courier['weight']){?>
                                        <option <?=$key==0?'selected':''?> value="<?php echo $courier['weight']?>"><?php echo $courier['name']?></option>
                                    <?php }}?>
                                    
                                </select>
                            </div>
                            
                            <div class="wrap_table_data table_data_gruz">
                                <table class="table_data">
                                    <tbody>
                                        <tr>
                                            <td><span id="unitpack1_str"></span></td>
                                            <td><span id="unitpack2_str"></span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="clr"></div>
                        <div class="properties_hint">
                            <p>Нормы загрузки материалов приведены справочно. Для точного расчета обращайтесь к нашим сотрудникам.</p>
                        </div>
                    </div>
                </div>
                
                <?php if(isset($product_lp_docs)){?>
                    <?php if(count($product_lp_docs)){?>
                        <div class="wrap_prop_block ">
                            <div class="properties_caption">Документы</div>
                            <div class="prop_block">
                                <div class="product_docs _flex _wrap">
                                    <?php foreach($product_lp_docs as $doc){?>
                                    <div class="product_doc"><a href="files/landing/<?=$doc['file']?>" download><?=$doc['text']?></a></div>
                                    <?php }?>
                                </div>
                            </div>
                        </div>
                    <?php }?>
                <?php }?>
            </div>
        </div>
        
        <?php if($video){?>
            <div class="wrapper_video">
                <div class="block_caption">Простые видео-инструкции по применению наших материалов</div>
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
                                    <div class="video_itm_caption video_itm_caption_product"><?=$video_item['video_caption']?></div>
                                </div>
                            </div>
                        <?php }?>
                    </div>
                </div>
            </div>
        <?php }?>
        <section class="container bottom_form_product" id="bottom_form">
            <?=$bform?>
        </div>
    </div>
</section>
<?=$footer?>