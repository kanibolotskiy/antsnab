import {Quantity} from './lib/quantity.es6.js';

/** init all quantiy containers in category or product page */
if( $('.qnt-container').length > 0 ) {
    Quantity.init('.qnt-container');
}