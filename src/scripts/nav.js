/* Навигация */
$('.btn-nav').click(function (eventObject) {
    $(this).toggleClass('btn-nav2');
    $(".nav").toggleClass("nav2");
    eventObject.preventDefault();
});

/* Скролл навигации */
var topPos = $('.catalog-product2').position().top;

$(window).scroll(function () {
    var top = $(document).scrollTop();
    if (top > topPos) {
        $('.catalog-product2').addClass('fixed');
        var height_block = $('.catalog-product2').outerHeight();
        $('#empty_block_catalog_helper').css({"height": height_block});
    } else {
        $('.catalog-product2').removeClass('fixed');
        $('#empty_block_catalog_helper').css({"height": 0});
    }
});

/* Активный пункт нельзя нажать */
$(".nav a.active").click(function (e) {
    e.preventDefault();
});