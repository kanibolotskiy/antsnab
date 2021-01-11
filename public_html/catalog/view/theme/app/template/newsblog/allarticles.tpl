<!--@task1 to css move-->
<style>
    .staty-container .staty-list ul li .news-block .news-description a.title-news {
        height: 62px !important;
    }
</style>
<?= $header ?>

<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        <div class="news-container staty-container">
            <?php if( !empty($articles) ):?>
                    <div class="wrapper_sale_title">
                    
                        <?php $cat_str="";?>
                        <?php if( !empty($subCats) ){ ?>
                            <?php foreach($subCats as $sc){ ?>
                                <?php if( $sc['active'] and $sc['name']!="Все статьи" ){$cat_str="о &quot;".$sc['name']."&quot;";}?>
                            <?php }?>

                        <?php }?>
                        <?php if($cat_str){?>
                            <h1 class="title art_title">Статьи <?php echo $cat_str.$article_page;?></h1>
                        <?php }else{?>
                            <h1 class="title art_title">Статьи<?php echo $article_page;?></h1>
                        <?php }?>
                        
                        <div style="width:100%;">
                        <?php if( !empty($subCats) ):?>
                        <select id="seldef1" >
                            <?php foreach($subCats as $sc): ?>
                                <?php if($sc['active']):?>
                                    <option selected="selected" value="<?=$sc['href']?>">
                                        <a href="<?=$sc['href']?>"><?=$sc['name']?></a>
                                    </option>
                                <?php else:?>
                                    <option value="<?=$sc['href']?>">
                                        <a href="<?=$sc['href']?>"><?=$sc['name']?></a>
                                    </option>
                                <?php endif;?>
                            <?php endforeach;?>
                        </select>
                        </div>
                    </div>
                    <?php endif; ?>
                    <div class="staty-list">
                        <ul id="lazy-load_container">
                            <?php  foreach ($articles as $article) : ?>
                            <?php include __DIR__ . "/partial/item_allarticles.tpl" ?> 
                            <?php endforeach; ?>
                        </ul>
                    </div>
                    
            <?php else: ?>
                <div class="title">Статей не найдено</div>
                <?php if( !empty($subCats) ):?>
                <select id="seldef1" >
                    <?php foreach($subCats as $sc): ?>
                        <?php if($sc['active']):?>
                            <option selected="selected" value="<?=$sc['href']?>">
                                <a href="<?=$sc['href']?>"><?=$sc['name']?></a>
                            </option>
                        <?php else:?>
                            <option value="<?=$sc['href']?>">
                                <a href="<?=$sc['href']?>"><?=$sc['name']?></a>
                            </option>
                        <?php endif;?>
                    <?php endforeach;?>
                </select>
                <?php endif; ?>
            <?php endif;?>
        </div>
        <?php echo $paginationLazy;?>
        <?php echo $pagination;?>

        <?php echo $content_bottom; ?>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function(){
            $('#seldef1').on('change', function(){
                window.location.href = $(this).val();
            });
        });
    </script>
</div>
<?= $footer ?>