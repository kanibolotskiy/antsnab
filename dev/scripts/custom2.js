$(function(){
    /*added kanibolotskiy*/
    $(".article").find("table").each(function(){
        $(this).wrap('<div class="table-responsive"></div>')
    });
    $(".nav a.active").click(function(e){
        e.preventDefault();
    });
    $('#demoTab').easyResponsiveTabs({ tabidentify: 'vert' });
    /*-------------------*/
    //var topPos = $('.catalog-product2').offset().top; //topPos - это значение от верха блока до окна браузера
    var topPos = $('.catalog-product2').position().top;

    $(window).scroll(function() {
        var top = $(document).scrollTop();
        if (top > topPos) {
            $('.catalog-product2').addClass('fixed');
            var height_block=$('.catalog-product2').outerHeight();
            $('#empty_block_catalog_helper').css({"height":height_block});
        }
        else {
            $('.catalog-product2').removeClass('fixed');
            $('#empty_block_catalog_helper').css({"height":0});
        }
    });
});

