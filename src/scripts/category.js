import {Quantity} from './lib/quantity.es6.js';
var Fraction = require('fraction.js');
var Noty = require('noty');

function initBuyButtons($buttons){
    $buttons.on('click', function(e){
        e.preventDefault();
        var $container = $(this).parents('.quantity-buy'),
            qntController = $container.find('.qnt-widget').data('quantity'), 
            quantityInSaleUnits = qntController.getQuantityInSaleUnits(), 
            toPriceQuantityKoef = new Fraction( $(this).attr('data-sale_to_price_koef') ), 
            quantityInPriceUnits = toPriceQuantityKoef.mul(quantityInSaleUnits); 
    
        $.ajax({
            url:  '/index.php?route=checkout/cart/add',
            type: 'post',
            data: {
                quantity: quantityInPriceUnits.valueOf(),
                product_id: $(this).attr('data-product_id'), 
            },
            dataType: 'json',
            beforeSend: function() {
                $('#cart_preloader').fadeIn(200);
            },
            complete: function() {
                $('#cart_preloader').fadeOut(200);
            },
            success: function(json) {
                if (json['success']) {
                    $('.basket').html(json['total']);
                    $('html, body').animate({ scrollTop: 0 }, 'slow');
    
                    new Noty({
                        text: json['success'],
                        type: 'warning',
                        theme: 'relax',
                        timeout: 3000, 
                    }).show();
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
}

/** add to cart */
$(window).on('load', function () {
    initBuyButtons($('.buy'));
})

function initQuantityContainers($collection) {
    $collection.each(function(index){
        var $el = $(this);
            Quantity.init($el, {
                    'sale_to_ui_koef':$el.attr('data-sale_to_ui_koef'),
                    'ui_step':$el.attr('data-ui_step'),
                    'ui_minimum':$el.attr('data-ui_minimum'),
                    'ui_names': {
                        'ui_name': $el.attr('data-ui_name'),
                        'ui_name_plural': $el.attr('data-ui_name_plural'),
                        'ui_name_genitive': $el.attr('data-ui_name_genitive')
                    }
            });
    });
}

/** init all quantiy containers in category or product page */
if( $('.qnt-container').length > 0 ) {
    initQuantityContainers($('.qnt-container'))    
}

$('body').delegate('#lazy-load_container','onLazyLoaded', function(e, $items){
    initQuantityContainers($items.find('.qnt-container'));
    initBuyButtons($items.find('.buy'));
});