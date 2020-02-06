function getParamsForm(){
    //$(".inputRangeMin").each()
    var str='';
    $(".inputRangeMin").each(function(){
        var val=$(this).val()*1;
        var min=$(this).closest(".wrapper_range_slider").find(".range_slider").attr("min_value")*1;
        if(val!=min){
            str+="&"+$(this).attr("name")+"="+$(this).val();
        }
    });
    $(".inputRangeMax").each(function(){
        var val=$(this).val()*1;
        var max=$(this).closest(".wrapper_range_slider").find(".range_slider").attr("max_value")*1;
        if(val!=max){
            str+="&"+$(this).attr("name")+"="+$(this).val();
        }
    });
    $(".param_check").each(function(){
        if($(this).prop("checked")){
            str+="&"+$(this).attr("name")+"="+$(this).val();
        }
    });
    if(str){
        str="?"+str;
    }
    return str;
}
function change_params_form(){
    //data_url1=getParamsForm()

    var url=$("#form_params").attr("action");
    //var data_url=decodeURI($("#form_params").serialize());
    var data_url=getParamsForm();
    var catalog_id=$("#form_params").attr("catalog_id");
    history.pushState(null,null, url+data_url);
    var tp=$(".catalog-list").offset().top-$(".header").height();
    
    $.ajax({
        url:  '/index.php?route=extension/module/category/ajaxRefreshParams',
        type: 'post',
        data: data_url+"&catalog_id="+catalog_id,
        dataType: 'json',
        /*
        beforeSend: function() {
            $('#cart_preloader').fadeIn(200);
        },
        complete: function() {
            $('#cart_preloader').fadeOut(200);
        },*/
        success: function(json) {
            //console.log(json)
            if (json['success']) {
                var avail_data=json['avail'];
                $(".row_check").removeClass("_unactive");
                $(".param_check").attr("disabled",false);

                for(avail_item in avail_data){
                    let itm=avail_data[avail_item];
                    if(itm.type){
                        let min_value=itm.result.min;
                        let max_value=itm.result.max;
                        let range_row=$(".param_row[param_name='"+avail_item+"']");
                        let range_row_slider=range_row.find(".range_slider");

                        let inputMin=range_row.find(".inputRangeMin").val()*1;
                        let inputMax=range_row.find(".inputRangeMax").val()*1;

                        //range_row.find(".inputRangeMin").val()
                        
                        range_row_slider.attr("min_value",min_value);
                        range_row_slider.attr("max_value",max_value);
                        
                        if(min_value>inputMin){
                            range_row.find(".inputRangeMin").val(min_value)
                        }
                        if(max_value<inputMax){
                            range_row.find(".inputRangeMax").val(max_value)
                        }
                        console.log(min_value+"="+max_value)
                        range_row_slider.slider("option",{"min":min_value,"max":max_value});
                        


                        //range_row_slider.


                    }else{                        
                        $(".param_row[param_name='"+avail_item+"'] .param_check").each(function(){
                            //console.log($(this).val());
                            let flag=true;
                            for(itm_result in itm.result){
                                if((itm.result[itm_result]["param_id"]*1)==$(this).val()){
                                    flag=false;
                                }
                            }
                            if(flag){
                                $(this).attr("disabled",true);
                                $(this).closest(".row_check").addClass("_unactive");
                            }else{
                                $(this).attr("disabled",false);
                                $(this).closest(".row_check").removeClass("_unactive");
                            }
                            //itm.result

                        });
                    }
                }
            
                $("html,body").animate({"scrollTop":tp},500)
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
}

$(document).ready(function(){
    $(document).on("change",".param_check",function(){
        change_params_form();
    });
    $(".range_slider").each(function(){
        var min_value=$(this).attr("min_value")*1;
        var max_value=$(this).attr("max_value")*1;
        
        $(this).slider({
            range: true,
            animate: "fast",
            min: min_value,
            max: max_value,
            values: [min_value,max_value],
            slide: function( event, ui ) {
                //console.log(ui.values[ 0 ] )
                $(this).closest(".wrapper_range_slider").find(".inputRangeMin").val(ui.values[0])
                $(this).closest(".wrapper_range_slider").find(".inputRangeMax").val(ui.values[1])
            },
            change:function(event, ui){
                change_params_form();
            }
        });
    });
    $(".inputRangeMin").change(function(){
        var vl=$(this).val()*1;
        var itm=$(this).closest(".wrapper_range_slider").find(".range_slider");
        var avail_min = itm.attr("min_value")*1;
        var avail_max = itm.attr("max_value")*1;
        if(vl<avail_min){
            $(this).val(avail_min);
            vl=avail_min;
        }
        if(vl>avail_max){
            $(this).val(avail_max);
            vl=avail_max;
        }
        itm.slider("values", 0, vl);
    });

    $(".inputRangeMax").change(function(){
        var vl=$(this).val()*1;
        var itm=$(this).closest(".wrapper_range_slider").find(".range_slider");
        var avail_min = itm.attr("min_value")*1;
        var avail_max = itm.attr("max_value")*1;
        if(vl<avail_min){
            $(this).val(avail_min);
            vl=avail_min;
        }
        if(vl>avail_max){
            $(this).val(avail_max);
            vl=avail_max;
        }
        itm.slider("values", 1, vl);
    });

    $(".wrp_sidebar_filter_caption").click(function(){
        $(".sidebar_filter_caption").addClass("active");
        $(".catalog-product").addClass("_filter");
    });
    $(".sidebar_filter_close").click(function(){
        $(".sidebar_filter_caption").removeClass("active");
        $(".catalog-product").removeClass("_filter");
    });

    $(".catalog_opens").click(function(){
        $(".catalog-product .accordion").slideToggle(200);
    });

    $(".catalog_arrow").click(function(){
        var itm=$(this).closest("li");
        if(itm.hasClass("_active")){
            itm.find(".slide").slideUp(200);
            itm.removeClass("_active");
        }else{
            $(".simple-accordion li").removeClass("_active");
            $(".sidebar .slide").slideUp(200);
            itm.find(".slide").slideDown(200);
            itm.addClass("_active");
        }
    });
    

    $(".table_catalog").click(function(){
        $(this).toggleClass("active");
        
        $(".catalog-product").toggleClass("active");
        $("body").toggleClass("_lmenu");
    });
    $(".catalog_hide").click(function(){
        $(".catalog-product").removeClass("active");
        $(".table_catalog").removeClass("active");
        $("body").removeClass("_lmenu");
    });

    $(document).on("focusin",".ya-site-form__input-text",function(){
        $("#search").addClass("active");
    });
    $(document).on("focusout",".ya-site-form__input-text",function(){
        $("#search").removeClass("active");
    })
})