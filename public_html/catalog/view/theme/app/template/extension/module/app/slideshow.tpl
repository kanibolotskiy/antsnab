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
                        <div class="slide c1 active" style="background-image:url(<?php echo $banner['image']; ?>)">
                        <?php else: ?>
                        <div class="slide c<?=$counter?>" style="background-image:url(<?php echo $banner['image']; ?>)">
                        <?php endif;?>
                            
                            <a href="<?php echo $banner['link']; ?>" title="<?php echo $banner['title']; ?>">
                            <!--<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>">-->
                            <div class="slide-block">
                                <div class="slide-block-border">
                                    <div class="slide-block_caption"><?=$banner['title'];?></div>
                                    <div class="slide-block_text"><?=$banner['descr'];?></div>
                                </div>
                            </div>
                            </a>
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