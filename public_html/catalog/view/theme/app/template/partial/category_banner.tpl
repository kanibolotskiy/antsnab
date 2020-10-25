<?php if(count($banners)){?>
    <div class="wrap_category_banners">
        <div class="category_banners" id="category_banners">
            <?php foreach($banners as $banner) {?>
                <div class="category_banner">
                    <a href="<?=$banner['link']?>">
<picture >
    <source type="image/webp" srcset="<?=$banner['image_webp']?>">
    <source type="image/jpeg" srcset="<?=$banner['image']?>">
    <img src="<?=$banner['image']?>" alt="<?=$banner['title']?>"/>
</picture>
                        
                    </a>
                </div>
            <?php }?>
        </div>
    </div>
<?php }?>