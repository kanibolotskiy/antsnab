$.fn.formSubmit = function(opts){
    this.on('click', function(){
        $(opts.loaderSelector).fadeIn(200);
        opts.before();
        
        $.ajax({
            url: opts.url, 
            type: opts.type, 
            dataType: opts.dataType, 
            data: $(this).parents('form').serialize(),
            
            success: function(json) {
                $(opts.loaderSelector).fadeOut(200);
                opts.success(json);
            },

            error: function(jqXHR, textStatus, errorThrown) {
                $(opts.loaderSelector).fadeOut(200);
                console.error(textStatus);
                console.error(errorThrown);
                opts.error(jqXHR, textStatus, errorThrown);
            }
            
        });

    });
}