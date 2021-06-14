import {Quantity} from './lib/quantity.es6.js';

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
            'el_name': $inputName,
            'ui_step':$el.attr('data-ui_step'),
            'ui_minimum':$el.attr('data-ui_minimum')
        });
        
        var qntController = $el.data('quantity');
        qntController.setQuantityInUiUnits($priceUnitQuantity);
        $el.removeClass("without_input");

    });
}
function validateEmail(email) {
    var re = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/;
    return re.test(String(email).toLowerCase());
  }
function getDelivery(){
    //var koef=$("#priceSwitcher .active").attr("data-sale_to_ui_koef")*1;
    var koef=eval($("#priceSwitcher .active").attr("data-sale_to_ui_koef"));
    var base_weight=$("#priceSwitcher").attr("data-base_weight")*1;
    var product_id=$("#product_id").data("product_id");
    //console.log(koef);
    if(!koef){
        koef=1;
    }
    var qnt=$(".quantity-buy .qnt").val()
    //var base_count=$("#product_count_add").val()/koef;
    var base_count=qnt/koef;

    var weight=base_count*base_weight;
    //console.log($("#product_count_add").val()+"/"+koef);
    //var data={};
    $.ajax({
        url: '/index.php?route=product/product/ajaxDelivery/',
        data: '&product_id='+product_id+'&weight='+weight,
        type: 'POST',
        dataType: 'json',
        success: function(json) {
            if(json['success']){
                var str_delivery='<span class="nowrap">'+json['date_delivery']+'</span>,<br/>'+json['price_delivery'];
                $("#delivery_text").html(str_delivery);

                $("#caption_delivery").html(json['caption_delivery']);
                $("#text_delivery").html(json['text_delivery']);
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
    
}

function refresh_veiew_cart(json){
    if(json["success"]){
        
        var total=json["total"];
        $("#total_cart").css({"opacity":0});
        $("#total_cart").html(total);
        
        $(".basket_link").html(json['total_str']);

        $("#total_cart").animate({"opacity":1},100);

        $("#order_weight").css({"opacity":0});
        $("#order_weight").html(json["total_weight"]);
        $("#order_weight").animate({"opacity":1},200);

        if($("#order_weight_cost").html()!=json["total_del"]){
            $("#order_weight_cost").css({"opacity":0});
            $("#order_weight_cost").html(json["total_del"]);
            $("#order_weight_cost").animate({"opacity":1},200);
        }
        
        if(json["econom"]==0){
            $(".intotal.economy").hide();
        }else{
            $(".intotal.economy").show(200);
            $("#ecosum").css({"opacity":0});
            $("#ecosum").html(json["econom"]);
            $("#ecosum").animate({"opacity":1},200);

            
        }
        
        var products=json["products"];
        if(products.length){
            $("#empty_cart_block").hide();
            $("#full_cart_block").show();
            for(var i=0;i<products.length;i++){
                var itm=$("input[name='quantity["+products[i].cart_id+"]']").closest(".basket-row");
                if(products[i].isWholesale){
                    itm.find(".cart_price_caption_opt").show();
                    itm.find(".cart_price_caption_rozn").hide();
                    itm.find(".cart_price_val").html(products[i].price_wholesale)
                }else{
                    itm.find(".cart_price_caption_opt").hide();
                    itm.find(".cart_price_caption_rozn").show();
                    itm.find(".cart_price_val").html(products[i].price)
                }
                itm.find(".recalc").html(products[i].total);
            }
        }else{
            $("#empty_cart_block").show();
            $("#full_cart_block").hide();
        }
    }
}
function refresh_cart(){
    var data=$("#cart_form").serialize();
    
    $.ajax({
        url: '/index.php?route=checkout/cart/ajaxRefresh/',
        data: data,
        type: 'POST',
        dataType: 'json',
        success: function(json) {
            if (typeof dataLayer != 'undefined') {
                var product = [{
                    "id": json['metrika_product_id'],
                    "name": json['metrika_product_name'],
                    "price": json['metrika_product_price'],
                    "quantity": json['metrika_product_quantity']
                }];
                
                if(json["metrika_action"]=="add"){
                    dataLayer.push({"ecommerce": {"add": {"products": product}}});
                }else{
                    dataLayer.push({"ecommerce": {"remove": {"products": product}}});
                }
            }
            refresh_veiew_cart(json);
        },
        error: function(xhr, ajaxOptions, thrownError) {
            console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
}
function check_opt_notification(itm){
    //Цена близка к оптовой (показываем подсказку)
    var row_count=itm.find(".qnt").val()*1;
    var itm_widget=itm.find(".qnt-widget");
    var opt_limit=itm_widget.attr("data-sale_to_price_koef")*itm_widget.attr("data-wholesale_threshold");
    
    if((row_count>=opt_limit*80/100) && (row_count<opt_limit)){
        itm.find(".opt_limit_notification_value").html(opt_limit-row_count);
        itm.find(".opt_limit_notification").fadeIn(200);
    }else{
        itm.find(".opt_limit_notification").fadeOut(200);
    }

    //Проверка кол-ва
    
    if(row_count>itm_widget.data("cnt")*1){
        itm.find(".basket-row_info._unavail").fadeIn(150);
        itm.find(".basket-row_info._avail").fadeOut(150);
    }else{
        itm.find(".basket-row_info._unavail").fadeOut(150);
        itm.find(".basket-row_info._avail").fadeIn(150);
    }

}
$(function(){
    $("#order_form input").on("keydown",function(e){
        //console.log(e.keyCode)  
        if(e.keyCode==13){
            e.preventDefault();
            var rel=$(".ordering_caption_item.active:last").attr("rel");

            $(".order_block[rel='"+rel+"']").find(".order_button_next").trigger("click");
            if(rel==1){
                $("#order_address").focus();
            }
            if(rel==2){
                $("#send_order_button").focus();
            }
        }
        
    });

    if($("#order_name").length){$.cookie('orderdata')
        if($.cookie('orderdata')){
            var orderdata=JSON.parse($.cookie('orderdata'));
            $("#order_name").val(orderdata['name']);
            $("#order_phone").val(orderdata['phone']);
            $("#order_email").val(orderdata['email']);
            $("#order_inn").val(orderdata['inn']);
            $("#order_address").val(orderdata['address']);
            if(orderdata['delivery']){
                //$(".delivery
                $(".delivery_order_block").removeClass("active");
                var del_itm=$(".delivery_order_block[rel='"+(orderdata['delivery']*1)+"']");
                del_itm.addClass("active");
                $("#shipping_method").val(del_itm.attr("data-caption"))
            }
            $(".payment_order_blocks").hide();
            //console.log(orderdata)
            if(orderdata['client']*1==2){
                //console.log(2)
                $(".payment_order_blocks[rel='2']").css({"display":"flex"});
                $("#payment_method").val("Оплата по счёту для юридических лиц");
            }else{
                //console.log(1)
                $(".payment_order_blocks[rel='1']").css({"display":"flex"});
                $("#payment_method").val("Наличными при получении");
            }
        }
        //console.log();
    }
    $('#order_form').submit(function(){
        /**Сохраняем инфу в куки */
        var orderdata={"name":$("#order_name").val(),"phone":$("#order_phone").val(),"email":$("#order_email").val(),"address":$("#order_address").val(),"inn":$("#order_inn").val(),"client":$("#lico").val(),"delivery":$(".delivery_order_block.active").attr("rel")};
        $.cookie('orderdata', JSON.stringify(orderdata), { expires: 100, path: '/' });
        
        $(this).find('input[type=submit], button[type=submit]').prop('disabled', true);
        

	});
    $(".basket-row").each(function(){
        check_opt_notification($(this));
    });

    getDelivery();

    $(".payment_order_block").click(function(){
        if($(this).hasClass("_disable")){
            var itm=$(this).find(".delivery_disabled");
            itm.fadeIn(200,function(){
                itm.delay(2000).fadeOut(150);
            });

        }else{
            var rel=$(this).attr("rel");
            $(this).parent().find(".payment_order_block").removeClass("active");
            $(this).addClass("active");
        }
    });

    $(".delivery_order_block").click(function(){
        var rel=$(this).attr("rel");
        var cap=$(this).attr("data-caption");
        $("#shipping_method").val(cap);
        $(".delivery_order_block1,.delivery_order_block2").removeClass("active");
        $(this).addClass("active");
    });
    $(".inputAddress").suggestions({
        token: "b231f8faef5fbb8190930e4ade4f722e7b3f7a89",
        type: "ADDRESS",
        constraints: {
            // ISO-код страны
            // Список ISO-кодов: https://ru.wikipedia.org/wiki/ISO_3166-1
            locations: [{ "region": "Московская"},{"region": "Москва"}],
        },
        //"locations":[{"kladr_id":"50"}]
        onSelect: function(suggestion) {
            //console.log(suggestion);
        }
    });

    $('#file').on('change', function () {
        var filename = this.files[0].name;
        var filename_arr=filename.split('.');
        var ext = filename_arr.pop();
        
        $('#filename').html('<span class="filename_info">'+filename_arr.join("")+'</span><span class="filename_ext">.'+ext+'</span><div class="uplodafile_del" id="uplodafile_del"></div>');
        $('#filename').closest(".modal_form_row").removeClass("error");
    });
    $(document).on("click","#uplodafile_del",function(){
        console.log("re");
        $("#file").val("");
        $("#filename").html("Прикрепите реквизиты");
    });
    $(document).on("click",".actionbutton.del",function(){
        var key=$(this).attr("data-cartid");
        var data="key="+key;
        var cart_row=$(this).closest(".basket-row");

        cart_row.fadeOut(200,function(){
            cart_row.remove();
        })
        
        $.ajax({
            url: '/index.php?route=checkout/cart/ajaxDel/',
            data: data,
            type: 'POST',
            dataType: 'json',
            success: function(json) {
                //console.log(json);
                var product = [{
                    "id": json['metrika_product_id'],
                    "name": json['metrika_product_name'],
                    "price": json['metrika_product_price'],
                    "quantity": json['metrika_product_quantity']
                }];
                if (typeof dataLayer != 'undefined') {
                    dataLayer.push({"ecommerce": {"remove": {"products": product}}});
                }

                refresh_veiew_cart(json);
                /*
                cart_row.fadeOut(200,function(){
                    cart_row.remove();
                })
                */
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    //$(document).on("change",".qnt",function(){
    $(document).on("click",".basket-row .LeftButton,.basket-row .RightButton",function(){
        check_opt_notification($(this).closest(".basket-row"));
        refresh_cart();
    });

    $(document).on("click",".quantity-buy_product .LeftButton,.quantity-buy_product .RightButton",function(){
        getDelivery();
    });
    $(document).on("change",".basket-row .qnt",function(){
        check_opt_notification($(this).closest(".basket-row"));
    });

    $(document).on("change",".qnt",function(){
        
        refresh_cart();
        getDelivery();
    });

    $("#order_form input[type='submit']").click(function(e){
        
        e.preventDefault();
        
        var flag_order=true;
        var frm=$("#order_form");

        var input_name=frm.find("input[name='name']")
        var input_phone=frm.find("input[name='phone']")
        var input_email=frm.find("input[name='email']")
        var input_address=frm.find("input[name='shipping_address']")

        var pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i;

        if($.trim(input_name.val())==""){
            flag_order=false;
            input_name.prev().fadeIn(100);
        }else{
            input_name.prev().fadeOut(100);
        }
         
        var phone_str=$.trim(input_phone.val());
        if($.trim(input_phone.val())==""){
            flag_order=false; 
            input_phone.prev().fadeIn(100);
        }else{
            if(phone_str.indexOf("_")!=-1){
                flag_order=false; 
                input_phone.prev().fadeIn(100);
            }else{
                input_phone.prev().fadeOut(100);            
            }
            
        }

        if($("input[name='need_shipping']").prop("checked")){
            if($.trim(input_address.val())==""){
                flag_order=false;
                input_address.prev().fadeIn(100);
            }else{
                input_address.prev().fadeOut(100);
            }
        }else{
            input_address.prev().fadeOut(100);            
        }

        if(flag_order){    
            $.ajax({
                url: '/index.php?route=checkout/cart/setProductsCommerce/',
                type: 'POST',
                dataType: 'json',
                success: function(json) {

                    if (typeof dataLayer != 'undefined') {
                        dataLayer.push({"ecommerce": {"purchase": {"actionField": {
                            "id" : json['orderid']
                        },"products": json['products']}}});

                        $("#order_form").submit();
                    }
                }
            });
        }else{
            //console.log("not send");
        }

    });
    /*
    $("input[name='need_shipping']").change(function(){
        if($(this).prop("checked")){
            $(".delivery_row").stop().slideDown(150);
        }else{
            $(".delivery_row").stop().slideUp(150);
        }
    });
    */
    $(".ordering_type").click(function(){
        $(".ordering_type").removeClass("active");
        $(this).addClass("active");
        var rel=$(this).attr("rel");
        $("#lico").val(rel);
        var pay=$(this).attr("data-pay");
        $("#payment_method").val(pay);

        if(rel==2){
            $(".client2").addClass("_showed");
            //$(".client2").fadeIn(200);
            //$(".client2").css({"visibility":"visible"})
        }else{
            $(".client2").removeClass("_showed");
            $("#order_email").parent().removeClass("_error");

            //$(".client2").fadeOut(200);
            //$(".client2").css({"visibility":"hidden"})
        }
        $(".payment_order_blocks").hide();
        $(".payment_order_blocks[rel='"+rel+"']").fadeIn(200)
    });

    $(".inpOrderText").keyup(function(){
        $(this).parent().removeClass("_error");
    });

    $(document).on("click",".ordering_caption_item.active.apply",function(){
        var rel=$(this).attr("rel");
        var itm=$(".ordering_caption_item[rel='"+rel+"']");
        itm.removeClass("apply");
        itm.nextAll().removeClass("apply active");
        $(".order_block").hide();
        $(".order_block[rel='"+rel+"']").fadeIn(200)


        console.log(rel);
    });

    $("#order_next1").click(function(){
        var rel=$(".ordering_type.active").attr("rel");
        var flag=true;
        $("#order_email").val($("#order_email").val().replace(/\s/ig, ''));

        if($.trim($("#order_name").val())==""){
            $("#order_name").parent().addClass("_error");
            flag=false;
        }
        if($.trim($("#order_phone").val())==""){
            $("#order_phone").parent().addClass("_error");
            flag=false;
        }
        if($(".ordering_type.active").attr("rel")==2){
            if(!validateEmail($("#order_email").val())){
                $("#order_email").parent().addClass("_error");
                flag=false;
            }
        }else{
            if($.trim($("#order_email").val())!=""){
                if(!validateEmail($("#order_email").val())){
                    $("#order_email").parent().addClass("_error");
                    flag=false;
                }
            }
        }
        

        if(rel==2){
            if($.trim($("#order_inn").val())==""){
                $("#order_inn").parent().addClass("_error");
                flag=false;
            }
        }
        
        $("#order_address").focus();
    
        if(flag){
            $(".order_block[rel='1']").hide();
            $(".order_block[rel='2']").fadeIn(200);
            $(".ordering_caption_item[rel='1']").addClass("apply");
            $(".ordering_caption_item[rel='2']").addClass("active");
            if($(window).width()<750){
                var tp=$(".ordering").position().top+40
                $("html,body").animate({"scrollTop":tp});
            }
        }
    });

    $("#order_next2").click(function(){
        var rel=$(".delivery_order_block.active").attr("rel");
        var flag=true;
        $("#send_order_button").focus();
        if(rel==2){
            if($.trim($("#order_address").val())==""){
                $("#order_address").parent().addClass("_error");
                flag=false;
            }
        }
        if(flag){
            $(".order_block[rel='2']").hide();
            $(".order_block[rel='3']").fadeIn(200);
            $(".ordering_caption_item[rel='2']").addClass("apply");
            $(".ordering_caption_item[rel='3']").addClass("active");
            if($(window).width()<750){
                var tp=$(".ordering").position().top+40
                $("html,body").animate({"scrollTop":tp});
            }
        }
        //ordering_caption_item_numval

    });

    /*Блокировка формы перед отправкой */
    $("#send_order_button").click(function(e){
        e.preventDefault();        
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'order-send');
        }
        $(this).closest("form").submit();
    });

    $("#button_prev1").click(function(){
        $(".order_block[rel='2']").hide();
        $(".order_block[rel='1']").fadeIn(200);
        $(".ordering_caption_item[rel='1']").removeClass("apply");
        $(".ordering_caption_item[rel='2']").removeClass("active");
    });
    $("#button_prev2").click(function(){
        $(".order_block[rel='3']").hide();
        $(".order_block[rel='2']").fadeIn(200);
        $(".ordering_caption_item[rel='2']").removeClass("apply");
        $(".ordering_caption_item[rel='3']").removeClass("active");
    });
    $(document).on("click",".similar_block_caption",function(){
        var itm=$(this).parent();
        itm.toggleClass("active");
        //itm.find(".wrapper_similar_slider").slideToggle(200);
    });
    $(".cart_similar_block_products").slick({
        infinite: true,
        slidesToShow: 3,
        slidesToScroll: 1,
        swipeToSlide:true,
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
    
    /*
    if($(".cart_similar_block_products").length){
        $(".cart_similar_block_products").each(function(){
            $(this).slick({
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
        });
    }
    */
    /*
    $('.your-element').on('beforeChange', function(event, slick, currentSlide, nextSlide){
        console.log(nextSlide);
      });
    /*
    $(".cart_similar_block_products").slick({
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
    */

});