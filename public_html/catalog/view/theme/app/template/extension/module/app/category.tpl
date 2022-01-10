

<div class="catalog-product  _filter">
    
    <div class="wrapper_catalog-btn">
        <div class="catalog_opens <?php echo $show_params?'':'act' ?>"></div>
        <a href="<?=$root?>" class="catalog-btn">
            Каталог
        </a>
    </div>
    
    
    <div class="wrapper_left_data">
        <div class="wrap_ct">
            <div class="accordion scroll-pane" <?php echo $show_params?'style="display:none;"':'style="display:block;opacity:1;"' ?>>
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
                
                <div class="catalog_hide"><span>Свернуть каталог</span></div>
            </div>
            <?php if($show_params){ ?>
                <!--<div class="sidebar_filter_caption <?php echo ($show_filter?'active':'');  ?>">-->
                <div class="sidebar_filter_caption active">
                    <div class="wrp_sidebar_filter_caption">
                        <div><span>Подбор по параметрам</span></div>
                    </div>
                    <div class="sidebar_filter_close"></div>
                </div>
            <?php }?>
        </div>
    </div>
    
</div>

