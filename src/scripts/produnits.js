import Quantity from './lib/quantity.es6.js';

/** init all quantiy containers in category or product page */
if( $('.qnt-container').length > 0 ) {
    Quantity.init('.qnt-container');
}

/** init ui in specification (product) page */
if( $('#priceSwitcher').length > 0 && $('.qnt-container-spec').length > 0){
    (function() {
        var switcher = $('#priceSwitcher'),
                switchOpts = $('li', switcher),
                firstOpt = $(switchOpts[0]),
                sale_to_ui_koef = firstOpt.attr('data-sale_to_ui_koef'),
                sale_to_price_koef = switcher.attr('data-sale_to_price_koef');
        
        // init input
        Quantity.init('.qnt-container-spec', 
                        {'sale_to_ui_koef':sale_to_ui_koef, 'sale_to_price_koef':sale_to_price_koef});
        var qntInputController = $('.qnt-container-spec').data('quantity');

        // init switcher
        switchOpts.on('click', function(e){
            e.preventDefault();
            switchOpts.removeClass('active');
            var $el = $(this),
                sale_to_ui_koef = $el.attr('data-sale_to_ui_koef');

            qntInputController.switch(sale_to_ui_koef);
            $el.addClass('active');
        })
    })()
}
