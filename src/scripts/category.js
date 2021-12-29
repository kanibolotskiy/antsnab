import {Quantity} from './lib/quantity.es6.js';
import './lib/jquery.cookie';
var Fraction = require('fraction.js');
var Noty = require('noty');
var min_width_filter=1100;

/**Дублируется в prod.js */
function initQuantityContainers($collection) {
    $collection.each(function(index){
        var $el = $(this);
            Quantity.init($el, {
                    'start_value':$el.attr('data-cnt')?$el.attr('data-cnt'):1,
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
//-------------------------------------------
function getParamsForm(){
    var str='';
    $(".range_slider").each(function(){
        var select_min=$(this).data("select_min");
        var select_max=$(this).data("select_max");
        var min_value=$(this).data("min_value")*1;
        var max_value=$(this).data("max_value")*1;

        if(select_min!=""){
            if((select_min)*1!=min_value){
                str+="&param["+$(this).data("name")+"][min]="+select_min;
            }
            if(select_max==""){
                str+="&param["+$(this).data("name")+"][max]="+max_value;
            }
        }
        if(select_max!=""){
            if(select_min==""){
                str+="&param["+$(this).data("name")+"][min]="+min_value;
            }
            if((select_max*1)!=max_value){
                //str+=(str!=""?"&":"")+"param["+$(this).attr("name")+"][max]="+select_max;
                str+="&param["+$(this).data("name")+"][max]="+select_max;
            }
            
        }
    });
    $(".param_check").each(function(){
        if($(this).prop("checked")){
            str+="&"+$(this).data("name")+"="+$(this).val();
        }
    });

    
    if(str){
        $("#reset_filter").addClass("active");
    }else{
        $("#reset_filter").removeClass("active");
    }
    
    //Сортировка
    var sort=$("#seldef1 option:selected").val();
    var sort_str="";
    if(sort){
        //str+=(str!=""?"&":"")+"sort="+sort;
        str+="&sort="+sort;
    }

    //Пагинация
    var limit=$(".showby_item.active").data("rel");
    if(limit!="18"){
        str+="&limit="+limit;
    }
    //console.log(str)
    var url=$("[data-id='form_params']").attr("action");
    var str_fin="";
    if(str){
        str_fin="?"+str.slice(1)
    }
    history.pushState(null,null, url+str_fin);
    return "?"+str;
}
//-------------------------------------------
function resetSliders(){
    $(".range_slider").each(function(){

        var min_value=$(this).data("def_min_value")*1;
        var max_value=$(this).data("def_max_value")*1;

        var sel_min_value=$(this).data("def_min_value")*1;
        var sel_max_value=$(this).data("def_max_value")*1;


        $(this).data("select_min",min_value);
        $(this).data("select_max",max_value);

        $(this).data("min_value",min_value);
        $(this).data("max_value",max_value);

        $(this).slider("option",{"min":min_value,"max":max_value});
        $(this).slider("values",[min_value,max_value]);

        $(this).parent().find(".inputRangeMin").val(min_value)
        $(this).parent().find(".inputRangeMax").val(max_value)
        
    });
}
//-------------------------------------------
function resetFilterForm(){
    flag_update=false;
    $(".param_check").each(function(){
        $(this).prop("checked",false);
    });
    resetSliders();

    flag_update=true;
    change_params_form(true);
    //$(".filter_reset").animate({"opacity":0},200);

}
//-------------------------------------------
function set_state_checks(avail_data){
//if(avail_data.length){
    var flag_empty=true;
    //console.log(avail_data)
    for(var avail_item in avail_data){
        
        var flag_empty=false;
        let itm=avail_data[avail_item];
        
        if((itm.type==0)||(itm.type==2)){
            //console.log(avail_item)
            $(".param_row[data-param_name='"+avail_item+"'] .param_check").each(function(){
                //console.log($(this).val());
                //)
                let flag=true;
                
                for(var itm_result in itm.result){
                    
                    //if((itm.result[itm_result]["param_id"]*1)==$(this).val()){
                    if((itm_result*1)==$(this).val()){
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

        if((itm.type==4)||(itm.type==5)){
            //console.log(avail_item)
            $(".param_row[data-param_name='"+avail_item+"'] .param_check").each(function(){
                //console.log(avail_item)
                if(itm.result.count){
                    $(this).attr("disabled",false);
                    $(this).closest(".row_check").removeClass("_unactive");
                }else{
                    $(this).attr("disabled",true);
                    $(this).closest(".row_check").addClass("_unactive");
                }
                
            });
        }
        
    }
    if(flag_empty){
        //resetSliders();
    }
    flag_update=true;
}
//-------------------------------------------
function change_params_form(flag=true){
    
    if(flag){
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'filter');
        }
        
        
        if(flag_update){
            var data_url=getParamsForm();
            var catalog_id=$("[data-id='form_params']").data("catalog_id");
            
            var tp=$(".catalog-list").offset().top-$(".header").height();
            flag_update=false;
            $("#lazy-load_container").css({opacity:0});
            $.ajax({
                url:  '/index.php?route=product/category/ajaxRefreshParams',
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

                        set_state_checks(avail_data);

                        $("#wrp_paginate").html(json['showMore']+json['pagination']);
                        //-50
                        
                        $("html,body").animate({"scrollTop":tp},500)
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
            
        }
    }
}
//-------------------------------------------
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

                    $(".cart_similar_block_products:not(.slick-initialized)").slick({
                        infinite: true,
                        slidesToShow: 3,
                        slidesToScroll: 1,
                        responsive: [
                            {
                                breakpoint: 1024,
                                settings: {
                                    slidesToShow: 2,
                                    arrows:false
                                }
                            },{
                                breakpoint: 640,
                                settings: {
                                    slidesToShow: 1,
                                    arrows:false
                                }
                            },
                        ]
                    });
                    
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
    $(".basket").addClass("bask_full");

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
        var price_str=number_format(price, 0,"."," ")+' &#x20bd;';
        $(this).find(".cart_price_val").html(price_str);

        $(this).find(".recal_tll").html(number_format(row_sum, 0,"."," "));
    });
}

function getCalcProducts(data){
    $.ajax({
        url:  '/index.php?route=common/kalkulyator/calcData',
        data: data,
        type: 'post',
        dataType: 'json',
        success: function(json) {
            
            $("#calc_product_list").html(json['products']);
            $("#calc_product_dop_list").html(json['products_analog']);

            if( $('.qnt-container').length > 0 ) {
                $(".calc_products").show();
                initQuantityContainers($('.qnt-container'))
            }
        }
    });
}

$(document).ready(function(){
    /*
    $('.buy').on('touchstart touchend', function(e) {
        //e.preventDefault();
        $(this).toggleClass('_hover');
    });
    */
    $(document).on("mouseenter",".buy",function(){
        $(this).addClass('_hover');
    });
    $(document).on("mouseleave",".buy",function(){
        $(this).removeClass('_hover');
    });
    /*
    $('.buy').on('mouseenter', function() {
        $(this).addClass('_hover');
    });
    $('.buy').on('mouseleave', function() {
        $(this).removeClass('_hover');
    });
    */
    $(".param_check:checked").each(function(){
        var prnts=$(this).closest(".row_checks_wrap");
        prnts.addClass("active");
        var prnts_more=prnts.parent().find(".show_more_params")
        prnts_more.addClass("active");
        prnts_more.children("span").addClass("active").html("Скрыть");

    });
    $("#showmore_isseo").click(function(){
        if($(this).hasClass("active")){
            $(this).html("показать еще");            
            $(this).removeClass("active");
            $(".pick-up ul li._hidden").fadeOut(200);
        }else{
            $(this).html("скрыть");
            $(this).addClass("active");
            $(".pick-up ul li._hidden").fadeIn(200);
        }
        
    });
    if($(".filter_reset.active").length){
        $(".up").addClass("_filter");
    }
    $(".wrp_filter_title").click(function(){
        if($(".filter_reset").hasClass("active")){
            $(".wrp_filter_title").removeClass("active");
            $(".param_item").slideUp(300);
            $(".filter_reset").removeClass("active");
            $(".up").removeClass("_filter");
        }else{
            $(".wrp_filter_title").addClass("active");
            $(".param_item").slideDown(300);
            $(".filter_reset").addClass("active");
            $(".up").addClass("_filter");
        }

        /*
        if($(".filter_reset").hasClass("active")){
            $(".param_item").slideUp(300);
            $(".filter_reset").removeClass("active");
            $(".up").removeClass("_filter");
        }else{
            $(".param_item").slideDown(300);
            $(".filter_reset").addClass("active");
            $(".up").addClass("_filter");
        }
        */
    });
    
    $("#seltype").change(function(){
        document.location=$("#seltype").attr("data-href")+"?"+$("#seltype option:selected").val();

    });

    $("#seldef1").change(function(){
        /*
        var flag=true;
        if($(window).width()<min_width_filter){
            flag=false;
        }
        console.log(flag)
        */
        change_params_form(true);
    });
    /*
    $(".filter_reset").click(function(){
        resetFilterForm();
    });
    */
    $("#apply_filter").click(function(){
        change_params_form(true);
    });

    $("#hide_filter").click(function(){
        $(".param_item").hide()
        var tp=$(".catalog-list").offset().top-$(".header").height();
        $("html,body").animate({"scrollTop":tp},300)
        $(".filter_reset").removeClass("active");
        $(".up").removeClass("_filter");
        
    });
    $("#reset_filter").click(function(){
        if($(this).hasClass("active")){
            $(".param_item").hide();//,function(){
            var tp=$(".catalog-list").offset().top-$(".header").height();
            $("html,body").animate({"scrollTop":tp},300)
            //$(".filter_reset").removeClass("active");
            resetFilterForm();
            $(".up").removeClass("_filter");
        }
    });

    $(".showby_item").click(function(){
        $(".showby_item").removeClass("active");
        $(this).addClass("active");
        change_params_form(true);
    });

    $(document).on("change",".param_check",function(){
        if(flag_update){
            var flag=true;
            if($(window).width()<min_width_filter){
                flag=false;
            }
            change_params_form(flag);
        }
    });
    $(".range_slider").each(function(){
        var min_value=$(this).data("min_value")*1;
        var max_value=$(this).data("max_value")*1;
        var slider_item=$(this);

        if($(this).data("select_min")!=""){
            var sel_min_value=$(this).data("select_min")*1;
        }else{
            var sel_min_value=min_value;
        }

        if($(this).data("select_max")!=""){
            var sel_max_value=$(this).data("select_max")*1;
        }else{
            var sel_max_value=max_value;
        }
        if($(this).data("step")!=0){
            var step=$(this).data("step")*1;
        }else{
            var step=1;
        }
        
        slider_item.slider({
            step:step,
            range: true,
            animate: "fast",
            min: min_value,
            max: max_value,
            values: [sel_min_value,sel_max_value],
            slide: function( event, ui ) {

                $(this).closest(".wrapper_range_slider").find(".inputRangeMin").val(ui.values[0])
                $(this).closest(".wrapper_range_slider").find(".inputRangeMax").val(ui.values[1])
                
            },
            change:function(event, ui){
                var min_value=slider_item.data("min_value");
                var max_value=slider_item.data("max_value");

                if(flag_update){
                    //console.log($(this).attr("min_value")+"="+$(this).attr("max_value"))
                    if(min_value!=max_value){
                        if(min_value==ui.values[0]){
                            slider_item.data("select_min","");
                        }else{
                            slider_item.data("select_min",ui.values[0]);
                        }
                        if(max_value==ui.values[1]){
                            slider_item.data("select_max","");
                        }else{
                            slider_item.data("select_max",ui.values[1]);
                        }

                    }
                    var flag=true;
                    if($(window).width()<min_width_filter){
                        flag=false;
                    }
                    change_params_form(flag);
                }
            }
        });
    });
    $(".inputRangeMin").change(function(){
        var vl=$(this).val()*1;
        var itm=$(this).closest(".wrapper_range_slider").find(".range_slider");
        var avail_min = itm.data("min_value")*1;
        var avail_max = itm.data("max_value")*1;
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
        var avail_min = itm.data("min_value")*1;
        var avail_max = itm.data("max_value")*1;
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
            var product_id=fav_itm.data("product_id")
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
        if($(e.target).closest(".quantity-").length){
            e.preventDefault();
        }
    });
    /**Добавление товара из калькулятора #1 */
    $("#add_calcdata_tocart1").click(function(){
        //console.log("tut"+$("#calc_out1").attr("data-count"))
        /**Рассчитываемый товар */
        add_to_cart($("#product_id").data("product_id"), $("#calc_out1").attr("data-count"), 1);

        /**Праймер */
        add_to_cart(770, $("#calc_out3").attr("data-count"), 1);

        /**Цель*/
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'calc-cart');
        }

    });

    /**Добавление товара из калькулятора #6 */
    $("#add_calcdata_tocart6").click(function(){
        //console.log("tut"+$("#calc_out1").attr("data-count"))
        /**Рассчитываемый товар */

        add_to_cart($("#product_id").data("product_id"), $("#calc_out1").data("count"), 1);      
        add_to_cart(770, $("#calc_out5").data("count")*1, 1);
        add_to_cart(1015, $("#calc_out7").data("count")*1, 1);
        
    });

    $("#add_calcdata_tocart2").click(function(){        
        add_to_cart($("#product_id").data("product_id"), $("#calc_out1").attr("data-count"), 1);
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'calc-cart');
        }
    });

    $(".part_title._collapse").click(function(){
        $(this).toggleClass("active");
        $(".list_subcats").slideToggle(200);
    });
    $(document).on("mouseenter",".catalog_item_product",function(){
        $(this).addClass("_hover");
    });
    $(document).on("mouseleave",".catalog_item_product",function(){
        $(this).removeClass("_hover");
    });

    $(document).on('click','.buy',function(e){
        e.preventDefault();
        var show_added=0;
        var itm=$(this);
        
        
        if((!itm.hasClass("cart_similar_button"))&&(!itm.hasClass("cart_favorite_button"))){
            var ttl_buy='';
            if(itm.attr("button_name")){
                ttl_buy=itm.attr("button_name");
            }else{
                ttl_buy=itm.html()
                itm.attr("button_name",ttl_buy)
            }
            
            //itm.css({"background-color":"#41737E"});
            itm.addClass("_clicked");
            itm.html("Добавлено");
            
            let timerId=setTimeout(function(){
                //itm.css({"background-color":"#d3a06d"});
                itm.removeClass("_clicked");
                itm.html(ttl_buy);
                clearTimeout(timerId);
            }, 2000);
        }
        //switch  add-to-card-compare
        if((itm.hasClass("cart_similar_button"))||(itm.hasClass("add-to-card-compare"))){
            
            show_added=1;
            var product_id=$(this).data('product_id');
            //Добавление в козину из подобных товаров
            if(itm.hasClass("cart_similar_button")){
                if (typeof ym != 'undefined') {
                    ym(14496178, 'reachGoal', 'related-products');
                }
            }
            //Добавление в корзину из сравнения
            if(itm.hasClass("add-to-card-compare")){
                if (typeof ym != 'undefined') {
                    ym(14496178, 'reachGoal', 'add-to-card-compare');
                }
            }
            var cnt=itm.data("ui_minimum")*1;
            add_to_cart(product_id, cnt, show_added);
            
        }else{
            
            //Добавление в корзину из акции
            if($(this).closest(".tab-block").hasClass("accia_products")){
                if (typeof ym != 'undefined') {
                    ym(14496178, 'reachGoal', 'sale-card');
                }
            }
            var $container = $(this).closest('.quantity-buy'),
            qntController = $container.find('.qnt-widget').data('quantity'), 

            quantityInSaleUnits = qntController.getQuantityInSaleUnits(), 
            toPriceQuantityKoef = new Fraction( $(this).attr('data-sale_to_price_koef') ), 
            quantityInPriceUnits = toPriceQuantityKoef.mul(quantityInSaleUnits); 

            var product_id=$(this).data('product_id');
            var count_add=quantityInPriceUnits.valueOf();
            var itm_fly=$(this).closest(".wrp_fly");
            add_to_cart(product_id, count_add,0,itm_fly);
        }
    });

    $(document).on("click",".calc_show_more",function(){
        if($(this).hasClass("active")){          
            $(this).removeClass("active")
            $(this).text($(this).data("text"));
            $(this).closest(".calc_product_list").find("._hidden").fadeOut(200);
        }else{
            $(this).addClass("active")
            $(this).data("text",$(this).text());
            $(this).text("Скрыть дополнительные варианты")
            $(this).closest(".calc_product_list").find("._hidden").fadeIn(200);
        }
    });

    $(".inputCalc").change(function(){
        $(this).closest(".wrap_calculator-block").find(".calculator-block_error").hide();
    });
    $("#calc_select1").change(function(){
        var calcs=$(this).val();
        if(calcs){
            var calcs_arr=calcs.split(",");
            
            if(calcs_arr.length==1){               
                $("#calc_select2").val(calcs_arr[0]);
                //var calc=$(this).val()
                $(".calc_item").hide();
                $(".calc_item[data-calc='"+calcs_arr[0]+"']").fadeIn(200);
                $(".calc_products").hide();
                
            }else{
                $("#calc_select2").val(0);
            }
            $("#calc_select2").niceSelect('update');

            $(".wrap_calc_select2 .option").hide();           
            for(var i in calcs_arr){
                $(".wrap_calc_select2 .option[data-value='"+calcs_arr[i]+"']").show();
            }
        }
    });
    $("#calc_select2").change(function(){
        var calc=$(this).val()
        $(".calc_item").hide();
        $(".calc_item[data-calc='"+calc+"']").fadeIn(200);
        $(".calc_products").hide();
    })
    
    
    /**Калькулятор1 */
    function calc_calc1(itm){
        if($("#inp_calc_1").val()==""){
            itm.closest(".wrap_calculator-block").find(".calculator-block_error").show();
        }else{
            var data="&calculator_id=1&area="+$("#inp_calc_1").val();
            itm.closest(".calc_item").find(".result_calc").show();
            $("#rez_calc1").html($("#inp_calc_1").val())
            getCalcProducts(data);
        }
    }
    $("#cl_button_calc_1").click(function(){
        calc_calc1($(this))
    });
    $("#inp_calc_1").keypress(function(e){
        if(e.which == 13) {
            calc_calc1($(this))
        }
    });

    /**Калькулятор2 */
    function calc_calc2(itm){
        if($("#inp_calc_2").val()==""){
            itm.closest(".wrap_calculator-block").find(".calculator-block_error").show();
        }else{
            var data="&calculator_id=2&area="+$("#inp_calc_2").val();
            itm.closest(".calc_item").find(".result_calc").show();
            $("#rez_calc2").html($("#inp_calc_2").val())
            getCalcProducts(data);
        }
    }
    $("#cl_button_calc_2").click(function(){
        calc_calc2($(this))
    });
    $("#inp_calc_2").keypress(function(e){
        if(e.which == 13) {
            calc_calc2($(this))
        }
    });

    /**Калькулятор3 */
    function calc_calc3(itm){
        if(($("#inp_calc_31").val()=="")||($("#inp_calc_32").val()=="")||($("#inp_calc_33").val()=="")){
            itm.closest(".wrap_calculator-block").find(".calculator-block_error").show();
        }else{
            var data="&calculator_id=3&area1="+$("#inp_calc_31").val()+"&area2="+$("#inp_calc_32").val()+"&area3="+$("#inp_calc_33").val();
            itm.closest(".calc_item").find(".result_calc").show();
            $("#rez_calc3_1").html($("#inp_calc_31").val())
            $("#rez_calc3_2").html($("#inp_calc_32").val())
            $("#rez_calc3_3").html($("#inp_calc_33").val())
            getCalcProducts(data);
        }
    }
    $("#cl_button_calc_3").click(function(){
        calc_calc3($(this));
    });
    $("#inp_calc_31,#inp_calc_32,#inp_calc_33").keypress(function(e){
        if(e.which == 13) {
            calc_calc3($(this));
        }
    });


    /**Калькулятор4 */
    function calc_calc4(itm){
        if(($("#inp_calc_41").val()=="")||($("#inp_calc_42").val()=="")||($("#inp_calc_43").val()=="")){
            itm.closest(".wrap_calculator-block").find(".calculator-block_error").show();
        }else{
            var data="&calculator_id=4&area1="+$("#inp_calc_41").val()+"&area2="+$("#inp_calc_42").val()+"&area3="+$("#inp_calc_43").val();
            itm.closest(".calc_item").find(".result_calc").show();
            $("#rez_calc4_1").html($("#inp_calc_41").val())
            $("#rez_calc4_2").html($("#inp_calc_42").val())
            $("#rez_calc4_3").html($("#inp_calc_43").val())
            getCalcProducts(data);
        }
    }
    $("#cl_button_calc_4").click(function(){
        calc_calc4($(this));
    });
    $("#inp_calc_41,#inp_calc_42,#inp_calc_43").keypress(function(e){
        if(e.which == 13) {
            calc_calc4($(this));
        }
    });

    /**Калькулятор5 */
    function calc_calc5(itm){
        if(($("#inp_calc_51").val()=="")||($("#inp_calc_52").val()=="")||($("#inp_calc_53").val()=="")){
            itm.closest(".wrap_calculator-block").find(".calculator-block_error").show();
        }else{
            var data="&calculator_id=5&area1="+$("#inp_calc_51").val()+"&area2="+$("#inp_calc_52").val()+"&area3="+$("#inp_calc_53").val();
            itm.closest(".calc_item").find(".result_calc").show();
            $("#rez_calc5_1").html($("#inp_calc_51").val())
            $("#rez_calc5_2").html($("#inp_calc_52").val())
            $("#rez_calc5_3").html($("#inp_calc_53").val())
            getCalcProducts(data);
        }
    }
    $("#cl_button_calc_5").click(function(){
        calc_calc5($(this));
    });
    $("#inp_calc_51,#inp_calc_52,#inp_calc_53").keypress(function(e){
        if(e.which == 13) {
            calc_calc5($(this));
        }
    });

    /**Калькулятор6 */
    function calc_calc6(itm){
        if($("#inp_calc_6").val()==""){
            itm.closest(".wrap_calculator-block").find(".calculator-block_error").show();
        }else{
            var data="&calculator_id=6&area="+$("#inp_calc_6").val();
            itm.closest(".calc_item").find(".result_calc").show();
            $("#rez_calc6").html($("#inp_calc_6").val())

            getCalcProducts(data);
        }
    }
    $("#cl_button_calc_6").click(function(){
        calc_calc6($(this));
    });
    $("#inp_calc_6").keypress(function(e){
        if(e.which == 13) {
            calc_calc6($(this));
        }
    });


});