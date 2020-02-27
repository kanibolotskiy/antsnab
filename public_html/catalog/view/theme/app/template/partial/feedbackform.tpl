<div class="wrp_feedback">
    <h2>Обратная связь</h2>

    <form class="feedbackform" id="feedbackform" action="#" method="post">
        <div id="ajax_loader_feedback" class="ajax_loader" style="display: none;">
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
        <input value="" name="workemail" type="text" placeholder="Рабочий email">

        <div class="row">
            <div class="row_cap">Имя:<i class="error name"></i></div>
            <input value="" name="name" type="text" placeholder="Введите Ваше имя">
        </div>
        <div class="row">
            <div class="row_cap">Телефон:<i class="error phone"></i></div>
            <input value="" name="phone" type="tel" placeholder="Введите телефон" im-insert="true">
        </div>
        <div class="row">
            <div class="row_cap">Email:</div>
            <input value="" name="email" type="text" placeholder="Введите email" im-insert="true">
        </div>
        <div class="row">
            <div class="row_cap">Сообщение:</div>
            <textarea placeholder="Введите Ваше сообщение" name="text"></textarea>
        </div>
        <div class="row_cap">
            <p>Нажимая на кнопку Отправить, я даю <a target="_blank" href="http://antsnab.cp06038.tmweb.ru/agreement/">согласие на обработку персональных данных</a></p>
        </div>
        <div id="feedback_submit" class="call_submit">Отправить</div>
    </form>
</div>