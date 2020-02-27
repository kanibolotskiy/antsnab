import './lib/jquery.tabs';

/* Табы вида (грида) в категории */
// page init
$(function(){
	//initTabs();
	$(".select_view").click(function(){
		if(!$(this).hasClass("active")){
			$(".select_view").removeClass("active");
			$(this).addClass("active");
			
			$(".tab-block").each(function(){
				if(!$(this).hasClass("tab-block-cat")){
					$(this).toggleClass("tab-block2");
				}
			});
			
			var rel=$(this).attr("rel");
			$.cookie('cat_view', rel, { expires: 7, path: '/' });
		}
	});
});

// content tabs init
function initTabs() {
	jQuery('ul.fade-tabset').contentTabs({
		autoHeight: true,
		animSpeed: 300,
		effect: 'fade',
		tabLinks: 'a',
		event: 'mouseenter'
	});
	jQuery('ul.slide-tabset').contentTabs({
		addToParent: true,
		animSpeed: 500,
		effect: 'slide',
		tabLinks: 'a'
	});
	jQuery('ul.multi-tabset').contentTabs({
		tabLinks: 'a'
	});
}

$('#prodgrid').on('click', function(e){
	e.preventDefault();
	var container = $(this).parents('.catalog-tab').find('.tab-block');
	container.addClass('tab-block2');
	container.addClass('tab-block3');
});

$('#prodlist').on('click', function(e){
	e.preventDefault();
	var container = $(this).parents('.catalog-tab').find('.tab-block');
	container.removeClass('tab-block2');
	container.removeClass('tab-block3');
});