/** @task resolve throug webpack */
import './lib/nice-select';
//import Inputmask from "inputmask/dist/inputmask/inputmask.phone.extensions";
import Inputmask from "./lib/jquery.inputmask.bundle.min.js";


$(window).on('load', function(){
    $('select').niceSelect();
    /*
    var selector = $('input[name="phone"]'),
        //im = new Inputmask("(999) 999-99-99");
        im = new Inputmask("+7 9999999999");
    im.mask(selector);
    */
   $('input[name="phone"]').inputmask("+7 9999999999",{ "clearIncomplete": true });


   
});
