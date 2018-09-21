/* Навигация */
$('.btn-nav').click(function (eventObject) {
    $(this).toggleClass('btn-nav2');
    $(".nav").toggleClass("nav2");
    eventObject.preventDefault();
});

/* Активный пункт нельзя нажать */
$(".nav a.active").click(function (e) {
    e.preventDefault();
});