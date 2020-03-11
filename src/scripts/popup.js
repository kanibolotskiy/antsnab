function scrollbarWidth() {
    var documentWidth = parseInt(document.documentElement.clientWidth);
    var windowsWidth = parseInt(window.innerWidth);
    var scrollbarWidth = windowsWidth - documentWidth;
    return scrollbarWidth;
  }
$(document).ready(function(){

    $("#call_submit").click(function(){
        var data=$("#call_form").serialize();
        $.ajax({
            url:  '/index.php?route=extension/module/callform',
            type: 'post',
            data: data,
            dataType: 'json',
            beforeSend: function() {
                $('#ajax_loader_call').fadeIn(200);
            },
            complete: function() {
                $('#ajax_loader_call').fadeOut(200);
            },
            success: function(json) {
                if(json['success']){
                    $(".modal").hide();
                    $(".modal_thanks").fadeIn(200);
                }else{
                    for(var err in json["errors"]){
                        $("#call_form .error."+err).html(json["errors"][err]);
                    }
                }
                
            }
        })
    });

    $("#feedback_submit").click(function(){
        var data=$("#feedbackform").serialize();
        $.ajax({
            url:  '/index.php?route=extension/module/feedback',
            type: 'post',
            data: data,
            dataType: 'json',
            beforeSend: function() {
                $('#ajax_loader_feedback').fadeIn(200);
            },
            complete: function() {
                $('#ajax_loader_feedback').fadeOut(200);
            },
            success: function(json) {
                if(json['success']){
                    $(".modal_thanks").fadeIn(200);
                    $("#feedbackform")[0].reset();
                }else{
                    for(var err in json["errors"]){
                        $("#feedbackform .error."+err).html(json["errors"][err]);
                    }
                }
                
            }
        })
    });


    /**Попапы*/
    $(".btn-request-call").click(function () {
        $(".popup").css("display", "block");
    });

    $(".js-call").click(function (e) {
        e.preventDefault();
        $(".popup.popup_call").fadeIn(200);
    });

    $(".js_modal").click(function(e){
        e.preventDefault();
        var modal=$(this).attr("data-modal");
        $(".wrp_modal_body").show();
        $(".wrp_modal_thsnk").hide();

        var sw=scrollbarWidth();
        $("html").css("overflow", "hidden");
        $("html").css("margin-right", sw+"px");
        $("body._hfixed .wrp_header").css({"padding-right":sw+"px"});
        $("."+modal).fadeIn(200);
    });

    $(document).on("click",".modal_close,.modal_overlay,._modal_close",function(){
        $(".modal").fadeOut(200);
        $("html").css({"overflow":"inherit","margin-right":"0"});
        $(".wrp_header").css({"padding-right":0});
    });

/*   
    $(document).on("keypress",function(e){
        console.log("ok")
        if(e.which == 27){
            $(".modal").fadeOut(200);
            $("html").css({"overflow":"inherit","margin-right":"0"});
            $(".wrp_header").css({"padding-right":0});
        }
    });
*/
    $(".bene_item").click(function(){
        var sw=scrollbarWidth();
        $("html").css("overflow", "hidden");
        $("html").css("margin-right", sw+"px");

        var bene_cap=$(this).find(".bene_item_val").html();
        var bene_text=$(this).find(".bene_item_desc").html();
        $("#caption_benefit").html(bene_cap);
        $("#text_benefit").html(bene_text);
        $(".modal_benefits").fadeIn(200);
    });


    $(".close, .close2").click(function () {

        //$(".popup").css("display", "none");
        $(".modal").fadeOut(200);
        $(".popup").fadeOut(200);
    });


    $(".stock1").click(function () {
        //$(".popup2").css("display", "block");
        $(".popup2").show();
        $("html").css("overflow", "hidden");
        $("html").css("margin-right", "17px");
        
    });

    $(".close3, .close4").click(function () {
        $(".popup2").css("display", "none");
        $("html").css("overflow", "inherit");
        $("html").css("margin-right", "0");
    });

    $(".stock2").click(function () {
        $(".popup3").css("display", "block");
        $("html").css("overflow", "hidden");
        $("html").css("margin-right", "17px");
    });

    $(".close5, .close6").click(function () {
        $(".popup3").css("display", "none");
        $("html").css("overflow", "inherit");
        $("html").css("margin-right", "0");
    });
});


