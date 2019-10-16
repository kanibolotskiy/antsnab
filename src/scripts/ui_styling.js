/** @task resolve throug webpack */
import './lib/nice-select';
//import Inputmask from "inputmask/dist/inputmask/inputmask.phone.extensions";
import Inputmask from "./lib/jquery.inputmask.bundle.min.js";
//import Inputmask from "./lib/jquery.fancybox.min.js";
//var $ = require('jquery');
import './lib/jquery.fancybox.min';

$(document).ready(function(){
    $('input[name="phone"]').inputmask("+7 9999999999",{ 
        "clearIncomplete": true,
        "alias": 'numeric', 
        "allowMinus": false
    });
    $('select').niceSelect();
    //$("input[name='search']").attr('autocomplete','off');
});