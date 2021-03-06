<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-review" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-review" class="form-horizontal">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                        <li class=""><a href="#tab-products" data-toggle="tab"><?php echo $tab_products; ?></a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-title"><?php echo $entry_title; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="title" value="<?php echo $title; ?>" placeholder="<?php echo $entry_title; ?>" id="input-title" class="form-control" />
                                    <?php if ($error_title) { ?>
                                        <div class="text-danger"><?php echo $error_title; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-meta_title"><?php echo $entry_meta_title; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="meta_title" value="<?php echo $meta_title; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta_title" class="form-control" />
                                    <?php if ($error_meta_title) { ?>
                                        <div class="text-danger"><?php echo $error_meta_title; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-meta_h1"><?php echo $entry_meta_h1; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="meta_h1" value="<?php echo $meta_h1; ?>" placeholder="<?php echo $entry_meta_h1; ?>" id="input-meta_h1" class="form-control" />
                                    <?php if ($error_meta_h1) { ?>
                                        <div class="text-danger"><?php echo $error_meta_h1; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-description"><?php echo $entry_description; ?></label>
                                <div class="col-sm-10">
                                    <textarea id="input-description" name="description" cols="60" rows="8" placeholder="<?php echo $entry_description; ?>" id="input-description" class="form-control summernote"><?php echo $description; ?></textarea>
                                    
                                    <?php if ($error_description) { ?>
                                        <div class="text-danger"><?php echo $error_description; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-shorttext"><?php echo $entry_shorttext; ?></label>
                                <div class="col-sm-10">
                                    <textarea id="input-description" name="shorttext" cols="60" rows="8" placeholder="<?php echo $entry_shorttext; ?>" id="input-shorttext" class="form-control"><?php echo $shorttext; ?></textarea>
                                    <?php if ($error_shorttext) { ?>
                                        <div class="text-danger"><?php echo $error_shorttext; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-meta_description"><?php echo $entry_meta_description; ?></label>
                                <div class="col-sm-10">
                                    <textarea id="input-meta_description" name="meta_description" cols="60" rows="8" placeholder="<?php echo $meta_description; ?>" id="input-meta_description" class="form-control"><?php echo $meta_description; ?></textarea>
                                    <?php if ($error_meta_description) { ?>
                                        <div class="text-danger"><?php echo $error_meta_description; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-meta_keyword"><?php echo $entry_meta_keyword; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="meta_keyword" value="<?php echo $meta_keyword; ?>" placeholder="<?php echo $entry_meta_keyword; ?>" id="input-meta_keyword" class="form-control" />
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="table-responsive">
                                    <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
                                    <div class="col-sm-10">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td class="text-left"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb_image; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                                    <input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" /></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="table-responsive">
                                    <label class="col-sm-2 control-label" for="input-banner"><?php echo $entry_banner; ?></label>
                                    <div class="col-sm-10">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td class="text-left">
                                                        <a href="" id="thumb-banner" data-toggle="image" class="img-thumbnail">
                                                            <img src="<?php echo $thumb_banner; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                                                        </a>
                                                        <input type="hidden" name="banner" value="<?php echo $banner; ?>" id="input-banner" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-keyword"><?php echo $entry_keyword; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="keyword" value="<?php echo $keyword; ?>" placeholder="<?php echo $entry_keyword; ?>" id="input-keyword" class="form-control" />
                                </div>
                            </div>

                            
                        </div>
                        <div class="tab-pane" id="tab-products">
                            <input type="hidden" name="accia_products" id="accia_products" value="<?php echo $accia_products;?>"/>
                            <input type="hidden" name="accia_products_change" id="accia_products_change" value="0"/>
<!--
                            <input type="text" name="accia_categories" id="accia_categories" value="<?php echo $accia_categories;?>"/>
                            <input type="text" name="accia_categories_change" id="accia_categories_change" value="0"/>
-->
<div class="wrap_accia_products">
    <input type="hidden" name="change_products" id="change_products" value="0"/>
    <?php foreach($categories_tree as $category){?>
        <div class="accia_catalog_row acc_cat_caption" rel="<?php echo $category['category_id'];?>">
            <div class="accia_catalog_left">
                <div class="accia_column_category_caption"><?php echo $category["name"];?></div>
            </div>
            <div class="accia_catalog_right"></div>
        </div>
        <?php if(isset($category["list"])){ ?>
            <div class="subcat_wrapper" rel="<?php echo $category['category_id'];?>">
            <?php foreach($category["list"] as $category_item){?>
                
                <div class="accia_catalog_row acc_cat_caption" rel="<?php echo $category_item['category_id'];?>">
                    <div class="accia_catalog_left">
                        <div class="accia_column_subcategory_caption"><?php echo $category_item["name"];?></div>
                    </div>
                    
                    <div class="accia_catalog_right">
                        <?php if(isset($products[$category_item["category_id"]])){ foreach($products[$category_item["category_id"]] as $product){?>
                            <div class="product_discount_item <?php echo isset($productAccia[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?>
                                <input value="<?php echo isset($productAccia[$product['product_id']])?$productAccia[$product['product_id']]:""; ?>" step="0.01" min="0" max="100" type="number" class="dis_percent" name="discount[<?php echo $product['product_id'];?>]"/>
                                <div class="product_discount_info">
                                    <div class="product_discount_line _active">
                                        <span class="product_discount_line_caption">Цена:</span> <span class="prod_item_price" data-price="<?=$product['price']?>"><?=number_format($product['price'],2,"."," ")?></span> / <span class="prod_item_priceopt" data-price="<?=$product['price_wholesale']?>"><?=number_format($product['price_wholesale'],2,"."," ")?></span>
                                    </div>
                                    <div class="product_discount_line product_discount_line_sale <?php echo isset($productAccia[$product['product_id']])?"_active":""; ?>">
                                        <span class="product_discount_line_caption">Цена без скидки:</span> <span class="prod_item_price_old">0</span> / <span class="prod_item_priceopt_old"></span>
                                    </div>
                                </div>
                            </div>
                        <?php }}?>
                    </div>
                </div>
                <?php if(isset($category_item["list"])){ ?>
                    <div class="subcat_wrapper" rel="<?php echo $category_item['category_id'];?>">
                        <?php foreach($category_item["list"] as $category_item_child){?>
                        <div class="accia_catalog_row">
                            <div class="accia_catalog_left">
                                <div class="accia_column_subcategory_caption _sub"><?php echo $category_item_child["name"];?></div>
                            </div>
                            <div class="accia_catalog_right">
                                <?php if(isset($products[$category_item_child["category_id"]])){ foreach($products[$category_item_child["category_id"]] as $product){?>
                                    <div class="product_discount_item <?php echo isset($productAccia[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?>
                                        <input value="<?php echo isset($productAccia[$product['product_id']])?$productAccia[$product['product_id']]:""; ?>" step="0.01" min="0" max="100" type="number" class="dis_percent" name="discount[<?php echo $product['product_id'];?>]" />
                                        <div class="product_discount_info">
                                            <div class="product_discount_line _active">
                                                <span class="product_discount_line_caption">Цена:</span> <span class="prod_item_price" data-price="<?=$product['price']?>"><?=number_format($product['price'],2,"."," ")?></span> / <span class="prod_item_priceopt" data-price="<?=$product['price_wholesale']?>"><?=number_format($product['price_wholesale'],2,"."," ")?></span>
                                            </div>
                                            <div class="product_discount_line product_discount_line_sale <?php echo isset($productAccia[$product['product_id']])?"_active":""; ?>">
                                                <span class="product_discount_line_caption">Цена без скидки:</span> <span class="prod_item_price_old">0</span> / <span class="prod_item_priceopt_old"></span>
                                            </div>
                                        </div>
                                    </div>
                                <?php }}?>
                            </div>
                        </div>
                        <?php }?>
                    </div>
                <?php }?>
            <?php }?>
            </div>
        <?php }?>
    <?php }?>
</div>
                                
                            
                        </div>
                    </div>
                    
                    
                </form>
            </div>
        </div>
    </div>
    <script>
    /*-----------------------------------*/
    function number_format(number,decimals,dec_point,thousands_sep) {
        number  = number*1;//makes sure `number` is numeric value
        var str = number.toFixed(decimals?decimals:0).toString().split('.');
        var parts = [];
        for ( var i=str[0].length; i>0; i-=3 ) {
            parts.unshift(str[0].substring(Math.max(0,i-3),i));
        }
        str[0] = parts.join(thousands_sep?thousands_sep:',');
        return str.join(dec_point?dec_point:'.');
    }
    /*-----------------------------------*/
    function setOldPrice(itm){
        var itm_price=itm.find(".prod_item_price").attr("data-price")*1;
        var itm_priceopt=itm.find(".prod_item_priceopt").attr("data-price")*1;
        var itm_discount=itm.find(".dis_percent").val()*1;

        if(itm_discount>0){
            var old_price=itm_price+itm_price*itm_discount/(100-itm_discount);
            var old_priceopt=itm_priceopt+itm_priceopt*itm_discount/(100-itm_discount);

            var old_price_str=number_format(old_price,2,"."," ");
            var old_priceopt_str=number_format(old_priceopt,2,"."," ");

            itm.find(".prod_item_price_old").html(old_price_str);
            itm.find(".prod_item_priceopt_old").html(old_priceopt_str);
            itm.find(".product_discount_line_sale").addClass("_active");
        }else{
            itm.find(".product_discount_line_sale").removeClass("_active");
        }
        
    }
    $(document).ready(function(){
        $(".dis_percent").keyup(function(e){
            if(e.keyCode==27){
                $(this).val("0");
                $(this).parent().removeClass("_active");
                $("#change_products").val(1);
                $(this).closest(".product_discount_item").removeClass("show_info");
            }
            //console.log(e.keyCode);
        });
        $(".dis_percent").keyup(function(){
            var val_perc=$(this).val()*1;
            if(val_perc){
                $(this).parent().addClass("_active");
            }else{
                $(this).parent().removeClass("_active");
            }
            $("#change_products").val(1);
            setOldPrice($(this).closest(".product_discount_item"))
        });
        /*
        $(".dis_percent").change(function(){
            var val_perc=$(this).val()*1;
            if(val_perc){
                $(this).parent().addClass("_active");
            }else{
                $(this).parent().removeClass("_active");
            }
            $("#change_products").val(1);
            setOldPrice($(this).closest(".product_discount_item"))
        });
        */

        $(document).click( function(e){
            if ( $(e.target).closest('.product_discount_item').length ) {
                return;
            }
            $(".product_discount_item").removeClass("show_info");
        });
        $(".product_discount_item._active").each(function(){
            setOldPrice($(this));
            $(this).parents(".subcat_wrapper").show();
        });
        $(".product_discount_item").click(function(e){
            if ( $(e.target).closest('.product_discount_info').length ) {
                return;
            }
            //if(!$(this).hasClass("show_info")){
                $(".product_discount_item").removeClass("show_info");
                $(this).addClass("show_info");
            //}
            
        });
        $(".product_discount_info").click(function(){
            $(this).parent().removeClass("show_info");
        });

        $(".acc_cat_caption").click(function(){
            var rel=$(this).attr("rel");
            $(".subcat_wrapper[rel='"+rel+"']").slideToggle(200);
            $(this).toggleClass("active");
        });
    });
    /*
        function products_selected(){
            var products_used=[];
            $(".product_used_item._active").each(function(){
                var product_id=$(this).attr("rel");
                products_used.push(product_id);
            });
            $("#accia_products_change").val(1);
            $("#accia_products").val(products_used.join(","));
        }
        $(document).ready(function(){
            $(".product_used_item._active").each(function(){
                $(this).parents(".subcat_wrapper").show();
                //itm.show();
                //itm.closest(".subcat_wrapper").show();
            });

            $(".product_used_item").click(function(){
                $(this).toggleClass("_active");
                products_selected();
            });
            $(".acc_cat_caption").click(function(){
                var rel=$(this).attr("rel");
                $(".subcat_wrapper[rel='"+rel+"']").slideToggle(200);
                $(this).toggleClass("active");
            });
        });
    */   
    </script>


    <script type="text/javascript"><!--
  <?php if ($ckeditor) { ?>
      ckeditorInit('input-description', getURLVar('token'));
  <?php } ?>

//--></script>
        <script type="text/javascript"><!--
    $('.datetime').datetimepicker({
            pickDate: true,
            pickTime: false
            });
                   //--></script>
                <script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
                'source': function (request, response) {
                    $.ajax({
                        url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                        dataType: 'json',
                        success: function (json) {
                            response($.map(json, function (item) {
                                return {
                                    label: item['name'],
                                    value: item['product_id']
                                }
                            }));
                        }
                    });
                },
                'select': function (item) {
                    $('input[name=\'product\']').val(item['label']);
                    $('input[name=\'product_id\']').val(item['value']);
                }
            });
            //--></script></div>
                <?php echo $footer; ?>