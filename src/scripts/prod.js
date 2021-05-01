import {Quantity} from './lib/quantity.es6.js';
import './lib/formsubmit.js';
var Fraction = require('fraction.js');
var $switchers;
var $firstSwitcher;
var timeoutID;
var sending=false;
//var format = require('number-format.js');



function getPlural(number, one, two) {///1,ведра,вёдер
    let n = Math.abs(number);

    if(n==11){
        return two;
    }else{
        n %= 10;
        if (n === 1) {
            return one;
        }else{
            return two;
        }
    }
}
/**Дублируется в category.js */
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

/*Склонение по падежам*/
function declOfNum(number, titles)
{
    var cases = [2, 0, 1, 1, 1, 2];
    return titles[ (number%100>4 && number%100<20)? 2 : cases[(number%10<5)?number%10:5] ];
}
function getFloat(itm_val){
    return parseFloat(itm_val.replace(/,/, '.'));
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
        //currency = $('#priceSwitcher').attr('data-currency_symbol');
        currency = '<div class="rur">i</div>';
        
    
    var plural1=$("#priceSwitcher .active").attr("data-ui_name_genitive");
    var plural2=$("#priceSwitcher .active").attr("data-ui_name_plural");
    var mincount = $('#priceSwitcher .active').attr('data-ui_minimum');

    var opt_limit=$("#priceSwitcher").attr("data-opt_limit")
    var count_limit=Math.ceil(opt_limit*saleToUiKoef);

    var plural_str=getPlural(count_limit,plural1,plural2);

    var plural_min_count_str=getPlural(mincount,plural1,plural2);

    $("#opt_limit").html("от "+count_limit+" "+plural_str);

    $("#rosn_limit").html("от " + mincount + " " + plural_min_count_str);

    var isInt = ( uiPrice.valueOf() - parseInt(uiPrice.valueOf()) === 0 ),
        formatStr = isInt?'### ###.':'### ###,##';
 
        var price_val=uiPrice.valueOf();
        var opt_price_val=uiWholeSalePrice.valueOf();
        var price_str='';
        var opt_price_str='';

        if(price_val-parseInt(price_val)===0){
            price_str = number_format(price_val, 0, ",", " ") + " " + currency 
        }else{
            price_str = number_format(price_val, 2, ",", " ") + " " + currency
        }
        $price.html(price_str);

        if(opt_price_val-parseInt(opt_price_val)===0){
            opt_price_str = number_format(opt_price_val, 0, ",", " ") + " " + currency 
        }else{
            opt_price_str = number_format(opt_price_val, 2, ",", " ") + " " + currency
        }
        $wholeSalePrice.html(opt_price_str);

        if($("#discount_val").length){
            /*
            var discount_val1=$("#discount_val").attr("discount_val1")*(-1);
            var discount_val2=$("#discount_val").attr("discount_val2")*(-1);
            */
            var discount_val=$("#discount_val").attr("data-value")*1;

            var pr1=opt_price_val+opt_price_val*discount_val/(100-discount_val);
            var pr2=price_val+price_val*discount_val/(100-discount_val);
            var pr1_str="";
            var pr2_str="";

            //console.log(opt_price_val+"="+discount_val);

            pr1=pr1.toFixed(2);
            pr2=pr2.toFixed(2);
            
            pr1_str = number_format(pr1, 0, ",", " ") + " " + currency 
            pr2_str = number_format(pr2, 0, ",", " ") + " " + currency 
            /*
            if(pr1-parseInt(pr1)===0){
                pr1_str = number_format(pr1, 0, ",", " ") + " " + currency 
            }else{
                pr1_str = number_format(pr1, 2, ",", " ") + " " + currency
            }
            if(pr2-parseInt(pr2)===0){
                pr2_str = number_format(pr2, 0, ",", " ") + " " + currency 
            }else{
                pr2_str = number_format(pr2, 2, ",", " ") + " " + currency
            }
            */
            
            $(".product_old_price1").html(pr1_str);
            $(".product_old_price2").html(pr2_str);
        }
}


