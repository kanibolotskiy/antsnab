$(document).ready(function(){
    $(".row_checks").each(function(){
        if($(this).height()>175){
            $(this).closest(".param_row").find(".show_more_params").show();
        }
    });
    $(".show_more_params span").click(function(){
        if($(this).hasClass("active")){            
            $(this).css({"opacity":0});
            $(this).html("Показать еще");
            $(this).animate({"opacity":1},300);
            $(this).removeClass("active");
            $(this).closest(".param_row").find(".row_checks_wrap").removeClass("active");
            
        }else{
            $(this).css({"opacity":0});
            $(this).html("Скрыть");
            $(this).animate({"opacity":1},300);
            $(this).addClass("active");
            $(this).closest(".param_row").find(".row_checks_wrap").addClass("active");
        }
    });

    $(".catalog_opens").click(function(){
        $(".catalog-product .accordion").slideToggle(200);
    });

    $(".table_catalog").click(function(){
        $(this).toggleClass("active");
        
        $(".catalog-product").toggleClass("active");
        $("body").toggleClass("_lmenu");
    });
    $(".catalog_hide").click(function(){
        $(".catalog-product").removeClass("active");
        $(".table_catalog").removeClass("active");
        $("body").removeClass("_lmenu");
    });

    $(document).on("focusin",".ya-site-form__input-text",function(){
        $("#search").addClass("active");
    });
    $(document).on("focusout",".ya-site-form__input-text",function(){
        $("#search").removeClass("active");
    })
})