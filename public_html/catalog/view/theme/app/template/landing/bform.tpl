<div class="_flex wrap_bform">

    <div class="bform_info">
        <div class="bform_caption"><?=$block_bform_caption?></div>
        <div class="bform_perc">
            <div class="bform_perc_shadow"></div>
            <span><?=$block_bform_perc?></span>
        </div>
    </div>
    <div class="bform_form wrap_form">
        <form action="#" method="POST">
            <input type="hidden" id="bform_type" name="bform_type" value="1" />
            <input class="inpF" type="hidden" name="landing" value="<?=$title?>"/>
            <input class="inpF" type="hidden" name="landing_id" value="<?=$landing_id?>"/>
            <input class="inpF" type="text" name="workemail" value=""/>

            <div class="form_rows ">
                <div class="form_row _hidden">
                    <input placeholder="Имя *" name="name" type="text" class="inputRow " />
                </div>
                <div class="form_row">
                    <input placeholder="test" name="phone" type="phone" class="inputRow inputForm inputPhone required" />
                </div>
                <div class="form_row _hidden">
                    <input placeholder="E-mail *" name="email" type="text" class="inputRow" />
                </div>
                <div class="form_row _hidden">
                    <input placeholder="ИНН или название компании *" name="inn" type="text" class="inputRow" />
                </div>
                <div class="form_row _hidden">
                    <input placeholder="Сайт компании (необязательно)" name="site" type="text" class="inputRow" />
                </div>
                <div class="form_row">
                    <button class="sendForm buttonSend" type="submit">Получить предложение</button>
                </div>
            </div>
            <div class="form_row_hint">
                <span id="form_more">Хочу скидку больше</span>
            </div>
        </form>
        <div class="form_thanks">
            <?=html_entity_decode($mailthanks)?>
        </div>
    </div>
</div>