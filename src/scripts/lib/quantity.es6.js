import './decimalRound.js';
var Fraction = require('fraction.js');
/*
 * Терминология
 * Кратные единицы (sale) - те, в которых осуществляется продажа и которые определяют шаг продажи
 * Пользовательские/отображаемые единицы (ui) - любая единица доступная для данного товара из переключателя
 */
class Quantity {
    static init(selector, opts) {
        if (undefined === opts) {
            opts = {};
        }

        var $els = (selector instanceof jQuery)?selector:$(selector),
            elName = (opts.el_name)?opts.el_name:null; // не путать с opts.ui_names. el_name это аттрибут name input поля

        $els.each(function () {
            let view = new QuantityView(this, elName),
                controller = new Quantity(view, opts);
            $(this).data('quantity', controller);
        });

    }
    
    constructor(view, opts) {
        this._options = {
            /** SaleQuantity options */
            'sale_step': opts.sale_step? parseFloat(opts.sale_step) : 1,
            'sale_minimum': opts.sale_minimum? parseFloat(opts.sale_minimum) : 1,

            /** Injected uis' quantity options */
            'sale_to_ui_koef': opts.sale_to_ui_koef ? new Fraction(opts.sale_to_ui_koef) : new Fraction(1),
            'ui_minimum': opts.ui_minimum ? parseFloat(opts.ui_minimum) : null, 
            'ui_step': opts.ui_step ? parseFloat(opts.ui_step) : null,
            'ui_names': opts.ui_names || {}

            //'sale_to_price_koef': new Fraction(opts.sale_to_price_koef) || new Fraction(1),
        };
        
        this.view = view;
        this.model = new SaleQuantityModel(this._options.sale_minimum, this._options.sale_step) ;
        this.model.setUiModel(this._options.sale_to_ui_koef, this._options.ui_minimum, this._options.ui_step);

        this._registerEvents();
        this.view.$input = this.getQuantityInUiUnits(); 
        this.view.$uName = this._resolveUiName(this._options.ui_names); //this._options.ui_name;

        this.view.render();

        return this;
    }

    

    /**
     * Получить количество в выбранных пользователем единицах
     * Только для отображения! Не исползовать для расчетов цен
     */
    getQuantityInUiUnits() {
        return Math.round10(this.model.uiQuantity.valueOf(), -3);
    }

    /**
     * Установить новое значение, в отображаемых единицах 
     * @param {*} value 
     */
    setQuantityInUiUnits(value) {
        /** @task Здесь необходима проверка value - например на 1.09.01 - fraction отваливается */
        this.model.uiQuantity = new Fraction(value);

        /** Количество автоматически округляется до шага кратности, возвращаем в инпут актуальное значение */
        this.view.$input = this.getQuantityInUiUnits();
        this.view.$uName = this._resolveUiName(); 
    }

    /**
     * Получить текущее количество в кратных единицах.
     */
    getQuantityInSaleUnits() {
        return this.model.saleQuantity.valueOf();
    }

    /**
     * Переключить режим представления 
     * @param {string} sale_to_ui_koef - коэффициент пересчета из
     * единицы кратности в новую пользовательскую единицу (дробь-строковое представление)
     * @param {string} ui_name - отображаемое имя
     */
    switch(sale_to_ui_koef, ui_minimum, ui_step, ui_names) {
        ui_minimum = ui_minimum ? parseFloat(ui_minimum) : null;
        ui_step = ui_step ? new Fraction(ui_step) : null;
        if( !sale_to_ui_koef ) {
            console.warn('You should set the koef for converting this value to your sale unit value');
        }
        this.model.setUiModel(new Fraction(sale_to_ui_koef), ui_minimum, ui_step);
        this.view.$input = this.getQuantityInUiUnits(); 
        this.view.$uName = this._resolveUiName(ui_names);
    }

    _registerEvents() {
        this.view.$input.on('change', this._changeHandler.bind(this));
        this.view.$plusButton.on('click', this._handleUp.bind(this));
        this.view.$minusButton.on('click', this._hadleDown.bind(this));
    }

    _handleUp() {
        this.model.up(1);
        this.view.$input = this.getQuantityInUiUnits();
        this.view.$uName = this._resolveUiName();  
    }

