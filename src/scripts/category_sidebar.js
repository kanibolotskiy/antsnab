import './lib/jquery.accordion';
import 'jquery-touchswipe';

/* Навигация в сайдбаре */
(function($){

   const  slideDuration = 300,
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

        /** @see https://stackoverflow.com/questions/986763/jquery-how-to-determine-that-a-div-is-scrolled-down user2226623*/ 
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

        /*Подтягиваем вьюпорт под пункты меню если нужно*/
        afterOpenHandler: function(options, $item) {
            var accordion = this,
                accordionCont = accordion.parent('div');

            //in sticked mode
            if($item.position().top < 0) {
                //accordionCont.scrollTop( accordionCont.scrollTop()+$item.position().top );
                accordionCont.animate({scrollTop: accordionCont.scrollTop()+$item.position().top}, "slow");

            //in desktop mode
            /*} else if( $(window).scrollTop() > $item.offset().top ) {
                $(window).animate( {scrollTop: $item.offset().top} );*/
            } 
        }
	});
}


