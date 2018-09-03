/**Попапы*/
$(".btn-request-call").click(function () {
    $(".popup").css("display", "block");
});

$(".close, .close2").click(function () {
    $(".popup").css("display", "none");
});


$(".stock1").click(function () {
    $(".popup2").css("display", "block");
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