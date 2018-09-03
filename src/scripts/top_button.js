/* Кнопка наверх*/
$.fn.scrollToTop = function () {
    var $scrolldiv = $(this);
    $(window).scroll(function () {
        if ($(window).scrollTop() <= "250")
            $scrolldiv.fadeOut("slow");
        else
            $scrolldiv.fadeIn("slow");
    });

    $scrolldiv.hide().removeAttr("href");
    $scrolldiv.click(function () {
        $("html, body").animate({scrollTop: 0}, "slow");
    });

};
$(".up").scrollToTop();

