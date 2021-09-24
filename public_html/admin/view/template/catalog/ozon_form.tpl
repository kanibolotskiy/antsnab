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
                    <!--
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                        <li class=""><a href="#tab-products" data-toggle="tab"><?php echo $tab_products; ?></a></li>
                    </ul>
                    -->
                    
                    <div class="tab-content">
                        
                        
                            

<div class="wrap_accia_products">
    <input name="products_change" id="products_change" type="hidden"/>
    <input name="products" id="products" type="hidden"/>

    <table class="ozon_table">
        <thead>
            <tr>
                <th>Наименование</th>
                <th>Код Ozon</th>
                <th>Упаковка</th>
                <th>Активно</th>
            </tr>
        </thead>
        <?php foreach($categories_tree as $category){?>
            <tr class="ozon_catname1"><td colspan="4"><?=$category["name"]?></td></tr>

            <?php if(isset($category["list"])){ ?>
                <?php foreach($category["list"] as $category_item){?>
                    <tr class="ozon_catname2"><td colspan="4"><?=$category_item['name']?></td></tr>
                    <?php if(isset($products[$category_item["category_id"]])){ foreach($products[$category_item["category_id"]] as $product){?>
                        <tr>
                            <td class="ozon_product2">
                                <label for="ozon_flag_<?=$product['product_id']?>"><?php echo $product["name"];?></label>
                            </td>
                            <td><input class="ischange_ozon" type="text" name="ozon_code[<?=$product['product_id']?>]" value="<?=$product['ozon_code']?>" /></td>
                            <td><input class="ischange_ozon" type="text" name="ozon_count[<?=$product['product_id']?>]" value="<?=$product['ozon_count']?>"/></td>
                            <td>
                                <input class="ozon_change" type="hidden" name="ozon_change[<?=$product['product_id']?>]"/>
                                <input <?=$product['ozon_flag']?'checked':''?> value="1" class="ischange_ozon" id="ozon_flag_<?=$product['product_id']?>" type="checkbox" name="ozon_flag[<?=$product['product_id']?>]"/>
                            </td>
                        </tr>
                    <?php }}?>
                    <?php if(isset($category_item["list"])){ ?>
                        <?php foreach($category_item["list"] as $category_item2){?>
                            <tr class="ozon_catname2"><td colspan="3"><?=$category_item2['name']?></td></tr>
                            <?php if(isset($products[$category_item2["category_id"]])){ foreach($products[$category_item2["category_id"]] as $product){?>
                                <tr>
                                    <td class="ozon_product2">
                                        <label for="ozon_flag_<?=$product['product_id']?>"><?php echo $product["name"];?></label>
                                    </td>
                                    <td><input class="ischange_ozon" type="text" name="ozon_code[<?=$product['product_id']?>]" value="<?=$product['ozon_code']?>"/></td>
                                    <td><input class="ischange_ozon" type="text" name="ozon_count[<?=$product['product_id']?>]" value="<?=$product['ozon_count']?>"/></td>
                                    <td>
                                        <input class="ozon_change" type="hidden" name="ozon_change[<?=$product['product_id']?>]"/>
                                        <input <?=$product['ozon_flag']?'checked':''?> value="1" class="ischange_ozon" id="ozon_flag_<?=$product['product_id']?>" type="checkbox" name="ozon_flag[<?=$product['product_id']?>]"/>
                                    </td>
                                </tr>
                            <?php }}?>
                            
                        <?php }?>
                    <?php }?>
                <?php }?>
            <?php }?>
        <?php }?>
    </table>




                        </div>
                    </div>
                        
                </form>
            </div>
        </div>
    </div>
    
    

  </div>

  
<script type="text/javascript"><!--
    /*
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
    */
    $(document).ready(function(){
        $(".ischange_ozon").change(function(){
            $(this).closest("tr").find(".ozon_change").val(1);
        });
    })
    
//--></script>  
<script type="text/javascript"><!--
<?php if ($ckeditor) { ?>
    <?php foreach ($languages as $language) { ?>
        ckeditorInit('input-content', getURLVar('token'));
    <?php } ?>
<?php } ?>
//--></script>
<?php echo $footer; ?>