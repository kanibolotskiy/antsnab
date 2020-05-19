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
                                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                                    <?php if ($error_name) { ?>
                                        <div class="text-danger"><?php echo $error_name; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-text"><?php echo $entry_text; ?></label>
                                <div class="col-sm-10">
                                    <textarea id="input-description" name="text" cols="60" rows="8" placeholder="<?php echo $entry_text; ?>" id="input-text" class="form-control summernote"><?php echo $text; ?></textarea>
                                    
                                    <?php if ($error_text) { ?>
                                        <div class="text-danger"><?php echo $error_text; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-shorttext"><?php echo $entry_shorttext; ?></label>
                                <div class="col-sm-10">
                                    <textarea id="input-description" name="shorttext" cols="60" rows="8" placeholder="<?php echo $entry_shorttext; ?>" id="input-shorttext" class="form-control summernote"><?php echo $shorttext; ?></textarea>
                                    <?php if ($error_text) { ?>
                                        <div class="text-danger"><?php echo $error_text; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="table-responsive">
                                    <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
                                    <div class="col-sm-10">
                                        <table class="table table-striped table-bordered table-hover">
                                            
                                            <tbody>
                                                <tr>
                                                    <td class="text-left"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb_image; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" /></td>
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
                                                    <td class="text-left"><a href="" id="thumb-banner" data-toggle="banner" class="img-thumbnail"><img src="<?php echo $thumb_banner; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="banner" value="<?php echo $banner; ?>" id="input-banner" /></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-date-start"><?php echo $entry_date_start; ?></label>
                                <div class="col-sm-3">
                                    <div class="input-group datetime">
                                        <input type="text" name="date_start" value="<?php echo $date_start; ?>" placeholder="<?php echo $entry_date_start; ?>" data-date-format="YYYY-MM-DD HH:mm:ss" id="input-date-start" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-date-end"><?php echo $entry_date_end; ?></label>
                                <div class="col-sm-3">
                                    <div class="input-group datetime">
                                        <input type="text" name="date_end" value="<?php echo $date_end; ?>" placeholder="<?php echo $entry_date_end; ?>" data-date-format="YYYY-MM-DD HH:mm:ss" id="input-date-end" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                                <div class="col-sm-10">
                                    <select name="status" id="input-status" class="form-control">
                                        <?php if ($status) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
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
                            <div class="product_used_item <?php echo isset($productAccia[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?></div>
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
                                    <div class="product_used_item <?php echo isset($productAccia[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?></div>
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