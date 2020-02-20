<?= $header ?>
<div class="container main withparams">
    
    <div class="wrapper_content">
        <div class="content">
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
                                <span>Подборки:</span>
                                
                                <ul>    
                                    <?php foreach($categories_isseo as $item) {?>
                                        <li><a class="<?php echo $item["category_id"]==$category_id?'active':'';?>" href="<?php echo $item['href'];?>"><?php echo $item['name']?></a></li>
                                    <?php }?>
                                </ul>
                            </div>
                        </div>
                    <?php }?>
                <?php }?>
                <!--<div class="temp_params" style="width:100px;height:100px;background:red;">test</div>-->
                
                <div class="wrapper_parameters scroll-pane">
                    <div class="wrapper_param_list">
                        <div class="param_item">
                            <div class="param_item_rows">
                                <form id="form_params" action="<?=$catalog_info['category_url']?>" catalog_id="<?=$catalog_info['category_id']?>">
                                    <?php foreach($params as $param_item){?>
                                        <?php if($param_item["type_param"]){?>
                                            <div class="param_row" rel="<?=$param_item['id']?>" param_name="<?=$param_item['translit']?>">
                                                <div class="param_item_caption"><?=$param_item['name']?><?php echo $param_item['unit']?', '.$param_item['unit']:'';  ?></div>
                                                <div class="wrapper_range_slider">
                                                    <div name="<?=$param_item['translit']?>" class="range_slider" select_min="" select_max="" min_value="<?=$param_item['avail_params']['min']?>" max_value="<?=$param_item['avail_params']['max']?>" def_min_value="<?=$param_item['avail_params']['min']?>" def_max_value="<?=$param_item['avail_params']['max']?>"></div>
                                                    <div class="wrapper_range_input">
                                                        <div class="range_input_part _first">
                                                            <div class="range_input_caption">от</div>
                                                            <input type="number" class="inputRange inputRangeMin" value="<?=$param_item['avail_params']['min']?>" />
                                                        </div>
                                                        <div class="range_input_part">
                                                            <div class="range_input_caption">до</div>
                                                            <input type="number" class="inputRange inputRangeMax" value="<?=$param_item['avail_params']['max']?>" />
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
                                                            <?php foreach($param_item['avail_params'] as $param_list_item) {?>
                                                                <div class="row_check">
                                                                    <input class="param_check" name="param[<?=$param_item['translit']?>][]" type="checkbox" id="check_<?=$param_list_item['param_id']?>" value="<?=$param_list_item['param_id']?>">
                                                                    <label for="check_<?=$param_list_item['param_id']?>"><?php echo html_entity_decode($param_list_item["param_value"]);?></label>
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
                            <div class="filter_reset"><span>Очистить фильтр</span></div>
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
                    
                        <ul class="select_view_switch">
                            <li class="select_view select_view1 <?php echo $cat_view1;?>" rel="view1"></li>
                            <li class="select_view select_view2 <?php echo $cat_view2;?>" rel="view2"></li>
                        </ul>
                    </div>
                    <div class="clear"></div>
                    <div class="tab-list">
                        <div class="tab-block tab-block3 <?php echo $cat_view_class;?>" >
                            <ul id="lazy-load_container">
                                <?php foreach ($products as $p): ?>
                                    <?php include __DIR__ . '/../partial/product_item.tpl' ?>
                                <?php endforeach; ?>
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

                    <?php echo $paginationLazy ?>
                    <?php echo $pagination; ?>

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
