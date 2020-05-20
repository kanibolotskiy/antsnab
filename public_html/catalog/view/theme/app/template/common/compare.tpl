<?= $header ?>

<div class="container">
    <?= $column_left ?>
</div>
<div class="container main _compare_head">
    
    <div class="content without_sidebar _compare_head">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <h1 class="title">Сравнение</h1>
    </div>
</div>

<div class="mob_compare_hint">
    <div class="compare_hint_info">
        <div class="compare_hint_ico"></div>
        <div class="compare_hint_text">Переверните телефон для более удобного просмотра</div>
    </div>
</div>
<div class="compare_catalog_captions">
    <div class="compare_catalog_captions_wrapper container">
        <?php $z=0;foreach($favorite_products as $favorite_product){ ?>
            <div class="compare_catalog_caption<?php echo ($z==0?' active':'');?>" rel="<?=$favorite_product['catalog_id'];?>"><?=$favorite_product['name'];?> (<span class="compare_catalog_count"><?php echo count($favorite_product["products"]);?></span>)</div>
        <?php $z++;} ?>
    </div>
</div>
<div class="compare_catalog_captions_empty"></div>
<div class="wrapper_container_compare">
    <div class="container main _compare">
        <div class="content without_sidebar">
            <div class="compare_footer <?php echo count($favorite_products)?'active':''; ?>">
                <div class="compare-block">
                    <div class="compare_catalog_blocks">
                        
                        
                            <?php $z=0;foreach($favorite_products as $favorite_product){ ?>
                        
                            <div class="compare_catalog_block" rel="<?=$favorite_product['catalog_id']?>" style="<?php echo ($z==0?'display:block;':''); ?>">
                                <div class="left_compare">
                                    <div class="compare_header compare_header_ico">
                                        <div class="left_compare_caption">
                                            <div class="compare_img"></div>
                                            <div class="left_compare_text">Выберите лучший товар, сравнив характеристики</div>
                                        </div>

                                        <div class="left_compare_checkbox checkbox <?php echo count($favorite_product['products'])<2?'_unactive':'';?>">
                                            <input class="check_compare" type="checkbox" id="check_compare_<?=$favorite_product['catalog_id'];?>" <?php echo count($favorite_product['products'])<2?'disabled':'';?>/>
                                            <label for="check_compare_<?=$favorite_product['catalog_id'];?>">Показывать только отличающиеся параметры</label>
                                        </div>
                                    </div>
                                    <div class="empty_compare_header"></div>
                                    <div class="compare_body">
                                        <div class="compare_caption" rel="compare_filter">Основное</div>
                                        <div class="compare_blocks" rel="compare_filter">
                                            <?php foreach($favorite_product["category_params"] as $category_param){?>
                                                <?php if($category_param["used"] and $category_param["name"]){?>
                                                    <div rel="<?php echo $category_param['id'];?>" class="compare_block comp_row">
                                                        <?php echo html_entity_decode($category_param["name"])." ".html_entity_decode($category_param["unit"]);?>
                                                    </div>
                                                <?php }?>
                                            <?php }?>
                                        </div>
                                        <div class="compare_caption" rel="compare_char">Характеристики</div>
                                        <div class="compare_blocks" rel="compare_char">
                                            <?php $z=0;foreach($favorite_product["properties"][$favorite_product['catalog_id']] as $property){?>
                                                <div rel="<?php echo 'char_'.$favorite_product['catalog_id'].'_'.$z;?>" class="compare_block comp_row">
                                                    <?php echo html_entity_decode($property);?>
                                                </div>                                    
                                            <?php $z++;}?>
                                        </div>
                                        <div class="compare_caption" rel="compare_pack">Упаковка</div>
                                        <div class="compare_blocks" rel="compare_pack">
                                            <?php $z=0;foreach($favorite_product["pack_list"][$favorite_product['catalog_id']] as $pack_key=>$pack_item){?>
                                                <div rel="<?php echo 'pack_'.$favorite_product['catalog_id'].'_'.$z;?>" class="compare_block comp_row">
                                                    <?php echo html_entity_decode($pack_key);?>
                                                </div>                                    
                                            <?php $z++;}?>
                                        </div>
                                        <div class="compare_caption" rel="compare_avail">Доступность</div>
                                        <div class="compare_blocks" rel="compare_avail">
                                            <div class="compare_block " rel="comp_row_avail_0">Наличие</div>
                                            <div class="compare_block " rel="comp_row_avail_1">Доставка</div>
                                        </div>
                                        
                                    </div>
                                </div>

                                <div class="right_compare scroll_content">
                                    <div class="compare_products">
                                        <?php foreach($favorite_product["products"] as $product) {?>
                                        <div class="compare_product" rel="<?php echo $product['product_id'];?>">
                                            
                                            <div class="compare_header compare_product_header notfixed">
                                                <div class="comdel"></div>
                                                <div class="compare_product_header_info">
                                                    
                                                    <div class="compare_ttl">
                                                        <a target="_blank" href="<?php echo $product['href'];?>">
                                                            <?=$product["name"]?>
                                                        </a>
                                                    </div>
                                                    <div class="compare_product_img">
                                                        <a target="_blank" href="<?=$product['href']?>"><img src="<?=$product['image']?>" alt="<?=$product['name']?>"/></a>
                                                    </div>
                                                    <div class="compare_priceline">
                                                        <div class="compare_price">от <span class="compare_price_val"><?=$product["price"]?></span> <div class="rur compare_currency">i</div></div>
                                                    </div>
                                                    <div title="Добавить в корзину" class="buy add-to-card add-to-card-compare" data-product_id="<?php echo $product['product_id'];?>" data-sale_to_price_koef="1">
                                                        В корзину
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="empty_compare_header"></div>
                                            <div class="compare_body">
                                                <div class="compare_caption _empty" rel="compare_filter"></div>
                                                <div class="compare_blocks" rel="compare_filter">
                                                    <?php foreach($favorite_product["category_params"] as $category_param){?>
                                                        <?php if($category_param["used"] and $category_param["name"]){?>
                                                            <div rel="<?php echo $category_param['id'];?>" class="compare_block compare_block_val comp_row">
                                                                <?php echo isset($product["compare_filter"][$category_param["id"]])?html_entity_decode($product["compare_filter"][$category_param["id"]]):"-"; ?>
                                                            </div>
                                                        <?php }?>
                                                    <?php }?>
                                                </div>
                                                <div class="compare_caption _empty" rel="compare_char"></div>
                                                <div class="compare_blocks" rel="compare_char">
                                                    <?php $z=0;foreach($favorite_product["properties"][$favorite_product['catalog_id']] as $property){?>
                                                        <div class="compare_block comp_row compare_block_val" rel="<?php echo 'char_'.$favorite_product['catalog_id'].'_'.$z;?>">
                                                            <?php echo isset($product["properties"][$property])?$product["properties"][$property]:"-";?>
                                                        </div>
                                                    <?php $z++;}?>
                                                </div>
                                                <div class="compare_caption _empty" rel="compare_pack"></div>
                                                <div class="compare_blocks" rel="compare_pack">
                                                    <?php //print_r($product["params_pack"]);?>
                                                    <?php $z=0;foreach($favorite_product["pack_list"][$favorite_product['catalog_id']] as $pack_key=>$pack_item){?>
                                                        <div class="compare_block comp_row compare_block_val" rel="<?php echo 'pack_'.$favorite_product['catalog_id'].'_'.$z;?>">
                                                            <?php echo isset($product["params_pack"][$pack_key])?html_entity_decode($product["params_pack"][$pack_key]):"-";?>
                                                        </div>    
                                                    <?php $z++;}?>
                                                    
                                                </div>
                                                <div class="compare_caption _empty" rel="compare_avail"></div>
                                                <div class="compare_blocks" rel="compare_avail">
                                                    <div class="compare_block comp_row compare_block_val" rel="comp_row_avail_0"><?php echo $product["data_stock"];?></div>
                                                    <div class="compare_block comp_row compare_block_val" rel="comp_row_avail_1"><?php echo $product["delivery"];?></div>
                                                </div>
                                                

                                            </div>
                                            

                                        </div>
                                        <?php }?>
                                    </div>
                                </div>
                            </div>    

                            <?php $z++;}?>
                    </div>
        
                </div>

            
                <div class="compare_hint">
                    Если вы не можете самостоятельно выбрать продукцию, обращайтесь за помощью к <a href="contacts/" title="Контакты">нашим специалистам</a>
                </div>
                <div class="permanent_link_button" href="compare/" id="permanent_link_button" data-title="Скопировано">
                    <span>Скопировать ссылку на список сравнения</span>
                </div>
            </div>
            <div class="compare_footer_empty <?php echo count($favorite_products)?'active':''; ?>">
                <p>Для сравнения товаров следует их предварительно добавить из <a href="products/">каталога</a></p>
            </div>

        </div>
        
    </div>
    
</div>
<?= $footer ?>