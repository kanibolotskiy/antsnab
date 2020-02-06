
<div class="catalog-product">
    <div class="catalog_opens"></div>
    <a href="<?=$root?>" class="catalog-btn">    
        Каталог
    </a>
    <!--
    <div class="sidebar_filter_caption">
        <div class="wrp_sidebar_filter_caption">
            <div><span>Фильтр</span></div>
        </div>
        <div class="sidebar_filter_close"></div>
    </div>
    -->
    <div class="wrapper_left_data">
        <!--
        <div class="wrapper_parameters">
            <div class="wrapper_param_list">
                <div class="param_item">
                    <div class="param_item_rows">
                        <form id="form_params" action="<?=$catalog_info['category_url']?>" catalog_id="<?=$catalog_info['category_id']?>">
                            <?php foreach($params as $param_item){?>
                                <?php if($param_item["type_param"]){?>
                                    <div class="param_row" rel="<?=$param_item['id']?>" param_name="<?=$param_item['translit']?>">
                                        <div class="param_item_caption"><?=$param_item['name']?><?php echo $param_item['unit']?', '.$param_item['unit']:'';  ?></div>
                                        <div class="wrapper_range_slider">
                                            <div class="range_slider" min_value="<?=$param_item['avail_params']['min']?>" max_value="<?=$param_item['avail_params']['max']?>" def_min_value="<?=$param_item['avail_params']['min']?>" def_max_value="<?=$param_item['avail_params']['max']?>"></div>
                                            <div class="wrapper_range_input">
                                                <div class="range_input_part _first">
                                                    <div class="range_input_caption">от</div>
                                                    <input name="param[<?=$param_item['translit']?>][min]" type="number" class="inputRange inputRangeMin" value="<?=$param_item['avail_params']['min']?>" />
                                                </div>
                                                <div class="range_input_part">
                                                    <div class="range_input_caption">до</div>
                                                    <input name="param[<?=$param_item['translit']?>][max]" type="number" class="inputRange inputRangeMax" value="<?=$param_item['avail_params']['max']?>" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <?php }else{?>
                                    <?php if(count($param_item['avail_params'])>1) {?>
                                        <div class="param_row" rel="<?=$param_item['id']?>" param_name="<?=$param_item['translit']?>">
                                            <div class="param_item_caption"><?=$param_item['name']?><?php echo $param_item['unit']?', '.$param_item['unit']:'';  ?></div>
                                            <?php foreach($param_item['avail_params'] as $param_list_item) {?>
                                            <div class="row_check">
                                                <input class="param_check" name="param[<?=$param_item['translit']?>][]" type="checkbox" id="check_<?=$param_list_item['param_id']?>" value="<?=$param_list_item['param_id']?>">
                                                <label for="check_<?=$param_list_item['param_id']?>"><?=$param_list_item["param_value"]?></label>
                                            </div>
                                            <?php }?>
                                        </div>
                                    <?php }?>
                                <?php }?>
                            
                            <?php }?>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        -->
            
        <div class="accordion">
            <ul class="simple-accordion"  itemscope itemtype="http://www.schema.org/SiteNavigationElement">        
            <?php foreach ($categories as $parent) { ?>
                    
                <?php if ( in_array($parent['category_id'], $openeditems) ) { ?>
                <li class="active _active">
                <?php } else { ?>
                <li>
                <?php } ?>
                <div class="catalog_arrow"></div>
                <a href="<?php echo $parent['href']?>" class="main_category"><?php echo $parent['name']; ?></a>
                    
                <?php if (!empty($parent['child'])) { ?>
                    <div class="slide">
                        <ul>
                            <?php foreach ($parent['child'] as $child) { ?>
                                <li itemprop="name">

                                <?php if ($category_id == $child['category_id']) { ?>
                                <a itemprop="url" class="active" href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                                <?php } else { ?>
                                <a itemprop="url" href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                                <?php } ?>

                                <!-- @task1 to scss remove -->
                                <?php if (!empty($child['child'])) : ?>
                                    <ul style="margin-left:20px">
                                        <?php foreach ($child['child'] as $sub) : ?>
                                            <li itemprop="name">
                                                <?php if ($category_id == $sub['category_id']) { ?>
                                                <a itemprop="url" class="active" href="<?php echo $sub['href']; ?>"><?php echo $sub['name']; ?></a>
                                                <?php } else { ?>
                                                <a itemprop="url" href="<?php echo $sub['href']; ?>"><?php echo $sub['name']; ?></a>
                                                <?php } ?>
                                            </li>
                                        <?php endforeach ?>
                                    </ul>
                                <?php endif; ?>

                                </li>
                            <?php } ?>
                        </ul>
                    </div>
                <?php } ?>
                </li>
            <?php } ?>

            </ul>
            <div class="collapse">
                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" 
                    width="48" 
                    height="48" 
                    viewBox="0 0 32 32" 
                    transform="rotate(90)">
                <g data-width="32" data-height="32"  >
                    <path  d="M0 0h6v32h-6z"/>
                    <path  d="M16 0h2v32h-2z"/>
                    <path d="M5 15.5l6-4.5v9z"/>
                </g>
                <text x="-31" y="26" font-family="sans-serif" font-size="7px" fill="" transform="rotate(-90)">cвернуть</text>
                </svg>
            </div> 
            <div class="catalog_hide"><span>Свернуть каталог</span></div>
        </div>
    </div>
    
</div>

