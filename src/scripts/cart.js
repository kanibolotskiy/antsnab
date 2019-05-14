import {Quantity} from './lib/quantity.es6.js';

if( $('.qnt-container-cart').length > 0) {
    $('.qnt-container-cart').each(function(index){
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
            'ui_minimum':$el.attr('data-ui_minimum')
        });

        var qntController = $el.data('quantity');
        qntController.setQuantityInUiUnits($priceUnitQuantity);
        $el.removeClass("without_input");

    });
}
function getDelivery(){
    var koef=$("#priceSwitcher .active").attr("data-sale_to_ui_koef")*1;
    var base_weight=$("#priceSwitcher").attr("data-base_weight")*1;
    var product_id=$("#product_id").val();
    //console.log(koef);
    if(!koef){
        koef=1;
    }
    var base_count=$("#product_count_add").val()/koef;
    var weight=base_count*base_weight;

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
        $("#total_cart").text(total);
        $(".basket").html(json['total_str']);

        $("#total_cart").animate({"opacity":1},100);
        
        var products=json["products"];
        if(products.length){
            $("#empty_cart_block").hide();
            $("#full_cart_block").show();
            for(var i=0;i<products.length;i++){
                var itm=$("input[name='quantity["+products[i].cart_id+"]']").closest("ul");
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
    console.log("total");
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
    var row_count=itm.find(".qnt").val()*1;
    var itm_widget=itm.find(".qnt-widget");
    var opt_limit=itm_widget.attr("data-sale_to_price_koef")*itm_widget.attr("data-wholesale_threshold");
    
    if((row_count>=opt_limit*80/100) && (row_count<opt_limit)){
        itm.find(".opt_limit_notification_value").html(opt_limit-row_count);
        //itm.find(".opt_limit-row_count").html();
        itm.find(".opt_limit_notification").fadeIn(200);
    }else{
        itm.find(".opt_limit_notification").fadeOut(200);
    }
}
$(function(){
    $(".basket-row").each(function(){
        check_opt_notification($(this));
    });
    getDelivery();
    $(document).on("click",".actionbutton.del",function(){
        var key=$(this).attr("data-cartid");
        var data="key="+key;
        var cart_row=$(this).closest(".basket-row");
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
                cart_row.fadeOut(200,function(){
                    cart_row.remove();
                })
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
        
        if($.trim(input_phone.val())==""){
            flag_order=false; 
            input_phone.prev().fadeIn(100);

        }else{
            input_phone.prev().fadeOut(100);            
        }
        /*
        if(($.trim(input_phone.val())!="")||($.trim(input_email.val())!="")){
            input_phone.prev().fadeOut(100);
            if($.trim(input_email.val())!=""){
                if(!pattern.test($.trim(input_email.val()))){
                    flag_order=false; 
                    input_email.prev().fadeIn(100);
                }else{
                    input_email.prev().fadeOut(100);
                }
            }else{
                input_email.prev().fadeOut(100);
            }
        }else{
            flag_order=false; 
            input_phone.prev().fadeIn(100);
        }
        */
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
    
    $("input[name='need_shipping']").change(function(){
        if($(this).prop("checked")){
            $(".delivery_row").stop().slideDown(150);
        }else{
            $(".delivery_row").stop().slideUp(150);
        }
    });
});