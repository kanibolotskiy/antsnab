<div class="_flex wrap_bform">

    <div class="bform_info">
        <div class="bform_caption"><?=$block_bform_caption?></div>
        <div class="bform_perc">
            <div class="bform_perc_shadow"></div>
            <span><?=$block_bform_perc?></span>
        </div>
    </div>
    <div class="bform_form">
        <form action="#" method="POST">
            <input type="hidden" id="bform_type" name="bform_type" value="1" />
            <div class="form_rows ">
                <div class="form_row _hidden">
                    <input placeholder="Имя *" name="name" type="text" class="inputRow" />
                </div>
                <div class="form_row">
                    <input placeholder="test" id="phone2" name="phone" type="phone" class="inputRow inputPhone" />
                </div>
                <div class="form_row _hidden">
                    <input placeholder="E-mail *" name="email" type="text" class="inputRow" />
                </div>
                <div class="form_row _hidden">
                    <input placeholder="ИНН или название компании *" name="inn" type="text" class="inputRow" />
                </div>
                <div class="form_row _hidden">
                    <input placeholder="Сайт компании *" name="site" type="text" class="inputRow" />
                </div>
                <div class="form_row">
                    <button class="buttonSend" type="submit">Получить предложение</button>
                </div>
            </div>
            <div class="form_row_hint">
                <span id="form_more">Хочу скидку больше</span>
            </div>
        </form>
    </div>
</div>