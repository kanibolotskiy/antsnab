<div>
    <div class="calculator" calc_data1="<?php echo $calc_data1;?>" calc_data2="<?php echo $calc_data2;?>" calc_data3="<?php echo $calc_data3;?>" id="calculator">
        <div class="content-text">
            <p>Для расчета необходимого количества материала введите площадь изолируемой поверхности:</p>
        </div>

        <div class="wrap_calculator-block">
            <div class="calculator-block">  
                <div class="calculator-block_col">
                    <input class="inputCalc" type="number" placeholder="Площадь" id="input_calc_6">
                    <span>м<sup>2</sup></span>
                </div>
                <div id="button_calc_6" class="button_calc">Рассчитать</div>
            </div>
            <div class="calculator-block_error">Заполните все поля</div>
        </div>
        <div class="wrap_table_data wrap_table_calc">
            <div class="content-text">
                <p>Расчет необходимого количества материалов на площадь <span class="input_area" id="input_area6"></span> м<sup>2</sup></p>
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
                            <div class="calc_hint"><span id="calc_hint_caption">мин. для заказа</span> <span id="calc_out2"></span></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="_left">В рулонах это:</td>
                        <td class="nowrap">
                            <div id="calc_out3" data-count="0">-</div>
                            <div class="calc_hint"><span id="calc_hint_caption">мин. для заказа</span> <span id="calc_out4"></span></div>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="_left">Для подготовки поверхности необходим <a target="_blank" href="https://ant-snab.ru/products/mastics/praimers/praimer-proof/">Битумный праймер</a> в количестве:</td>
                        <td class="nowrap">
                            <div id="calc_out5" data-count="0">-</div>
                            <div class="calc_hint"><span id="calc_hint_caption">мин. для заказа</span> <span id="calc_out6"></span></div>
                        </td>
                    </tr>                    
                    <tr>
                        <td class="_left">Еще необходима <a target="_blank" href="https://ant-snab.ru/products/mastics/cold/krovelnaya-mastika-proof/">Битумная мастика</a> в количестве:</td>
                        <td class="nowrap">
                            <div id="calc_out7" data-count="0">-</div>
                            <div class="calc_hint"><span id="calc_hint_caption">мин. для заказа</span> <span id="calc_out8"></span></div>
                        </td>
                    </tr>                    
                </tbody>
            </table>
            <div class="calc_footer">
                <div class="button_calc to_cart_from_calc" id="add_calcdata_tocart6">Добавить расчет в корзину</div>
                <div class="content-text">
                    <p>Приведенные цифры являются справочными, за точными расчетами и консультацией обращайтесь к <a title="Контакты" target="_blank" href="contacts/" >нашим сотрудникам</a></p>
                </div>
            </div>
        </div>        
    </div>
</div>