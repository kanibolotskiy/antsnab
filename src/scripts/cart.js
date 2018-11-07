import {Quantity} from './lib/quantity.es6.js';

if( $('.qnt-container-cart').length > 0) {
    $('.qnt-container-cart').each(function(index){
        var $el = $(this),
            $priceUnitName = $el.attr('data-ui_name'),
            $priceUnitKoef = $el.attr('data-sale_to_price_koef'),
            $priceUnitQuantity = $el.attr('data-price_quantity'),
            $inputName = $el.attr('data-el_name');

        Quantity.init($el, {
            'sale_to_ui_koef': $priceUnitKoef,
            'ui_name': $priceUnitName,
            'el_name': $inputName
        });

        var qntController = $el.data('quantity');
        qntController.setQuantityInUiUnits($priceUnitQuantity);
    });
}