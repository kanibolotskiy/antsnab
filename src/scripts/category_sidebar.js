import './lib/jquery.accordion';

function mobileMenuPreconfig() {
    var bottomMargin = 25,
        mostHeight = 280,
        maxHeight = $(window).height() - $('.catalog-product_mobile .catalog-btn').height() - bottomMargin;
    maxHeight = ( maxHeight <= mostHeight )? maxHeight: mostHeight;
    $('.catalog-product_mobile .accordion').css('max-height', maxHeight);
}
function toggleMenu($accordion) {
    $accordion.slideToggle();
}
function menuHandler(e){
    e.stopPropagation();
    var $button = $(this),
        $accordion = $button.next('.accordion'),
        $container = $button.parents('.catalog-product');

    if( $container.hasClass("catalog-product_mobile") ){
        mobileMenuPreconfig();
    }

    toggleMenu($accordion);
}

$(".catalog-btn").on('click', menuHandler);
/*$('body').on('click', function(e) {
    var $button=$('.catalog-product_mobile .catalog-btn');
    if( $button.next('.accordion').css('display') == 'block') {
        menuHandler.call($button[0], e);
    }
});*/
$('.catalog-product .accordion').on('click', function(e){ e.stopPropagation(); });
$(window).on('resize', mobileMenuPreconfig);

/*
$(".catalog-btn").click(function () {
    $(".accordion").slideToggle("slow");
});*/