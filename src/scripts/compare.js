function setRightCompareWidth(){
    if($(".right_compare").length){
        var cb_width=$(".compare-block").width();
        var wn_width=$(window).width();
        
        var part_width=(wn_width-cb_width)/2
        $(".right_compare").css({"width":cb_width-$(".left_compare").width()*1+part_width})
    }
}

function setRightHeight(){
    var rel_cap=$(".compare_catalog_caption.active").attr("rel");

    $(".compare_catalog_block[rel='"+rel_cap+"']").each(function(){
        var itm=$(this);
        itm.find(".left_compare").find(".comp_row").each(function(){
            var rel=$(this).attr("rel");
            var ht=$(this).height();

            itm.find(".right_compare").find(".comp_row[rel='"+rel+"']").each(function(){
                var ht_val=$(this).height();
                if(ht_val>ht){ht=ht_val;}
            })
            itm.find(".comp_row[rel='"+rel+"']").css({"height":ht+21});
        });
        
    });
}
function checkCompare(){
    //checkCompare($(this))
    var rel_cap=$(".compare_catalog_caption.active").attr("rel");

    var parent_itm=$(".compare_catalog_block[rel='"+rel_cap+"']");
    var itm_left=parent_itm.children(".left_compare");
    var itm_right=parent_itm.children(".right_compare");
    var itm_check=parent_itm.find(".check_compare");

    if(itm_check.prop("checked")){
        
        itm_left.find(".comp_row").each(function(){
            var rel=$(this).attr("rel");
            var flag=false;
            //var compare_str="";
            var compare_str=itm_right.find(".compare_block_val[rel='"+rel+"']").first().html();
            //console.log(compare_str);
            itm_right.find(".compare_block_val[rel='"+rel+"']").each(function(){
                //compare_str=;
                if(compare_str!=$(this).html()){
                    flag=true;
                }
                //console.log($(this).html())
            });
            //$(this)
            if(!flag){
                parent_itm.find(".compare_block[rel='"+rel+"']").fadeOut(200);
            }
        })
    }else{
        parent_itm.find(".compare_block").fadeIn(200);
    }
}
function compareScroll(){
    var st=$(window).scrollTop();
    //var ht=$("header").height()*1;
    var ht=90;

    //ht=110;
    
    if(st>50){
        $("body.common-compare .catalog-product").css({"margin-top":st-50+11});
    }else{
        $("body.common-compare .catalog-product").css({"margin-top":0});
    }

    if($(window).width()>750){
        var limit2=st-st-ht-$(".compare_catalog_captions_wrapper").height()*1;
        var ht_cards=ht+$(".compare_catalog_captions_wrapper").height()*1;
        var dempst=0;

        if($(window).width()<1100){
            dempst=40;
        }
        if((st-ht-70+dempst)>0){
            var wd=$(".common-compare").width();
            var empty_height=$(".compare_catalog_captions").height();

            $(".common-compare").addClass("fixed_compare_caption");
            //$(".compare_catalog_captions").css({"width":wd,"top":ht});
            $(".compare_catalog_captions").css({"width":wd});
            $(".compare_catalog_captions_empty").css({"height":empty_height})
        }else{
            $(".common-compare").removeClass("fixed_compare_caption")
            //$(".compare_catalog_captions").css({"width":"initial","top":0});
            $(".compare_catalog_captions").css({"width":"initial"});
            $(".compare_catalog_captions_empty").css({"height":0})
        }
        //console.log(st+"-"+ht+"-"+$(".compare_catalog_captions_wrapper").height()+"+"+70+"="+(st-ht-$(".compare_catalog_captions_wrapper").height()+70))
        var marg_img=st-190-7+dempst
        if((marg_img)>0){
            $(".compare_header").removeClass("notfixed").css({"top":ht_cards});
            $(".common-compare").addClass("fixed_compare_header");

            //console.log(limit2)
            
            //$(".compare_product_img").css({"margin-top":-marg_img})

            var ht_comp_header=320-marg_img;
            if(marg_img<170){
                $(".compare_product_img").css({"margin-top":-marg_img})
                $(".compare_header").css({"height":ht_comp_header})
                $(".compare_product_header").removeClass("_with_border");
            }else{
                $(".compare_product_img").css({"margin-top":-170})
                $(".compare_header").css({"height":150})
                $(".compare_product_header").addClass("_with_border");
            }
            $(".left_compare_caption").addClass("_active");

        }else{
            $(".left_compare_caption").removeClass("_active");
            $(".compare_header").addClass("notfixed").css({"top":0});
            $(".common-compare").removeClass("fixed_compare_header");
            $(".compare_product_img").css({"margin-top":0})
            $(".compare_header").css({"height":320})
        }
        
        
    }else{
        $(".common-compare").removeClass("fixed_compare_caption")
        //$(".compare_catalog_captions").css({"width":"initial","top":0});
        $(".compare_catalog_captions").css({"width":"initial"});
        $(".compare_catalog_captions_empty").css({"height":0})
    }
    
}

