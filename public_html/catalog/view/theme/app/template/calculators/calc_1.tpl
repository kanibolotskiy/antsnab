<div>
    <div class="calculator" data-consumption="<?php echo $consumption;?>" id="calculator">
        <div class="content-text">
            <p>Для расчета необходимого количества материала введите площадь изолируемой поверхности.</p>
        </div>

        <div class="calculator-block">
            
            <input type="number" placeholder="Площадь" id="input_calc_1">
            <span>м<sup>2</sup></span>
            <div id="button_calc_1" class="button_calc">Рассчитать</div>
        
        </div>  
        <div class="wrap_table_data">
            <div class="content-text">
                <p>Расчет необходимого количества материалов для гидроизоляции на площадь <span class="input_area" id="input_area">-</span></p>
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
                        <td class="_left">Также для подготовки поверхности необходим <a target="_blank" title="Битумный праймер Пруф" href="products/mastics/praimers/praimer-proof/">Битумный праймер</a> в количестве:</td>
                        <td class="nowrap" id="calc_out3" data-count="0">-</td>
                    </tr>
                </tbody>
            </table>
            <div class="calc_footer">
                <div class="button_calc to_cart_from_calc" id="add_calcdata_tocart1">Добавить расчет в корзину</div>

                <div class="content-text">
                    <p>Приведенные цифры являются справочными, за точными расчетами и консультацией обращайтесь к <a title="Контакты" target="_blank" href="contacts/" >нашим сотрудникам</a></p>
                </div>
            </div>
        </div>
        
    </div>
</div>