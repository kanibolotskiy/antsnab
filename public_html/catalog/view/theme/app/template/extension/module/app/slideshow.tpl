<div class="gallery-holder slideshow">
    <div class="gallery">
        <div class="gholder">
            <a class="btn-prev" href="#">&lt;</a>
            <a class="btn-next" href="#">&gt;</a>
            <div class="gmask">
                <div class="slideset">
                    <?php $counter = 0; ?>
                    <?php foreach ($banners as $banner) { ?>
                    <?php $counter++; ?>
                        <?php if( 1 == $counter): ?>
                        <div class="slide c1 active">
                        <?php else: ?>
                        <div class="slide c<?=$counter?>">
                        <?php endif;?>
                            <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
                            <div class="slide-block">
                                <span><?php echo $banner['title']; ?></span>
                                <?=$banner['descr'];?>
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