<div class="reviews">
    <div class="title"><?=$heading_title?></div>
    <div class="slider responsive">
        <?php foreach( $reviews as $r):?>
        
        <div class="slick-slide">
            <div class="slick-slide-block">
                <div class="slick__review">
                    <div class="top">
                        <?php 
                            $about_txt='<a href="'.$r["href"].'">'.$r["about_txt"].'</a>';
                        ?>
                        <span><strong><?php echo $r["author"]?></strong> о <b><?php echo $about_txt?></b></span>
                        <p><?= date_format(date_create($r['date_added']), 'd.m.Y') ?></p>
                    </div>
                    <em><?=$r['text']?></em>
                </div>
            </div>
        </div>
        <?php endforeach;?>
    </div>
</div>
