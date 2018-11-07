import {Quantity} from './lib/quantity.es6.js';

/** init all quantiy containers in category or product page */
if( $('.qnt-container').length > 0 ) {
    $('.qnt-container').each(function(index){
        var $el = $(this),
            $saleUnitName = $el.attr('data-ui_name');

            Quantity.init($el, {
                'ui_name': $saleUnitName,
            });
    });
}