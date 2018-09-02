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

/* Кнопка наверх*/
$.fn.scrollToTop = function () {
    var $scrolldiv = $(this);
    $(window).scroll(function () {
        if ($(window).scrolltop() <= "250")
            $scrolldiv.fadeout("slow");
        else
            $scrolldiv.fadeIn("slow");
    });

    $scrolldiv.hide().removeattr("href");
    $scrolldiv.click(function () {
        $("html, body").animate({scrollTop: 0}, "slow");
    });

};
$(".up").scrollToTop();

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

/* @task refactor here Catalog Menu*/
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



/* Адаптивные таблицы в статьях */
$(".article").find("table").each(function () {
    $(this).wrap('<div class="table-responsive"></div>');
});

/* Адаптивные таблицы в карточке продукта */
$('#demoTab').easyResponsiveTabs({tabidentify: 'vert'});


/* Стили инпутов и селекторов */ 
jcf.lib.domReady(function(){
    jcf.customForms.replaceAll();
});

/* Slick слайдеры */
$('.slider-nav').slick({
    slidesToShow: 4,
    slidesToScroll: 1,
    asNavFor: '.fade',
    dots: false,
    focusOnSelect: true
});

$('.multiple-items').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 1,
    responsive: [
        {
            breakpoint: 640,
            settings: {
                slidesToShow: 2
            }
        },
        {
            breakpoint: 480,
            settings: {
                slidesToShow: 1
            }
        }
    ]
});

$('.screenshots-carousel').slick({
    centerMode: true,
    centerPadding: '60px',
    slidesToShow: 3,
    responsive: [
        {
            breakpoint: 768,
            settings: {
                arrows: false,
                centerMode: true,
                centerPadding: '40px',
                slidesToShow: 3
            }
        },
        {
            breakpoint: 480,
            settings: {
                arrows: false,
                centerMode: true,
                centerPadding: '40px',
                slidesToShow: 1
            }
        }
    ]
});

$('.feedback-carousel').slick({
    dots: true,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    adaptiveHeight: true
});

$('.responsive').slick({
    infinite: true,
    speed: 700,
    slidesToShow: 2,
    slidesToScroll: 1,
    responsive: [
        {
            breakpoint: 960,
            settings: {
                slidesToShow: 1,
                slidesToScroll: 1,
            }
        },
        {
            breakpoint: 800,
            settings: {
                slidesToShow: 2,
                slidesToScroll: 1
            }
        },
        {
            breakpoint: 640,
            settings: {
                slidesToShow: 1,
                slidesToScroll: 1
            }
        }
        // You can unslick at a given breakpoint now by adding:
        // settings: "unslick"
        // instead of a settings object
    ]
});


/*@task REFACTOR - не знаю что это за херня*/
(function(){
    var a = document.querySelector('.top-table'), b = null, P = 0;
    window.addEventListener('scroll', Ascroll, false);
    document.body.addEventListener('scroll', Ascroll, false);
    function Ascroll() {
        if (b == null) {
            var Sa = getComputedStyle(a, ''), s = '';
            for (var i = 0; i < Sa.length; i++) {
                if (Sa[i].indexOf('overflow') == 0 || Sa[i].indexOf('padding') == 0 || Sa[i].indexOf('border') == 0 || Sa[i].indexOf('outline') == 0 || Sa[i].indexOf('box-shadow') == 0 || Sa[i].indexOf('background') == 0) {
                    s += Sa[i] + ': ' +Sa.getPropertyValue(Sa[i]) + '; '
                }
            }
            b = document.createElement('div');
            b.style.cssText = s + ' box-sizing: border-box; width: ' + a.offsetWidth + 'px;';
            a.insertBefore(b, a.firstChild);
            var l = a.childNodes.length;
            for (var i = 1; i < l; i++) {
                b.appendChild(a.childNodes[1]);
            }
            a.style.height = b.getBoundingClientRect().height + 'px';
            a.style.padding = '0';
            a.style.border = '0';
        }
        var Ra = a.getBoundingClientRect(),
            R = Math.round(Ra.top + b.getBoundingClientRect().height - document.querySelector('.table4').getBoundingClientRect().bottom);  // селектор блока, при достижении нижнего края которого нужно открепить прилипающий элемент
        if ((Ra.top - P) <= 0) {
            if ((Ra.top - P) <= R) {
                b.className = 'stop';
                b.style.top = - R +'px';
            } else {
                b.className = 'sticky';
                b.style.top = P + 'px';
            }
        } else {
            b.className = '';
            b.style.top = '';
        }
        window.addEventListener('resize', function() {
            a.children[0].style.width = getComputedStyle(a, '').width
        }, false);
    }
})();


