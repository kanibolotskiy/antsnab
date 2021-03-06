
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
                <div class="wrp_star">
                    <span>Отзыв:
                        <i id="error_text" class="error"></i>
                    </span>
                    <div class="wrp_star_rating">
                        <input type="hidden" name="rating" value="5" id="star_value"/>
                        <span class="rating_caption">Рейтинг:</span>
                        <div class="rating_stars">
                            <div class="star_block rating_star _rate" rel="1"></div>
                            <div class="star_block rating_star _rate" rel="2"></div>
                            <div class="star_block rating_star _rate" rel="3"></div>
                            <div class="star_block rating_star _rate" rel="4"></div>
                            <div class="star_block rating_star _rate" rel="5"></div>
                        </div>
                        <div class="rating_stars_value">(<span id="rating_stars_value">5</span>)</div>
                    </div>
                </div>
                    <textarea  placeholder="Поделитесь своим мнением о нашей компании" name="text"><?= $entry_text ?></textarea>
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
    <div id="lazy-load_container">
        <?php foreach ($reviews as $r): ?>
            <?php include __DIR__ . '/../../../partial/review_page_item.tpl' ?>
        <?php endforeach; ?>
    </div>
    <!--<div class="page-navigation page-navigation2">-->
        <?php echo $paginationLazy;?>
        <?php echo $pagination; ?>
    <!--</div>-->
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

