$(document).ready(function(){
    $(".history_caption").click(function(){
        var prnt=$(this).closest(".row_about");
        var rel=$(this).attr("rel");

        if(!$(this).hasClass("active")){
            
            prnt.find(".history_caption").removeClass("active");
            prnt.find(".mob_caption").removeClass("active");
            
            prnt.find(".mob_caption[rel='"+rel+"']").addClass("active");
            prnt.find(".history_caption[rel='"+rel+"']").addClass("active");

            prnt.find(".history_block").removeClass("active active_mob");
            prnt.find(".history_block[rel='"+rel+"']").addClass("active active_mob");
            //prnt.find(".history_block").hide();
            //prnt.find(".history_block[rel='"+rel+"']").fadeIn(200);
        }
    }); 

    $(".mob_caption").click(function(){
        var prnt=$(this).closest(".row_about");
        var rel=$(this).attr("rel");
        if($(this).hasClass("active")){
            prnt.find(".mob_caption").removeClass("active");
            prnt.find(".history_block").removeClass("active active_mob");
        }else{
            prnt.find(".mob_caption").removeClass("active");
            prnt.find(".history_block").removeClass("active active_mob"); 
            prnt.find(".mob_caption[rel='"+rel+"']").addClass("active");
            prnt.find(".history_block[rel='"+rel+"']").addClass("active active_mob");
        }
        
    });

    $(".media_slider").each(function(){
        $(this).slick({
            dots: false,
            arrows:true,
            infinite: true,
            speed: 300,
            slidesToShow: 4,
            slidesToScroll: 1,
            responsive: [
            {
                breakpoint: 1024,
                settings: {
                slidesToShow: 3,
                slidesToScroll: 1,
                }
            },
            {
                breakpoint: 600,
                settings: {
                slidesToShow: 2,
                slidesToScroll: 1
                }
            },
            {
                breakpoint: 480,
                settings: {
                slidesToShow: 1,
                slidesToScroll: 1
                }
            }
            // You can unslick at a given breakpoint now by adding:
            // settings: "unslick"
            // instead of a settings object
            ]
        })/*.on('setPosition', function (event, slick) {
            slick.$slides.css('height', slick.$slideTrack.height() + 'px');
        })*/;
    });
    
})