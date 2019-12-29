/** @task resolve throug webpack */
import './lib/nice-select';
//import Inputmask from "inputmask/dist/inputmask/inputmask.phone.extensions";
import Inputmask from "./lib/jquery.inputmask.bundle.min.js";

//import Inputmask from "./lib/jquery.fancybox.min.js";
//var $ = require('jquery');
import './lib/jquery.fancybox.min';
import './lib/jquery.autocomplete.min';

function check_scroll(){
    var st=$(window).scrollTop();
    var wd=window.innerWidth;
    var limit=40;
    var limit2=98;
    if ($("body").hasClass("checkout-cart")){
        limit=0
        limit2=0;
    }
    if(wd>1100){
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
    //if ($("body").hasClass("checkout-cart")){
    //    $("body").addClass("_hfixed").addClass("_hmenu");
    //}

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