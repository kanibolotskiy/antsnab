<div class="catalog-product">
    <a class="catalog-btn">Каталог продукции</a>
    <div class="accordion">
        <ul class="simple-accordion">
        <?php foreach ($categories->toArray() as $parent) { ?>
            <?php if ($category_id == $parent->get('category_id')) { ?>
                <li class="active">
                <?php } else { ?>
                <li>
                <?php } ?>
                <a href="#" class="opener"><?php echo $parent->get('name'); ?></a>
                <?php if (!$parent->get('categories')->isEmpty()) { ?>
                    <div class="slide">
                        <ul>
                            <?php foreach ($parent->get('categories')->toArray() as $child) { ?>
                                <?php if ($category_id == $child->get('category_id')) { ?>
                                    <li class="active">
                                    <?php } else { ?>
                                    <li>
                                    <?php } ?>
                                    <a href="<?php echo $child->getHref($url); ?>"><?php echo $child->get('name'); ?></a>
                                    <!-- @task1 to scss remove -->
                                    <?php if (!$child->get('categories')->isEmpty()) : ?>
                                        <ul style="margin-left:20px">
                                            <?php foreach ($child->get('categories')->toArray() as $sub) : ?>
                                                <?php if ($category_id == $child->get('category_id')) { ?>
                                                    <li class="active">
                                                    <?php } else { ?>
                                                    <li>
                                                    <?php } ?>
                                                    <a href="<?php echo $sub->getHref($url); ?>"><?php echo $sub->get('name'); ?></a>
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

