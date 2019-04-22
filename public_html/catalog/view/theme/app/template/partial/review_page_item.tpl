<div class = "review-block">
    <div class = "review">
        <div class = "top">
            <span><strong><?= $r['author'] ?></strong> о <b><?= $r['about'] ?></b></span>
            <p><?= $r['date'] ?></p>
        </div>
        <?= $r['text'] ?>
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