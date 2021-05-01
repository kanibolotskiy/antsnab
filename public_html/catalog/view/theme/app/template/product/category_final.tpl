<?= $header ?>
<div class="container main withparams">
    
    <div class="wrapper_content">
        <div class="filter_reset <?php echo ($show_filter?'active':'');  ?>" >
            <div class="wrp_filter_reset">
                <span id="apply_filter">Применить</span>
                <div class="wrp_buttons_reset_filter">
                    <div id="hide_filter" class="button_reset_filter_slide">Свернуть</div>
                    <div id="reset_filter" class="button_reset_filter_reset <?php echo ($show_filter?'active':'');?>"><span>Очистить</span></div>
                </div>
            </div>
        </div>
        <div class="content">
            <?php include __DIR__ . '/../partial/category_banner.tpl' ?>
            <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
            <?php echo $content_top; ?>
            
            <?php if (!empty($products)): ?>
                <div class="catalog-info">
                    <h1 class="title"><?= $heading_title ?></h1>
                    <?php if($description){ ?>

                        <div class="wrp_description">
                            <?php if($catalog_brand_img) {?>
                                <div class="catalog-info_img">
                                    <img src="<?php echo $catalog_brand_img;?>" alt="<?= $heading_title ?>"/>
                                </div>
                            <?php }?>
                            
                            <?php echo $description; ?>
                        </div>
                    <?php }?>
                </div>
                <?php if(isset($categories_isseo)) {?>
                    <?php if(count($categories_isseo)) {?>
                        <div class="wrp_pick-up">
                            <div class="pick-up">
                                <ul>    
                                    <li><span>Подборки:</span></li>
                                    <?php foreach($categories_isseo as $item) {?>
                                        <li><a class="<?php echo $item["category_id"]==$category_id?'active':'';?>" href="<?php echo $item['href'];?>"><?php echo $item['name']?></a></li>
                                    <?php }?>
                                    <?php if(count($categories_isseo_hidden)){?>
                                        
                                        <?php foreach($categories_isseo_hidden as $item) {?>
                                            <li class="_hidden"><a href="<?php echo $item['href'];?>"><?php echo $item['name']?></a></li>
                                        <?php }?>
                                        <li class="showmore__isseo">
                                            <div id="showmore_isseo">показать еще</div>
                                        </li>
                                    <?php }?>
                                </ul>
                            </div>
                        </div>
                    <?php }?>
                <?php }?>
                
                <div class="wrapper_parameters scroll-pane" <?php echo ($show_filter?'style="opacity:1;margin-left:0;"':'');  ?> >
                    
                    <div class="wrapper_param_list">
                        <div class="wrp_filter_title">
                            <div class="filter_title">Подбор по параметрам</div>
                        </div>
                        <div class="param_item" <?php echo ($show_filter?'style="display:block;"':'');  ?>>
                            <div class="param_item_rows">
                                    
                                    <form data-id="form_params" action="<?=$catalog_info['category_url']?>" data-catalog_id="<?=$catalog_info['category_id']?>">
                                        
                                        
                                        <?php foreach($params["items"] as $param_item){?>
                                            
                                            <?php if($param_item["type_param"]==1){?>
                                                <div class="param_row" data-rel="<?=$param_item['id']?>" data-param_name="<?=$param_item['translit']?>">
                                                    <div class="param_item_caption"><?=$param_item['name']?><?php echo $param_item['unit']?', '.$param_item['unit']:'';  ?></div>
                                                    <div class="wrapper_range_slider">
                                                        <div data-name="<?=$param_item['translit']?>" class="range_slider" data-select_min="<?php echo isset($params['selected'][$param_item['translit']]['min'])?$params['selected'][$param_item['translit']]['min']:'';?>" data-select_max="<?php echo isset($params['selected'][$param_item['translit']]['max'])?$params['selected'][$param_item['translit']]['max']:'';?>" data-min_value="<?=$param_item['avail_params']['min']?>" data-max_value="<?=$param_item['avail_params']['max']?>" data-def_min_value="<?=$param_item['avail_params']['min']?>" data-def_max_value="<?=$param_item['avail_params']['max']?>" data-step="<?=$param_item['step']?>"></div>
                                                        <div class="wrapper_range_input">
                                                            <div class="range_input_part _first">
                                                                <div class="range_input_caption">от</div>
                                                                
                                                                <input type="number" class="inputRange inputRangeMin" value="<?php echo isset($params['selected'][$param_item['translit']]['min'])?$params['selected'][$param_item['translit']]['min']:$param_item['avail_params']['min'];?>" />
                                                            </div>
                                                            <div class="range_input_part">
                                                                <div class="range_input_caption">до</div>
                                                                <input type="number" class="inputRange inputRangeMax" value="<?php echo isset($params['selected'][$param_item['translit']]['max'])?$params['selected'][$param_item['translit']]['max']:$param_item['avail_params']['max'];?>" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            <?php }?>
                                            
                                            <?php if($param_item["type_param"]==5){?>
                                                <div class="param_row param_row_full" data-rel="<?=$param_item['id']?>" data-param_name="<?=$param_item['translit']?>">
                                                    <!--<div class="param_item_caption"><?=$param_item['name']?></div>-->
                                                    <div class="row_checks_wrap">
                                                        <div class="row_checks">    
                                                            <?php foreach($param_item['avail_params'] as $key=>$param_list_item) {?>    
                                                                <?php if(isset($avail[$param_item['translit']]['result']['count'])){$cnt=$avail[$param_item['translit']]['result']['count'];}else{$cnt=0;} ?>
                                                                <div class="row_check <?php echo $cnt?'':'_unactive'; ?>">
                                                                    <input <?php echo $cnt?'':'disabled'; ?> <?php echo isset($params["selected"][$param_item['translit']])?'checked':'' ?> class="param_check" data-name="param[<?=$param_item['translit']?>]" type="checkbox" id="check_sale" value="1">
                                                                    <label for="check_sale"><?php echo html_entity_decode($param_list_item);?></label>
                                                                </div>
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                </div>
                                            <?php }?>

                                            <?php if($param_item["type_param"]==4){?>
                                                <div class="param_row param_row_full" data-rel="<?=$param_item['id']?>" data-param_name="<?=$param_item['translit']?>">
                                                    <!--<div class="param_item_caption"><?=$param_item['name']?></div>-->
                                                    <div class="row_checks_wrap">
                                                        <div class="row_checks">    
                                                            <?php foreach($param_item['avail_params'] as $key=>$param_list_item) {?>
                                                                <?php if(isset($avail[$param_item['translit']]['result']['count'])){$cnt=$avail[$param_item['translit']]['result']['count'];}else{$cnt=0;} ?>
                                                                <div class="row_check <?php echo $cnt?'':'_unactive'; ?>">
                                                                    <input <?php echo $cnt?'':'disabled'; ?> <?php echo isset($params["selected"][$param_item['translit']])?'checked':'' ?> class="param_check" data-name="param[<?=$param_item['translit']?>]" type="checkbox" id="check_availible" value="1">
                                                                    <label for="check_availible"><?php echo html_entity_decode($param_list_item);?></label>
                                                                </div>
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                </div>
                                            <?php }?>
                                            <?php if($param_item["type_param"]==0 or $param_item["type_param"]==2){?>
                                                
                                                <?php if(count($param_item['avail_params'])>1) {?>
                                                    <div class="param_row" data-rel="<?=$param_item['id']?>" data-param_name="<?=$param_item['translit']?>">
                                                        <div class="param_item_caption"><?=$param_item['name']?><?php echo $param_item['unit']?', '.$param_item['unit']:'';  ?></div>
                                                        <div class="row_checks_wrap">
                                                            <div class="row_checks">
                                                                
                                                                <?php foreach($param_item['avail_params'] as $key=>$param_list_item) {?>
                                                                    
                                                                    <?php $fl=false;if(isset($params["selected"][$param_item['translit']])){foreach($params["selected"][$param_item['translit']] as $pitm){ if($pitm==$key) {$fl=true;}}}?>
                                                                    <div class="row_check <?php echo isset($avail[$param_item['translit']]['result'][$key])?'':'_unactive'; ?>">
                                                                        <input <?php echo isset($avail[$param_item['translit']]['result'][$key])?'':'disabled'; ?> <?php echo $fl?'checked':''; ?> class="param_check" data-name="param[<?=$param_item['translit']?>][]" type="checkbox" id="check_<?=$key?>" value="<?=$key?>">
                                                                        <label for="check_<?=$key?>"><?php echo html_entity_decode($param_list_item);?></label>
                                                                    </div>
                                                                <?php } ?>
                                                            </div>
                                                        </div>
                                                        <div class="show_more_params"><span>Показать еще</span></div>
                                                    </div>
                                                <?php }?>
                                            <?php }?>
                                        
                                        <?php }?>
                                    </form>
                                </div>
                        </div>
                    </div>                    
                </div>
                

                <div class="catalog-tab catalog-list">

                    <div class="wrap_select_view">
                        <form method="GET" style="position:absolute;top:0;z-index:2;">
                            <select  name="sort" id="seldef1" title="Cортировка"> <!--onchange="this.form.submit()"-->
                                <option <?php if($sort_selected=="") echo 'selected';?> value="">по релевантности</option>
                                <option <?php if($sort_selected=="price|ASC") echo 'selected';?> value="price|ASC">сначала недорогие</option>
                                <option <?php if($sort_selected=="price|DESC") echo 'selected';?> value="price|DESC">сначала дорогие</option>
                                <option <?php if($sort_selected=="name|ASC") echo 'selected';?> value="name|ASC">от А до Я</option>
                                <option <?php if($sort_selected=="name|DESC") echo 'selected';?> value="name|DESC">от Я до А</option>
                            </select>
                        </form>
                        <div class="wrapper_show_types">
                            <div class="showby_list">
                                <div class="showby_item <?=$showby_9?>" data-rel="9">9</div>
                                <div class="showby_item <?=$showby_18?>" data-rel="18">18</div>
                                <div class="showby_item <?=$showby_all?>" data-rel="all">Все</div>
                            </div>
                            <ul class="select_view_switch">
                                <li class="select_view select_view1 <?php echo $cat_view1;?>" data-rel="view1"></li>
                                <li class="select_view select_view2 <?php echo $cat_view2;?>" data-rel="view2"></li>
                            </ul>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="tab-list">
                        <div class="tab-block tab-block3 <?php echo $cat_view_class;?>" >
                            <ul id="lazy-load_container" itemscope itemtype="https://schema.org/ItemList">
                                <?php echo $products;?>
                            </ul>
                        </div>
                    </div>
                    
                    <?php if( $products_add):?>
                        <div class="mentioned-products mentioned-products2">
                            
                            <div class="title">Популярное в категории <?php echo $parent_name;?></div>
                            <ul>
                            
                                <?php foreach($products_add as $p):?>
                                <li>
                                    <?php if($p["labels"]){  ?>
                                        <div class="item_labels">
                                            <?php foreach($p["labels"] as $key=>$label){ ?>
                                                <div class="item_label <?php echo $key;?>" title="<?php echo $label['title'];?>"><?php echo $label['label'];?></div>
                                            <?php } ?>
                                        </div>
                                    <?php }?>
                                    <div class="products-block">
                                        <?php if($p["rating"]){?>
                                            <div class="agg_rating"><?php echo $p["rating"];?></div>
                                        <?php }?>
                                        
                                        <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>

                                        <a href="<?=$p['href']?>" class="img-production">
                                            <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
                                        </a>
                                        
                                        <strong><?=$p['price']?> <div class="rur">i</div></strong>
                                        <a href="<?=$p['href']?>" class="order-btn">Подробнее</a>
                                    </div>
                                </li>
                                <?php endforeach;?>
                            </ul>
                        </div>
                    <?php endif;?>
                    <div id="wrp_paginate" class="wrp_paginate_cats">
                        <?php echo $paginationLazy ?>
                        <?php echo $pagination; ?>
                    </div>

                </div>
                <?php if($bottom_text){ ?>
                    <div class="bottom_text content-text">
                        <?php echo $bottom_text; ?>
                    </div>
                <?php }?>
            <?php else: ?>
                <h1>Товаров не найдено</h1>
            <?php endif; ?>

            <?php echo $content_bottom; ?>
        </div>
    </div>
    <?= $column_left ?>
</div>
<?= $footer ?>
