import Inputmask from "inputmask/dist/inputmask/inputmask.phone.extensions";
import jcf from "jcf";

/* Стили инпутов и селекторов */ 
$(function(){
    jcf.replaceAll();
});

/** Маска на полях с номером телефона*/
var phoneInput = $('input[name="phone"]'),
    im = new Inputmask( {mask: "(999) 999-9999"} );
im.mask(phoneInput);
