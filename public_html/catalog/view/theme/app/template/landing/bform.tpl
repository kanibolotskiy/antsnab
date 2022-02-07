<div class="_flex wrap_bform">
    <div class="b_form1">
        <div class="bottom_form_info _flex">
            <div class="bform_info">
                <div class="bform_caption"><?=$block_bform_caption?></div>
                <div class="bform_perc">
                    <div class="bform_perc_shadow"></div>
                    <span><?=$block_bform_perc?></span>
                </div>
            </div>
            <div class="bform_form wrap_form">
                <form action="#" method="POST" data-goal="lp-send-form-down">
                    <input class="inpF" type="hidden" name="landing" value="<?=$title?>"/>
                    <input class="inpF" type="hidden" name="landing_id" value="<?=$landing_id?>"/>
                    <input class="inpF" type="text" name="workemail" value=""/>
                    <input class="inpF" type="hidden" name="gf" value="1"/>
                    <input type="hidden" name="subject" value="Заказ звонка"/>
                    <input type="hidden" name="tp" value="1"/>

                    <div class="form_rows ">
                        <div class="form_row">
                            <input name="phone" type="phone" class="inputRow inputForm inputPhone required" />
                        </div>
                    </div>
                    <div class="form_row">
                            <button class="sendForm buttonSend" type="submit">Отправить заявку</button>
                        </div>
                    <div class="form_row_hint">
                        <span id="form_more" class="js_goal" data-goal="lp-skidka-bolshe">Хочу скидку больше</span>
                    </div>
                </form>
                <div class="form_thanks">
                    <?=html_entity_decode($mailthanks)?>
                </div>
            </div>
        </div>
    </div>
    <div class="b_form2" style="display:none;">
        <div class="bottom_form_info _flex">
            <div class="bform_info">
                <div class="bform_caption">Заполните форму и получите оптовое предложение с максимальной скидкой</div>
                <div class="bform_hint">
                    Мы отправим специальное коммерческое предложение на вашу электронную почту
                </div>
                <div class="bform_bt">Оставлю только телефон</div>
            </div>
            <div class="bform_form wrap_form">
                <form action="#" method="POST" data-goal="lp-send-full-form">
                    <input class="inpF" type="hidden" name="landing" value="<?=$title?>"/>
                    <input class="inpF" type="hidden" name="landing_id" value="<?=$landing_id?>"/>
                    <input class="inpF" type="text" name="workemail" value=""/>
                    <input class="inpF" type="hidden" name="tp" value="2"/>

                    <div class="form_rows ">
                        <div class="form_row">
                            <input placeholder="Имя *" name="name" type="text" class="inputRow inputForm required" />
                        </div>
                        <div class="form_row">
                            <input name="phone" type="phone" class="inputRow inputForm required inputPhone" />
                        </div>
                        <div class="form_row">
                            <input placeholder="E-mail *" name="email" type="text" class="inputRow inputForm required" />
                        </div>
                        <div class="form_row">
                            <input placeholder="ИНН *" name="inn" type="text" class="inputForm inputRow half_required" />
                            <div class="or_label">или</div>
                        </div>
                        <div class="form_row">
                            <input placeholder="Название компании *" name="firma" type="text" class="inputForm inputRow half_required" />
                        </div>
                        <div class="form_row">
                            <input placeholder="Сайт компании (необязательно)" name="site" type="text" class="inputForm inputRow" />
                        </div>
                        <div class="form_row">
                            <button class="sendForm buttonSend" type="submit">Отправить заявку</button>
                        </div>
                    </div>
                </form>
                <div class="form_thanks">
                    <?=html_entity_decode($mailthanks_full)?>
                </div>
            </div>
        </div>
    </div>
</div>