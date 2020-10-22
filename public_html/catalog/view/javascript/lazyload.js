

document.addEventListener("DOMContentLoaded", function(){
    //-------------------------------------------
    function getParamsForm(){
        var str='';
        $(".range_slider").each(function(){
            var select_min=$(this).attr("select_min");
            var select_max=$(this).attr("select_max");
            var min_value=$(this).attr("min_value")*1;
            var max_value=$(this).attr("max_value")*1;
            if(select_min!=""){
                if((select_min)*1!=min_value){
                    str+="&param["+$(this).attr("name")+"][min]="+select_min;
                }
            }
            if(select_max!=""){
                if((select_max*1)!=max_value){
                    str+="&param["+$(this).attr("name")+"][max]="+select_max;
                }
            }
        });
        $(".param_check").each(function(){
            if($(this).prop("checked")){
                //str+=(str!=""?"&":"")+$(this).attr("name")+"="+$(this).val();
                str+="&"+$(this).attr("name")+"="+$(this).val();
            }
        });

        if(str){
            $(".filter_reset").addClass("active");
        }else{
            $(".filter_reset").removeClass("active");
        }

        //Сортировка
        var sort=$("#seldef1 option:selected").val();
        var sort_str="";
        if(sort){
            //str+=(str!=""?"&":"")+"sort="+sort;
            str+="&sort="+sort;
        }

        //Пагинация
        var limit=$(".showby_item.active").attr("rel");
        if(limit!="9"){
            str+="&limit="+limit;
        }
        
        if(str){
            str_fin="?"+str.slice(1)
        }
        

        var url=$("#form_params").attr("action");
        return str_fin;
}
//-------------------------------------------
   
    
    function showMoreHandler(e) {
        //console.log("ook");
        e.preventDefault();
        var endPoint = $("#showMore").attr('data-href'),
            $self = $("#showMore"),
            $container = $($self.attr('data-container')),
            $paginContainer = $($self.attr('data-pagincontainer'));


        //console.log();
        //
        //if(flag){
        //    var base_href=$("link[rel='canonical']").attr("href");
        //}else{
        //    var base_href=$("#form_params").attr("action")+getParamsForm();
        //}
        //console.log($("link[rel='canonical']").attr("href"))
        //console.log(base_href)

        var data_pagenum=$("#showMore").attr("data-pagenum");
        //var base_href=$("link[rel='canonical']").attr("href");
        
        if($("#wrp_paginate").length){
            var base_href=document.location.pathname+getParamsForm();
            //console.log(getParamsForm());
        }else{
            base_href=$("link[rel='canonical']").attr("href");
        }

        var sep="?";
        if(base_href.indexOf("?")>=0){
            sep="&";
        }
        //console.log(base_href.indexOf("?"));

        var href=base_href+sep+"load_pages="+data_pagenum;
        
        history.pushState({page:href}, null, href);

        $.get(endPoint)
            .done(function(dataJson){
               
                var data = $.parseJSON(dataJson);

                if( null === data.result ) {
                    alert( 'Error response: ' + data.error);
                    return false;
                }
                
                var items = data.result.items,
                    showMore = data.result.showMore,
                    pagination = data.result.pagination,
                    $items = $([]);    
                
                /** append items */
                
                if(data.result.tp==1){
                    
                    var $item = $(items);
                    $item.css("display", "none");
                    $container.append($item);
                    
                    
                    $item.fadeIn(200);
                    //$item.slideDown('slow');
                    $items = $items.add($item);
                    $('input[name="phone"]').inputmask("+7 9999999999",{ 
                        "clearIncomplete": true,
                        "alias": 'numeric', 
                        "allowMinus": false
                    });

                    /**/
                    //$items=$(data.result.items);

                }else{
                    $.each( items, function(index, item){
                        var $item = $(item);
                     $items.push($item);
                        $item.css("display", "none");
                        $container.append($item);
                        $item.slideDown('slow');
                        $items = $items.add($item);
                        $('input[name="phone"]').inputmask("+7 9999999999",{ 
                            "clearIncomplete": true,
                            "alias": 'numeric', 
                            "allowMinus": false
                        });
                    });
                }

                /** rerender shomore button */
                $self.replaceWith(showMore);
                
                setTimeout( function() { 
                   //$('#showMore').on('click', showMoreHandler);
                    $container.trigger('onLazyLoaded', [$items]); 
                }, 100 );
                
                /** make manipulations with standart pagination */
                if( $paginContainer.length > 0) {
                    $paginContainer.replaceWith(pagination);
                }

            })
            .fail(function(){
                console.log('Server Error');
            });
    };
    //$(document).on("click","#showMore",showMoreHandler);
    $(document).on("click","#showMore",function(e){
        showMoreHandler(e);
    });

    //$('#showMore').on('click', showMoreHandler);
   
    /*$(document).on("click","#showMore",function(e){
        var data_pagenum=$(this).attr("data-pagenum");
        if($(this).parent().hasClass("wrp_paginate_cats")){
            showMoreHandler(e,true,data_pagenum);
        }else{
            showMoreHandler(e,false,data_pagenum);
        }
        
    });
    */
    /*
    $(document).on("click","#showMoreCat",function(e){
        showMoreHandler(e,true)
    });
    */
});