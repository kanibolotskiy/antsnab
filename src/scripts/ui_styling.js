/** @task resolve throug webpack */
import './lib/nice-select';
import Inputmask from "inputmask/dist/inputmask/inputmask.phone.extensions";

var selector = $('input[name="phone"'),
    im = new Inputmask("(999) 999-99-99");
im.mask(selector);

$(window).on('load', function(){
    $('select').niceSelect();
});