    _hadleDown() {
        this.model.down(1);
        this.view.$input = this.getQuantityInUiUnits();
        this.view.$uName = this._resolveUiName();  
    }

    _changeHandler(e) {
        this.setQuantityInUiUnits(this.view.$input.val());
    }

    /**
     * Склоняет отображение единицы измерения в инпуте, в зависимости от количества. Порт
     * аналогичной php функции @see app/Override/Gateway/ProdUnits/ProdUnitStrings.php::plural
     * @param {*} names 
     */
    _resolveUiName(names) {
        if ( undefined == names ) {
            names = this._options.ui_names;
        }
        if( undefined == names.ui_name ) {
            return '';
        }
        var fullDictionary = {
                name: names.ui_name,
                plural: names.ui_name_plural || names.ui_name,
                genitive: names.ui_name_genitive || names.ui_name
            },
            qnt = this.getQuantityInUiUnits(),
            absQnt = Math.abs(qnt),
            absQntStr = absQnt.toString(),
            lastDigit = absQntStr[ absQntStr.length - 1],
            beforeLastDigit = absQntStr[ absQntStr.length - 2];

    
        if (beforeLastDigit == '1' && absQntStr.length > 1 ) {
            return fullDictionary.plural; 
        } else if (lastDigit == '1') {
            return fullDictionary.name; 
        } else if ( ['2','3','4'].includes(lastDigit) ) {
            return fullDictionary.genitive;
        } else {
            return fullDictionary.plural; 
        }
    }

    /**
     * Получить текущее количество в единицах, в которых
     * ведется учет (для передачи в корзину и расчета сумм)
     * @deprecated
     */
    /*getQuantityInPriceUnits() {
        let quantityInSaleUnits = this.model.saleQuantity,
            saleToPriceKoef = this._options.sale_to_price_koef;
        return saleToPriceKoef.mul(quantityInSaleUnits).valueOf();
    }*/
}

/**
 * Модель для хранения единицы кратности 
 * (той единицы, кратно которой продаем, напр. рулон)
 * 
 * Хранит в себе текущее неокруглённое количество в продаваемых
 * еденицах. Служит фасадом доступа поверх других единиц, с которыми
 * пользователь работает в пользовательском интерфейсе
 */
class SaleQuantityModel {

    /**
     * @param {int} minimum - начальное значение (от..)
     */
    constructor(minimum, step) {
        this._saleMinimum = minimum;
        this._quantity = Fraction(minimum);
        this._saleStep = Fraction(step);
        this._uiKoef = Fraction(1);

        this.setUiModel(this._uiKoef, this._saleMinimum, this._saleStep);
    }

    /**
     * Получить текущее значение в единицах кратности 
     * @return Fraction
     */
    get saleQuantity() {
        return this._quantity;
    }

    /**
     * Множитель перевода из кратных едениц в текущую пользовательскую
     * (sale_to_ui option), например, в рулоне 20м2 Продаем рулонами
     * uiKoef = 20 (перевести рулоны в м2 - нужно умножить на 20) 
     * @return Fraction
     */
    get uiKoef() {
        return this._uiKoef;
    }


     /**
      * Получить текущее значение в пользовательских единицах
      * @return Fraction 
      */
    get uiQuantity() {
        return this._uiModel.value;
    }

    /**
     * Установить новое количество в пользовательских единицах
     * Количество кратных единиц пересчитывается автоматически
     * @param {Fraction} uiQuantity 
     */
    set uiQuantity(uiQuantity) {
        this._uiModel.value = uiQuantity;
        /** Нужно пересчитать актуальное значение в единицах кратности*/
        this._refresh();
    }

    /**
     * Увеличить количество на n шагов
     * Шаг - это число, на которое можно уменьшать или увеличивать
     * пользовательскую единицу измерения, чтобы не терять кратность покупки 
     * @param {int} steps 
     */
    up(steps) {
        this._uiModel.up(steps);
        this._refresh();
    }

    /**
     * Уменьшить количество на n шагов 
     * @param {int} steps 
     */
    down(steps) {
        this._uiModel.down(steps);
        this._refresh();
    }

    /** При изменении значений uiModel сама делает подгонку (округление) в соответствии со свои step. Родительскую модель надо рефрешить */
    _refresh() {
        this._quantity = this._uiModel.value.div(this._uiKoef);
    }

