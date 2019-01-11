import {Quantity} from './lib/quantity.es6.js';
import './lib/formsubmit.js';

var Fraction = require('fraction.js');
//var format = require('number-format.js');
function number_format(number, decimals, dec_point, thousands_sep) {
    number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
    var n = !isFinite(+number) ? 0 : +number,
	prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
	sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
	dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
	s = '',
	toFixedFix = function (n, prec) {
	    var k = Math.pow(10, prec);
	    return '' + Math.round(n * k) / k;
	};
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
	s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
	s[1] = s[1] || '';
	s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}
/** Карточка */
/** init switching ui in specification (product) page */
if( $('#priceSwitcher').length > 0 && $('.qnt-container-spec').length > 0){
    (function() {

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
                    'ui_names': {
                        'ui_name': $activeEl.attr('data-ui_name'),
                        'ui_name_plural': $activeEl.attr('data-ui_name_plural'),
                        'ui_name_genitive': $activeEl.attr('data-ui_name_genitive')
                    }
                };
        
            //check if input controller was inited
            if( !$input.data('quantity')) {
                Quantity.init(selector, options); 
                return;
            }
        
            var controller = $input.data('quantity');
            controller.switch(options.sale_to_ui_koef, options.ui_minimum, options.ui_step, options.ui_names);
        }
       
        function togglePrices($activeEl) {
            var $price = $('#price'),
                price = parseFloat($price.attr('data-value')),
                $wholeSalePrice = $('#wholesale_price'),
                wholeSalePrice = parseFloat($wholeSalePrice.attr('data-value')),
                saleToPriceKoef = new Fraction($('#button-cart').attr('data-sale_to_price_koef')),
                saleToUiKoef = new Fraction($activeEl.attr('data-sale_to_ui_koef')),
                uiPrice = saleToPriceKoef.div(saleToUiKoef).mul(price),
                uiWholeSalePrice = saleToPriceKoef.div(saleToUiKoef).mul(wholeSalePrice),
                currency = $('#priceSwitcher').attr('data-currency_symbol');

            
            var isInt = ( uiPrice.valueOf() - parseInt(uiPrice.valueOf()) === 0 ),
                formatStr = isInt?'### ###.':'### ###,##';
                //console.log(formatStr+"+"+currency+"+"+uiPrice.valueOf());
                //console.log(format(formatStr + currency, uiPrice.valueOf() ));

                var price_val=uiPrice.valueOf();
                var opt_price_val=uiWholeSalePrice.valueOf();
                var price_str='';
                var opt_price_str='';

                if(price_val-parseInt(price_val)===0){
                    price_str = number_format(price_val, 0, ",", " ") + " " + currency 
                }else{
                    price_str = number_format(price_val, 2, ",", " ") + " " + currency
                }
                $price.text(price_str);

                if(opt_price_val-parseInt(opt_price_val)===0){
                    opt_price_str = number_format(opt_price_val, 0, ",", " ") + " " + currency 
                }else{
                    opt_price_str = number_format(opt_price_val, 2, ",", " ") + " " + currency
                }
                $wholeSalePrice.text(opt_price_str);

                //$price.text(number_format(uiPrice.valueOf(), 2, ",", " ") + " " + currency);
          //  $price.text( format(formatStr + currency, uiPrice.valueOf() ) );
/*
            var isInt = ( uiWholeSalePrice.valueOf() - parseInt(uiWholeSalePrice.valueOf()) === 0 ),
                formatStr = isInt?'### ###.':'### ###,##';
            //$wholeSalePrice.text( format (formatStr + ' ' + currency, uiWholeSalePrice.valueOf()) );
                console.log(isInt);
                $wholeSalePrice.text(number_format(uiWholeSalePrice.valueOf(), 2, ",", " ") + " " + currency);
*/

        }

    })()
}

if( $('.in-stock').length > 0) {
    /** Авторесайз блока со складами под размер ноготков фоото */
    /** @task - если отсутствуют ноготки - схлопывается при ресайзе */
    /*
    window.addEventListener('resize', function(){
        var thumbNav = document.getElementsByClassName('thumb__nav')[0], 
            thumbNavHeight = thumbNav.offsetHeight,
            thumbMargin = parseFloat(getComputedStyle(thumbNav).marginTop),
            thumbNavTotalHeight = thumbMargin + thumbNavHeight;

        document.getElementById('prodRight').style.paddingBottom = thumbNavTotalHeight +  "px";
        document.getElementsByClassName('in-stock')[0].style.height = thumbNavHeight + "px";
    });
    */
}

/** submit reviews */
$('#button-review').formSubmit({
    loaderSelector: '#ajax_loader',
    url: '/index.php?route=product/product/write&product_id=' + $('#button-review').attr('data-product_id'),
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
            $('input, textarea','#form-review').val('');
        }
    },
    error: function(data){},
});

;
