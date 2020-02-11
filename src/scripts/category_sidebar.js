var flag_update=true;
function getParamsForm(){
    //$(".inputRangeMin").each()
    
    var str='';
    /*
    $(".inputRangeMin").each(function(){
        var val=$(this).val()*1;
        var min=$(this).closest(".wrapper_range_slider").find(".range_slider").attr("def_min_value")*1;
        if((val!=min)&&(val)){
            str+="&"+$(this).attr("name")+"="+$(this).val();
        }
    });
    $(".inputRangeMax").each(function(){
        var val=$(this).val()*1;
        var max=$(this).closest(".wrapper_range_slider").find(".range_slider").attr("def_max_value")*1;
        if((val!=max)&&(val)){
            str+="&"+$(this).attr("name")+"="+$(this).val();
        }param[price][min]
    });
    */

    $(".range_slider").each(function(){
        var select_min=$(this).attr("select_min")*1;
        var select_max=$(this).attr("select_max")*1;
        var min_value=$(this).attr("min_value")*1;
        var max_value=$(this).attr("max_value")*1;

        //console.log(select_min+">"+min_value)
        if(select_min!=min_value){
            str+="&param["+$(this).attr("name")+"][min]="+select_min;
        }
        
        if(select_max!=max_value){
            str+="&param["+$(this).attr("name")+"][max]="+select_max;
        }
    });

    $(".param_check").each(function(){
        if($(this).prop("checked")){
            str+="&"+$(this).attr("name")+"="+$(this).val();
        }
    });
    if(str){
        str="?"+str;
        $(".filter_reset").animate({"opacity":1},200);
    }else{
        $(".filter_reset").animate({"opacity":0},200);
    }
    return str;
}
function resetSliders(){
    
    $(".range_slider").each(function(){

        var min_value=$(this).attr("def_min_value")*1;
        var max_value=$(this).attr("def_max_value")*1;

        $(this).attr("select_min",min_value);
        $(this).attr("select_max",max_value);

        $(this).attr("min_value",min_value);
        $(this).attr("max_value",max_value);

        $(this).slider("option",{"min":min_value,"max":max_value});
        $(this).slider("values",[min_value,max_value]);

        $(this).parent().find(".inputRangeMin").val(min_value)
        $(this).parent().find(".inputRangeMax").val(max_value)
        
    });
}
function resetFilterForm(){
    flag_update=false;
    $(".param_check").each(function(){
        $(this).prop("checked",false);
    });
    resetSliders();

    flag_update=true;
    change_params_form();
    //$(".filter_reset").animate({"opacity":0},200);

}
function change_params_form(){
    //data_url1=getParamsForm()

    //console.log("flag_update="+flag_update);

    var url=$("#form_params").attr("action");
    //var data_url=decodeURI($("#form_params").serialize());
    if(flag_update){
        var data_url=getParamsForm();
        var catalog_id=$("#form_params").attr("catalog_id");
        history.pushState(null,null, url+data_url);
        var tp=$(".catalog-list").offset().top-$(".header").height();
        flag_update=false;
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

                    
                    //if(avail_data.length){
                    var flag_empty=true;
                    
                    for(var avail_item in avail_data){
                        var flag_empty=false;
                        let itm=avail_data[avail_item];
                        if(itm.type){
                            let min_value=itm.result.min;
                            let max_value=itm.result.max;

                            
                            let range_row=$(".param_row[param_name='"+avail_item+"']");
                            let range_row_slider=range_row.find(".range_slider");

                            range_row_slider.attr("min_value",min_value);
                            range_row_slider.attr("max_value",max_value);
                            

                            let inputMin=range_row.find(".inputRangeMin").val()*1;
                            let inputMax=range_row.find(".inputRangeMax").val()*1;

                            var select_min=range_row_slider.attr("select_min")*1;
                            var select_max=range_row_slider.attr("select_max")*1;

                            /*
                            if(min_value>select_min){
                                range_row.find(".inputRangeMin").val(min_value);
                                range_row_slider.slider("value",0,min_value)
                            }else{
                                range_row.find(".inputRangeMin").val(select_min);
                            }
                            
                            if(max_value<select_max){
                                range_row.find(".inputRangeMax").val(max_value);
                                range_row_slider.slider("value",1,max_value)
                            }else{
                                range_row.find(".inputRangeMax").val(select_max);
                            }*/
                            //console.log(min_value+">"+select_min)

                            if(min_value>select_min){
                                range_row.find(".inputRangeMin").val(min_value);
                                range_row_slider.slider("value",0,min_value)
                            }else{
                                range_row.find(".inputRangeMin").val(select_min);
                                range_row_slider.slider("value",0,select_min)
                            }
                            if(max_value<select_max){
                                range_row.find(".inputRangeMax").val(max_value);
                                range_row_slider.slider("value",1,max_value)
                            }else{
                                range_row.find(".inputRangeMax").val(select_max);
                                range_row_slider.slider("value",1,select_max)
                            }

                            range_row_slider.slider("option",{"min":min_value,"max":max_value});



                            //range_row.find(".inputRangeMin").val()                            
                            //range_row_slider.attr("min_value",min_value);
                            //range_row_slider.attr("max_value",max_value);
                            
                            /*
                            var select_min=range_row_slider.attr("select_min");
                            var select_max=range_row_slider.attr("select_max");

                            
                            
                            */

                            /*
                            if(min_value>inputMin){
                                range_row.find(".inputRangeMin").val(min_value);
                            }else{
                                range_row.find(".inputRangeMin").val(inputMin);
                            }
                            if(max_value<inputMax){
                                range_row.find(".inputRangeMax").val(max_value)
                            }else{
                                range_row.find(".inputRangeMax").val(inputMax)
                            }
                            */
                        }else{                        
                            $(".param_row[param_name='"+avail_item+"'] .param_check").each(function(){
                                //console.log($(this).val());
                                let flag=true;
                                for(var itm_result in itm.result){
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
                    if(flag_empty){
                        //resetSliders();
                    }
                    flag_update=true;
                    $("html,body").animate({"scrollTop":tp},500)
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
        
    }
}

$(document).ready(function(){
    $(".filter_reset").click(function(){
        resetFilterForm();
    });
    $(document).on("change",".param_check",function(){
        if(flag_update){
            change_params_form();
        }
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

                $(this).closest(".wrapper_range_slider").find(".inputRangeMin").val(ui.values[0])
                $(this).closest(".wrapper_range_slider").find(".inputRangeMax").val(ui.values[1])
                
            },
            change:function(event, ui){
                if(flag_update){
                    $(this).attr("select_min",ui.values[0]);
                    $(this).attr("select_max",ui.values[1]);
                
                    change_params_form();
                }
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