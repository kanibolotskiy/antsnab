import {Quantity} from './lib/quantity.es6.js';
import './lib/formsubmit.js';
var Fraction = require('fraction.js');
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

        $(".wrap_table_data").fadeIn();
    }else{
        $(".wrap_table_data").fadeOut();
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


$('#file').on('change', function () {
    var filename = this.files[0].name;
    $('#filename').html(filename);
    $('#filename').closest(".modal_form_row").removeClass("error");
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
                console.log(data);
                $(".wrp_modal_body").hide();
                $(".wrp_modal_thsnk").show();
            }
        });
    }

});
function calc1(){
    if (typeof ym != 'undefined') {
        ym(14496178, 'reachGoal', 'calc-use');
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
        $("#calc_out1").attr("data-count",count_itm1);

        /**Расчет праймера */
        var count_itm2=Math.ceil(data_calc2*0.5/16);
        var unitpack2_str=declOfNum(count_itm2, ["ведро","ведра","вёдер"]);
        $("#calc_out2").html(number_format(count_itm2,0,"."," ")+" "+unitpack2_str);
        $("#calc_out2").attr("data-count",count_itm2);
        $("#input_area").html(data_calc2+"м<sup>2</sup>");
        $(".wrap_table_data").fadeIn(200);

        var min_count=$("#priceSwitcher").attr("data-rosn_limit");
        if(total_consumption<min_count){
            $(".calc_hint").fadeIn();
            
            $("#calc_out1").attr("data-count",min_count);
            $("#calc_out3").html(min_count);
        }else{
            $(".calc_hint").fadeOut();
            //$("#calc_out1").attr("data-count",count_itm1);
        }

    }else{
        $("#calc_out1").html("-");
        $("#calc_out1").attr("data-count",0);

        $("#calc_out2").html("-");
        $("#calc_out3").html("-");
        $("#calc_out2").attr("data-count",0);
        $(".wrap_table_data").fadeOut(200);
    }
}
function calc2(){
    if (typeof ym != 'undefined') {
        ym(14496178, 'reachGoal', 'calc-use');
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
        $(".wrap_table_data").fadeIn(200);

        var min_count=$("#priceSwitcher").attr("data-rosn_limit");

        if(total_consumption<min_count){
            $(".calc_hint").fadeIn();
            
            $("#calc_out1").attr("data-count",min_count);
            $("#calc_out2").html(min_count);
        }else{
            $(".calc_hint").fadeOut();
            $("#calc_out1").attr("data-count",total_consumption);
        }

    }else{
        $("#calc_out1").html("-");
        $("#calc_out1").attr("data-count",0);
        $(".wrap_table_data").fadeOut(200);
    }
}
function calc3(){
    if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'calc-use');
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
            $(".wrap_table_data").fadeIn(200);
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
            $(".wrap_table_data").fadeOut(200);
    }

}
function calc4(){
    if (typeof ym != 'undefined') {
        ym(14496178, 'reachGoal', 'calc-use');
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
        
        
        $(".wrap_table_data").fadeIn(200);
    
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
        $(".wrap_table_data").fadeOut(200);
    }
}
function calc5(){
    if (typeof ym != 'undefined') {
        ym(14496178, 'reachGoal', 'calc-use');
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
        
        
        $(".wrap_table_data").fadeIn(200);
    
        var min_count=$("#priceSwitcher").attr("data-rosn_limit");
        
        var step=1;
        if($("#priceSwitcher").children(".unitpack1").attr("data-ui_step")!=undefined){
                step=$("#priceSwitcher").children(".unitpack1").attr("data-ui_step")*1;
        }
        min_count=min_count*step;
        
        //console.log(step);

        if(calc_rez<min_count){
            $(".calc_hint").fadeIn();
            $("#calc_out2").html(min_count);
            $("#calc_out1").attr("data-count",min_count);

            if(min_count>1){
                $("#calc_hint_caption").html("кратно упаковкам");
                var step_count=Math.ceil(calc_rez/step);
                console.log(step_count);

                $("#calc_out2").html(step_count*min_count);

                $(".calc_hint").fadeIn(200);
                $("#calc_out1").attr("data-count",step_count*min_count);
            }else{
                $(".calc_hint").fadeOut(200);
                $("#calc_out1").attr("data-count",calc_rez);
            }
            
        }else{
            $(".calc_hint").fadeOut();
            $("#calc_out1").attr("data-count",calc_rez);
        }
    }else{
        $("#input_area1").html("-");
        $("#input_area2").html("-");
        $("#input_area3").html("-");
        $(".wrap_table_data").fadeOut(200);
    }

}
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