    /**
     * Устанавливаем модель, поверх которой работает
     * пользователь в данный момент  
     * @param {Fraction} koef - множитель перевода из кратной еденицы в пользовательскую 
     * @param {float} minium - минимальный порог пользовательской единицы (не может быть меньше sale unit)
     * @param {Fraction} step - шаг пользовательской модели (не может быть меньше шага sale unit)
     */
    setUiModel(koef, minimum, step) {
        let uiStep, uiMinimum;
        
        if(!minimum) {
            uiMinimum = koef.mul(this._saleMinimum ); 
        } else {
            if( Fraction(minimum).div(koef).compare(this._saleMinimum) >= 0) { //given minimum is bigger or equal than sale minimum
                uiMinimum = new Fraction(minimum);
            } else {
                uiMinimum = koef.mul(this._saleMinimum );
                console.warn('ui units minimum cant be less that its related sale unit'); 
            }
        }
        
        if(!step) {
            uiStep = koef;
        } else {
            step = new Fraction(step);
            if( step.div(koef).compare(this._saleStep) >= 0 ) { //given step is bigger than sale step
                uiStep = step;
                //@todo - step должен содержать целое число sale steps
            } else {
                uiStep = koef;                
                console.warn('ui units step cant be less that its related sale unit');
            }
        }

        this._uiModel = new UiQuantityModel(uiStep, uiMinimum);
        this._uiModel.value = koef.mul(this._quantity);
        this._uiKoef = koef;

        this._refresh();
    }

}

/**
 * Хранит текущее состояние выбора пользователя
 * в пользовательских (выбранных) единицах продажи
 * 
 * Не используется без фасада SaleQuantityModel
 * 
 * @param Fraction step
 * @param Fraction minimum
 */
class UiQuantityModel {

    constructor(step, minimum) {
        this._step = step;
        this._minimum = minimum;
        this._value = this._minimum;
    }

    get value() {
        return this._value;
    }

    /** Округляет переданный nval под ровное количество шагов для данной UiUnit! */
    set value(nval) {
        let steps = Math.round(nval.sub(this._value).div(this._step).valueOf());
        if (steps >= 0) {
            this.up(steps);
        } else {
            this.down(Math.abs(steps));
        }
    }

    up(steps) {
        if (steps < 0) {
            console.warn("up step cant be negative do nothing");
            return;
        }
        this._value = this._value.add(this._step.mul(steps));
    }

    down(steps) {
        if (steps < 0) {
            console.warn("up step cant be negative do nothing");
            return;
        }
        this._value = this._value.sub(this._step.mul(steps));
        if ( this._value.compare(this._minimum) < 0 )  { // < miniumum
            this._value = this._minimum;
        }
    }
}


class QuantityView {
    static minusButClass = 'LeftButton';
    static plusButClass = 'RightButton';
    static inputName = 'qnt';
    static unameClass = 'unameVal'

    constructor(container, name) {
        this.$container = $(container);
        this.el = document.createElement('DIV');
        this.$el = $(this.el);
        this.$el.css('display', 'flex');
        this.$el.css('justify-content', 'space-between');
        this.$el.css('align-items', 'center');

        var elName = (name)?name:QuantityView.inputName + Math.random();
        this._elName = elName;

        this.$el.html('<div class="' + QuantityView.minusButClass + '"></div>\
             <input class="qnt" type="text" name="' + elName + '" />\
             <span class="' + QuantityView.unameClass + '"></span>\
             <div class="'+ QuantityView.plusButClass + '"></div>');
    }

    get $minusButton() {
        return $('.' + QuantityView.minusButClass, this.$el);
    }

    get $plusButton() {
        return $('.' + QuantityView.plusButClass, this.$el);
    }

    get $uName() {
        return $('.' + QuantityView.unameClass, this.$el);
    }

    set $uName(value) {
        $('.' + QuantityView.unameClass, this.$el).html(value);
    }

    get $input() {
        return $('input[name="' + this._elName  + '"]', this.$el);
    }

    set $input(value) {
        $('input[name="' + this._elName + '"]', this.$el).val(value);
    }

    render() {
        this.$container.addClass('qnt-widget');
        this.$container.append(this.$el);
    }
}

export {Quantity};