<?php if(count($banners)){?>
    <div class="category_banners" id="category_banners">
        <?php foreach($banners as $banner) {?>
            <div class="category_banner">
                <a href="<?=$banner['link']?>"><img src="<?=$banner['image']?>" alt="<?=$banner['title']?>"/></a>
            </div>
        <?php }?>
    </div>
<?php }?>