$(".btn-request-call").click(function(){
    $(".popup").css("display", "block");
});

$(".close").click(function(){
    $(".popup").css("display", "none");
});

$(".close2").click(function(){
    $(".popup").css("display", "none");
});


$(".stock1").click(function(){
    $(".popup2").css("display", "block");
    $("html").css("overflow", "hidden");
    $("html").css("margin-right", "17px");
});

$(".close3").click(function(){
    $(".popup2").css("display", "none");
    $("html").css("overflow", "inherit");
    $("html").css("margin-right", "0");
});

$(".close4").click(function(){
    $(".popup2").css("display", "none");
    $("html").css("overflow", "inherit");
    $("html").css("margin-right", "0");
});

$(".stock2").click(function(){
    $(".popup3").css("display", "block");
    $("html").css("overflow", "hidden");
    $("html").css("margin-right", "17px");
});

$(".close5").click(function(){
    $(".popup3").css("display", "none");
    $("html").css("overflow", "inherit");
    $("html").css("margin-right", "0");
});

$(".close6").click(function(){
    $(".popup3").css("display", "none");
    $("html").css("overflow", "inherit");
    $("html").css("margin-right", "0");
});

$(function() {
    $.fn.scrolltotop = function() {
        $(this).hide().removeattr("href");
        if ($(window).scrolltop() >= "250") $(this).fadein("slow")
        var scrolldiv = $(this);
        $(window).scroll(function() {
            if ($(window).scrolltop() <= "250") $(scrolldiv).fadeout("slow")
            else $(scrollDiv).fadeIn("slow")
        });
        $(this).click(function() {
            $("html, body").animate({scrollTop: 0}, "slow")
        })
    }
});

$(function() {
    $(".up").scrollToTop();
});



$('.btn-nav').click(function(eventObject){
    $(this).toggleClass('btn-nav2');
    $(".nav").toggleClass("nav2");
    eventObject.preventDefault();
});

