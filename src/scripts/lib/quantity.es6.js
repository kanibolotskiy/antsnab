class Quantity {
    static init(selector, opts) {
        if (undefined === opts) {
            opts = {};
        }

        $(selector).each(function () {
            let view = new QuantityView(this),
                controller = new Quantity(view, opts);
            $(this).data('quantity', controller);
        });

    }

    constructor(view, opts) {

        this._options = {
            'minimum_sale': parseInt(opts.minimum_sale) || 1,
            'sale_to_ui_koef': parseFloat(opts.sale_to_ui_koef) || 1,
            'sale_to_price_koef': parseFloat(opts.sale_to_price_koef) || 1
        };

        this.view = view;
        this.model = new SaleQuantityModel(this._options.minimum_sale);
        this.model.setUiModel(this._options.sale_to_ui_koef);

        this._registerEvents();
        this.view.$input = this.model.uiQuantity;
        this.view.render();

        return this;
    }


    /**
     * Получить текущее количество в кратных единицах.
     * Всегда округляем в большую сторону.
     */
    getQuantityInSaleUnits() {
        return Math.ceil(this.model.explicitQuantity);
    }

    /**
     * Получить текущее количество в единицах, в которых
     * ведется учет (для передачи в корзину и расчета сумм)
     */
    getQuantityInPriceUnits() {
        let quantityInSaleUnits = this.getQuantityInSaleUnits(),
            saleToPriceKoef = this._options.sale_to_price_koef;
        return quantityInSaleUnits * saleToPriceKoef;
    }

    /**
     * Переключить режим представления 
     * @param {int} sale_to_ui_koef - коэффициент пересчета из
     * единицы кратности в новую пользовательскую единицу
     */
    switch(sale_to_ui_koef) {
        this.model.setUiModel(sale_to_ui_koef);
        this.view.$input = this.model.uiQuantity;    
    }

    _registerEvents() {
        this.view.$input.on('change', this._changeHandler.bind(this));
        this.view.$plusButton.on('click', this._handleUp.bind(this));
        this.view.$minusButton.on('click', this._hadleDown.bind(this));
    }

    _handleUp() {
        this.model.up(1);
        this.view.$input = this.model.uiQuantity;
    }

    _hadleDown() {
        this.model.down(1);
        this.view.$input = this.model.uiQuantity;
    }

    _changeHandler(e) {
        this.model.uiQuantity = this.view.$input.val();

        /** Количество автоматически округляется, возвращаем пользователю актуальное значение */
        this.view.$input = this.model.uiQuantity;
    }
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
    /** Продаем всегда c шагом штука в единицах кратности*/
    static step = 1;

    /**
     * @param {int} minimum - начальное значение (от..)
     */
    constructor(minimum) {
        this._minimum = minimum;
        this._quantity = minimum;
        this._uiKoef = 1;
        this.setUiModel(this._uiKoef);
    }

    /**
     * Получить текущее неокругленное значение в единицах кратности 
     */
    get explicitQuantity() {
        return this._quantity;
    }

    /**
     * Множитель перевода из кратных едениц в текущую пользовательскую
     * (sale_to_ui option), например, в рулоне 20м2 Продаем рулонами
     * uiKoef = 20 (перевести рулоны в м2 - нужно умножить на 20) 
     */
    get uiKoef() {
        return this._uiKoef;
    }

    /**
      * Получить текущее целое (округленное) значение в пользовательских единицах
      */
    get uiQuantity() {
        return this._uiModel.value;
    }

    /**
     * Установить новое количество в пользовательских единицах
     * Количество кратных единиц пересчитывается автоматически
     * @param {*} uiQuantity 
     */
    set uiQuantity(uiQuantity) {
        /** Геттер uiModel автоматически округляет до целых единиц в большую сторону */
        this._uiModel.value = parseFloat(uiQuantity);
        /** Нужно пересчитать актуальное значение */
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

    /**
     * Устанавливаем модель, поверх которой работает
     * пользователь в данный момент  
     * @param {int} koef - множитель перевода из кратной еденицы в пользовательскую 
     */
    setUiModel(koef) {
        this._uiKoef = parseFloat(koef);

        //округление шага в большую сторону для ситуаций, когда пользовательская ед. больше чем кратная
        //например в 1м3 = 0.сколько-то листов. Продаем в листах. Значит шаг м3 = 1 
        let uiStep = Math.ceil(SaleQuantityModel.step * this._uiKoef),
            uiMinimum = Math.ceil(this._minimum * this._uiKoef);
        this._uiModel = new UiQuantityModel(uiStep, uiMinimum);
        this.uiQuantity = this.explicitQuantity * this._uiKoef;
    }

    _refresh() {
        this._quantity = this._uiModel.value / this._uiKoef;
    }

}

/**
 * Хранит текущее состояние выбора пользователя
 * в пользовательских (выбранных) единицах продажи
 * 
 * Не используется без фасада SaleQuantityModel
 */
class UiQuantityModel {

    constructor(step, minimum) {
        this.minimum = parseInt(minimum);
        this._value = this.minimum;
        this.step = parseInt(step);
    }

    get value() {
        return this._value;
    }

    set value(nval) {
        let steps = parseInt(Math.ceil((nval - this._value) / this.step));
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
        this._value = this._value + this.step * steps;
    }

    down(steps) {
        if (steps < 0) {
            console.warn("up step cant be negative do nothing");
            return;
        }
        this._value = this._value - this.step * steps;
        if (this._value < this.minimum) {
            this._value = this.minimum;
        }
    }
}


class QuantityView {
    static minusButClass = 'LeftButton';
    static plusButClass = 'RightButton';
    static inputName = 'qnt';

    constructor(container) {
        this.$container = $(container);
        this.el = document.createElement('DIV');
        this.$el = $(this.el);
        this.$el.css('display', 'flex');
        this.$el.css('justify-content', 'space-between');

        this.$el.html('<div class="' + QuantityView.minusButClass + '"></div>\
             <input type="text" name="qnt"/>\
             <div class="'+ QuantityView.plusButClass + '"></div>');
    }

    get $minusButton() {
        return $('.' + QuantityView.minusButClass, this.$el);
    }

    get $plusButton() {
        return $('.' + QuantityView.plusButClass, this.$el);
    }

    get $input() {
        return $('input[name="' + QuantityView.inputName + '"]', this.$el);
    }

    set $input(value) {
        $('input[name="' + QuantityView.inputName + '"]', this.$el).val(value);
    }

    render() {
        this.$container.addClass('qnt-widget');
        this.$container.append(this.$el);
    }
}

export default Quantity;