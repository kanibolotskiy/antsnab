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
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-video" class="form-horizontal">
                   <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                        <li class=""><a href="#tab-products" data-toggle="tab"><?php echo $tab_products; ?></a></li>
                    </ul>
                    
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="name" value="<?php echo isset($name) ? $name : ''; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-sort_order"><?php echo $entry_sort_order; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="sort_order" value="<?php echo isset($sort_order) ? $sort_order : ''; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort_order" class="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-products">
                            

<div class="wrap_accia_products">
    <input name="products_change" id="products_change" type="hidden"/>
    <input name="products" id="products" type="hidden"/>

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
                            <div class="product_used_item <?php echo isset($productUsed[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?></div>
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
                                    <div class="product_used_item <?php echo isset($productUsed[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?></div>
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
    
    

  </div>

  
<script type="text/javascript"><!--
    function products_selected(){
        var products_used=[];
        $(".product_used_item._active").each(function(){
            var product_id=$(this).attr("rel");
            products_used.push(product_id);
        });
        $("#products_change").val(1);
        $("#products").val(products_used.join(","));
    }
    $(document).ready(function(){
        $(".accia_column_subcategory_caption").click(function(){
            if($(this).hasClass("active")){
                $(this).removeClass("active");
                $(this).closest(".accia_catalog_row").find(".product_used_item").removeClass("_active");
            }else{
                $(this).addClass("active");
                $(this).closest(".accia_catalog_row").find(".product_used_item").addClass("_active");
            }
            products_selected();
        });

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
//--></script>  
<script type="text/javascript"><!--
<?php if ($ckeditor) { ?>
    <?php foreach ($languages as $language) { ?>
        ckeditorInit('input-content', getURLVar('token'));
    <?php } ?>
<?php } ?>
//--></script>
<?php echo $footer; ?>