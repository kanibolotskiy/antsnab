import {Quantity} from './lib/quantity.es6.js';
import './lib/jquery.cookie';
var Fraction = require('fraction.js');
var Noty = require('noty');
/*
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
*/
/** add to cart */
/*
$(window).on('load', function () {
    initBuyButtons($('.buy'));
})
*/

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
    //initBuyButtons($items.find('.buy'));
});

/*-----------------------------------------------------*/
function add_to_cart(product_id, count_add, show_added){
    $.ajax({
        url:  '/index.php?route=checkout/cart/add',
        type: 'post',
        data: {
            quantity: count_add,
            product_id: product_id, 
            show_added:show_added
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
                var product = [{
                    "id": json['metrika_product_id'],
                    "name": json['metrika_product_name'],
                    "price": json['metrika_product_price'],
                    "brand": json['metrika_product_manufacturer'],
                    "category": json['metrika_product_category'],
                    "quantity": json['metrika_product_quantity']
                }];
                dataLayer.push({"ecommerce": {"add": {"products": product}}});
                

                $('.basket').html(json['total_str']);
                

                //if(itm.hasClass("cart_button_buy")){
                if(show_added){
                    var total=json["total"];
                    $("#total_cart").css({"opacity":0});
                    $("#total_cart").text(total);
                    
                    $("#total_cart").animate({"opacity":1},100);
                    
                    var new_product=json["added_product"];
                    var added_key=json["added_key"];

                    var f_itm=$('[data-el_name="quantity['+added_key+']"]')
                    if(f_itm.length){
                        f_itm.closest(".basket-row").html(json["added_product"]);
                    }else{
                        $(".basket-block").append(json["added_product"]);
                    }
                    
                    if( $('.qnt-container-cart').length > 0) {
                        $('.qnt-container-cart.without_input').each(function(index){
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
                            $el.removeClass("without_input");
                        });
                    }
                }

                new Noty({
                    text: json['success']+"<div class='notify_cart'><a href='card/'>Перейти в корзину</a></div>",
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
}

$(document).ready(function(){

    /**Добавление товара из калькулятора #1 */
    $("#add_calcdata_tocart1").click(function(){
        /**Рассчитываемый товар */
        add_to_cart($("#product_id").val(), $("#calc_out1").attr("data-count"), 1);

        /**Праймер */
        add_to_cart(770, $("#calc_out2").attr("data-count"), 1);

        /**Цель*/
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'calc-cart');
        }

    });
    $("#add_calcdata_tocart2").click(function(){        
        add_to_cart($("#product_id").val(), $("#calc_out1").attr("data-count"), 1);
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'calc-cart');
        }
    });
    

    $(document).on('click','.buy',function(e){
        
        e.preventDefault();
        var show_added=0;
        var itm=$(this);
        if(itm.hasClass("cart_button_buy")){
            //show_added="show_added=1";
            show_added=1;
        }     
        
        var $container = $(this).parents('.quantity-buy'),
            qntController = $container.find('.qnt-widget').data('quantity'), 
            quantityInSaleUnits = qntController.getQuantityInSaleUnits(), 
            toPriceQuantityKoef = new Fraction( $(this).attr('data-sale_to_price_koef') ), 
            quantityInPriceUnits = toPriceQuantityKoef.mul(quantityInSaleUnits); 
        
        
        var product_id=$(this).attr('data-product_id');
        var count_add=quantityInPriceUnits.valueOf();

        
        add_to_cart(product_id, count_add,show_added);

        
    });
});