import {Quantity} from './lib/quantity.es6.js';
import './lib/formsubmit.js';

/** Карточка */
/** init switching ui in specification (product) page */
if( $('#priceSwitcher').length > 0 && $('.qnt-container-spec').length > 0){
    (function() {
        var Fraction = require('fraction.js'),
            format = require('number-format.js');


        var $switchers = $('li','#priceSwitcher' ),
            $firstSwitcher = $($switchers[0]);
        // sale_to_price_koef = switcher.attr('data-sale_to_price_koef'),
        
        $switchers.on('click', toggleSwitchHandler);
        $firstSwitcher.trigger('click');

        function toggleSwitchHandler(e){
            e.preventDefault();
            var $el = $(this);
        
            $switchers.removeClass('active');
            $el.addClass('active');
            togglePriceDescr($el);
            toggleQuantityInput($el);
            togglePrices($el);
        }

        function togglePriceDescr($activeEl) {
            var ui_descr = $activeEl.attr('data-ui_descr');
            $('#priceWholesaleDescr').html(ui_descr);
            $('#priceDescr').html(ui_descr);
        }
        
        function toggleQuantityInput($activeEl) {
            var selector = '.qnt-container-spec',
                $input = $(selector),
                options = {
                    'sale_to_ui_koef':$activeEl.attr('data-sale_to_ui_koef'),
                    'ui_minimum':$activeEl.attr('data-ui_minimum'),
                    'ui_step':$activeEl.attr('data-ui_step'),
                    'ui_name': $activeEl.attr('data-ui_name')
                };
        
            //check if input controller was inited
            if( !$input.data('quantity')) {
                Quantity.init(selector, options); 
                return;
            }
        
            var controller = $input.data('quantity');
            controller.switch(options.sale_to_ui_koef, options.ui_minimum, options.ui_step, options.ui_name);
        }
       
        function togglePrices($activeEl) {
            var $price = $('#price'),
                price = parseFloat($price.attr('data-value')),
                $wholeSalePrice = $('#wholesale_price'),
                wholeSalePrice = parseFloat($wholeSalePrice.attr('data-value')),
                saleToPriceKoef = new Fraction($('#priceSwitcher').attr('data-sale_to_price_koef')),
                saleToUiKoef = new Fraction($activeEl.attr('data-sale_to_ui_koef')),
                uiPrice = saleToPriceKoef.div(saleToUiKoef).mul(price),
                uiWholeSalePrice = saleToPriceKoef.div(saleToUiKoef).mul(wholeSalePrice),
                currency = $('#priceSwitcher').attr('data-currency_symbol');

            $price.text( format('# ###.00 ' + currency, uiPrice.valueOf() ) );
            $wholeSalePrice.text( format ('# ###.00 ' + currency, uiWholeSalePrice.valueOf()) );
        }

    })()
}

if( $('.in-stock').length > 0) {
    /** Авторесайз блока со складами под размер ноготков фоото */
    window.addEventListener('resize', function(){
        var thumbNav = document.getElementsByClassName('thumb__nav')[0], 
            thumbNavHeight = thumbNav.offsetHeight,
            thumbMargin = parseFloat(getComputedStyle(thumbNav).marginTop),
            thumbNavTotalHeight = thumbMargin + thumbNavHeight;

        document.getElementById('prodRight').style.paddingBottom = thumbNavTotalHeight +  "px";
        document.getElementsByClassName('in-stock')[0].style.height = thumbNavHeight + "px";
    });
}

/** submit reviews */
$('#button-review').formSubmit({
    loaderSelector: '#ajax_loader',
    url: 'index.php?route=product/product/write&product_id=' + $('#button-review').attr('data-product_id'),
    type: 'post',
    dataType: 'json',
    before: function() {
        $("#form-review .error").html("");
    },
    success: function(json) {
        $('.alert-success, .alert-danger').remove();
        if (json['error']) {
            for(var err in json['error']){
                $("#error_"+err).html(json['error'][err]);
            }
        }else{
            $(".popup.thank-you").addClass("visible");
        }
    },
    error: function(data){},
});
