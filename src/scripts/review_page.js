import './lib/formsubmit.js';

/** agree checkbox. used in prod page too */
window.onload = function ()
{
    $('#agreeeLabel').on('click', function (e) {
        var ischecked = $('#agree').prop('checked');
        $('#agree').prop('checked', !ischecked);
    });
}

/** submit form on review page */
$('#button-review_page').formSubmit({
    loaderSelector: '#ajax_loader',
    url: $('#button-review_page').attr('data-action'), 
    type: 'post',
    dataType: 'json',
    before: function() {
        $("#review_form .error").html("");
    },
    success: function(json) {
        if (json['error']) {
            for(var err in json['error']){
                $("#error_"+err).html(json['error'][err]);
            }
        }else{
            //$(".popup.thank-you").addClass("visible");
            $(".modal").hide();
            $(".modal_thanks_feedback").fadeIn(200);
            $("body").addClass("is-compensate-for-scrollbar");
            $('input, textarea','#review_form').val('');
        }
    },
    error: function(){},
});