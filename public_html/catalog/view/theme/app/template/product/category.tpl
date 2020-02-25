<?= $header ?>
<div class="container main withparams">
    <div class="wrapper_content">
        <div class="content">
            <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
            <?php echo $content_top; ?>

            <?php if (!empty($categories)): ?>
                <div class="catalog-info">
                    <h1 class="title"><?= $heading_title ?></h1>
                    <?= $description ?>
                </div>
                <?php if(isset($categories_isseo)) {?>
                    <?php if(count($categories_isseo)) {?>
                        <div class="pick-up">
                            <ul>    
                                <li><span>Подборки:</span></li>
                                <?php foreach($categories_isseo as $item) {?>
                                    <li><a href="<?php echo $item['href'];?>"><?php echo $item['name']?></a></li>
                                <?php }?>
                            </ul>
                        </div>
                    <?php }?>
                <?php }?>
                <h2 class="part_title">Категории</h2>
                <div class="catalog-tab">
                    
                    <div id="mtab1" class="tab">
                        
                        <div class="tab-list">
                            <div id="m1tab1">
                                <div class="tab-block-cat tab-block tab-block2">
                                
                                    <ul>
                                        <?php foreach ($categories as $c): ?>
                                            <li>
                                                <div class="catalog-block">
                                                    <div class="catalog-img">
                                                        <a href="<?= $c['href'] ?>"><img src="<?= $c['thumb'] ?>" title="<?= $c['name']?>" alt="<?= $c['name']?>"></a>
                                                    </div>
                                                    <div class="catalog-description">
                                                        <a class="title-product" href="<?= $c['href'] ?>">
                                                            <?= $c['name'] ?>
                                                        </a> 
                                                        <div class="cat-desc">
                                                            <p>
                                                            <?= $c['description'] ?>
                                                            </p>
                                                        </div>
                                                        <!--   
                                                        <div class="tags">
                                                            <?php foreach( $c['sub'] as $sub ): ?>
                                                                <a href="<?=$sub['href']?>">
                                                                    <?=$sub['name']?>
                                                                </a>
                                                            <?php endforeach;?>
                                                        </div> 
                                                        -->
                                                    </div> 
                                                    <a href="<?= $c['href'] ?>" class="more">Смотреть все</a> 
                                                </div> 
                                            </li>
                                        <?php endforeach; ?>
                                    </ul>
                                    
                                </div>
                            </div> 
                        
                        </div>
                    </div>
                </div>
                
                <div class="wrapper_parameters scroll-pane" <?php echo ($show_filter?'style="opacity:1;margin-left:0;"':'');  ?> >
                    <div class="wrapper_param_list">
                        <div class="wrp_filter_title">
                            <div class="filter_title">Фильтр товаров</div>
                        </div>
                        <div class="param_item">
                            <div class="param_item_rows">
                                
                                <form id="form_params" action="<?=$catalog_info['category_url']?>" catalog_id="<?=$catalog_info['category_id']?>">
                                
                                    <?php foreach($params["items"] as $param_item){?>


                                        <?php if($param_item["type_param"]){?>
                                            <div class="param_row" rel="<?=$param_item['id']?>" param_name="<?=$param_item['translit']?>">
                                                <div class="param_item_caption"><?=$param_item['name']?><?php echo $param_item['unit']?', '.$param_item['unit']:'';  ?></div>
                                                <div class="wrapper_range_slider">
                                                    <div name="<?=$param_item['translit']?>" class="range_slider" select_min="<?php echo isset($params['selected'][$param_item['translit']]['min'])?$params['selected'][$param_item['translit']]['min']:'';?>" select_max="<?php echo isset($params['selected'][$param_item['translit']]['max'])?$params['selected'][$param_item['translit']]['max']:'';?>" min_value="<?=$param_item['avail_params']['min']?>" max_value="<?=$param_item['avail_params']['max']?>" def_min_value="<?=$param_item['avail_params']['min']?>" def_max_value="<?=$param_item['avail_params']['max']?>"></div>
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
                                        <?php }else{?>
                                            
                                            <?php if(count($param_item['avail_params'])>1) {?>
                                                <div class="param_row" rel="<?=$param_item['id']?>" param_name="<?=$param_item['translit']?>">
                                                    <div class="param_item_caption"><?=$param_item['name']?><?php echo $param_item['unit']?', '.$param_item['unit']:'';  ?></div>
                                                    <div class="row_checks_wrap">
                                                        <div class="row_checks">
                                                            
                                                            <?php foreach($param_item['avail_params'] as $key=>$param_list_item) {?>
                                                                
                                                                <?php $fl=false;if(isset($params["selected"][$param_item['translit']])){foreach($params["selected"][$param_item['translit']] as $pitm){ if($pitm==$key) {$fl=true;}}}?>
                                                                <div class="row_check <?php echo isset($avail[$param_item['translit']]['result'][$key])?'':'_unactive'; ?>">
                                                                    <input <?php echo $fl?'checked':''; ?> class="param_check" name="param[<?=$param_item['translit']?>][]" type="checkbox" id="check_<?=$key?>" value="<?=$key?>">
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
                            <div class="filter_reset" <?php echo ($show_filter?'style="opacity:1;"':'');  ?>><span>Очистить фильтр</span></div>
                        </div>
                    </div>
                </div>
                
                <h2>Товары из категории <?= $heading_title ?></h2>
                <div class="catalog-tab catalog-list">

                    <div class="wrap_select_view">
                        <form method="GET" style="position:absolute;top:0;z-index:2;">
                            <select  name="sort" id="seldef1" title="Cортировка"><!-- onchange="this.form.submit()"-->
                                <option <?php if($sort_selected=="") echo 'selected';?> value="">по релевантности</option>
                                <option <?php if($sort_selected=="price|ASC") echo 'selected';?> value="price|ASC">сначала недорогие</option>
                                <option <?php if($sort_selected=="price|DESC") echo 'selected';?> value="price|DESC">сначала дорогие</option>
                                <option <?php if($sort_selected=="name|ASC") echo 'selected';?> value="name|ASC">от А до Я</option>
                                <option <?php if($sort_selected=="name|DESC") echo 'selected';?> value="name|DESC">от Я до А</option>
                            </select>
                        </form>
                    
                        <ul class="select_view_switch">
                            <li class="select_view select_view1 <?php echo $cat_view1;?>" rel="view1"></li>
                            <li class="select_view select_view2 <?php echo $cat_view2;?>" rel="view2"></li>
                        </ul>
                    </div>
                    <div class="clear"></div>
                    <div class="tab-list">
                        <div class="tab-block tab-block3 <?php echo $cat_view_class;?>" >
                            <ul id="lazy-load_container">
                                <?php echo $products;?>
                            </ul>
                        </div>
                    </div>
                    <div id="wrp_paginate">
                    <?php echo $paginationLazy ?>
                    <?php echo $pagination; ?>
                    </div>

                </div>
                <div class="bottom_text content-text">
                    <?php echo $bottom_text; ?>
                </div>
            <?php else: ?>
                <h1>Категорий не найдено</h1>
            <?php endif; ?>

            <?php echo $content_bottom; ?>
            
        </div>
    </div>
    <?= $column_left ?>
</div>
<?= $footer ?>