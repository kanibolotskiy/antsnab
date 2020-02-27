import './lib/easyResponsiveTabs';

function totop(){
    var tp=$(".resp-accordion.vert.resp-tab-active").offset().top;
    $("html,body").animate({"scrollTop":tp-68},300);
}
/* Адаптивные табы в карточке продукта */
$('#demoTab').easyResponsiveTabs(
    {
        tabidentify: 'vert',
        active_border_color: '#fff',
        active_content_border_color: '#fff',
        inactive_bg: "#EFEEEC",
        /*
        activate: function() {
            setTimeout(totop, 300);
        }
        */
    }
);
if($(document).width()<750){
    $(".resp-accordion.vert.resp-tab-active").each(function(){
        $(this).removeClass("resp-tab-active");
        $(this).css({"background-color":"rgb(239, 238, 236)","border-color":"rgb(255, 255, 255)"});
    })
    $(".resp-tab-content.vert.resp-tab-content-active").each(function(){
        $(this).removeClass("resp-tab-content-active");
        $(this).css({"display":"none"});
    });
}
/* Адаптивные таблицы в статьях */
$(".article").find("table").each(function () {
    $(this).wrap('<div class="table-responsive"></div>');
});
$(".application").find("table").each(function () {
    $(this).wrap('<div class="table-responsive"></div>');
});

$(".content-text table").each(function () {
    $(this).wrap('<div class="table-responsive"></div>');
});


