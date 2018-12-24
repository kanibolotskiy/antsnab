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
        <?php if( !empty($articles) ):?>
            <div class="news-container staty-container">
                <div class="title">Статьи</div>
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
                <script>
                    document.addEventListener('DOMContentLoaded', function(){
                        $('#seldef1').on('change', function(){
                            window.location.href = $(this).val();
                        });
                    });
                </script>
                <?php endif; ?>
                <div class="staty-list">
                    <ul id="lazy-load_container">
                        <?php  foreach ($articles as $article) : ?>
                           <?php include __DIR__ . "/partial/item_allarticles.tpl" ?> 
                        <?php endforeach; ?>
                    </ul>
                </div>
                
            </div>
            <?php echo $paginationLazy;?>
            <?php echo $pagination;?>
        <?php else: ?>
            <h1>Статей не найдено</h1>
        <?php endif;?>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?= $footer ?>