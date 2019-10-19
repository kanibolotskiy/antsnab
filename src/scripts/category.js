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
            //console.log(json);
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
                
                if(json["econom"]==0){
                    $(".intotal.economy").hide();
                }else{
                    $(".intotal.economy").show(200);
                    $("#ecosum").css({"opacity":0});
                    $("#ecosum").html(json["econom"]);
                    $("#ecosum").animate({"opacity":1},200);
                    //$("#ecosum").fadeOut(200);
                }

                $('.basket_link').html(json['total_str']);
                

                //if(itm.hasClass("cart_button_buy")){
                if(show_added){
                    
                    var total=json["total"];
                    $("#total_cart").css({"opacity":0});
                    $("#total_cart").html(total);
                    
                    $("#total_cart").animate({"opacity":1},100);
                    
                    var new_product=json["added_product"];
                    var added_key=json["added_key"];

                    var f_itm=$('[data-el_name="quantity['+added_key+']"]')
                    if(f_itm.length){
                        //var added_itm=$(json["added_product"]);
                        //console.log(added_itm.html())

                        f_itm.closest(".basket-row").replaceWith(json["added_product"]);
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

function add_favorite_to_cart(product_id, count_add){
    $.ajax({
        url:  '/index.php?route=checkout/cart/add',
        type: 'post',
        data: {
            quantity: count_add,
            product_id: product_id, 
            show_added:true
        },success: function(json) {
            
            new Noty({
                text: json['success']+"<div class='notify_cart'><a href='card/'>Перейти в корзину</a></div>",
                type: 'warning',
                theme: 'relax',
                timeout: 3000, 
            }).show();
            $('.basket_link').html(json['total_str']);
        }
    });
}

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

function change_favorite_sum(){
    $(".fav_row").each(function(){
        var itm_widget=$(this).find(".qnt-widget");
        var count=$(this).find(".qnt").val();
        var opt_limit=itm_widget.attr("data-sale_to_price_koef")*itm_widget.attr("data-wholesale_threshold");

        var row_sum=0;
        var price=0;
        if(count>=opt_limit){
            $(this).find(".cart_price_caption_opt").fadeIn();
            $(this).find(".cart_price_caption_rozn").hide();
            price=$(this).attr("price_opt");

            $(this).find(".cart_price_val").html()
        }else{
            $(this).find(".cart_price_caption_opt").hide();
            $(this).find(".cart_price_caption_rozn").fadeIn();
            price=$(this).attr("price");
        }
        row_sum=price*count;
        var price_str=number_format(price, 0,"."," ")+' <div class="rur">i</div>';
        $(this).find(".cart_price_val").html(price_str);

        $(this).find(".recal_tll").html(number_format(row_sum, 0,"."," "));
    });
}
$(document).ready(function(){
    $(".fav_row .qnt").change(function(){
        change_favorite_sum();
    });
    $(".fav_row .LeftButton").click(function(){
        change_favorite_sum();
    });
    $(".fav_row .RightButton").click(function(){
        change_favorite_sum();
    });

    
    $("#add_all_favorites").click(function(){
        $(".fav_row").each(function(){
            var fav_itm=$(this);
            var product_id=fav_itm.attr("data-product_id")
            var count_add=fav_itm.find(".qnt").val();
            add_favorite_to_cart(product_id, count_add);
        });
    });

    $(".cart_similar_button").click(function(){
        var fav_itm=$(this).closest(".fav_row");
        var product_id=fav_itm.attr("data-product_id")
        var count_add=fav_itm.find(".qnt").val();
        //add_to_cart(product_id, count_add, true);
        add_favorite_to_cart(product_id, count_add);
    });

    $(document).on("click",".full_item_link",function(e){
        if($(e.target).closest(".quantity-buy").length){
            e.preventDefault();
        }
    });
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
        if(itm.hasClass("cart_similar_button")){
            show_added=1;
            var product_id=$(this).attr('data-product_id');
            /**Цель*/
            if (typeof ym != 'undefined') {
                ym(14496178, 'reachGoal', 'related-products');
            }
            add_to_cart(product_id, 1, show_added);
        }else{
            var $container = $(this).closest('.quantity-buy'),
            qntController = $container.find('.qnt-widget').data('quantity'), 

            quantityInSaleUnits = qntController.getQuantityInSaleUnits(), 
            toPriceQuantityKoef = new Fraction( $(this).attr('data-sale_to_price_koef') ), 
            quantityInPriceUnits = toPriceQuantityKoef.mul(quantityInSaleUnits); 

            var product_id=$(this).attr('data-product_id');
            var count_add=quantityInPriceUnits.valueOf();
            add_to_cart(product_id, count_add,0);
        }
     
     

        
    });
});