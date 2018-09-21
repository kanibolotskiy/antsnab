<?= $header ?>

<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <?php echo $content_top; ?>
        <div class = "reviews-container">
            <div class = "give-feedback">
                <div class = "title-give-feedback">Оставить отзыв</div>
                <form id="review_form" action = "<?= $action ?>" method="post">
                    <div class = "row">
                        <span>Имя: 
                            <?php if (isset($errors['author'])): ?>
                                <i class="error"><?= $errors['author'] ?></i>
                            <?php endif; ?>
                        </span>
                        <?php if (isset($errors['author'])): ?>
                            <input class="error" name="author" type = "text" placeholder="Ведите Ваше имя" value="<?= $entry_author ?>">
                        <?php else: ?>
                            <input name="author" type = "text" placeholder="Ведите Ваше имя" value="<?= $entry_author ?>">
                        <?php endif; ?>
                    </div>
                    <div class = "row">
                        <span>
                            e-mail:
                            <?php if (isset($errors['email'])): ?>
                                <i class="error"><?= $errors['email'] ?></i>
                            <?php endif; ?>
                        </span>
                        <?php if (isset($errors['email'])): ?>
                            <input value="<?= $entry_email ?>" type = "text" class="error" name="email" placeholder="Введите Ваш e-mail">
                        <?php else: ?>
                            <input value="<?= $entry_email ?>" type = "text" name="email" placeholder="Введите Ваш e-mail">
                        <?php endif; ?>
                    </div>
                    <div class = "row">
                        <span>Организация:
                            <?php if (isset($errors['company'])): ?>
                                <i class="error"><?= $errors['company'] ?></i>
                            <?php endif; ?>
                        </span>
                        <?php if (isset($errors['company'])): ?>
                            <input value="<?= $entry_company ?>"  class="error" type = "text" name="company" placeholder="Введите название организации">
                        <?php else: ?>
                            <input value="<?= $entry_company ?>" type = "text" name="company" placeholder="Введите название организации">
                        <?php endif; ?>
                    </div>
                    <div class = "row">
                        <span>Отзыв:
                            <?php if (isset($errors['text'])): ?>
                                <i class="error"><?= $errors['text'] ?></i>
                            <?php endif; ?>
                        </span>
                        <?php if (isset($errors['text'])): ?>
                            <textarea  class="error" name="text"><?= $entry_text ?></textarea>
                        <?php else: ?>
                            <textarea  name="text"><?= $entry_text ?></textarea>
                        <?php endif; ?>
                    </div>
                    <div class = "agreement">
                        <input name="agree" class="error" type = "checkbox" id = "agree" value="1"/>
                        <label for = "agree" id="agreeLabel">
                            Я согласен с <a target="_blank" href = "<?=$rules?>">правилами</a>
                            <?php if (isset($errors['agree'])): ?>
                                <i class="error"><?= $errors['agree'] ?></i>
                            <?php endif; ?>
                        </label>
                    </div>
                    <input
                        type ="submit"
                        class="g-recaptcha"
                        data-sitekey="<?= $captcha_key ?>"
                        data-callback="submitReviewForm" value="Добавить отзыв"/>
                    <script type="text/javascript">
                        function submitReviewForm()
                        {
                            $('#review_form').submit();
                        }
                        window.onload = function ()
                        {
                            $('#agreeeLabel').on('click', function (e) {
                                var ischecked = $('#agree').prop('checked');
                                $('#agree').prop('checked', !ischecked);
                            });
                        }
                    </script>
                </form>
            </div>
            <?php foreach ($reviews as $r): ?>
                <div class = "review-block">
                    <div class = "review">
                        <div class = "top">
                            <span><strong><?= $r['author'] ?></strong> о <b><?= $r['about'] ?></b></span>
                            <p><?= $r['date'] ?></p>
                        </div>
                        <em><?= $r['text'] ?></em>
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
        <?php echo $content_bottom; ?>
    </div>
</div>
<!--@task1 to css-->
<style>
    .popup .popup-block {
        top:120px;
    }
</style>
<?php if ($show_popup): ?>
    <div class="popup thank-you visible" style="display: block;">
        <div class="close"></div>
        <div class="popup-block">
            <div class="popup-content">
                <div class="close2"></div>
                <span>Благодарим вас за отзыв!</span>
                <!--@task1 to css-->
                <p style="text-align: center">Отзыв появится на сайте в ближайшее время</p>
            </div>
        </div>
    </div>
<?php endif; ?>
<?= $footer ?>
