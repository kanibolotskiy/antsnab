/**Попапы*/
$(".btn-request-call").click(function () {
    $(".popup").css("display", "block");
});

$(".js-call").click(function (e) {
    e.preventDefault();
    //$(".popup").css("display", "block");
    $(".popup").fadeIn(200);
});

$(".js_modal").click(function(e){
    e.preventDefault();
    var modal=$(this).attr("data-modal");
    $(".wrp_modal_body").show();
    $(".wrp_modal_thsnk").hide();

    $("."+modal).fadeIn(200);
});
$(".modal_close,.modal_overlay").click(function(){
    $(".modal").fadeOut(200);
});

$(".bene_item").click(function(){
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

