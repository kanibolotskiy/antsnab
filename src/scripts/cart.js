import {Quantity} from './lib/quantity.es6.js';

if( $('.qnt-container-cart').length > 0) {
    $('.qnt-container-cart').each(function(index){
        var $el = $(this),
            /** Имя единицы измерения в которой ведем учет и офрмляем заказ (priceUnit) */
            $priceUnitName = {
                'ui_name': $el.attr('data-ui_name'),
                'ui_name_plural': $el.attr('data-ui_name_plural'),
                'ui_name_genitive': $el.attr('data-ui_name_genitive')
            },
            /** Коэффициент перевода из кратных единиц продажи (в которых продаем) в единицы учета */
            /** Необходимо здесь, тк плагин работает поверх кратных единиц продажи */
            $priceUnitKoef = $el.attr('data-sale_to_price_koef'),
            $priceUnitQuantity = $el.attr('data-price_quantity'),
            $inputName = $el.attr('data-el_name');

        Quantity.init($el, {
            'sale_to_ui_koef': $priceUnitKoef,
            'ui_names': $priceUnitName,
            'el_name': $inputName
        });

        var qntController = $el.data('quantity');
        qntController.setQuantityInUiUnits($priceUnitQuantity);
    });
}