function calc1(){
    if (typeof ym != 'undefined') {
        ym(14496178, 'reachGoal', 'calc-use');
    }
    var flag_error=false;
    $(".inputCalc").each(function(){
        if($(this).val()==""){
            flag_error=true;
        }
    });
    if(flag_error){
        $(".calculator-block_error").fadeIn(150);
    }else{
        $(".calculator-block_error").fadeOut(150);
    }
    
    var data_calc1=getFloat($("#calculator").attr("data-consumption"));
    var data_calc2=getFloat($("#input_calc_1").val());
    var data_calc3=getFloat($("#priceSwitcher").attr("data-base_weight"));
    if(!data_calc3){
        data_calc3=1;
    }


    var total_consumption=data_calc1*data_calc2;
    if(total_consumption>0){
        
        var unitpack1=$(".unitpack1");
        var count_itm1=Math.ceil(total_consumption/data_calc3);
        var unitpack1_str=declOfNum(count_itm1, [unitpack1.attr("data-ui_name"),unitpack1.attr("data-ui_name_genitive"),unitpack1.attr("data-ui_name_plural")]);
        
        $("#calc_out1").html(number_format(count_itm1,0,"."," ")+" "+unitpack1_str);
        //$("#calc_out1").attr("data-count",count_itm1);
        $("#input_area").html(data_calc2+"м<sup>2</sup>");
        $(".wrap_table_calc").fadeIn(200);

        //var min_count=$("#priceSwitcher").attr("data-rosn_limit");
        var min_count=unitpack1.attr("data-ui_minimum");
        
        if(count_itm1<min_count){
            $(".calc_hint").fadeIn();
            $("#calc_out1").attr("data-count",min_count);
            $("#calc_out2").html(min_count);
        }else{
            $(".calc_hint").fadeOut();
            $("#calc_out1").attr("data-count",count_itm1);
        }

        /*
        var unitpack1=$(".unitpack1");
        var count_itm1=Math.ceil(total_consumption/data_calc3);
        var unitpack1_str=declOfNum(count_itm1, [unitpack1.attr("data-ui_name"),unitpack1.attr("data-ui_name_genitive"),unitpack1.attr("data-ui_name_plural")]);
        var min_count=unitpack1.attr("data-ui_minimum");

        $("#calc_out1").html(number_format(count_itm1,0,"."," ")+" "+unitpack1_str);
        $("#calc_out1").attr("data-count",count_itm1);
*/

        //Расчет праймера
        var count_itm2=Math.ceil(data_calc2*0.5/16);
        var unitpack2_str=declOfNum(count_itm2, ["ведро","ведра","вёдер"]);
        $("#calc_out3").html(number_format(count_itm2,0,"."," ")+" "+unitpack2_str);
        $("#calc_out3").attr("data-count",count_itm2);
        $("#input_area").html(data_calc2+"м<sup>2</sup>");
        $(".wrap_table_calc").fadeIn(200);
        

    }else{
        $("#calc_out1").html("-");
        $("#calc_out1").attr("data-count",0);

        $("#calc_out2").html("-");
        $("#calc_out3").html("-");
        $("#calc_out2").attr("data-count",0);
        $(".wrap_table_calc").fadeOut(200);
    }
}
function calc2(){
    if (typeof ym != 'undefined') {
        ym(14496178, 'reachGoal', 'calc-use');
    }
    var flag_error=false;
    $(".inputCalc").each(function(){
        if($(this).val()==""){
            flag_error=true;
        }
    });
    if(flag_error){
        $(".calculator-block_error").fadeIn(100);
    }else{
        $(".calculator-block_error").fadeOut(100);
    }

    var data_calc1=getFloat($("#calculator").attr("data-consumption"));
    var data_calc2=getFloat($("#input_calc_1").val());
    var data_calc3=getFloat($("#priceSwitcher").attr("data-base_weight"));
    if(!data_calc3){
        data_calc3=1;
    }
    var total_consumption=data_calc1*data_calc2;
    if(total_consumption>0){
        var unitpack1=$(".unitpack1");
        var count_itm1=Math.ceil(total_consumption/data_calc3);
        var unitpack1_str=declOfNum(count_itm1, [unitpack1.attr("data-ui_name"),unitpack1.attr("data-ui_name_genitive"),unitpack1.attr("data-ui_name_plural")]);
        
        $("#calc_out1").html(number_format(count_itm1,0,"."," ")+" "+unitpack1_str);
        //$("#calc_out1").attr("data-count",count_itm1);
        $("#input_area").html(data_calc2+"м<sup>2</sup>");
        $(".wrap_table_calc").fadeIn(200);

        //var min_count=$("#priceSwitcher").attr("data-rosn_limit");
        var min_count=unitpack1.attr("data-ui_minimum");
        
        if(count_itm1<min_count){
            $(".calc_hint").fadeIn();
            $("#calc_out1").attr("data-count",min_count);
            $("#calc_out2").html(min_count);
        }else{
            $(".calc_hint").fadeOut();
            $("#calc_out1").attr("data-count",count_itm1);
        }

    }else{
        $("#calc_out1").html("-");
        $("#calc_out1").attr("data-count",0);
        $(".wrap_table_calc").fadeOut(200);
    }
}
function calc3(){
    if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'calc-use');
    }

    var flag_error=false;
    $(".inputCalc").each(function(){
        if($(this).val()==""){
            flag_error=true;
        }
    });
    if(flag_error){
        $(".calculator-block_error").fadeIn(100);
    }else{
        $(".calculator-block_error").fadeOut(100);
    }

    var data_product1=getFloat($("#calculator").attr("calc_data1"));

    var data_calc1=$("#input_calc_31").val();
    var data_calc2=$("#input_calc_32").val();
    var data_calc3=$("#input_calc_33").val();

    var total_value=data_product1*data_calc1*data_calc2*data_calc3;
    total_value=Math.ceil(total_value*100)/100;


    if(total_value>0){
            $("#input_area1").html(data_calc1);
            $("#input_area2").html(data_calc2);
            $("#input_area3").html(data_calc3);
            var data_calc_count=getFloat($("#priceSwitcher").attr("data-base_vol"));
            if(!data_calc_count){
                    data_calc_count=1;
            }
            var calc_rez=Math.ceil(total_value/data_calc_count);

            var unitpack1=$(".unitpack1");
            //var count_itm1=Math.ceil(total_value/data_calc3);

            var unitpack1_str=declOfNum(calc_rez, [unitpack1.attr("data-ui_name"),unitpack1.attr("data-ui_name_genitive"),unitpack1.attr("data-ui_name_plural")]);
            $("#calc_out1").html(number_format(calc_rez,0,"."," ")+" "+unitpack1_str);
            $(".wrap_table_calc").fadeIn(200);
            var min_count=$("#priceSwitcher").attr("data-rosn_limit");

            var step=1;
            if($("#priceSwitcher").children(".unitpack1").attr("data-ui_step")!=undefined){
                    step=$("#priceSwitcher").children(".unitpack1").attr("data-ui_step")*1;
            }
            min_count=min_count*step;

            if(calc_rez<min_count){
                $("#calc_hint_caption").html("мин. для заказа");
                $(".calc_hint").fadeIn();
                $("#calc_out2").html(min_count);
                $("#calc_out1").attr("data-count",min_count);
            }else{
                if(min_count>1){
                        $("#calc_hint_caption").html("кратно упаковкам");
                        var step_count=Math.ceil(calc_rez/min_count);
                        $("#calc_out2").html(step_count*min_count);

                        $(".calc_hint").fadeIn(200);
                        $("#calc_out1").attr("data-count",step_count*min_count);
                }else{
                        $(".calc_hint").fadeOut(200);
                        $("#calc_out1").attr("data-count",calc_rez);
                }
            }
    }else{
            $("#input_area1").html("-");
            $("#input_area2").html("-");
            $("#input_area3").html("-");
            $(".wrap_table_calc").fadeOut(200);
    }

}
function calc4(){
    if (typeof ym != 'undefined') {
        ym(14496178, 'reachGoal', 'calc-use');
    }
    var flag_error=false;
    $(".inputCalc").each(function(){
        if($(this).val()==""){
            flag_error=true;
        }
    });
    if(flag_error){
        $(".calculator-block_error").fadeIn(100);
    }else{
        $(".calculator-block_error").fadeOut(100);
    }

    var data_product2=getFloat($("#calculator").attr("calc_data2"));
    var data_product3=getFloat($("#calculator").attr("calc_data3"));


    var data_calc1=$("#input_calc_41").val();
    var data_calc2=$("#input_calc_42").val();
    var data_calc3=$("#input_calc_43").val();

    var total_value=data_product2*data_product3*data_calc1*data_calc2*data_calc3/10;
    total_value=Math.ceil(total_value*100)/100;
    

    var data_calc_count=getFloat($("#priceSwitcher").attr("data-base_weight"));
    if(!data_calc_count){
        data_calc_count=1;
    }

    if(total_value>0){
        $("#input_area1").html(data_calc1);
        $("#input_area2").html(data_calc2);
        $("#input_area3").html(data_calc3);

        var unitpack1=$(".unitpack1");

        var calc_rez=Math.ceil(total_value/data_calc_count);
    
        var unitpack1_str=declOfNum(calc_rez, [unitpack1.attr("data-ui_name"),unitpack1.attr("data-ui_name_genitive"),unitpack1.attr("data-ui_name_plural")]);
        $("#calc_out1").html(number_format(calc_rez,0,"."," ")+" "+unitpack1_str);
        
        
        $(".wrap_table_calc").fadeIn(200);
    
        var min_count=$("#priceSwitcher").attr("data-rosn_limit");
        
        if(calc_rez<min_count){
            $(".calc_hint").fadeIn();
            $("#calc_out2").html(min_count);
            $("#calc_out1").attr("data-count",min_count);
        }else{
            $(".calc_hint").fadeOut();
            $("#calc_out1").attr("data-count",calc_rez);
        }
    }else{
        $("#input_area1").html("-");
        $("#input_area2").html("-");
        $("#input_area3").html("-");
        $(".wrap_table_calc").fadeOut(200);
    }
}
function calc5(){
    if (typeof ym != 'undefined') {
        ym(14496178, 'reachGoal', 'calc-use');
    }
    var flag_error=false;
    $(".inputCalc").each(function(){
        if($(this).val()==""){
            flag_error=true;
        }
    });
    if(flag_error){
        $(".calculator-block_error").fadeIn(100);
    }else{
        $(".calculator-block_error").fadeOut(100);
    }
    
    var data_product4=getFloat($("#calculator").attr("calc_data4"));


    var data_calc1=$("#input_calc_51").val();
    var data_calc2=$("#input_calc_52").val();
    var data_calc3=$("#input_calc_53").val();

    
    var data_calc_count=getFloat($("#priceSwitcher").attr("data-base_weight"));
    if(!data_calc_count){
        data_calc_count=1;
    }

    var total_value=data_calc1*data_calc2*data_calc3/10/data_product4;
    total_value=Math.ceil(total_value*100)/100;
    

    if(total_value>0){
        $("#input_area1").html(data_calc1);
        $("#input_area2").html(data_calc2);
        $("#input_area3").html(data_calc3);

        var unitpack1=$(".unitpack1");

        var calc_rez=Math.ceil(total_value/data_calc_count);
        //console.log(total_value+"/"+data_calc_count);

        var unitpack1_str=declOfNum(calc_rez, [unitpack1.attr("data-ui_name"),unitpack1.attr("data-ui_name_genitive"),unitpack1.attr("data-ui_name_plural")]);
        $("#calc_out1").html(number_format(calc_rez,0,"."," ")+" "+unitpack1_str);
        
        
        $(".wrap_table_calc").fadeIn(200);
    
        var min_count=$("#priceSwitcher").attr("data-rosn_limit");
        
        var step=1;
        if($("#priceSwitcher").children(".unitpack1").attr("data-ui_step")!=undefined){
                step=$("#priceSwitcher").children(".unitpack1").attr("data-ui_step")*1;
        }
        min_count=min_count*step;
        
        if(calc_rez<min_count){
            $(".calc_hint").fadeIn();
            $("#calc_out2").html(min_count);
            $("#calc_out1").attr("data-count",min_count);
            $("#calc_hint_caption").html("мин. для заказа");            
        }else{
            if(min_count>1){
                $("#calc_hint_caption").html("кратно упаковкам");
                var step_count=Math.ceil(calc_rez/min_count);
                $("#calc_out2").html(step_count*min_count);

                $(".calc_hint").fadeIn(200);
                $("#calc_out1").attr("data-count",step_count*min_count);
            }else{
                    $(".calc_hint").fadeOut(200);
                    $("#calc_out1").attr("data-count",calc_rez);
            }
        }
    }else{
        $("#input_area1").html("-");
        $("#input_area2").html("-");
        $("#input_area3").html("-");
        $(".wrap_table_calc").fadeOut(200);
    }

}
$( document ).ready(function() {

    $(document).on("mouseenter",".wrp_product_color,.wrap_viriant_itm_color",function(){
        var itm=$(this).children(".product_color_hint");
        //itm.css({"margin-left":0});
        //itm.find(".product_color_hint_arrow").css({"margin-left":0});

        itm.stop().css({"display":"block","opacity":0,"margin-left":0,})
        itm.find(".product_color_hint_arrow").css({"margin-left":0});
        var lft=itm.offset().left*1;
        var wd=itm.width()+50;
        var wd_window=0;
        if($(window).width()>880){
            wd_window=$(".content_visible").width()+30
        }else{
            wd_window=$(".content_visible").width();
        }

        var delta=$(".content_visible").offset().left+wd_window-(lft+wd);
        //console.log($(".content_visible").width());
        
        if(delta<0){
            itm.css({"margin-left":delta});
            itm.find(".product_color_hint_arrow").css({"margin-left":-delta});
        }
        if(lft<0){
            var delta_lft=lft-12
            itm.css({"margin-left":-delta_lft});
            itm.find(".product_color_hint_arrow").css({"margin-left":delta_lft});
        }
        itm.animate({"opacity":1},150);
    });
    $(document).on("mouseleave",".wrp_product_color,.wrap_viriant_itm_color ",function(){
        var itm=$(this).children(".product_color_hint");

        itm.stop().fadeOut(100,function(){
            itm.css({"margin-left":0});
            itm.find(".product_color_hint_arrow").css({"margin-left":0}); 
        });

    });
    if($('#priceSwitcher').length){
        $switchers = $('li','#priceSwitcher' );
        $firstSwitcher = $($switchers[0]);
        
        $switchers.on('click', toggleSwitchHandler);
        $firstSwitcher.trigger('click');
    }

    
/** Карточка */
/** init switching ui in specification (product) page 
if( $('#priceSwitcher').length > 0 && $('.qnt-container-spec').length > 0){
    (function() {

        var $switchers = $('li','#priceSwitcher' ),
            $firstSwitcher = $($switchers[0]);
        // sale_to_price_koef = switcher.attr('data-sale_to_price_koef'),
        
        $switchers.on('click', toggleSwitchHandler);
        $firstSwitcher.trigger('click');

        
        

    })()
}
*/
    $(".favdel").click(function(){
        
        var item_id=$(this).closest(".fav_row").data("product_id");

        var favorite_str=$.cookie('favorite');
        var fav_count=0;        
        if(favorite_str!=null){
            var favorite_arr=JSON.parse(favorite_str);
        }else{
            var favorite_arr=[];
        }
        

        var new_favorite_arr=[];
        var z=0;
        for(var i=0;i<favorite_arr.length;i++){
            if(favorite_arr[i]!=item_id){
                new_favorite_arr[z]=favorite_arr[i];
                z++;
            }
        }
        favorite_str=JSON.stringify(new_favorite_arr);
        fav_count=new_favorite_arr.length;
        if(fav_count==0){
            $(".empty_favorite_text").fadeIn(200);
            $("#wrp_add_all_favorites").fadeIn(200);
            $(".favorite_link").addClass("_empty");
            $("#add_all_favorites").hide();
        }else{
            $(".favorite_link").removeClass("_empty");
            $("#add_all_favorites").fadeIn(200);
        }

        $.cookie('favorite', favorite_str, { expires: 30, path: '/' });
        $("#favorite").css({"opacity":0});
        $("#favorite").animate({"opacity":1},200);
        var fav_itm=$(this).closest(".wrapper_basket-row");
        fav_itm.fadeOut(200,function(){
            fav_itm.remove();
        });
    });
    
    $(".favorite_link").click(function(e){
        if($(this).hasClass("_empty")){
            e.preventDefault();
        }
    });
    $(".compare_link").click(function(e){
        if($(this).hasClass("_empty")){
            e.preventDefault();
        }
    });

    $(document).on("click",".compare",function(e){
        e.preventDefault();

        var compare_itm=$(this);
        compare_itm.addClass("fly_animate");
        $(".compare_div").addClass("fly_animate");
        setTimeout(function() {
            compare_itm.removeClass("fly_animate");
            $(".compare_div").removeClass("fly_animate");
        }, 210);


        var item_id=$(this).data("rel");

        var compare_str=$.cookie('compare');
        if(compare_str!=null){
            var compare_arr=JSON.parse(compare_str);
        }else{
            var compare_arr=[];
        }
        var compare_count=0;

        if($(this).hasClass("active")){
            $(this).removeClass("active");
            var new_compare_arr=[];
            var z=0;
            for(var i=0;i<compare_arr.length;i++){
                if(compare_arr[i]!=item_id){
                    new_compare_arr[z]=compare_arr[i];
                    z++;
                }
            }
            compare_str=JSON.stringify(new_compare_arr);
            compare_count=new_compare_arr.length;
        }else{
            if (typeof ym != 'undefined') {
                ym(14496178, 'reachGoal', 'compare');
            }
            $(this).addClass("active");
            compare_arr[compare_arr.length]=item_id;
            compare_str=JSON.stringify(compare_arr);
            compare_count=compare_arr.length;
        }
        if(compare_count==0){
            $(".compare_link").addClass("_empty");
        }else{
            $(".compare_link").removeClass("_empty");
        }


        $("#compare").css({"opacity":0});
        $("#compare").animate({"opacity":1},200);
        $.cookie('compare', compare_str, { expires: 30, path: '/' });
    });

    $(document).on("click",".favorite",function(e){
        var fav_itm=$(this);
        

        fav_itm.addClass("fly_animate");
        $(".favorite_div").addClass("fly_animate");
        setTimeout(function() {
            fav_itm.removeClass("fly_animate");
            $(".favorite_div").removeClass("fly_animate");
        }, 210);


        e.preventDefault();
        var item_id=$(this).data("rel");

        var favorite_str=$.cookie('favorite');//$.cookie('cat_view', rel, { expires: 7, path: '/' });
        if(favorite_str!=null){
            var favorite_arr=JSON.parse(favorite_str);
        }else{
            var favorite_arr=[];
        }
        var fav_count=0;

        if($(this).hasClass("active")){
            $(this).removeClass("active");
            var new_favorite_arr=[];
            var z=0;
            for(var i=0;i<favorite_arr.length;i++){
                if(favorite_arr[i]!=item_id){
                    new_favorite_arr[z]=favorite_arr[i];
                    z++;
                }
            }
            favorite_str=JSON.stringify(new_favorite_arr);
            fav_count=new_favorite_arr.length;
        }else{
            if (typeof ym != 'undefined') {
                ym(14496178, 'reachGoal', 'favorite');
            }
            $(this).addClass("active");
            favorite_arr[favorite_arr.length]=item_id;
            favorite_str=JSON.stringify(favorite_arr);
            fav_count=favorite_arr.length;
        }
        if(fav_count==0){
            $(".favorite_link").addClass("_empty");
        }else{
            $(".favorite_link").removeClass("_empty");
        }


        $("#favorite").css({"opacity":0});
        $("#favorite").html(fav_count);
        $("#favorite").animate({"opacity":1},200);
        $.cookie('favorite', favorite_str, { expires: 30, path: '/' });
    });

    
    $(document).on("mouseenter",".wrap_oneclick",function(){
        $(this).addClass("active");
    });
    $(document).on("mouseleave",".catalog_item_product",function(){
        if(!$(this).find(".onclickInput").is(":focus")){
            $(this).find(".wrap_oneclick").removeClass("active");
        } 
    });
    $(document).on("focusout",".onclickInput",function(){
        $(this).closest(".wrap_oneclick").removeClass("active");
    });
    /*
    $(document).on("keyup touched",".onclickInput",function(){
        var vl=$(this).val();
        var itm=$(this).closest(".wrap_oneclick");
        itm.closest(".catalog_item_product").find(".input_test").html(vl);
    });
    */
   
    $(document).on("click",".onclickInput",function(e){
        e.preventDefault();
    })
    $(document).on("click",".oneclick_hover",function(e){
        e.preventDefault();
        $(this).closest(".wrap_oneclick").find(".onclickInput").focus();
        
    });
    $(document).on("keyup input",".onclickInput",function(){
        //console.log("send");
        var vl=$(this).val();
        var itm=$(this).closest(".wrap_oneclick");
        
        if((vl.indexOf("_")==-1)&&(vl!="")){
            if(!sending){
                sending=true;
                //console.log("посылаем");
                var frm=$(this).closest(".oneclickform");
                var data=frm.serialize();
                var itm_thanks=itm.find(".oneclick_thanks");

                itm.find(".oneclick_loader").fadeIn(100);
                itm.find(".oneclick_hover_ok").hide();
                
                
                $.ajax({
                    url: '/index.php?route=product/product/sendOneForm/',
                    data: data,
                    cache: false,
                    method: 'POST',
                    dataType: 'json',
                    success: function(data){

                        itm.find(".oneclick_loader").hide();
                        itm.find(".oneclick_hover_ok").fadeIn(100);
                        frm.find(".onclickInput").val("");
                        itm_thanks.fadeIn(100,function(){
                            itm_thanks.delay(2000).fadeOut(200,function(){
                                $(".wrap_oneclick").removeClass("active");
                                sending=false;
                            });
                            
                        });
                        
                        if (typeof ym != 'undefined') {
                            if(itm.closest(".tab-block").hasClass("accia_products")){
                                //Быстрый заказ (акции)
                                ym(14496178, 'reachGoal', 'sale-1click');
                            }else{
                                //Быстрый заказ (все остальное)
                                ym(14496178, 'reachGoal', '1click');
                            }
                        }
                    }
                });
            }
           
        }
        
    });

    /**/
    $(document).on("click",".onclickButton",function(e){
        e.preventDefault();
        
        var frm=$(this).closest(".oneclickform");

        var itm_phone=frm.find(".onclickInputMain");
        var itm_button=$(this)
        $(".onclickInputMain").removeClass("error");

        if(itm_phone.val()==""){
            itm_phone.addClass("error");
        }else{
            itm_phone.removeClass("error");
            var data=frm.serialize();
            itm_button.prop('disabled', true);

            $.ajax({
                
                url: '/index.php?route=product/product/sendOneForm/',
                data: data,
                cache: false,
                
                method: 'POST',
                type: 'POST', // For jQuery < 1.9
                dataType: 'json',
                success: function(data){
                    itm_button.prop('disabled', false);
                    $(".oneclick_product_thanks").fadeIn(200,function(){
                        frm.find(".onclickInputMain").val("");
                        $(".oneclick_product_thanks").delay(2000).fadeOut(200);
                    });
                    if (typeof ym != 'undefined') {
                        ym(14496178, 'reachGoal', '1click');
                    }
                }
            });
        }
    });
    
    /** submit reviews */
    $('#button-review').formSubmit({
        loaderSelector: '#ajax_loader',
        url: '/index.php?route=product/product/write&product_id=' + $('#button-review').data('product_id'),
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
                /*console.log("okk");
                $(".popup.thank-you").addClass("visible");
                */
                $(".modal").hide();
                $(".modal_thanks_feedback").fadeIn(200);
                $("body").addClass("is-compensate-for-scrollbar");
                $('input, textarea','#form-review').val('');
            }

        },
        error: function(data){},
    });

    /**Грузоподъемность */
    $("#courier_select").on('change', function () {
        var max_weight=$(this).val();
        var weight=$("#priceSwitcher").attr("data-base_weight");

        var unitpack1=$(".unitpack1");
        var unitpack2=$(".unitpack2");
        
        var unitpack1_count=Math.floor(max_weight*unitpack1.attr("data-sale_to_ui_koef")/weight);
        if($(this).val()>0){
            if (typeof ym != 'undefined') {
                ym(14496178, 'reachGoal', 'loading-rates');
            }
            $(".table_data_gruz").fadeIn();
            //$(this).closest(".resp-tab-content").find(".wrap_table_data").fadeIn();
        }else{
            $(".table_data_gruz").fadeOut();
            //$(this).closest(".resp-tab-content").find(".wrap_table_data").fadeOut();
        }
        if(unitpack1.length){
            if(unitpack1_count>0){            
                var unitpack1_str=declOfNum(unitpack1_count, [unitpack1.attr("data-ui_name"),unitpack1.attr("data-ui_name_genitive"),unitpack1.attr("data-ui_name_plural")]);
                $("#unitpack1_str").html(number_format(unitpack1_count,0,"."," ") + " "+unitpack1_str);
            }else{
                $("#unitpack1_str").html("-");
            }
        }
        if(unitpack2.length){
            if(unitpack1_count>0){
                var unitpack2_count=Math.ceil(unitpack1_count*unitpack2.attr("data-nom") / unitpack2.attr("data-denom") /unitpack1.attr("data-sale_to_ui_koef"));
                var unitpack2_str=declOfNum(unitpack2_count, [unitpack2.attr("data-ui_name"),unitpack2.attr("data-ui_name_genitive"),unitpack2.attr("data-ui_name_plural")]);
                $("#unitpack2_str").html(number_format(unitpack2_count,0,"."," ") +" "+unitpack2_str);
            }else{
                $("#unitpack2_str").html("-");
            }
        }    

    });


    
    $("#discount_form .required").change(function(){
        $(this).parent().removeClass("error");
    });
    $("#discount_form input[type='submit']").click(function(e){
        e.preventDefault();
        
        var flag_order=true;
        var frm=$("#discount_form");
        
        var input_email=frm.find("input[name='email']")
        
        frm.find(".required").each(function(){
            var itm=$(this);
            if($.trim(itm.val())==""){
                flag_order=false;
                itm.parent().addClass("error");
            }else{
                itm.parent().removeClass("error");
            }
        });
        if($.trim($("#file").val())==""){
            $("#file").closest(".modal_form_row").addClass("error");
        }else{
            $("#file").closest(".modal_form_row").removeClass("error");
        }

        var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
        if(pattern.test(input_email.val())){
            input_email.parent().removeClass("error");
        }else{
            input_email.parent().addClass("error");        
        }

        var data = new FormData($('#discount_form')[0]);
        if(flag_order){
            
            $.ajax({
                url: '/index.php?route=product/product/sendOptForm/',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST', // For jQuery < 1.9
                dataType: 'json',
                success: function(data){
                    $(".wrp_modal_body").hide();
                    $(".wrp_modal_thsnk").show();
                    $("body").addClass("is-compensate-for-scrollbar");
                }
            });
        }

    });
    
    $(".rating_star").mouseenter(function(){
        $(".rating_star").removeClass("_hide").removeClass("_current");
        $(this).addClass("_current");
        $(this).prevAll().addClass("_hide");
        $(this).nextAll().addClass("_hide");
        var rel=$(this).attr("rel");
        $("#rating_stars_value").html(rel);
    });

    $(".rating_stars").mouseenter(function(){
        $(".rating_star").removeClass("_rate");
    });
    $(".rating_stars").mouseleave(function(){
        $(".rating_star").removeClass("_current").removeClass("_hide");
        var star_value=$("#star_value").val();
        $("#rating_stars_value").html(star_value);
        var i=0;
        $(".rating_star").each(function(){
            if(i>=star_value){

                $(this).addClass("_hide");
            }
            i++;
        });
    });
    $(".rating_star").click(function(){
        $(this).addClass("_rate");
        $(this).prevAll().addClass("_rate");
        $(this).nextAll().addClass("_hide");
        $(".rating_stars").removeClass("active");
        var rel=$(this).attr("rel");
        $("#rating_stars_value").html(rel);
        $("#star_value").val(rel);
    });



    $("#input_calc_1").on('keypress',function(e) {
        if(e.which == 13) {
            calc1();
        }
    });
    $("#input_calc_2").on('keypress',function(e) {
        if(e.which == 13) {
            calc2();
        }
    });
    $("#input_calc_31,#input_calc_32,#input_calc_33").on('keypress',function(e) {
        if(e.which == 13) {
            calc3();
        }
    });
    $("#input_calc_41,#input_calc_42,#input_calc_43").on('keypress',function(e) {
        if(e.which == 13) {
            calc4();
        }
    });
    $("#input_calc_51,#input_calc_52,#input_calc_53").on('keypress',function(e) {
        if(e.which == 13) {
            calc5();
        }
    });

    $("#button_calc_1").click(function(){
        calc1();
    });
    $("#button_calc_2").click(function(){
        calc2();
    });

    $("#button_calc_3").click(function(){
        calc3();
    });
    $("#button_calc_4").click(function(){
        calc4();
    });
    $("#button_calc_5").click(function(){
        calc5();
    });

    $(document).on("click",".fast_preview_span",function(e){
        e.preventDefault();
        var product_id=$(this).closest(".catalog_item_product").data("rel");
        $.ajax({
            url: '/index.php?route=product/product/getFastInfo/',
            data: "&product_id="+product_id,
            cache: false,
            method: 'POST',
            //dataType: 'json',
            success: function(data) {
                //console.log(data);
                $("#modal_info_product").html(data);
                $('input[name="phone"]').inputmask("+7 9999999999",{ 
                    "clearIncomplete": true,
                    "alias": 'numeric', 
                    "allowMinus": false
                });
                $("body").addClass("is-compensate-for-scrollbar");
                $(".modal").hide();
                $(".modal_info").fadeIn(200);
                /*
                var sw=scrollbarWidth();
                $("html").css("overflow", "hidden");
                $("html").css("margin-right", sw+"px");
                
                $("body._hfixed .wrp_header").css({"padding-right":sw+"px"});
                */
                

                //import {Quantity} from './lib/quantity.es6.js';
                initQuantityContainers($('.qnt-container-modal'));
                $switchers = $('li','#priceSwitcher' ),
                $firstSwitcher = $($switchers[0]);
                $switchers.on('click', toggleSwitchHandler);
                $firstSwitcher.trigger('click');
            }
        });
    });
    
    $(document).on("click",".close_accia_info",function(){
        $(this).closest(".product_accia_text").removeClass("active");
    });
    $(document).on("click",function(e){
        if($(e.target).closest('.product_accia_text').length ) {
            return;
        }
        $(".product_accia_text").removeClass("active");
    });

    $(".product_accia_text").mouseleave(function(){
        var itm=$(this);
        itm.addClass("_leave");
        
        setTimeout(function () {
            if(itm.hasClass("_leave")){
                itm.removeClass("active").removeClass("_leave").removeClass("_hover");
            }
        }, 500)
    });
    $(".product_accia_text").mouseenter(function(){
        var itm=$(this);
        itm.addClass("_hover");
        itm.removeClass("_leave");   
    });
    /*
    $(".item_label._accia").mouseleave(function(){
        $(this).removeClass("_enter");
    });
    */
    $(document).on("mouseleave",".item_label._accia",function(){
        var itm=$(this).closest(".catalog_item_product").find(".product_accia_text");
        setTimeout(function () {
            if(!itm.hasClass("_hover")){
                itm.removeClass("active");
            }
            
        }, 500)
    });
    $(document).on("mouseenter",".item_label._accia",function(){

        if($(this).hasClass("mainitem_accialabel")){
            $(".product_accia_text").addClass("active");
        }else{
            var itm=$(this);
            itm.addClass("_enter");
            $(".product_accia_text").removeClass("active");
            setTimeout(function () {
                if(itm.hasClass("_enter")){
                    itm.closest(".catalog_item_product").find(".product_accia_text").addClass("active");
                }
            }, 500)
        }
    });


    $(document).on("click",".modal_info_product .tovar_mini_image",function(){
        var itm=$(this);
        if(!itm.hasClass("active")){
            $(".tovar_mini_image").removeClass("active");
            itm.addClass("active");
            var rel=itm.attr("rel");
            //console.log(rel);
            var pop_image=$("#main_popup_product_image");
            pop_image.css({"opacity":0});
            pop_image.attr("src",rel);
            pop_image.animate({"opacity":1},400);
        }
    });
    if($(".mentioned_products_caption.active").length){
        var itm=$(".mentioned_products_caption.active");
        var wd=itm.outerWidth();
        var lp=itm.position().left;
        $("#mentioned_active_line").animate({"width":wd,"left":lp},100)
    }
    $(".mentioned_products_caption").mouseenter(function(){
        var wd=$(this).outerWidth();
        var lp=$(this).position().left;
        $("#mentioned_active_line").animate({"width":wd,"left":lp},100)
    });

    $(".mentioned_products_captions").mouseleave(function(){
        var itm=$(".mentioned_products_caption.active");
        var wd=itm.outerWidth();
        var lp=itm.position().left;
        $("#mentioned_active_line").animate({"width":wd,"left":lp},100)
    });
    $(".type_reviews_caption").click(function(){
        if(!$(this).hasClass("active")){
            var rel=$(this).attr("rel");
            var ttl=$(this).data("caption");
            var lbl=$(this).data("label");
            var plc=$(this).data("plc");
            $("#txt_review").attr("placeholder",plc);
            $("#label_review").html(lbl);
            $(".type_reviews_caption").removeClass("active");
            $(this).addClass("active");
            $(".type_reviews_block").hide();
            $(".type_reviews_block[rel='"+rel+"']").fadeIn(150);
            $(".title-give-feedback").html(ttl);
            $("#button-review").html(ttl)
        }
    });
});
