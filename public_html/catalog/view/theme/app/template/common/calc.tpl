<?= $header ?>
<div class="container main _compare_head">
    
    <div class="content without_sidebar _compare_head">
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <h1 class="title">Калькулятор</h1>
    </div>
</div>


    <div class="container main ">
        <div class="content without_sidebar">
            <div class="wrap_calculators">
                <div class="calc_select_row">
                    <div class="calc_select_col">
                        <div class="calc_select_caption">Выберите категорию товара:</div>
                        <select id="calc_select1">
                            <option value="1,2">Мастики, праймеры, битум</option>
                            <option value="3">Рулонные битумные материалы</option>
                            <option value="4,5">Герметики и клеи</option>
                            <option value="6">Монтажные пены</option>
                        </select>
                    </div>
                    <div class="calc_select_col">
                        <div class="calc_select_caption">Выберите калькулятор:</div>
                        <div class="wrap_calc_select2">
                            <select id="calc_select2">
                                <option value="0" data-display="-- выберите калькулятор">-- выберите калькулятор</option>
                                <option value="1">Битумные мастики</option>
                                <option value="2">Битумные праймеры</option>
                                <option value="3">Рулонные материалы</option>
                                <option value="4">Герметики в маленьких упаковках</option>
                                <option value="5">Герметики в ведрах</option>
                                <option value="6">Монтажные пены</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="calcs_wrapper">

                    <div class="calc_item" data-calc="1">
                        <div class="content-text">
                            <p>Для расчета необходимого количества материала введите площадь изолируемой поверхности</p>
                        </div>
                        <div class="wrap_calculator-block">
                            <div class="calculator-block">
                                <input type="number" placeholder="Площадь" id="inp_calc_1" class="inputCalc">
                                <span>м<sup>2</sup></span>
                                <div id="cl_button_calc_1" class="button_calc">Рассчитать</div>    
                            </div>
                            <div class="calculator-block_error">Заполните все поля</div>
                        </div>
                        <div class="content-text result_calc">
                            <p>Расчет необходимого количества материалов для гидроизоляции на площадь <span id="rez_calc1"></span> м<sup>2</sup></p>
                        </div>
                    </div>

                    <div class="calc_item" data-calc="2">
                        <div class="content-text">
                            <p>Для расчета необходимого количества праймера введите площадь поверхности, которую необходимо загрунтовать</p>
                        </div>
                        <div class="wrap_calculator-block">
                            
                            <div class="calculator-block">
                                <input type="number" placeholder="Площадь" id="inp_calc_2" class="inputCalc">
                                <span>м<sup>2</sup></span>
                                <div id="cl_button_calc_2" class="button_calc">Рассчитать</div>
                            </div>
                            <div class="calculator-block_error">Заполните все поля</div>
                        </div>
                        <div class="content-text result_calc">
                            <p>Расчет необходимого количества материалов для гидроизоляции на площадь <span id="rez_calc2"></span> м<sup>2</sup></p>
                        </div>
                    </div>

                    
                    <div class="calc_item" data-calc="3">
                        <div class="content-text">
                            <p>Для расчета необходимого количества материала введите площадь изолируемой поверхности</p>
                        </div>
                        <div class="wrap_calculator-block">
                            
                            <div class="calculator-block">
                                <input type="number" placeholder="Площадь" id="inp_calc_6" class="inputCalc">
                                <span>м<sup>2</sup></span>
                                <div id="cl_button_calc_6" class="button_calc">Рассчитать</div>
                            </div>
                            <div class="calculator-block_error">Заполните все поля</div>
                        </div>
                        <div class="content-text result_calc">
                            <p>Расчет необходимого количества материалов на площадь <span id="rez_calc6"></span> м<sup>2</sup></p>
                        </div>     
                    </div>

                    <div class="calc_item" data-calc="4">
                        <div class="content-text">
                            <p>Для расчета необходимого количества материала введите параметры герметизируемого шва:</p>
                        </div>
                        <div class="wrap_calculator-block">
                            <div class="calculator-block">
                                <div class="calculator-block_col">
                                    <input class="inputCalc" type="number" placeholder="Длина шва" id="inp_calc_31">
                                    <span>п.м.</span>
                                </div>
                                <div class="calculator-block_col">
                                    <input class="inputCalc" type="number" placeholder="Ширина шва" id="inp_calc_32">
                                    <span>мм</span>
                                </div>
                                <div class="calculator-block_col">
                                    <input class="inputCalc" type="number" placeholder="Толщина слоя" id="inp_calc_33">
                                    <span>мм</span>
                                </div>
                                <div id="cl_button_calc_3" class="button_calc">Рассчитать</div>
                            </div>
                            <div class="calculator-block_error" style="display: none;">Заполните все поля</div>
                        </div>

                        <div class="content-text result_calc">
                            <p>Расчет необходимого количества материалов для герметизации шва длиной <span id="rez_calc3_1"></span> п.м., шириной <span id="rez_calc3_2"></span> мм, с толщиной слоя <span id="rez_calc3_3"></span> мм:</p>
                        </div>   
                    </div>

                    <div class="calc_item" data-calc="5">
                        <div class="content-text">
                            <p>Для расчета необходимого количества материала введите параметры герметизируемого шва:</p>
                        </div>

                        <div class="wrap_calculator-block">
                            <div class="calculator-block">
                                <div class="calculator-block_col">
                                    <input class="inputCalc" type="number" placeholder="Длина шва" id="inp_calc_41">
                                    <span>п.м.</span>
                                </div>
                                <div class="calculator-block_col">
                                    <input class="inputCalc" type="number" placeholder="Ширина шва" id="inp_calc_42">
                                    <span>см</span>
                                </div>
                                <div class="calculator-block_col">
                                    <input class="inputCalc" type="number" placeholder="Глубина шва" id="inp_calc_43">
                                    <span>см</span>
                                </div>
                                <div id="cl_button_calc_4" class="button_calc">Рассчитать</div>
                            </div>
                            <div class="calculator-block_error">Заполните все поля</div>
                        </div>
                        
                        <div class="content-text result_calc">
                            <p>Расчет необходимого количества материалов для герметизации шва длиной <span id="rez_calc4_1"></span> п.м., шириной <span id="rez_calc4_2"></span> см, глубиной <span id="rez_calc4_3"></span> см:</p>
                        </div>

                    </div>
                    <div class="calc_item" data-calc="6">
                        <div class="content-text">
                            <p>Для расчета необходимого количества материала введите параметры заполняемого шва:</p>
                        </div>
                        <div class="wrap_calculator-block">
                            <div class="calculator-block">  
                                <div class="calculator-block_col">
                                    <input class="inputCalc" type="number" placeholder="Длина шва" id="inp_calc_51">
                                    <span>п.м.</span>
                                </div>
                                <div class="calculator-block_col">
                                    <input class="inputCalc" type="number" placeholder="Ширина шва" id="inp_calc_52">
                                    <span>см</span>
                                </div>
                                <div class="calculator-block_col">
                                    <input class="inputCalc" type="number" placeholder="Глубина шва" id="inp_calc_53">
                                    <span>см</span>
                                </div>
                                <div id="cl_button_calc_5" class="button_calc">Рассчитать</div>
                            </div>
                            <div class="calculator-block_error">Заполните все поля</div>
                        </div>
                        <div class="content-text result_calc">
                            <p>Расчет необходимого количества материалов для заполнения шва длиной <span id="rez_calc5_1"></span> п.м., шириной <span id="rez_calc5_2"></span> см, глубиной <span id="rez_calc5_3"></span> см:
                        </p></div>
                    </div>
                </div>

                <div class="calc_products">
                    <ul class="calc_product_list" id="calc_product_list"></ul>
                    <div class="calc_product_dop_list_caption">Также может понадобится</div>
                    <ul class="calc_product_list" id="calc_product_dop_list"></ul>
                </div>
            </div>
        </div>        
    </div>
    
</div>
<?= $footer ?>
