<div class = "review-block">
    <div class = "review">
        <div class = "top">
            <span><strong><?= $r['author'] ?></strong> о <b><?= $r['about'] ?></b></span>
            <p><?= $r['date'] ?></p>
        </div>
        <div class="rating_stars _reviews">    
            <?php for($i=1;$i<=5;$i++){?>
                
                <?php if($i<=$r['rating']){?>
                    <div class="star_block"></div>
                <?php }else{?>
                    <div class="star_block _hide"></div>
                <?php }?>

            <?php }?>
        </div>
        <div class="reviewBody"<?= $r['text'] ?></div>
    </div>
    <?php if (!empty($r['answer'])): ?>
        <div class = "review answer-review">
            <div class = "top">
                <span><strong><?= $r['moderator'] ?></strong></span>
            </div>
            <em><?= $r['answer'] ?></em>
        </div>
    <?php endif; ?>
</div>