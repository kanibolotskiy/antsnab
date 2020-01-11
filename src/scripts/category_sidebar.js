/*
import './lib/jquery.accordion';
import 'jquery-touchswipe';
(function($){
   var  slideDuration = 300,
          stickBreakpoint = 800,
          freezeClass = 'freeze',
          stickClass = 'fixed-nav'; 

   var  $header = $('.catalog-product'),
        $container = $header.parents('.container.main'),
        $accordeon = $header.find('.accordion'),
        $accordeonInner = $accordeon.find('.simple-accordion'),
        $accordeonHeader = $(".catalog-btn"),
        $accordeonToggleButton = $(".catalog-opener"),
        $collapseButton = $(".collapse");

    $header.data('stickVerticalBreakPoint', $header.offset().top);
          

   var  toggleStickHeader = function() {
            
            if( 
                !isHeaderSticked() && 
                $(window).scrollTop() >= $header.offset().top && 
                window.innerWidth <= stickBreakpoint 
            ) {
                $header.data('stickVerticalBreakPoint', $header.offset().top);
                $container.addClass(stickClass);

            } else if ( 
                window.innerWidth > stickBreakpoint ||
                $(window).scrollTop() < $header.data('stickVerticalBreakPoint')
            ) {
                $container.removeClass(stickClass);
                $header.data('stickVerticalBreakPoint', $header.offset().top);
            }
        },

        isHeaderSticked = function() {
            return $container.hasClass(stickClass);
        },
   
        toggleAccordeon = function(complete) {
            $accordeon.slideToggle(slideDuration, complete);
        },

        isAccordeonOpened = function () {
            return !($accordeon.css('display') === 'none');        
        },

        toggleFreezeBody = function() {
            if( isAccordeonOpened() && isHeaderSticked() ) {
                $('body').addClass(freezeClass);
                $accordeon.css('height', window.innerHeight-$accordeonHeader.height() );
            } else {
                $('body').removeClass(freezeClass);
                $accordeon.css('height', 'auto');
            } 
        },

        isBodyFreezed = function() {
            return $('body').hasClass(freezeClass);
        },

        isScrolledBottom = function() {
            var totalHeight = $accordeon[0].scrollHeight,
                scrollPosition = $accordeon.height() + $accordeon.scrollTop();
            return (totalHeight == scrollPosition);
        },

        registerEvents = function() {

            //toggle accordeon
            $accordeonToggleButton.on('click', function(e){
                e.preventDefault();
                e.stopPropagation();
                toggleAccordeon(toggleFreezeBody);
            });

            $collapseButton.on('click', function(){
                toggleAccordeon(toggleFreezeBody);
            });
            
            //scroll
            $(window).on('scroll resize load', function(){
                toggleStickHeader();
                toggleFreezeBody();
                if( $(window).width() > stickBreakpoint && !isAccordeonOpened() ) {
                    toggleAccordeon();
                }
            });

            $accordeon.on('scroll', function() {
                if( isScrolledBottom() ) {
                    //console.log('bottom');
                }
            });
        };
  registerEvents();
})($);


// page init
jQuery(function(){
	initAccordion();
});

// inner accordions in menu
function initAccordion() {
	jQuery('ul.simple-accordion').slideAccordion({
		opener:'>a.opener',
		slider:'>div.slide',
		collapsible:true,
		animSpeed: 300,

        afterOpenHandler: function(options, $item) {
            var accordion = this,
                accordionCont = accordion.parent('div');

            //in sticked mode
            if($item.position().top < 0) {
                //accordionCont.scrollTop( accordionCont.scrollTop()+$item.position().top );
                accordionCont.animate({scrollTop: accordionCont.scrollTop()+$item.position().top}, "slow");

            //in desktop mode
            //} else if( $(window).scrollTop() > $item.offset().top ) {
            //    $(window).animate( {scrollTop: $item.offset().top} );
            //} 
        }
	});
}
*/
$(document).ready(function(){
    $(".catalog_opens").click(function(){
        $(".catalog-product .accordion").slideToggle(200);
    });

    $(".catalog_arrow").click(function(){
        var itm=$(this).closest("li");
        if(itm.hasClass("_active")){
            itm.find(".slide").slideUp(200);
            itm.removeClass("_active");
        }else{
            $(".simple-accordion li").removeClass("_active");
            $(".sidebar .slide").slideUp(200);
            itm.find(".slide").slideDown(200);
            itm.addClass("_active");
        }
    });
    

    $(".table_catalog").click(function(){
        $(this).toggleClass("active");
        $(".catalog-product").toggleClass("active");
        $("body").toggleClass("_lmenu");
    });
    $(".catalog_hide").click(function(){
        $(".catalog-product").removeClass("active");
        $(".table_catalog").removeClass("active");
        $("body").removeClass("_lmenu");
    });

    $(document).on("focusin",".ya-site-form__input-text",function(){
        $("#search").addClass("active");
    });
    $(document).on("focusout",".ya-site-form__input-text",function(){
        $("#search").removeClass("active");
    })
})