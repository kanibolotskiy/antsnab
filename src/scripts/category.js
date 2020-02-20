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

/**Дублируется в prod.js */
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

var flag_update=true;

function getParamsForm(){
    //$(".inputRangeMin").each()
    
    var str='';
    /*
    $(".inputRangeMin").each(function(){
        var val=$(this).val()*1;
        var min=$(this).closest(".wrapper_range_slider").find(".range_slider").attr("def_min_value")*1;
        if((val!=min)&&(val)){
            str+="&"+$(this).attr("name")+"="+$(this).val();
        }
    });
    $(".inputRangeMax").each(function(){
        var val=$(this).val()*1;
        var max=$(this).closest(".wrapper_range_slider").find(".range_slider").attr("def_max_value")*1;
        if((val!=max)&&(val)){
            str+="&"+$(this).attr("name")+"="+$(this).val();
        }param[price][min]
    });
    */

    $(".range_slider").each(function(){
        var select_min=$(this).attr("select_min")*1;
        var select_max=$(this).attr("select_max")*1;
        var min_value=$(this).attr("min_value")*1;
        var max_value=$(this).attr("max_value")*1;

        if(select_min){
            if(select_min!=min_value){
                str+="&param["+$(this).attr("name")+"][min]="+select_min;
            }
        }
        if(select_max){
            if(select_max!=max_value){
                str+="&param["+$(this).attr("name")+"][max]="+select_max;
            }
        }

        /*
        if(select_min>min_value){
            str+="&param["+$(this).attr("name")+"][min]="+select_min;
        }
        if(select_max<max_value){
            str+="&param["+$(this).attr("name")+"][max]="+select_max;
        }
        */
        //console.log(select_min+">"+min_value)
        /*
        if(select_min!=min_value){
            str+="&param["+$(this).attr("name")+"][min]="+select_min;
        }
        if(select_max!=max_value){
            str+="&param["+$(this).attr("name")+"][max]="+select_max;
        }
        */
    });
    

    $(".param_check").each(function(){
        if($(this).prop("checked")){
            str+="&"+$(this).attr("name")+"="+$(this).val();
        }
    });

    //Сортировка
    var sort=$("#seldef1 option:selected").val();
    var sort_str="";
    if(sort){
        str+="&sort="+sort;
    }

    if(str){
        str="?"+str;
        $(".filter_reset").animate({"opacity":1},200);
    }else{
        $(".filter_reset").animate({"opacity":0},200);
    }
    var url=$("#form_params").attr("action");

    history.pushState(null,null, url+str);
    return str;
}
function resetSliders(){
    
    $(".range_slider").each(function(){

        var min_value=$(this).attr("def_min_value")*1;
        var max_value=$(this).attr("def_max_value")*1;

        $(this).attr("select_min",min_value);
        $(this).attr("select_max",max_value);

        $(this).attr("min_value",min_value);
        $(this).attr("max_value",max_value);

        $(this).slider("option",{"min":min_value,"max":max_value});
        $(this).slider("values",[min_value,max_value]);

        $(this).parent().find(".inputRangeMin").val(min_value)
        $(this).parent().find(".inputRangeMax").val(max_value)
        
    });
}
function resetFilterForm(){
    flag_update=false;
    $(".param_check").each(function(){
        $(this).prop("checked",false);
    });
    resetSliders();

    flag_update=true;
    change_params_form();
    //$(".filter_reset").animate({"opacity":0},200);

}
function change_params_form(){
    //data_url1=getParamsForm()

    //console.log("flag_update="+flag_update);

    
    //var data_url=decodeURI($("#form_params").serialize());
    if(flag_update){
        var data_url=getParamsForm();
        var catalog_id=$("#form_params").attr("catalog_id");
        
        var tp=$(".catalog-list").offset().top-$(".header").height();
        flag_update=false;
        $("#lazy-load_container").css({opacity:0});
        $.ajax({
            url:  '/index.php?route=extension/module/category/ajaxRefreshParams',
            type: 'post',
            data: data_url+"&catalog_id="+catalog_id,
            dataType: 'json',
            /*
            beforeSend: function() {
                $('#cart_preloader').fadeIn(200);
            },
            complete: function() {
                $('#cart_preloader').fadeOut(200);
            },*/
            success: function(json) {
                //console.log(json)
                if (json['success']) {
                    var avail_data=json['avail'];
                    var products_str=json['products'];
                    //console.log(products_str);

                    $("#lazy-load_container").html(products_str);
                    $("#lazy-load_container").animate({"opacity":1},300);
                    $('input[name="phone"]').inputmask("+7 9999999999",{ 
                        "clearIncomplete": true,
                        "alias": 'numeric', 
                        "allowMinus": false
                    });
                    initQuantityContainers($('.qnt-container'))  

                    $(".row_check").removeClass("_unactive");
                    $(".param_check").attr("disabled",false);

                    
                    //if(avail_data.length){
                    var flag_empty=true;
                    
                    for(var avail_item in avail_data){
                        var flag_empty=false;
                        let itm=avail_data[avail_item];
                        if(itm.type){
                            let min_value=itm.result.min;
                            let max_value=itm.result.max;
                            
                            
                            let range_row=$(".param_row[param_name='"+avail_item+"']");
                            let range_row_slider=range_row.find(".range_slider");


                            let inputMin=range_row.find(".inputRangeMin").val()*1;
                            let inputMax=range_row.find(".inputRangeMax").val()*1;

                            //var select_min=range_row_slider.attr("select_min")*1;
                            //var select_max=range_row_slider.attr("select_max")*1;

                            var select_min=range_row_slider.attr("select_min")*1;
                            var select_max=range_row_slider.attr("select_max")*1;

                            /*
                            if(min_value>select_min){
                                range_row.find(".inputRangeMin").val(min_value);
                                range_row_slider.slider("value",0,min_value)
                            }else{
                                range_row.find(".inputRangeMin").val(select_min);
                            }
                            
                            if(max_value<select_max){
                                range_row.find(".inputRangeMax").val(max_value);
                                range_row_slider.slider("value",1,max_value)
                            }else{
                                range_row.find(".inputRangeMax").val(select_max);
                            }*/
                            //console.log(min_value+">"+select_min)

                            //if(select_min){
                          
                                if(min_value>=inputMin){
                          
                                    range_row.find(".inputRangeMin").val(min_value);
                                    range_row_slider.slider("value",0,min_value)
                                }else{
                                    if(select_min){
                                        if(select_min<max_value){
                                            range_row.find(".inputRangeMin").val(select_min);
                                            range_row_slider.slider("value",0,select_min)
                                        }else{
                                            range_row.find(".inputRangeMin").val(max_value);
                                            range_row_slider.slider("value",0,max_value)
                                        }
                                    }else{
                                        range_row.find(".inputRangeMin").val(min_value);
                                        range_row_slider.slider("value",0,min_value)
                                    }
                                }
                            //}
                            
                            //if(select_max){
                                
                                if(max_value<=inputMax){
                                    range_row.find(".inputRangeMax").val(max_value);
                                    range_row_slider.slider("value",1,max_value)
                                }else{
                                    if(select_max){
                                        if(select_max>min_value){
                                            range_row.find(".inputRangeMax").val(select_max);
                                            range_row_slider.slider("value",1,select_max)
                                        }else{
                                            range_row.find(".inputRangeMax").val(max_value);
                                            range_row_slider.slider("value",1,max_value)
                                        }
                                    }else{
                                        range_row.find(".inputRangeMax").val(max_value);
                                        range_row_slider.slider("value",1,max_value)
                                        
                                    }
                                }
                            //}
                            
                            range_row_slider.slider("option",{"min":min_value,"max":max_value});
                            if(min_value==max_value){
                                range_row_slider.closest(".param_row").addClass("unactive");
                            }else{
                                range_row_slider.closest(".param_row").removeClass("unactive");
                            }
                            range_row_slider.attr("min_value",min_value);
                            range_row_slider.attr("max_value",max_value);
                        }else{                        
                            $(".param_row[param_name='"+avail_item+"'] .param_check").each(function(){
                                //console.log($(this).val());
                                let flag=true;
                                for(var itm_result in itm.result){
                                    if((itm.result[itm_result]["param_id"]*1)==$(this).val()){
                                        flag=false;
                                    }
                                }
                                if(flag){
                                    $(this).attr("disabled",true);
                                    $(this).closest(".row_check").addClass("_unactive");
                                }else{
                                    $(this).attr("disabled",false);
                                    $(this).closest(".row_check").removeClass("_unactive");
                                }
                            });
                        }
                        
                    }
                    if(flag_empty){
                        //resetSliders();
                    }
                    flag_update=true;
                    //$("html,body").animate({"scrollTop":tp},500)
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
        
    }
}
/*-----------------------------------------------------*/
function add_to_cart(product_id, count_add, show_added, fly_to_cart=false){
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
                $(".basket").addClass("bask_full");
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
                if(fly_to_cart){
                    var fly_itm_img=fly_to_cart.find(".wrp_fly_image");
                    var fly_itm=$("#fly_item");
                    var tstart=fly_itm_img.offset().top-$(document).scrollTop();
                    

                    var lfinal=$(".wrapper_basket .basket").offset().left;
                    var tfinal=$(".wrapper_basket .basket").position().top;

                    fly_itm.css({"opacity":1,"width":fly_itm_img.width(),"height":fly_itm_img.height(),"left":fly_itm_img.offset().left,"top":tstart,"background-image":"url("+fly_itm_img.attr("src")+")"});

                    fly_itm.animate({"top":tfinal,"left":lfinal,"width":0,"height":0,"opacity":0},400);
                    //fly_to_cart.find(".wrp_fly_image").css({"opacity":0});

                }else{
                    new Noty({
                        //text: json['success']+"<div class='notify_cart'><a href='card/'>Перейти в корзину</a></div>",
                        text: json['success']+"<div class='notify_cart'></div>",
                        type: 'warning',
                        theme: 'relax',
                        timeout: 3000, 
                    }).show();
                } 
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
    $("#seldef1").change(function(){
        change_params_form();
    });
    $(".filter_reset").click(function(){
        resetFilterForm();
    });
    $(document).on("change",".param_check",function(){
        if(flag_update){
            change_params_form();
        }
    });
    $(".range_slider").each(function(){
        var min_value=$(this).attr("min_value")*1;
        var max_value=$(this).attr("max_value")*1;
        var slider_item=$(this);

        slider_item.slider({
            range: true,
            animate: "fast",
            min: min_value,
            max: max_value,
            values: [min_value,max_value],
            slide: function( event, ui ) {

                $(this).closest(".wrapper_range_slider").find(".inputRangeMin").val(ui.values[0])
                $(this).closest(".wrapper_range_slider").find(".inputRangeMax").val(ui.values[1])
                
            },
            change:function(event, ui){
                var min_value=slider_item.attr("min_value");
                var max_value=slider_item.attr("max_value");

                if(flag_update){
                    //console.log($(this).attr("min_value")+"="+$(this).attr("max_value"))
                    if(min_value!=max_value){
                        if(min_value==ui.values[0]){
                            slider_item.attr("select_min","");
                        }else{
                            slider_item.attr("select_min",ui.values[0]);
                        }
                        if(max_value==ui.values[1]){
                            slider_item.attr("select_max","");
                        }else{
                            slider_item.attr("select_max",ui.values[1]);
                        }

                    }
                    change_params_form();
                }
            }
        });
    });
    $(".inputRangeMin").change(function(){
        var vl=$(this).val()*1;
        var itm=$(this).closest(".wrapper_range_slider").find(".range_slider");
        var avail_min = itm.attr("min_value")*1;
        var avail_max = itm.attr("max_value")*1;
        if(vl<avail_min){
            $(this).val(avail_min);
            vl=avail_min;
        }
        if(vl>avail_max){
            $(this).val(avail_max);
            vl=avail_max;
        }
        itm.slider("values", 0, vl);
    });

    $(".inputRangeMax").change(function(){
        var vl=$(this).val()*1;
        var itm=$(this).closest(".wrapper_range_slider").find(".range_slider");
        var avail_min = itm.attr("min_value")*1;
        var avail_max = itm.attr("max_value")*1;
        if(vl<avail_min){
            $(this).val(avail_min);
            vl=avail_min;
        }
        if(vl>avail_max){
            $(this).val(avail_max);
            vl=avail_max;
        }
        itm.slider("values", 1, vl);
    });
    $(".fav_row .qnt").change(function(){
        change_favorite_sum();
    });
    $(".fav_row .LeftButton").click(function(){
        change_favorite_sum();
    });
    $(".fav_row .RightButton").click(function(){
        change_favorite_sum();
    });
    
    $(document).on("click",".RightButton",function(){
        var itm=$(this).closest(".quantity-buy");
        itm.find(".min_count_hint").fadeOut(150);
    });
    
    if($("#min_count_hint").length){
        var min_val=$(".unitpack1").attr("data-ui_minimum");
        if(min_val>1){
            $("#min_count_hint").show();
        }
    }
    $(document).on("click",".LeftButton",function(){
        var cont_itm=$(this).closest(".qnt-widget");
        var itm=$(this).closest(".quantity-buy");
        var input_val=itm.find(".qnt").val();
        var qnt_minimum=1;
        if((cont_itm.hasClass("qnt-container-spec"))||(cont_itm.hasClass("qnt-container-modal"))){
            qnt_minimum=$("#priceSwitcher li.active").attr("data-ui_minimum");
        }else{
            qnt_minimum=cont_itm.attr("data-ui_minimum");
        }
        if(input_val*1<=qnt_minimum*1){
            itm.find(".min_count_hint").fadeIn(150);
        }
    });

    
    $("#add_all_favorites").click(function(){
        $(".fav_row").each(function(){
            var fav_itm=$(this);
            var product_id=fav_itm.attr("data-product_id")
            var count_add=fav_itm.find(".qnt").val();
            add_favorite_to_cart(product_id, count_add);
        });
    });

    $(".cart_favorite_button").click(function(){
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
            var itm_fly=$(this).closest(".wrp_fly");
            add_to_cart(product_id, count_add,0,itm_fly);
        }
    });
});