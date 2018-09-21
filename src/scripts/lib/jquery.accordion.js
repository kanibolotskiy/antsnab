

/*
 * jQuery Accordion plugin
 */
;(function($){
	$.fn.slideAccordion = function(opt){
		// default options
		var options = $.extend({
			addClassBeforeAnimation: false,
			activeClass:'active',
			opener:'.opener',
			slider:'.slide',
			animSpeed: 300,
			collapsible:true,
			event:'click',
            afterOpenHandler: null
		},opt);

		return this.each(function(){
			// options
			var accordion = $(this);
            var self = $(this);
			var items = accordion.find(':has('+options.slider+')');

			items.each(function(){
				var item = $(this);
				var opener = item.find(options.opener);
				var slider = item.find(options.slider);
				opener.on(options.event, function(e){
					if(!slider.is(':animated')) {
						if(item.hasClass(options.activeClass)) {
							if(options.collapsible) {
								slider.slideUp(options.animSpeed, function(){
									hideSlide(slider);
									item.removeClass(options.activeClass);
								});
							}
						} else {
                            var levelItems = item.siblings('.'+options.activeClass);
                            var sliderElements = levelItems.find(options.slider);
                            
                            function processToggle() {
                                    // show active
                                    item.addClass(options.activeClass);
                                    showSlide(slider).hide().slideDown(options.animSpeed);
                                    
                                    // collapse others
                                    return sliderElements.slideUp(options.animSpeed, function(){
                                        levelItems.removeClass(options.activeClass);
                                        hideSlide(sliderElements);
                                    });
                            }

                            $.when(processToggle()).done(function(){                                                                        if( null !== options.afterOpenHandler && 
                                   typeof options.afterOpenHandler === 'function') 
                               {
                                   options.afterOpenHandler.call(self, options, item); 
                               }
                            });
						}
					}
					e.preventDefault();
				});
				if(item.hasClass(options.activeClass)) showSlide(slider); else hideSlide(slider);
			});
		});
	};

	// accordion slide visibility
	var showSlide = function(slide) {
		return slide.css({position:'', top: '', left: '', width: '' });
	};
	var hideSlide = function(slide) {
		return slide.show().css({position:'absolute', top: -9999, left: -9999, width: slide.width() });
	};
}(jQuery));