

<div class="catalog-product">
    <?php if($show_params){ ?>
        <div class="sidebar_filter_caption <?php echo ($show_filter?'active':'');  ?>">
            <div class="wrp_sidebar_filter_caption">
                <div><span>Подбор по параметрам</span></div>
            </div>
            <div class="sidebar_filter_close"></div>
        </div>
    <?php }?>

    <div class="wrapper_catalog-btn">
        <div class="catalog_opens"></div>
        <a href="<?=$root?>" class="catalog-btn">
            Каталог
        </a>
    </div>
    
    
    <div class="wrapper_left_data">
    
        <div class="accordion scroll-pane">
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

