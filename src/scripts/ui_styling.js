/** @task resolve throug webpack */
import './lib/nice-select';
//import Inputmask from "inputmask/dist/inputmask/inputmask.phone.extensions";
import Inputmask from "./lib/jquery.inputmask.bundle.min.js";

//import Inputmask from "./lib/jquery.fancybox.min.js";
//var $ = require('jquery');
import './lib/jquery.fancybox.min';
import './lib/jquery.autocomplete.min';

function check_left_position(){
    /*
    var st=$(window).scrollTop();
    var pnt1=$(document).height()-$("footer").innerHeight();
    var added_height=0;
    if($(".catalog-product").hasClass("_filter")){
        added_height=$(".wrapper_param_list").height()*1+190;
        //added_height=$(".wrapper_param_list").height()*1;
    }else{
        added_height=$(".accordion").height()*1+190;
    }

    var pnt2=(st+added_height);
    //console.log($(window).height())
    //console.log(pnt1+"="+pnt2)
    var lmt=pnt1-pnt2;
    if(lmt<0){
        $(".catalog-product").css({"marginTop":lmt})
    }else{
        $(".catalog-product").css({"marginTop":0})
    }
    */
}
function check_scroll(){
    //if($(".wrapper_parameters").length){
    //    $(".wrapper_parameters").css({"left":$(".catalog-product").offset().left})
    //}
    var st=$(window).scrollTop();
    var wd=window.innerWidth;
    var wh=window.innerHeight;
    var pnt1=$(document).height()-$("footer").innerHeight();
    var added_height=0;

    var limit=40;
    var limit2=98;
    var limit_leftmenu=200;
    var limit_bottom=$(document).height()-$(window).height();

    if ($("body").hasClass("checkout-cart")){
        limit=0
        limit2=0;
    }
    if(wd>1100){
        /**Sidebar */
        //$(".catalog-product").addClass("_fixed");
        if($(".container.main").hasClass("withparams")){
            //,"height":wh-$(".wrapper_parameters").offset().top+st
            if($(".sidebar_filter_caption").hasClass("active")){
                
                added_height=$(window).height();
            }else{
                added_height=$(".accordion").height()*1+190;
            }
            var pnt2=(st+added_height);

            var append_height=0;
            if(!$(".sidebar_filter_caption").hasClass("active")){
                append_height=65;
            }
            
            var lmt=pnt1-pnt2-append_height;
            //console.log(st);
            if(st>limit_leftmenu){
                //console.log("ok1");
                var ht=wh-165-50;
                
                $(".catalog-product").addClass("_fixed");
                if(lmt<0){
                    
                    $(".wrapper_parameters").css({"margin-top":lmt-202});
                    $(".filter_reset").css({"margin-bottom":-lmt});
                    $(".catalog-product").css({"margin-top":lmt})
                }else{
                    $(".wrapper_parameters").css({"margin-top":-202,"height":ht})
                    
                    $(".wrapper_left_data").css({"height":(ht-15)})
                    $(".catalog-product").css({"margin-top":0})
                    $(".filter_reset").css({"margin-bottom":0});
                }
                
            }else{
                $(".catalog-product").css({"margin-top":0})
                var ht=wh+st-367-50;
                //var ht=wh+st-417;
                $(".wrapper_parameters").css({"margin-top":-st,"height":ht})
                $(".wrapper_left_data").css({"height":(ht-15)})
                $(".filter_reset").css({"margin-bottom":0});
                //$(".catalog-product,.sidebar_filter_caption").removeClass("_fixed");
                $(".catalog-product").removeClass("_fixed");
                
            }
        }
        
        
        /**Меню */
        if(st>limit){
            $("body").addClass("_hfixed");
            if(st>limit2){
                $("body").addClass("_hmenu");
            }else{
                if(!$("body").hasClass("checkout-cart")){
                    $("body").removeClass("_hmenu").removeClass("_openmenu");
                }
            }
        }else{
            if(!$("body").hasClass("checkout-cart")){
                $("body").removeClass("_hfixed").removeClass("_hmenu").removeClass("_openmenu");
            }
        }
    }else{
        if(st>0){
            $("body").addClass("_hfixed");
        }else{
            if(!$("body").hasClass("checkout-cart")){
                $("body").removeClass("_hfixed");
            }
        }
    }
}
function check_resize(){
    var wd=window.innerWidth;
    if($(".wrapper_parameters").length){
        $(".wrapper_parameters").css({"left":$(".catalog-product").offset().left})
    }
    if(wd<=1100){
        $("body").addClass("_hmenu");
    }else{
        if(!$("body").hasClass("checkout-cart")){
            $("body").removeClass("_hmenu");
        }
    }
}
$(window).scroll(function(){
    check_scroll();
});
$(window).resize(function() {
    check_resize();
    check_scroll();
});
$(document).ready(function(){
    var scrollWidth = window.innerWidth - document.documentElement.clientWidth;
    if (scrollWidth > 1) {
    $('<style type="text/css">')
      .html('.is-compensate-for-scrollbar._hfixed .wrp_header{padding-right:' + scrollWidth + 'px;}.is-compensate-for-scrollbar { padding-right: ' + scrollWidth + 'px; }')
      .appendTo('head');
    }
    $(document).keyup(function(e) {
        if (e.key === "Escape") { // escape key maps to keycode `27`
            $(".modal").fadeOut(200);
            //$("html").css({"overflow":"inherit","margin-right":"0"});
            //$(".wrp_header").css({"padding-right":0});
            $("body").removeClass("_openmenu").removeClass("_lmenu"); 
            $(".catalog-product").removeClass("active");

       }
    });

    check_resize();
    check_scroll();
    $(".wrp_sidebar_filter_caption").click(function(){
        if($(".sidebar_filter_caption").hasClass("active")){
            $(".sidebar_filter_caption").removeClass("active");
            $(".filter_reset").removeClass("active");
            $(".catalog-product").removeClass("_filter");
            $(".wrapper_parameters").animate({"margin-left":320,"opacity":0},200);
        }else{
            $(".sidebar_filter_caption").addClass("active");
            $(".filter_reset").addClass("active");
            $(".catalog-product").addClass("_filter");
            $(".wrapper_parameters").animate({"margin-left":0,"opacity":1},200);
        }
        check_scroll();
    });
    /*
    $(".sidebar_filter_close").click(function(){
        
    });
    */

    $(".catalog_arrow").click(function(){
        var itm=$(this).closest("li");
        if(itm.hasClass("_active")){
            itm.find(".slide").slideUp(200,function(){
                check_left_position();
            });
            itm.removeClass("_active");
        }else{
            $(".simple-accordion li").removeClass("_active");
            $(".sidebar .slide").slideUp(200);
            itm.find(".slide").slideDown(200,function(){
                check_left_position();
            });
            itm.addClass("_active");
        }
    });
    $("#contact_slider").slick({
        appendArrows:$(".contact_slider_arrows"),
        dots: false,
        arrows:true,
        infinite: false,
        speed: 300,
        slidesToShow: 4,
        slidesToScroll: 1,
        responsive: [
          {
            breakpoint: 1024,
            settings: {
              slidesToShow: 3,
              slidesToScroll: 1,
            }
          },
          {
            breakpoint: 600,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 1
            }
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1
            }
          }
          // You can unslick at a given breakpoint now by adding:
          // settings: "unslick"
          // instead of a settings object
        ]
    });

    $('input[name="inn"]').inputmask("9999999999[99]",{
        "clearIncomplete": true,
    });
    $('input[name="phone"]').inputmask("+7 (999) 999-99-99",{ 
        "clearIncomplete": true,
        "alias": 'numeric', 
        "allowMinus": false
    });

    /*
    $('input[name="phone"]').inputmask("+7 9999999999",{ 
        "clearIncomplete": true,
        "alias": 'numeric', 
        "allowMinus": false
    });
    */
    $('select').niceSelect();
    
    
    $(".mob_menu_block").click(function(){
        $("body").toggleClass("_openmenu");
    });
    $(document).click(function(event) {
        if ($(event.target).closest(".container-nav").length) return;
        if ($(event.target).closest(".mob_menu").length) return;
        
        $("body").removeClass("_openmenu");
        event.stopPropagation();
    });
    $(".container-nav_close").click(function(){
        $("body").removeClass("_openmenu"); 
    });
    $("#category_banners").slick({
        speed: 500,
        autoplay:true,
        autoplaySpeed:4000,
        fade: false,
        //cssEase: 'linear'

    });
    $(".ment_slider").each(function(){
        $(this).slick({
            //centerPadding: '60px',
            infinite: true,
            autoplay: true,
            autoplaySpeed: 3000,
            arrows: true,
            slidesToShow: 4,
            responsive: [
                {
                breakpoint: 768,
                settings: {
                    slidesToShow: 3
                }
                },
                {
                breakpoint: 650,
                settings: {
                    slidesToShow: 2
                }
                },
                {
                breakpoint: 375,
                settings: {
                    slidesToShow: 1
                }
                }
            ]
        });
    });
    $(".mentioned_products_caption").click(function(){
        $(".mentioned_products_caption").removeClass("active");
        $(this).addClass("active");
        var rel=$(this).attr("rel");
        $(".mentioned_slider").removeClass("active");
        $(".mentioned_slider[rel='"+rel+"']").addClass("active");
    });


    $(".favorite").on("mouseenter",function(){
        $(this).addClass("_hover");
    });
    $(".favorite").on("mouseleave",function(){
        $(this).removeClass("_hover");
    });

    $(".compare").on("mouseenter",function(){
        $(this).addClass("_hover");
    });
    $(".compare").on("mouseleave",function(){
        $(this).removeClass("_hover");
    });

});