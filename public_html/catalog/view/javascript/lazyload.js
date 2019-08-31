
document.addEventListener("DOMContentLoaded", function(){
    $(window).bind('popstate', function(event){
        console.log("popstate");
    });
    
    function showMoreHandler(e) {
        e.preventDefault();
        var endPoint = $(this).attr('data-href'),
            $self = $(this),
            $container = $($self.attr('data-container')),
            $paginContainer = $($self.attr('data-pagincontainer'));

            
        var data_pagenum=$(this).attr("data-pagenum");

        var base_href=$("link[rel='canonical']").attr("href");
        var href=base_href+"?load_pages="+data_pagenum;
        history.pushState({page:href}, null, href);

        
        $.get(endPoint)
            .done(function(dataJson){
                var data = $.parseJSON(dataJson);

                if( null === data.result ) {
                    alert( 'Error response: ' + data.error);
                    return false;
                }
                
                var items = data.result.items,
                    showMore = data.result.showMore,
                    pagination = data.result.pagination,
                    $items = $([]);    
                
                /** append items */
                $.each( items, function(index, item){
                    var $item = $(item);
                    // $items.push($item);
                    $item.css("display", "none");
                    $container.append($item);
                    $item.slideDown('slow');
                    $items = $items.add($item);
                });
                
                /** rerender shomore button */
                $self.replaceWith(showMore);
                setTimeout( function() { 
                    $('#showMore').on('click', showMoreHandler);
                    $container.trigger('onLazyLoaded', [$items]); 
                }, 100 );

                /** make manipulations with standart pagination */
                if( $paginContainer.length > 0) {
                    $paginContainer.replaceWith(pagination);
                }

            })
            .fail(function(){
                console.log('Server Error');
            });
    };
    $('#showMore').on('click', showMoreHandler);
});