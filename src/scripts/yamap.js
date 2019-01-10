/** @task этот гребаный яндекс тормозит всю карточку и не работает основной функционал */
document.addEventListener("DOMContentLoaded", function () {
    if( undefined !== window.ymaps ) {
        ymaps.ready(init);
    }
    
    function init() {
        
        $('.map-container').each(function(index){
            var latitude = $(this).attr('data-latitude'),
                longitude = $(this).attr('data-longitude'),
                name = $(this).attr('name'),
                id = $(this).attr('id');

            var map = new ymaps.Map(id, {
                center: [latitude, longitude],
                zoom: 15
            });
            var myPlacemark = new ymaps.Placemark(
                    [latitude,longitude],
                    {hintContent: name}
            );
            map.geoObjects.add(myPlacemark);
        });
        
    }
});
$(document).ready(function(){
    $(".map_tab").click(function(e){
        e.preventDefault();
        if(!$(this).hasClass("active")){
            href=$(this).attr("href");
            $(".map_block").hide();
            $("#"+href).fadeIn();
            $(".map_tab").removeClass("active");
            $(this).addClass("active");
        }
    });
});