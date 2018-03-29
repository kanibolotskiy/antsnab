<div class="gallery-holder slideshow">
    <div class="gallery">
        <div class="gholder">
            <a class="btn-prev" href="#">&lt;</a>
            <a class="btn-next" href="#">&gt;</a>
            <div class="gmask">
                <div class="slideset">
                    <?php foreach ($banners as $banner) { ?>
                    <div class="slide c1 active">
                        <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
                        <div class="slide-block">
                            <span><?php echo $banner['title']; ?></span>
                            <p><?=$banner['descr']?></p>
                        </div>
                    </div>
                    <?php } ?>
                </div>
            </div>
        </div>
        <div class="pagination">
            <ul>
                <li class="active"><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
            </ul>
        </div>
    </div>
</div>
<!--@task to scss-->
<style>
   .gallery-holder a.btn-prev, .gallery-holder a.btn-next,
   .gallery-holder a.btn-prev, .gallery-holder a.btn-prev {
       bottom: 12px;
   }

   .gallery-holder .pagination {
       bottom: 62px;
   }
</style>