$(window).scroll(function(){
    compareScroll();
});
$(window).resize(function(){
    setRightCompareWidth();
    compareScroll();
});
$(window).on("load", function() {
    setRightHeight();
});
$(document).ready(function(){
    setRightCompareWidth();
    compareScroll();
    $(".comdel").click(function(){
        var product=$(this).closest(".compare_product");
        var products=product.parent();
        var rel=product.attr("rel");
        //console.log($.cookie('compare'));
        var compare_str=$.cookie('compare');
        var compare_arr=JSON.parse(compare_str);
        
        /*
        console.log(compare_arr);
        
        ///var index = compare_arr.indexOf(rel);
        var new_compare_arr=compare_arr
        var index =-1;
        for(i in compare_arr){
            if(compare_arr[i]==rel){
                new_compare_arr.splice(index, 1);
            }
        }
        ////console.log("rel="+rel)
        //console.log("splice="+index)
        /*
        if (index > -1) {
            compare_arr.splice(index, 1);
        }
        */
        var new_compare_arr=[];
        for(i in compare_arr){
            if(compare_arr[i]!=rel){
                new_compare_arr.push(compare_arr[i]);
            }
        }
        
        $.cookie('compare', JSON.stringify(new_compare_arr), { expires: 30, path: '/' });

        product.fadeOut(200,function(){
            product.remove();
            var cnt_item=$(".compare_catalog_caption.active").children(".compare_catalog_count");
            var cnt=cnt_item.html()*1;
            if(cnt>1){
                cnt_item.css({"opacity":0});
                cnt_item.html(cnt-1);
                cnt_item.animate({"opacity":1},200)
            }else{
                $(".compare_catalog_caption.active").remove();
                var new_item=$(".compare_catalog_caption").first();
                new_item.addClass("active");
                var rel_new_item=new_item.attr("rel");

                $(".compare_catalog_block").hide();
                $(".compare_catalog_block[rel='"+rel_new_item+"']").fadeIn(200);
            }
            var total_compare_product=$(".compare_product").length;
            if(total_compare_product){
                var left_products=products.find(".compare_product").length;
                if(left_products==1){
                    //console.log(left_products);
                    var check=products.closest(".compare_catalog_block").find(".check_compare");
                    check.prop("checked",false);
                    check.attr("disabled","disabled");
                    check.parent().addClass("_unactive");
                }
                checkCompare();
            }else{
                $(".compare_footer").removeClass("active");
                $(".compare_footer_empty").removeClass("active");
                $(".compare_link").addClass("_empty");

            }
        });
    });

    $(".check_compare").change(function(){
        checkCompare();
    });

    $(".compare_catalog_caption").click(function(){
        var rel=$(this).attr("rel");
        $(".compare_catalog_caption").removeClass("active");
        $(this).addClass("active");
        $(".compare_catalog_block").hide();
        $(".compare_catalog_block[rel='"+rel+"']").fadeIn(200);
        setRightHeight();
    });

    $(".compare_caption").click(function(){
        var rel=$(this).attr("rel");
        if($(this).hasClass("_hide")){
            $(this).removeClass("_hide")
            $(".compare_blocks[rel='"+rel+"']").slideDown(200)
        }else{
            $(this).addClass("_hide");
            $(".compare_blocks[rel='"+rel+"']").slideUp(200)
        }
    })
    $('.right_compare').scroll(function(){
        var lscroll=$(this).scrollLeft()*1;
        $(this).find(".compare_product_header").each(function(){
            $(this).css({"margin-left":-lscroll})
        });
    });
    $('.right_compare').mousewheel(function(e, delta) {
        
        var prev_scroll=this.scrollLeft;
        this.scrollLeft -= (delta * 40);
        var next_scroll=this.scrollLeft;
        
        var lscroll=$(this).scrollLeft()*1;
        $(this).find(".compare_product_header").each(function(){
            $(this).css({"margin-left":-lscroll})
        });

        if(prev_scroll!=next_scroll){
            e.preventDefault();
        }
        
    });

    function copytext(el) {
        var $tmp = $("<input>");
        $("body").append($tmp);
        $tmp.val($(el).text()).select();
        document.execCommand("copy");
        $tmp.remove();
    } 
    $("#permanent_link_button").click(function(){

        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'compare-copy');
        }

        var ttl1=$(this).text();
        var ttl2=$(this).attr("data-title");
        //$(this).attr("data-title",ttl1);
        var itm=$(this).children("span");
        itm.css({"opacity":0})
        itm.html(ttl2)
        itm.animate({"opacity":1},200)
        
        //var href=$("#permanent_link_button").attr("href");
        var href=document.location;
        var compare_str=$.cookie('compare');
        var compare_arr=JSON.parse(compare_str);
        var comp_link=href+"?comp_items="+compare_arr.join(",");
        
        ///$("#permanent_link").children("a").attr("href",comp_link)

        var $tmp = $("<input>");
            $("body").append($tmp);
            $tmp.val(comp_link).select();
            document.execCommand("copy");
            $tmp.remove();
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'compare-copy');
        }
        setTimeout(
            function() 
            {
                itm.css({"opacity":0});
                itm.html(ttl1);
                itm.animate({"opacity":1},200);
            }, 3000);
    });

})