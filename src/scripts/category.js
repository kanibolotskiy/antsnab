import {Quantity} from './lib/quantity.es6.js';

function initQuantityContainers(collection) {
    collection.each(function(index){
        var $el = $(this),
            saleUnitName = $el.attr('data-ui_name');
            Quantity.init($el, {
                'ui_names': {
                    'ui_name': saleUnitName,
                    'ui_name_plural': $el.attr('data-ui_name_plural'),
                    'ui_name_genitive': $el.attr('data-ui_name_genitive')
                }
            });
    });
}
/** init all quantiy containers in category or product page */
if( $('.qnt-container').length > 0 ) {
    initQuantityContainers($('.qnt-container'))    
}

$('body').delegate('#lazy-load_container','onLazyLoaded', function(e, $items){
    var collection = [];
    $.each( $items, function(index, $item){
        collection.push( $('.qnt-container', $item) ); 
    });
    initQuantityContainers($(collection))
})