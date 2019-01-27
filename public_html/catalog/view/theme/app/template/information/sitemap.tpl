<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        <div class="article">
        <h1><?php echo $heading_title; ?></h1>
            <div class="article_columns">
                <h2><?php echo $heading_categories; ?></h2>
                test
                <ul>
                <?php foreach ($categories as $category_1) { ?>
                <li><a href="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></a>
                  <?php if ($category_1['children']) { ?>
                  <ul>
                    <?php foreach ($category_1['children'] as $category_2) { ?>
                    <li><a href="<?php echo $category_2['href']; ?>"><?php echo $category_2['name']; ?></a>
                      <?php if ($category_2['children']) { ?>
                      <ul>
                        <?php foreach ($category_2['children'] as $category_3) { ?>
                        <li><a href="<?php echo $category_3['href']; ?>"><?php echo $category_3['name']; ?></a></li>
                        <?php if( $category_3['children']) { ?>
                            <ul>
                                <?php foreach ($category_3['children'] as $category_4) { ?>
                                <li><a href="<?php echo $category_4['href']; ?>"><?php echo $category_4['name']; ?></a></li>
                                <?php } ?>
                            </ul>
                        <?php } ?>
                      <?php } ?>
                      </ul>
                      <?php } ?>
                    </li>
                    <?php } ?>
                  </ul>
                  <?php } ?>
                </li>
                <?php } ?>
              </ul>

              <h2><?php echo $heading_news; ?></h2>
                <ul>
                <?php foreach ($news as $category_1) { ?>
                <li><a href="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></a>
                  <?php if ($category_1['children']) { ?>
                  <ul>
                    <?php foreach ($category_1['children'] as $category_2) { ?>
                    <li><a href="<?php echo $category_2['href']; ?>"><?php echo $category_2['name']; ?></a>
                      <?php if ($category_2['children']) { ?>
                      <ul>
                        <?php foreach ($category_2['children'] as $category_3) { ?>
                        <li><a href="<?php echo $category_3['href']; ?>"><?php echo $category_3['name']; ?></a></li>
                        <?php if( $category_3['children']) { ?>
                            <ul>
                                <?php foreach ($category_3['children'] as $category_4) { ?>
                                <li><a href="<?php echo $category_4['href']; ?>"><?php echo $category_4['name']; ?></a></li>
                                <?php } ?>
                            </ul>
                        <?php } ?>
                      <?php } ?>
                      </ul>
                      <?php } ?>
                    </li>
                    <?php } ?>
                  </ul>
                  <?php } ?>
                </li>
                <?php } ?>
              </ul>

              <h2><?php echo $heading_articles; ?></h2>
                <ul>
                <?php foreach ($articles as $category_1) { ?>
                <li><a href="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></a>
                  <?php if ($category_1['children']) { ?>
                  <ul>
                    <?php foreach ($category_1['children'] as $category_2) { ?>
                    <li><a href="<?php echo $category_2['href']; ?>"><?php echo $category_2['name']; ?></a>
                      <?php if ($category_2['children']) { ?>
                      <ul>
                        <?php foreach ($category_2['children'] as $category_3) { ?>
                        <li><a href="<?php echo $category_3['href']; ?>"><?php echo $category_3['name']; ?></a></li>
                        <?php if( $category_3['children']) { ?>
                            <ul>
                                <?php foreach ($category_3['children'] as $category_4) { ?>
                                <li><a href="<?php echo $category_4['href']; ?>"><?php echo $category_4['name']; ?></a></li>
                                <?php } ?>
                            </ul>
                        <?php } ?>
                      <?php } ?>
                      </ul>
                      <?php } ?>
                    </li>
                    <?php } ?>
                  </ul>
                  <?php } ?>
                </li>
                <?php } ?>
              </ul>
              
              <h2><?php echo $text_information; ?></h2>
              <ul>
                    <?php foreach ($informations as $information) { ?>
                    <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                    <?php } ?>
              </ul>
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>