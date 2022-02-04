var scrollWidth;
function scrollbarWidth() {
    var documentWidth = parseInt(document.documentElement.clientWidth);
    var windowsWidth = parseInt(window.innerWidth);
    scrollWidth = windowsWidth - documentWidth;
    return scrollbarWidth;
  }
function declOfNum(number, titles){
    var cases = [2, 0, 1, 1, 1, 2];
    return titles[ (number%100>4 && number%100<20)? 2 : cases[(number%10<5)?number%10:5] ];
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
function check_scroll(){
    var st=$(window).scrollTop();
    if(st>0){
        $(".header_shadow").addClass("active");
    }else{
        $(".header_shadow").removeClass("active");
    }
}
function courier_select(max_weight){
    var weight=$("#priceSwitcher").attr("data-base_weight");
    var unitpack1=$(".unitpack1");
    var unitpack2=$(".unitpack2");

    
    var unitpack1_count=Math.floor(max_weight*unitpack1.attr("data-sale_to_ui_koef")/weight);
    
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
}
$(window).scroll(function(){
    check_scroll();
});
$(document).ready(function(){
    scrollbarWidth();
    check_scroll();
    $("header").click(function(e){
        if ($(".header_info").has(e.target).length !== 0 ) return
        if ($(".wrp_mob_menu").has(e.target).length !== 0 ) return
        $("html,body").animate({"scrollTop":0},600);
    });

    
    $(".properties_more").click(function(){
        if($(this).hasClass("active")){
            $(this).html("Посмотреть технические характеристики");
            $(this).removeClass("active");
            $(".wrapp_props_table").fadeOut(200);
        }else{
            $(this).html("Скрыть технические характеристики");
            $(this).addClass("active");
            $(".wrapp_props_table").fadeIn(200);
        }
        
    });

    if($("#courier_select").length){
        courier_select($("#courier_select").val())
    }

    $("#courier_select").on('change', function () {
        courier_select($(this).val());
    });


    $(".properties_caption").click(function(){
        if($(window).width()<750){
            var block=$(this).closest(".wrap_prop_block");
            if(block.hasClass("active")){
                block.removeClass("active")
                block.find(".prop_block").fadeOut(150);
            }else{
                block.addClass("active")
                block.find(".prop_block").fadeIn(200);
            }
        }        
    });
    $(".application h2").click(function(){
        if($(window).width()<750){
            if($(this).hasClass("active")){
                $(this).removeClass("active");
                var flag=true;
                $(this).nextAll().each(function(){
                    if($(this).prop('nodeName')!="P"){
                        flag=false
                    }
                    if(flag){
                        $(this).fadeOut(150)
                    }
                });

            }else{
                $(this).addClass("active");
                var flag=true;
                $(this).nextAll().each(function(){
                    if($(this).prop('nodeName')!="P"){
                        flag=false
                    }
                    if(flag){
                        $(this).fadeIn(200)
                    }
                });
                /*
                $(this).nextAll("p").each(function(){
                    $(this).fadeIn(200)
                });
                */
            }
        }
    });

    $("#form_more").click(function(){
        $(".form_row._hidden").fadeIn(200);
    });
    $(".header_call").click(function(){
        var st=$("#bottom_form").offset().top
        $("html,body").animate({"scrollTop":st},700);
    });
    $(".mob_menu_ordercall").click(function(){
        var st=$("#bottom_form").offset().top
        $(".wrp_mob_menu").removeClass("active");
        $("html,body").animate({"scrollTop":st},700);
    });
    

    $(".mob_menu").click(function(){
        $(".wrp_mob_menu").addClass("active");
    });
    $(".mob_menu_close").click(function(){
        $(".wrp_mob_menu").removeClass("active");
    });

    $(".change_itm").click(function(){
        var product_id=$(this).data("id");
        var landing_id=$("#landing_id").data("id");
        var itm=$(this).closest(".product_itm");
        $(this).parent().find(".change_itm").removeClass("active");
        $(this).addClass("active");

        var data = {
            landing_id: landing_id,
            product_id: product_id
        }

//{"landing_id":landing_id,"product_id":product_id}
        $.ajax({
            url: '/index.php?route=landing/landing/changeProduct/',
            data: data,
            type: 'POST',
            dataType: 'json',
            success: function(json) {               
                itm.find(".product_price").html(json['price']);

                var itm_name=itm.find(".product_title a");
                itm_name.attr("href",json['alias']);
                itm_name.css({"opacity":0});
                itm_name.html(json['name']);
                itm_name.animate({"opacity":1},150);

                var itm_img=itm.find(".product_img");
                itm_img.find("a").attr("href",json['alias']);
                itm_img.css({"opacity":0});
                itm_img.find("img").attr("src",json['thumb']);
                itm_img.animate({"opacity":1},150);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    $("select").niceSelect();
    
    $(".inputForm").keyup(function(){
        $(this).removeClass("error")
    });
    $(".sendForm").click(function(){
        var form_item = $(this).closest("form");
        var form_thanks = form_item.closest(".wrap_form").find(".form_thanks");

        var flag=true
        form_item.find(".required").each(function(){
            if($.trim($(this).val())==""){
                $(this).addClass("error");
                flag=false;
            }
        });

        if(flag){
            var form = form_item.closest('form')[0];
            var data = new FormData(form);
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: '/index.php?route=landing/landing/sendForm/',
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                dataType: "json",
                timeout: 800000,
                success: function (data) {
                    form_item.hide();
                    form_thanks.fadeIn(200);
                    
                    form_item.find(".inputForm").val("");

                    setTimeout(function(){
                        form_thanks.hide();
                        form_item.fadeIn(200);
                    }, 3000);


                    /*
                    console.log("SUCCESS : ", data);
                    $("#btnSubmit").prop("disabled", false);
                    */
                },
                error: function (e) {                
                    console.log("ERROR : ", e);
                }
            });
        }
    });
    $(".fancybox").fancybox({
        beforeShow: function(){
            $("header").css({"right":scrollWidth})
        },
        afterClose:function(){
            $("header").css({"right":0})
        },
    })

    function changeMask(countryCode){
        var mask="+7 (999) 999-99-99";
        switch (countryCode){
            case "ru":
                var mask="+7 (999) 999-99-99";
            break;
            case "by":
                var mask="+375 (999) 999-99-99"
            break;
            case "kz":
                var mask="+7 (999) 999-99-99"
            break;
            case "am":
                var mask="+374 (999) 999-99-99"
            break;
            case "kg":
                var mask="+996 (999) 999-99-99";
            break;
            case "ua":
                var mask="+38 (999) 999-99-99";
            break;
            default:
                var mask="+7 (999) 999-99-99";

            
        }
        $("input[name='phone']").each(function(){
            $(this).attr("placeholder",mask);
            $(this).inputmask({
                "mask": mask,
                "clearIncomplete": true
            });
        })
    }

    $("input[name='phone']").on("countrychange", function(e) {
        //console.log($(this).intlTelInput("getSelectedCountryData").iso2)
        changeMask($(this).intlTelInput("getSelectedCountryData").iso2);
        //changeMask(countryCode);
    })
    
    $("input[name='phone']").each(function(){
        $(this).intlTelInput({
            preferredCountries: ["ru", "by", "kz", "am", "kg"], //,"ua"
            //autoPlaceholder: true,
            utilsScript:'catalog/view/theme/landing/js/utils.js',
            initialCountry: "auto",
            //separateDialCode:true,
            geoIpLookup: function(success, failure) {
                $.get("https://ipinfo.io", function() {}, "jsonp").always(function(resp) {
                var countryCode = (resp && resp.country) ? resp.country : "ru";
                success(countryCode);
                });
            },
        })
    });
    $(".sendForm").click(function(e){
        e.preventDefault();

    });
    
});
