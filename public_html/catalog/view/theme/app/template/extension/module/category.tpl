<div class="catalog-product">
    <a class="catalog-btn"><?=$heading_title?></a>
    <div class="accordion">
        <ul class="simple-accordion">

        <?php foreach ($categories as $parent) { ?>
                <?php if ( in_array($parent['category_id'], $openeditems) ) { ?>
                <li class="active">
                <?php } else { ?>
                <li>
                <?php } ?>
                <a href="#" class="opener"><?php echo $parent['name']; ?></a>

                <?php if (!empty($parent['child'])) { ?>
                    <div class="slide">
                        <ul>
                            <?php foreach ($parent['child'] as $child) { ?>
                                    <li>

                                    <?php if ($category_id == $child['category_id']) { ?>
                                    <a class="active" href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                                    <?php } ?>

                                    <!-- @task1 to scss remove -->
                                    <?php if (!empty($child['child'])) : ?>
                                        <ul style="margin-left:20px">
                                            <?php foreach ($child['child'] as $sub) : ?>
                                                <li>
                                                    <?php if ($category_id == $sub['category_id']) { ?>
                                                    <a class="active" href="<?php echo $sub['href']; ?>"><?php echo $sub['name']; ?></a>
                                                    <?php } else { ?>
                                                    <a href="<?php echo $sub['href']; ?>"><?php echo $sub['name']; ?></a>
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
    </div>
</div>

