<div>
    <div class="calculator" calc_data2="<?php echo $calc_data2;?>" calc_data3="<?php echo $calc_data3;?>" id="calculator">
        <div class="content-text">
            <p>Для расчета необходимого количества материала введите параметры герметизируемого шва:</p>
        </div>

        <div class="wrap_calculator-block">
            <div class="calculator-block">
                <div class="calculator-block_col">
                    <input class="inputCalc" type="number" placeholder="Длина шва" id="input_calc_41">
                    <span>п.м.</span>
                </div>
                <div class="calculator-block_col">
                    <input class="inputCalc" type="number" placeholder="Ширина шва" id="input_calc_42">
                    <span>см</span>
                </div>
                <div class="calculator-block_col">
                    <input class="inputCalc" type="number" placeholder="Глубина шва" id="input_calc_43">
                    <span>см</span>
                </div>
                <div id="button_calc_4" class="button_calc">Рассчитать</div>
            </div>
            <div class="calculator-block_error">Заполните все поля</div>
        </div>
        <div class="wrap_table_data wrap_table_calc">
            <div class="content-text">
                <p>Расчет необходимого количества материалов для герметизации шва длиной <span class="input_area" id="input_area1">-</span> п.м., шириной <span class="input_area" id="input_area2">-</span> см, глубиной <span class="input_area" id="input_area3">-</span> см:</p>
            </div>
            <table class="table_data _calc_table_data">
                <thead>
                    <tr>
                        <th>Материалы</th>
                        <th>Количество</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="_left">Материала <?=$heading_title?> вам понадобится:</td>
                        <td class="nowrap">
                            <div id="calc_out1" data-count="0">-</div>
                            <div class="calc_hint">мин. для заказа <span id="calc_out2"></span></div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="calc_footer">
                <div class="button_calc to_cart_from_calc" id="add_calcdata_tocart2">Добавить расчет в корзину</div>
                <div class="content-text">
                    <p>Приведенные цифры являются справочными, за точными расчетами и консультацией обращайтесь к <a title="Контакты" target="_blank" href="contacts/" >нашим сотрудникам</a></p>
                </div>
            </div>
        </div>        
    </div>
</div>