if( $('#priceTableContent').length == 1 ) {
    var SHOW_ALL_OPTION_VALUE = $('#priceTableContent').attr('data-show_all_option_value');

    document.addEventListener("DOMContentLoaded", function(){
        function redrawSelector(id, options, currentValue) {
                var $container = $('#' + id),
                    $selector = $container.find('select'),
                    $newSelector;

                
                console.warn(id);
                console.warn(options);
                console.warn(currentValue);
                $newSelector = $(document.createElement('select'));
                $newSelector.addClass('catSelector');
                $.each(options, function(text, val) {
                    var $option = $(document.createElement('option'));
                    $option.attr('value', val);
                    $option.text(text);
                    $newSelector.append($option);    
                });
                $newSelector.val(currentValue);
                $container.append($newSelector);

                $selector.niceSelect('destroy');
                $newSelector.niceSelect();
                $selector.remove();
        }

        function redrawBreadcrumbs(){
            var $breadcrumbs = $('.dop-title'),
                        string = $('#firstActive > select > option:selected').text(); 

                    if( SHOW_ALL_OPTION_VALUE !== $('#secondActive > select').val() ) {
                        string += ' > ' + $('#secondActive > select > option:selected').text(); 
                    } 

                    if( undefined !== $('#thirdActive > select').val() &&
                        SHOW_ALL_OPTION_VALUE !== $('#thirdActive > select').val() ) {

                        string += ' > ' + $('#thirdActive > select > option:selected').text(); 
                    }

                    $breadcrumbs.text(string);     
        }

        redrawBreadcrumbs();

        $('body').delegate('.catSelector', 'change', function(){
            var postData = {
                firstActive: $('#firstActive > select').val()    
            };

            var changedId = $(this).parent('li').attr('id'); 
            
            if( SHOW_ALL_OPTION_VALUE !== $('#secondActive > select').val() && 
                changedId !== 'firstActive' 
            ) {
                postData.secondActive = $('#secondActive > select').val();
            }

            if( undefined !== $('#thirdActive > select').val() 
                    && SHOW_ALL_OPTION_VALUE !== $('#thirdActive > select').val()
                    && changedId !=='secondActive'
                    && changedId !=='firstActive' ) {
                postData.thirdActive = $('#thirdActive > select ').val();
            }

            $.ajax({
                url: '/index.php?route=extension/module/price/ajaxRefresh',
                method: 'POST',
                data: postData,
                dataType: 'json',
                error: function(){
                    alert('Error while request');
                },
                success: function(data) {
                    //console.error(data);
                    //Selectors
                    var firstActive = data.selectors.active[0];
                    redrawSelector('firstActive', data.selectors.l1, firstActive);

                    var secondActive = data.selectors.active[1] || SHOW_ALL_OPTION_VALUE;
                    redrawSelector('secondActive', data.selectors.l2, secondActive);

                    if( undefined === data.selectors.l3 ) {
                        $('#thirdActive > select').niceSelect('destroy');
                        $('#thirdActive > select').remove();
                        $('#thirdActive').css("visibility", "hidden"); 
                    } else {
                        var thirdActive = data.selectors.active[2] || SHOW_ALL_OPTION_VALUE;
                        redrawSelector('thirdActive', data.selectors.l3, thirdActive);
                        $('#thirdActive').css("visibility", "visible");
                    }

                    //Breadcrumbs
                    redrawBreadcrumbs();

                    //Table
                    $('#priceTableContent').html(data.table);
                    
                }
            });
        }); 
    });
}