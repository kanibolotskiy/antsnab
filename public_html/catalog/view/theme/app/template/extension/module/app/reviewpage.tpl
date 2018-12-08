
<div class = "reviews-container">
    <div class = "give-feedback">
        <div class = "title-give-feedback">Оставить отзыв</div>
        <form id="review_form">


            <div class = "row">
                <span>Имя: 
                    <i id="error_author" class="error"></i>
                </span>
                <input name="author" type = "text" placeholder="Введите Ваше имя" value="<?= $entry_author ?>" />
            </div>
            <div class = "row">
                <span>
                    e-mail:
                    <i id="error_email" class="error"></i>
                </span>
                <input value="<?= $entry_email ?>" type = "text" name="email" placeholder="Введите Ваш e-mail"/>
            </div>
            <div class = "row">
                <span>Организация:
                </span>
                <input value="<?= $entry_company ?>" type = "text" name="company" placeholder="Введите название организации"/>
            </div>
            <div class = "row">
                <span>Отзыв:
                    <i id="error_text" class="error"></i>
                </span>
                    <textarea  placeholder="Напишите Ваше мнение о нашей компании" name="text"><?= $entry_text ?></textarea>
            </div>
            <div class = "agreement">
                <input name="agree" class="error" type = "checkbox" id = "agree" value="1"/>
                <label for = "agree" id="agreeLabel">
                    Я согласен с <a target="_blank" href = "<?=$rules?>">правилами</a>
                    <i id="error_agree" class="error"></i>
                </label>
            </div>

            <div id="ajax_loader" class="ajax_loader">
                <div class="loader-classic">
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div> 

            <button 
                id="button-review_page"
                data-action="<?= $action ?>"
                type="button"
                > Добавить отзыв
            </button>

            <?php /* captcha is disabled now <button
                type="submit"
                form="review_form"
                class="g-recaptcha"
                data-sitekey="<?= $captcha_key ?>"
                data-callback="submitReviewForm" >Добавить отзыв</button>*/?>
            
        </form>
    </div>
    <?php foreach ($reviews as $r): ?>
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
    <?php endforeach; ?>
    <div class="page-navigation page-navigation2">
        <?php echo $pagination; ?>
    </div>
</div>

    <div class="popup thank-you"> 
        <div class="close"></div>
        <div class="popup-block">
            <div class="popup-content">
                <div class="close2"></div>
                <span><?=$text_thankyou_header?></span>
                <p class="popup-block_text"><?=$text_thankyou?></p>
            </div>
        </div>
    </div>

