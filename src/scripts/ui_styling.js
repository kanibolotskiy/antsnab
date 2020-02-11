/** @task resolve throug webpack */
import './lib/nice-select';
//import Inputmask from "inputmask/dist/inputmask/inputmask.phone.extensions";
import Inputmask from "./lib/jquery.inputmask.bundle.min.js";

//import Inputmask from "./lib/jquery.fancybox.min.js";
//var $ = require('jquery');
import './lib/jquery.fancybox.min';
import './lib/jquery.autocomplete.min';

function check_left_position(){
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
}
function check_scroll(){
    var st=$(window).scrollTop();
    var wd=window.innerWidth;
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
        /*
        if(st>limit_leftmenu){
            $(".catalog-product").addClass("_fixed");
            //console.log("scroll="+st);
            check_left_position();

        }else{
            $(".catalog-product").removeClass("_fixed");
        }
        */
        
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
$(window).resize(function(){
    check_resize();
});
$(document).ready(function(){
    check_resize();
    check_scroll();

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

    $('input[name="phone"]').inputmask("+7 9999999999",{ 
        "clearIncomplete": true,
        "alias": 'numeric', 
        "allowMinus": false
    });
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
});