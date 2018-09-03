import './lib/jquery.slideshow';

// page init
jQuery(function(){
	initSlideShow();
});

// slideshow init
function initSlideShow() {
	jQuery('div.slideshow').fadeGallery({
		slides: '.slide',
		currentNumber: 'span.cur-num',
		totalNumber: 'span.all-num',
		switchSimultaneously: true,
		disableWhileAnimating: false,
		generatePagination: 'div.pagination',
		autoRotation: true,
		autoHeight: true,
        useSwipe: true,
        switchTime: 2000,
		animSpeed: 600
	});
}

