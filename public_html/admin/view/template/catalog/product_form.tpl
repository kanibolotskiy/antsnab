<?php echo $header; ?>
<?php echo $column_left; ?>


<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if (isset($product_page)) { ?><a class="btn btn-info" href="<?php echo $product_page; ?>" target="_blank" data-toggle="tooltip" title="<?php echo $button_view; ?>"><i class="fa fa-eye"></i></a><?php } ?>
                <button type="submit" form="form-product" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-product" class="form-horizontal">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                        <li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>

                        <li><a href="#tab-prodproperties" data-toggle="tab"><?php echo $tab_prodproperties; ?></a></li>
                        <li><a href="#tab-tabs" data-toggle="tab"><?php echo $tab_tabs; ?></a></li>
                        <li><a href="#tab-prices" data-toggle="tab"><?php echo $tab_prices; ?></a></li>
                        <li><a href="#tab-calcs" data-toggle="tab"><?php echo $tab_calcs; ?></a></li>

                        <li><a href="#tab_iden" data-toggle="tab"><?php echo $tab_iden; ?></a></li>
                        <li><a href="#tab_analog" data-toggle="tab"><?php echo $tab_analog; ?></a></li>
                        <li><a href="#tab_accompany" data-toggle="tab"><?php echo $tab_accompany; ?></a></li>

                        <li style="display:none"><a href="#tab-attribute" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
                        <li style="display:none"><a href="#tab-option" data-toggle="tab"><?php echo $tab_option; ?></a></li>
                        <li style="display:none"><a href="#tab-recurring" data-toggle="tab"><?php echo $tab_recurring; ?></a></li>

                        <li style="display:none"><a href="#tab-discount" data-toggle="tab"><?php echo $tab_discount; ?></a></li>
                        <li style="display:none"><a href="#tab-special" data-toggle="tab"><?php echo $tab_special; ?></a></li>
                        <li><a href="#tab-image" data-toggle="tab"><?php echo $tab_image; ?></a></li>
                        <li><a href="#tab-filter" data-toggle="tab"><?php echo $tab_filter; ?></a></li>
                        <li style="display:none"><a href="#tab-reward" data-toggle="tab"><?php echo $tab_reward; ?></a></li>
                        <!--<li><a href="#tab-design" data-toggle="tab"><?php echo $tab_design; ?></a></li>-->
                        
                        <!--
                        <li style="display:none"><a href="#tab-reward" data-toggle="tab"><?php echo $tab_reward; ?></a></li>
                        -->



                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <ul class="nav nav-tabs" id="language">
                                <?php foreach ($languages as $language) { ?>
                                    <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                                <?php } ?>
                            </ul>
                            <div class="tab-content">
                                <?php foreach ($languages as $language) { ?>
                                    <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                                        <div class="form-group required">
                                            <label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name; ?></label>
                                            <div class="col-sm-10">
                                                <input type="text" name="product_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                                                <?php if (isset($error_name[$language['language_id']])) { ?>
                                                    <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                                            <div class="col-sm-10">
                                                <textarea name="product_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" data-lang="<?php echo $lang; ?>" class="form-control summernote">
                                                    <?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['description'] : ''; ?>
                                                </textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-description_mini<?php echo $language['language_id']; ?>"><?php echo $entry_description_mini; ?></label>
                                            <div class="col-sm-10">
                                                <textarea name="product_description_mini[<?php echo $language['language_id']; ?>]"
                                                          placeholder="<?php echo $entry_description_mini; ?>"
                                                          id="input-description_mini<?php echo $language['language_id']; ?>" data-lang="<?php echo $lang; ?>"
                                                          class="form-control summernote">
                                                            <?php if(isset($product_description[$language['language_id']])): ?>
                                                                <?php if(isset($product_description[$language['language_id']]['description_mini'])): ?>
                                                                    <?=$product_description[$language['language_id']]['description_mini']?>
                                                                <?php endif; ?>
                                                            <?php endif; ?>
                                                </textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-meta-title<?php echo $language['language_id']; ?>"><?php echo $entry_meta_title; ?></label>
                                            <div class="col-sm-10">
                                                <input type="text" name="product_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_title'] : ''; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title<?php echo $language['language_id']; ?>" class="form-control" />
                                                <?php if (isset($error_meta_title[$language['language_id']])) { ?>
                                                    <div class="text-danger"><?php echo $error_meta_title[$language['language_id']]; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-meta-h1<?php echo $language['language_id']; ?>"><?php echo $entry_meta_h1; ?></label>
                                            <div class="col-sm-10">
                                                <input type="text" name="product_description[<?php echo $language['language_id']; ?>][meta_h1]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_h1'] : ''; ?>" placeholder="<?php echo $entry_meta_h1; ?>" id="input-meta-h1<?php echo $language['language_id']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-meta-description<?php echo $language['language_id']; ?>"><?php echo $entry_meta_description; ?></label>
                                            <div class="col-sm-10">
                                                <textarea name="product_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-meta-keyword<?php echo $language['language_id']; ?>"><?php echo $entry_meta_keyword; ?></label>
                                            <div class="col-sm-10">
                                                <textarea name="product_description[<?php echo $language['language_id']; ?>][meta_keyword]" rows="5" placeholder="<?php echo $entry_meta_keyword; ?>" id="input-meta-keyword<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-tag<?php echo $language['language_id']; ?>"><span data-toggle="tooltip" title="<?php echo $help_tag; ?>"><?php echo $entry_tag; ?></span></label>
                                            <div class="col-sm-10">
                                                <input type="text" name="product_description[<?php echo $language['language_id']; ?>][tag]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['tag'] : ''; ?>" placeholder="<?php echo $entry_tag; ?>" id="input-tag<?php echo $language['language_id']; ?>" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-video<?php echo $language['language_id']; ?>"><span><?php echo $entry_video; ?></span></label>
                                            <div class="col-sm-10">
                                                <input type="text" name="product_description[<?php echo $language['language_id']; ?>][video]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['video'] : ''; ?>" placeholder="<?php echo $entry_video; ?>" id="input-video" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-video<?php echo $language['language_id']; ?>"><span><?php echo $entry_video_preview; ?></span></label>
                                            <div class="col-sm-10">
                                                <a href="" id="thumb-video_preview" data-toggle="image" class="img-thumbnail">
                                                    <img id="image-video_preview" src="../image/<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['video_preview'] : ''; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>">
                                                </a>
                                                <input type="hidden" name="product_description[<?php echo $language['language_id']; ?>][video_preview]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['video_preview'] : ''; ?>" id="input-video_preview">
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-disseo">
                                                <?php echo $entry_disseo; ?>
                                            </label>
                                            <div class="col-sm-1">
                                            <div class="checkbox">
                                                <label>
                                                <?php if($disseo) { ?>
                                                <input  type="checkbox" name="disseo" value="1" checked="checked" id="input-disseo" />
                                                <?php } else { ?>
                                                <input type="checkbox" name="disseo" value="1" id="input-disseo" />
                                                <?php } ?>
                                                &nbsp; </label>
                                            </div>
                                            </div>

                                        </div>



                                    </div>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-data">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-model"><?php echo $entry_model; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="model" value="<?php echo $model; ?>" placeholder="<?php echo $entry_model; ?>" id="input-model" class="form-control" />
                                    <?php if ($error_model) { ?>
                                        <div class="text-danger"><?php echo $error_model; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-manufacturer"><?php echo $entry_manufacturer; ?></label>
                                <div class="col-sm-10">
                                    <select id="input-manufacturer" name="manufacturer_id" class="form-control">
                                        <option value="0" selected="selected"><?php echo $text_none; ?></option>
                                        <?php foreach ($manufacturers as $manufacturer) { ?>
                                            <?php if ($manufacturer['manufacturer_id'] == $manufacturer_id) { ?>
                                                <option value="<?php echo $manufacturer['manufacturer_id']; ?>" selected="selected"><?php echo $manufacturer['name']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $manufacturer['manufacturer_id']; ?>"><?php echo $manufacturer['name']; ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-sku"><span data-toggle="tooltip" title="<?php echo $help_sku; ?>"><?php echo $entry_sku; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="sku" value="<?php echo $sku; ?>" placeholder="<?php echo $entry_sku; ?>" id="input-sku" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group<?php echo ($hide_upc == true) ? ' hide' : ''; ?>">
                                <label class="col-sm-2 control-label" for="input-upc"><span data-toggle="tooltip" title="<?php echo $help_upc; ?>"><?php echo $entry_upc; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="upc" value="<?php echo $upc; ?>" placeholder="<?php echo $entry_upc; ?>" id="input-upc" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group<?php echo ($hide_ean == true) ? ' hide' : ''; ?>">
                                <label class="col-sm-2 control-label" for="input-ean"><span data-toggle="tooltip" title="<?php echo $help_ean; ?>"><?php echo $entry_ean; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="ean" value="<?php echo $ean; ?>" placeholder="<?php echo $entry_ean; ?>" id="input-ean" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group<?php echo ($hide_jan == true) ? ' hide' : ''; ?>">
                                <label class="col-sm-2 control-label" for="input-jan"><span data-toggle="tooltip" title="<?php echo $help_jan; ?>"><?php echo $entry_jan; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="jan" value="<?php echo $jan; ?>" placeholder="<?php echo $entry_jan; ?>" id="input-jan" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group<?php echo ($hide_isbn == true) ? ' hide' : ''; ?>">
                                <label class="col-sm-2 control-label" for="input-isbn"><span data-toggle="tooltip" title="<?php echo $help_isbn; ?>"><?php echo $entry_isbn; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="isbn" value="<?php echo $isbn; ?>" placeholder="<?php echo $entry_isbn; ?>" id="input-isbn" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group<?php echo ($hide_mpn == true) ? ' hide' : ''; ?>">
                                <label class="col-sm-2 control-label" for="input-mpn"><span data-toggle="tooltip" title="<?php echo $help_mpn; ?>"><?php echo $entry_mpn; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="mpn" value="<?php echo $mpn; ?>" placeholder="<?php echo $entry_mpn; ?>" id="input-mpn" class="form-control" />
                                </div>
                            </div>
                            <!--
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-location"><?php echo $entry_location; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="location" value="<?php echo $location; ?>" placeholder="<?php echo $entry_location; ?>" id="input-location" class="form-control" />
                                </div>
                            </div>
                            -->
                            <div style="display:none">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-tax-class"><?php echo $entry_tax_class; ?></label>
                                    <div class="col-sm-10">
                                        <select name="tax_class_id" id="input-tax-class" class="form-control">
                                            <option value="0"><?php echo $text_none; ?></option>
                                            <?php foreach ($tax_classes as $tax_class) { ?>
                                                <?php if ($tax_class['tax_class_id'] == $tax_class_id) { ?>
                                                    <option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-quantity"><?php echo $entry_quantity; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="quantity" value="<?php echo $quantity; ?>" placeholder="<?php echo $entry_quantity; ?>" id="input-quantity" class="form-control" />
                                </div>
                            </div>
                            <div style="display:none">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-minimum"><span data-toggle="tooltip" title="<?php echo $help_minimum; ?>"><?php echo $entry_minimum; ?></span></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="minimum" value="<?php echo $minimum; ?>" placeholder="<?php echo $entry_minimum; ?>" id="input-minimum" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-subtract"><?php echo $entry_subtract; ?></label>
                                    <div class="col-sm-10">
                                        <select name="subtract" id="input-subtract" class="form-control">
                                            <?php if ($subtract) { ?>
                                                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                                <option value="0"><?php echo $text_no; ?></option>
                                            <?php } else { ?>
                                                <option value="1"><?php echo $text_yes; ?></option>
                                                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-stock-status"><span data-toggle="tooltip" title="<?php echo $help_stock_status; ?>"><?php echo $entry_stock_status; ?></span></label>
                                    <div class="col-sm-10">
                                        <select name="stock_status_id" id="input-stock-status" class="form-control">
                                            <?php foreach ($stock_statuses as $stock_status) { ?>
                                                <?php if ($stock_status['stock_status_id'] == $stock_status_id) { ?>
                                                    <option value="<?php echo $stock_status['stock_status_id']; ?>" selected="selected"><?php echo $stock_status['name']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $stock_status['stock_status_id']; ?>"><?php echo $stock_status['name']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><?php echo $entry_shipping; ?></label>
                                    <div class="col-sm-10">
                                        <label class="radio-inline">
                                            <?php if ($shipping) { ?>
                                                <input type="radio" name="shipping" value="1" checked="checked" />
                                                <?php echo $text_yes; ?>
                                            <?php } else { ?>
                                                <input type="radio" name="shipping" value="1" />
                                                <?php echo $text_yes; ?>
                                            <?php } ?>
                                        </label>
                                        <label class="radio-inline">
                                            <?php if (!$shipping) { ?>
                                                <input type="radio" name="shipping" value="0" checked="checked" />
                                                <?php echo $text_no; ?>
                                            <?php } else { ?>
                                                <input type="radio" name="shipping" value="0" />
                                                <?php echo $text_no; ?>
                                            <?php } ?>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-keyword"><span data-toggle="tooltip" title="<?php echo $help_keyword; ?>"><?php echo $entry_keyword; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="keyword" value="<?php echo $keyword; ?>" placeholder="<?php echo $entry_keyword; ?>" id="input-keyword" class="form-control" />
                                    <?php if ($error_keyword) { ?>
                                        <div class="text-danger"><?php echo $error_keyword; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div style="display:none">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-date-available"><?php echo $entry_date_available; ?></label>
                                    <div class="col-sm-3">
                                        <div class="input-group date">
                                            <input type="text" name="date_available" value="<?php echo $date_available; ?>" placeholder="<?php echo $entry_date_available; ?>" data-date-format="YYYY-MM-DD" id="input-date-available" class="form-control" />
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                            </span></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-length"><?php echo $entry_dimension; ?></label>
                                    <div class="col-sm-10">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <input type="text" name="length" value="<?php echo $length; ?>" placeholder="<?php echo $entry_length; ?>" id="input-length" class="form-control" />
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-length-class"><?php echo $entry_length_class; ?></label>
                                    <div class="col-sm-10">
                                        <select name="length_class_id" id="input-length-class" class="form-control">
                                            <?php foreach ($length_classes as $length_class) { ?>
                                                <?php if ($length_class['length_class_id'] == $length_class_id) { ?>
                                                    <option value="<?php echo $length_class['length_class_id']; ?>" selected="selected"><?php echo $length_class['title']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $length_class['length_class_id']; ?>"><?php echo $length_class['title']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-weight"><?php echo $entry_weight; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="weight" value="<?php echo $weight; ?>" placeholder="<?php echo $entry_weight; ?>" id="input-weight" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-weight-class"><?php echo $entry_weight_class; ?></label>
                                    <div class="col-sm-10">
                                        <select name="weight_class_id" id="input-weight-class" class="form-control">
                                            <?php foreach ($weight_classes as $weight_class) { ?>
                                                <?php if ($weight_class['weight_class_id'] == $weight_class_id) { ?>
                                                    <option value="<?php echo $weight_class['weight_class_id']; ?>" selected="selected"><?php echo $weight_class['title']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['title']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select>
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
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-category"><?php echo $entry_main_category; ?></label>
                                <div class="col-sm-10">
                                    <select id="main_category_id" name="main_category_id" class="form-control">
                                        <option value="0" selected="selected"><?php echo $text_none; ?></option>
                                        <?php foreach ($categories as $category) { ?>
                                            <?php if ($category['category_id'] == $main_category_id) { ?>
                                                <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-category"><?php echo $entry_category; ?></label>
                                <div class="col-sm-10">
                                    <div class="well well-sm" style="min-height: 150px;max-height: 500px;overflow: auto;padding-left:17px;">
                                        <table class="table table-striped">
                                            <?php foreach ($categories as $category) { ?>
                                                <tr>
                                                    <td class="checkbox cat_isseo_<?php echo $category['isseo'];?>" >
                                                        <label>
                                                            <?php if (in_array($category['category_id'], $product_category)) { ?>
                                                                <input type="checkbox" name="product_category[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                                                                <?php echo $category['name']; ?>
                                                            <?php } else { ?>
                                                                <input type="checkbox" name="product_category[]" value="<?php echo $category['category_id']; ?>" />
                                                                <?php echo $category['name']; ?>
                                                            <?php } ?>
                                                        </label>
                                                    </td>
                                                </tr>
                                            <?php } ?>
                                        </table>
                                    </div>
                                    <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
                                    </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-benefits"><?php echo $entry_benefits; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="benefits" value="" placeholder="<?php echo $entry_benefits; ?>" id="input-benefits" class="form-control" />
                                    <div id="product-benefits" class="well well-sm" style="height: 150px; overflow: auto;">
                                        <?php foreach ($product_benefits as $product_benefit) { ?>
                                            <div id="product-benefit<?php echo $product_benefit['benefit_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product_benefit['name_admin']; ?>
                                                <input type="hidden" name="product_benefit[]" value="<?php echo $product_benefit['benefit_id']; ?>" />
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-prices">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-price"><?php echo $entry_price; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="price" value="<?php echo $price; ?>" placeholder="<?php echo $entry_price; ?>" id="input-price" class="form-control" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-price_wholesale">
                                    <?php echo $entry_price_wholesale; ?>
                                </label>
                                <div class="col-sm-10">
                                    <input type="text" name="price_wholesale" value="<?php echo $price_wholesale; ?>" placeholder="<?php echo $entry_price_wholesale; ?>" id="input-price_wholesale" class="form-control" />
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-discount_percent">
                                    <?php echo $entry_discount_percent; ?>
                                </label>
                                <div class="col-sm-10">
                                    <input type="text" name="discount_percent" value="<?php echo $discount_percent; ?>" placeholder="<?php echo $entry_discount_percent; ?>" id="input-discount_percent" class="form-control" />
                                </div>
                            </div>

                            <!--
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-priceold"><?php echo $entry_priceold; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="priceold" value="<?php echo $priceold; ?>" placeholder="<?php echo $entry_priceold; ?>" id="input-priceold" class="form-control" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-price_wholesale">
                                    <?php echo $entry_price_wholesale; ?>
                                </label>
                                <div class="col-sm-10">
                                    <input type="text" name="price_wholesale" value="<?php echo $price_wholesale; ?>" placeholder="<?php echo $entry_price_wholesale; ?>" id="input-price_wholesale" class="form-control" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-price_wholesaleold">
                                    <?php echo $entry_price_wholesaleold; ?>
                                </label>
                                <div class="col-sm-10">
                                    <input type="text" name="price_wholesaleold" value="<?php echo $price_wholesaleold; ?>" placeholder="<?php echo $entry_price_wholesaleold; ?>" id="input-price_wholesaleold" class="form-control" />
                                </div>
                            </div>
                            -->

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-wholesale_threshold"><?php echo $entry_wholesale_threshold; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="wholesale_threshold" value="<?php echo $wholesale_threshold; ?>" placeholder="<?php echo $entry_wholesale_threshold; ?>" id="input-wholesale_threshold" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-mincount"><?php echo $entry_mincount; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="mincount" value="<?php echo $mincount; ?>" placeholder="<?php echo $entry_mincount; ?>" id="input-mincount" class="form-control" />
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="produnit_template_id">
                                    <?php echo $entry_produnit_template_id; ?>
                                </label>
                                <div class="col-sm-10">
                                    <select name="produnit_template_id"
                                            id="produnit_template_id" class="form-control">
                                        <option value="">Нет</option>
                                        <?php foreach ($produnitTemplates as $template) { ?>
                                            <?php if ($template['produnit_template_id'] == $produnit_template_id) { ?>
                                                <option
                                                    value="<?php echo $template['produnit_template_id']; ?>"
                                                    selected="selected">
                                                        <?php echo $template['name']; ?>
                                                </option>
                                            <?php } else { ?>
                                               <option
                                                    value="<?php echo $template['produnit_template_id']; ?>">
                                                        <?php echo $template['name']; ?>
                                                </option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-discount"><?php echo $entry_discount; ?></label>
                                <div class="col-sm-10">
                                    <select id="input-discount" name="discount" class="form-control">
                                        <option value="0" selected="selected"><?php echo $text_none; ?></option>
                                        <?php foreach ($discounts as $discount_itm) { ?>
                                            <?php if ($discount_itm['discount_id'] == $discount) { ?>
                                                <option value="<?php echo $discount_itm['discount_id']; ?>" selected="selected"><?php echo $discount_itm['name']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $discount_itm['discount_id']; ?>"><?php echo $discount_itm['name']; ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-calcs">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-calc_category"><?php echo $entry_calc_category; ?></label>
                                <div class="col-sm-10">
                                    <select id="input-calc_category" name="calc_category" class="form-control" disabled>
                                        <option value="0" selected="selected"><?php echo $text_none; ?></option>
                                        <?php foreach ($calcs as $calc_itm) { ?>
                                            <?php if ($calc_itm['calc_id'] == $calc_category_id) { ?>
                                                <option value="<?php echo $calc_itm['calc_id']; ?>" selected="selected"><?php echo $calc_itm['name']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $calc_itm['calc_id']; ?>"><?php echo $calc_itm['name']; ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-calc"><?php echo $entry_calc_product; ?></label>
                                <div class="col-sm-10">
                                    <select id="input-calc" name="calc" class="form-control">
                                        <option value="0" selected="selected"><?php echo $text_none; ?></option>
                                        <?php foreach ($calcs as $calc_itm) { ?>
                                            <?php if ($calc_itm['calc_id'] == $calc_product_id) { ?>
                                                <option value="<?php echo $calc_itm['calc_id']; ?>" selected="selected"><?php echo $calc_itm['name']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $calc_itm['calc_id']; ?>"><?php echo $calc_itm['name']; ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group show_calc show_calc_1 show_calc_2">
                                <label class="col-sm-2 control-label" for="input-consumption"><?php echo $entry_consumption; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="consumption" value="<?php echo $consumption; ?>" placeholder="<?php echo $entry_consumption; ?>" id="input-consumption" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group show_calc show_calc_3">
                                <label class="col-sm-2 control-label" for="input-calc_data1"><?php echo $entry_calc_data1; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="calc_data1" value="<?php echo $calc_data1; ?>" placeholder="<?php echo $entry_calc_data1; ?>" id="input-calc_data1" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group show_calc show_calc_4">
                                <label class="col-sm-2 control-label" for="input-calc_data2"><?php echo $entry_calc_data2; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="calc_data2" value="<?php echo $calc_data2; ?>" placeholder="<?php echo $entry_calc_data2; ?>" id="input-calc_data2" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group show_calc show_calc_4">
                                <label class="col-sm-2 control-label" for="input-calc_data3"><?php echo $entry_calc_data3; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="calc_data3" value="<?php echo $calc_data3; ?>" placeholder="<?php echo $entry_calc_data3; ?>" id="input-calc_data3" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group show_calc show_calc_5">
                                <label class="col-sm-2 control-label" for="input-calc_data4"><?php echo $entry_calc_data4; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="calc_data4" value="<?php echo $calc_data4; ?>" placeholder="<?php echo $entry_calc_data4; ?>" id="input-calc_data4" class="form-control" />
                                </div>
                            </div>

                        </div>

                        <!-- @task1 move somewhere styles-->
                        <style>
                            #tab-prodproperties input,
                            #tab-tabs input {
                                color: #000;
                            }
                        </style>
                        <script>
                            $(window).on('load', function(){
                                $('#main_category_id').on('change', function(){
                                   $('#tab-prodproperties table tbody').html('');
                                   $('#tab-prodtabs table tbody').html('');
                                });
                            });
                        </script>
                        <div class="tab-pane" id="tab-prodproperties">
                            <div class="form-group row">
                                <div class="col-sm-12">
                                    <p><?= $property_helptext ?></p>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-3 control-label" for="input-showInSummary">
                                    <span data-toggle="tooltip">
                                        <?php echo $entry_showInSummary; ?>
                                    </span>
                                </label>
                                <div class="col-sm-9">
                                  <div class="checkbox">
                                    <label>
                                      <?php if ($showInSummary) { ?>
                                      <input  type="checkbox" name="showInSummary" value="1" checked="checked" id="input-showInSummary" />
                                      <?php } else { ?>
                                      <input type="checkbox" name="showInSummary" value="1" id="input-showInSummary" />
                                      <?php } ?>
                                      &nbsp; </label>
                                  </div>
                                </div>
                            </div>
                            <table class="table table-bordered table-hover" >
                                <thead>
                                    <tr>
                                        <td style="width:40px;" class="text-center">
                                            <?= $property_column_sortorder ?>
                                        </td>
                                        <td style="width:75px;" class="text-center">
                                            <?= $property_column_showInSummary ?>
                                        </td>
                                        <td style="width:80px;" class="text-center">
                                            <?= $property_column_showInPreview ?>
                                        </td>
                                        <td class="text-center"><?= $property_column_name ?></td>
                                        <td class="text-center"><?= $property_column_defval ?></td>
                                        <td class="text-center"><?= $property_column_val ?></td>
                                        <td class="text-center"><?= $property_column_unit ?></td>
                                        <td style="width: 1px;" class="text-center"><?= $property_column_hide ?></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($prodproperties as $t): ?>
                                    <tr>
                                        <td>
                                            <?php $v = (null === $t['prod_sortOrder']) ? '' : $t['prod_sortOrder'] ?>
                                            <input name="prodproperties[<?=$t['category_prodproperty_id']?>][sortOrder]" placeholder="<?= $t['cat_sortOrder'] ?>" value="<?=$v ?>"/>
                                        </td>

                                        <td class="text-center">
                                            <?= ( (1 == $t['showInSummary'] ) ? $yes : $no ) ?>
                                        </td>
                                        <td class="text-center">
                                            <?= ( (1 == $t['showInProdPreview'] ) ? $yes : $no ) ?>
                                        </td>
                                        <td>
                                            <?= $t['cat_name'] ?>
                                        </td>
                                        <td>
                                            <?= $t['cat_default'] ?>
                                        </td>
                                        <td>
                                            <?php $v = (null == $t['prod_val']) ? '' : $t['prod_val'] ?>
                                            <input name="prodproperties[<?=$t['category_prodproperty_id']?>][val]" placeholder="<?= $t['cat_default'] ?>" value="<?= $v ?>"/>
                                        </td>
                                        <td>
                                            <?= $t['cat_unit'] ?>
                                        </td>
                                        <td style="width: 1px;" class="text-center">
                                            <?php if ($t['prod_hide'] == 1): ?>
                                                <input type="checkbox" checked name="prodproperties[<?=$t['category_prodproperty_id']?>][hide]" value="1"  class="form-control">
                                            <?php else: ?>
                                                <input type="checkbox"  name="prodproperties[<?=$t['category_prodproperty_id']?>][hide]" value="1"  class="form-control">
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <div class="tab-pane" id="tab-tabs">
                            <div class="form-group row">
                                <div class="col-sm-12">
                                    <p><?= $tab_helptext ?></p>
                                </div>
                            </div>
                            <table class="table table-bordered table-hover" >
                                <thead>
                                    <tr>
                                        <td style="width:40px;" class="text-center">
                                            <?= $tab_column_sortorder ?>
                                        </td>
                                        <td style="width:100px;"  class="text-center"><?= $tab_column_name ?></td>
                                        <td style="width:100px;"  class="text-center"><?= $tab_column_defval ?></td>
                                        <td class="text-center"><?= $tab_column_val ?></td>
                                        <td style="width: 1px;" class="text-center"><?= $tab_column_hide ?></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($prodtabs as $t): ?>
                                    <tr>
                                        <td>
                                            <?php $v = (null === $t['prod_sortOrder']) ? '' : $t['prod_sortOrder'] ?>
                                            <input style="width:40px" name="prodtabs[<?=$t['category_prodtab_id']?>][sortOrder]" placeholder="<?= $t['cat_sortOrder'] ?>" value="<?=$v ?>"/>
                                        </td>
                                        <td>
                                            <?= $t['cat_name'] ?>
                                        </td>
                                        <td>
                                            <a href="<?=$t['link']?>" target="_blank">
                                                <?=$tab_entry_linkto_tabmanagement?>
                                            </a>
                                        </td>
                                        <td>
                                            <?php $v = (null == $t['prod_val']) ? '' : $t['prod_val'] ?>
                                            <textarea
                                                class="summernote"
                                                name="prodtabs[<?=$t['category_prodtab_id']?>][val]"><?= $v?></textarea>
                                        </td>
                                        <td style="width: 1px;" class="text-center">
                                            <?php if ($t['prod_hide'] == 1): ?>
                                                <input type="checkbox" checked name="prodtabs[<?=$t['category_prodtab_id']?>][hide]" value="1"  class="form-control">
                                            <?php else: ?>
                                                <input type="checkbox"  name="prodtabs[<?=$t['category_prodtab_id']?>][hide]" value="1"  class="form-control">
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <div class="tab-pane" id="tab-attribute">
                            <div class="table-responsive">
                                <table id="attribute" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $entry_attribute; ?></td>
                                            <td class="text-left"><?php echo $entry_text; ?></td>
                                            <td></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php $attribute_row = 0; ?>
                                        <?php foreach ($product_attributes as $product_attribute) { ?>
                                            <tr id="attribute-row<?php echo $attribute_row; ?>">
                                                <td class="text-left" style="width: 40%;"><input type="text" name="product_attribute[<?php echo $attribute_row; ?>][name]" value="<?php echo $product_attribute['name']; ?>" placeholder="<?php echo $entry_attribute; ?>" class="form-control" />
                                                    <input type="hidden" name="product_attribute[<?php echo $attribute_row; ?>][attribute_id]" value="<?php echo $product_attribute['attribute_id']; ?>" /></td>
                                                <td class="text-left"><?php foreach ($languages as $language) { ?>
                                                        <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                            <textarea name="product_attribute[<?php echo $attribute_row; ?>][product_attribute_description][<?php echo $language['language_id']; ?>][text]" rows="5" placeholder="<?php echo $entry_text; ?>" class="form-control"><?php echo isset($product_attribute['product_attribute_description'][$language['language_id']]) ? $product_attribute['product_attribute_description'][$language['language_id']]['text'] : ''; ?></textarea>
                                                        </div>
                                                    <?php } ?></td>
                                                <td class="text-left"><button type="button" onclick="$('#attribute-row<?php echo $attribute_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                            </tr>
                                            <?php $attribute_row++; ?>
                                        <?php } ?>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="2"></td>
                                            <td class="text-left"><button type="button" onclick="addAttribute();" data-toggle="tooltip" title="<?php echo $button_attribute_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-option">
                            <div class="row">
                                <div class="col-sm-2">
                                    <ul class="nav nav-pills nav-stacked" id="option">
                                        <?php $option_row = 0; ?>
                                        <?php foreach ($product_options as $product_option) { ?>
                                            <li><a href="#tab-option<?php echo $option_row; ?>" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$('a[href=\'#tab-option<?php echo $option_row; ?>\']').parent().remove(); $('#tab-option<?php echo $option_row; ?>').remove(); $('#option a:first').tab('show');"></i> <?php echo $product_option['name']; ?></a></li>
                                            <?php $option_row++; ?>
                                        <?php } ?>
                                        <li>
                                            <input type="text" name="option" value="" placeholder="<?php echo $entry_option; ?>" id="input-option" class="form-control" />
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-sm-10">
                                    <div class="tab-content">
                                        <?php $option_row = 0; ?>
                                        <?php $option_value_row = 0; ?>
                                        <?php foreach ($product_options as $product_option) { ?>
                                            <div class="tab-pane" id="tab-option<?php echo $option_row; ?>">
                                                <input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_id]" value="<?php echo $product_option['product_option_id']; ?>" />
                                                <input type="hidden" name="product_option[<?php echo $option_row; ?>][name]" value="<?php echo $product_option['name']; ?>" />
                                                <input type="hidden" name="product_option[<?php echo $option_row; ?>][option_id]" value="<?php echo $product_option['option_id']; ?>" />
                                                <input type="hidden" name="product_option[<?php echo $option_row; ?>][type]" value="<?php echo $product_option['type']; ?>" />
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label" for="input-required<?php echo $option_row; ?>"><?php echo $entry_required; ?></label>
                                                    <div class="col-sm-10">
                                                        <select name="product_option[<?php echo $option_row; ?>][required]" id="input-required<?php echo $option_row; ?>" class="form-control">
                                                            <?php if ($product_option['required']) { ?>
                                                                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                                                <option value="0"><?php echo $text_no; ?></option>
                                                            <?php } else { ?>
                                                                <option value="1"><?php echo $text_yes; ?></option>
                                                                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                                                            <?php } ?>
                                                        </select>
                                                    </div>
                                                </div>
                                                <?php if ($product_option['type'] == 'text') { ?>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" id="input-value<?php echo $option_row; ?>" class="form-control" />
                                                        </div>
                                                    </div>
                                                <?php } ?>
                                                <?php if ($product_option['type'] == 'textarea') { ?>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
                                                        <div class="col-sm-10">
                                                            <textarea name="product_option[<?php echo $option_row; ?>][value]" rows="5" placeholder="<?php echo $entry_option_value; ?>" id="input-value<?php echo $option_row; ?>" class="form-control"><?php echo $product_option['value']; ?></textarea>
                                                        </div>
                                                    </div>
                                                <?php } ?>
                                                <?php if ($product_option['type'] == 'file') { ?>
                                                    <div class="form-group" style="display: none;">
                                                        <label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" id="input-value<?php echo $option_row; ?>" class="form-control" />
                                                        </div>
                                                    </div>
                                                <?php } ?>
                                                <?php if ($product_option['type'] == 'date') { ?>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
                                                        <div class="col-sm-3">
                                                            <div class="input-group date">
                                                                <input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" data-date-format="YYYY-MM-DD" id="input-value<?php echo $option_row; ?>" class="form-control" />
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                                </span></div>
                                                        </div>
                                                    </div>
                                                <?php } ?>
                                                <?php if ($product_option['type'] == 'time') { ?>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
                                                        <div class="col-sm-10">
                                                            <div class="input-group time">
                                                                <input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" data-date-format="HH:mm" id="input-value<?php echo $option_row; ?>" class="form-control" />
                                                                <span class="input-group-btn">
                                                                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                                </span></div>
                                                        </div>
                                                    </div>
                                                <?php } ?>
                                                <?php if ($product_option['type'] == 'datetime') { ?>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
                                                        <div class="col-sm-10">
                                                            <div class="input-group datetime">
                                                                <input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-value<?php echo $option_row; ?>" class="form-control" />
                                                                <span class="input-group-btn">
                                                                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                                </span></div>
                                                        </div>
                                                    </div>
                                                <?php } ?>
                                                <?php if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') { ?>
                                                    <div class="table-responsive">
                                                        <table id="option-value<?php echo $option_row; ?>" class="table table-striped table-bordered table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <td class="text-left"><?php echo $entry_option_value; ?></td>
                                                                    <td class="text-right"><?php echo $entry_quantity; ?></td>
                                                                    <td class="text-left"><?php echo $entry_subtract; ?></td>
                                                                    <td class="text-right"><?php echo $entry_price; ?></td>
                                                                    <td class="text-right"><?php echo $entry_option_points; ?></td>
                                                                    <td class="text-right"><?php echo $entry_weight; ?></td>
                                                                    <td></td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <?php foreach ($product_option['product_option_value'] as $product_option_value) { ?>
                                                                    <tr id="option-value-row<?php echo $option_value_row; ?>">
                                                                        <td class="text-left"><select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][option_value_id]" class="form-control">
                                                                                <?php if (isset($option_values[$product_option['option_id']])) { ?>
                                                                                    <?php foreach ($option_values[$product_option['option_id']] as $option_value) { ?>
                                                                                        <?php if ($option_value['option_value_id'] == $product_option_value['option_value_id']) { ?>
                                                                                            <option value="<?php echo $option_value['option_value_id']; ?>" selected="selected"><?php echo $option_value['name']; ?></option>
                                                                                        <?php } else { ?>
                                                                                            <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
                                                                                        <?php } ?>
                                                                                    <?php } ?>
                                                                                <?php } ?>
                                                                            </select>
                                                                            <input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][product_option_value_id]" value="<?php echo $product_option_value['product_option_value_id']; ?>" /></td>
                                                                        <td class="text-right"><input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][quantity]" value="<?php echo $product_option_value['quantity']; ?>" placeholder="<?php echo $entry_quantity; ?>" class="form-control" /></td>
                                                                        <td class="text-left"><select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][subtract]" class="form-control">
                                                                                <?php if ($product_option_value['subtract']) { ?>
                                                                                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                                                                    <option value="0"><?php echo $text_no; ?></option>
                                                                                <?php } else { ?>
                                                                                    <option value="1"><?php echo $text_yes; ?></option>
                                                                                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                                                                                <?php } ?>
                                                                            </select></td>
                                                                        <td class="text-right"><select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price_prefix]" class="form-control">
                                                                                <?php if ($product_option_value['price_prefix'] == '+') { ?>
                                                                                    <option value="+" selected="selected">+</option>
                                                                                <?php } else { ?>
                                                                                    <option value="+">+</option>
                                                                                <?php } ?>
                                                                                <?php if ($product_option_value['price_prefix'] == '-') { ?>
                                                                                    <option value="-" selected="selected">-</option>
                                                                                <?php } else { ?>
                                                                                    <option value="-">-</option>
                                                                                <?php } ?>
                                                                            </select>
                                                                            <input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price]" value="<?php echo $product_option_value['price']; ?>" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>
                                                                        <td class="text-right"><select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][points_prefix]" class="form-control">
                                                                                <?php if ($product_option_value['points_prefix'] == '+') { ?>
                                                                                    <option value="+" selected="selected">+</option>
                                                                                <?php } else { ?>
                                                                                    <option value="+">+</option>
                                                                                <?php } ?>
                                                                                <?php if ($product_option_value['points_prefix'] == '-') { ?>
                                                                                    <option value="-" selected="selected">-</option>
                                                                                <?php } else { ?>
                                                                                    <option value="-">-</option>
                                                                                <?php } ?>
                                                                            </select>
                                                                            <input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][points]" value="<?php echo $product_option_value['points']; ?>" placeholder="<?php echo $entry_points; ?>" class="form-control" /></td>
                                                                        <td class="text-right"><select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight_prefix]" class="form-control">
                                                                                <?php if ($product_option_value['weight_prefix'] == '+') { ?>
                                                                                    <option value="+" selected="selected">+</option>
                                                                                <?php } else { ?>
                                                                                    <option value="+">+</option>
                                                                                <?php } ?>
                                                                                <?php if ($product_option_value['weight_prefix'] == '-') { ?>
                                                                                    <option value="-" selected="selected">-</option>
                                                                                <?php } else { ?>
                                                                                    <option value="-">-</option>
                                                                                <?php } ?>
                                                                            </select>
                                                                            <input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight]" value="<?php echo $product_option_value['weight']; ?>" placeholder="<?php echo $entry_weight; ?>" class="form-control" /></td>
                                                                        <td class="text-left"><button type="button" onclick="$(this).tooltip('destroy');$('#option-value-row<?php echo $option_value_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                                                    </tr>
                                                                    <?php $option_value_row++; ?>
                                                                <?php } ?>
                                                            </tbody>
                                                            <tfoot>
                                                                <tr>
                                                                    <td colspan="6"></td>
                                                                    <td class="text-left"><button type="button" onclick="addOptionValue('<?php echo $option_row; ?>');" data-toggle="tooltip" title="<?php echo $button_option_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                                                </tr>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                    <select id="option-values<?php echo $option_row; ?>" style="display: none;">
                                                        <?php if (isset($option_values[$product_option['option_id']])) { ?>
                                                            <?php foreach ($option_values[$product_option['option_id']] as $option_value) { ?>
                                                                <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    </select>
                                                <?php } ?>
                                            </div>
                                            <?php $option_row++; ?>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-recurring">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $entry_recurring; ?></td>
                                            <td class="text-left"><?php echo $entry_customer_group; ?></td>
                                            <td class="text-left"></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php $recurring_row = 0; ?>
                                        <?php foreach ($product_recurrings as $product_recurring) { ?>

                                            <tr id="recurring-row<?php echo $recurring_row; ?>">
                                                <td class="text-left"><select name="product_recurring[<?php echo $recurring_row; ?>][recurring_id]" class="form-control">
                                                        <?php foreach ($recurrings as $recurring) { ?>
                                                            <?php if ($recurring['recurring_id'] == $product_recurring['recurring_id']) { ?>
                                                                <option value="<?php echo $recurring['recurring_id']; ?>" selected="selected"><?php echo $recurring['name']; ?></option>
                                                            <?php } else { ?>
                                                                <option value="<?php echo $recurring['recurring_id']; ?>"><?php echo $recurring['name']; ?></option>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    </select></td>
                                                <td class="text-left"><select name="product_recurring[<?php echo $recurring_row; ?>][customer_group_id]" class="form-control">
                                                        <?php foreach ($customer_groups as $customer_group) { ?>
                                                            <?php if ($customer_group['customer_group_id'] == $product_recurring['customer_group_id']) { ?>
                                                                <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                                                            <?php } else { ?>
                                                                <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    </select></td>
                                                <td class="text-left"><button type="button" onclick="$('#recurring-row<?php echo $recurring_row; ?>').remove()" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                            </tr>
                                            <?php $recurring_row++; ?>
                                        <?php } ?>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="2"></td>
                                            <td class="text-left"><button type="button" onclick="addRecurring()" data-toggle="tooltip" title="<?php echo $button_recurring_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-discount">
                            <div class="table-responsive">
                                <table id="discount" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $entry_customer_group; ?></td>
                                            <td class="text-right"><?php echo $entry_quantity; ?></td>
                                            <td class="text-right"><?php echo $entry_priority; ?></td>
                                            <td class="text-right"><?php echo $entry_price; ?></td>
                                            <td class="text-left"><?php echo $entry_date_start; ?></td>
                                            <td class="text-left"><?php echo $entry_date_end; ?></td>
                                            <td></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php $discount_row = 0; ?>
                                        <?php foreach ($product_discounts as $product_discount) { ?>
                                            <tr id="discount-row<?php echo $discount_row; ?>">
                                                <td class="text-left"><select name="product_discount[<?php echo $discount_row; ?>][customer_group_id]" class="form-control">
                                                        <?php foreach ($customer_groups as $customer_group) { ?>
                                                            <?php if ($customer_group['customer_group_id'] == $product_discount['customer_group_id']) { ?>
                                                                <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                                                            <?php } else { ?>
                                                                <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    </select></td>
                                                <td class="text-right"><input type="text" name="product_discount[<?php echo $discount_row; ?>][quantity]" value="<?php echo $product_discount['quantity']; ?>" placeholder="<?php echo $entry_quantity; ?>" class="form-control" /></td>
                                                <td class="text-right"><input type="text" name="product_discount[<?php echo $discount_row; ?>][priority]" value="<?php echo $product_discount['priority']; ?>" placeholder="<?php echo $entry_priority; ?>" class="form-control" /></td>
                                                <td class="text-right"><input type="text" name="product_discount[<?php echo $discount_row; ?>][price]" value="<?php echo $product_discount['price']; ?>" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>
                                                <td class="text-left" style="width: 20%;"><div class="input-group date">
                                                        <input type="text" name="product_discount[<?php echo $discount_row; ?>][date_start]" value="<?php echo $product_discount['date_start']; ?>" placeholder="<?php echo $entry_date_start; ?>" data-date-format="YYYY-MM-DD" class="form-control" />
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                        </span></div></td>
                                                <td class="text-left" style="width: 20%;"><div class="input-group date">
                                                        <input type="text" name="product_discount[<?php echo $discount_row; ?>][date_end]" value="<?php echo $product_discount['date_end']; ?>" placeholder="<?php echo $entry_date_end; ?>" data-date-format="YYYY-MM-DD" class="form-control" />
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                        </span></div></td>
                                                <td class="text-left"><button type="button" onclick="$('#discount-row<?php echo $discount_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                            </tr>
                                            <?php $discount_row++; ?>
                                        <?php } ?>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="6"></td>
                                            <td class="text-left"><button type="button" onclick="addDiscount();" data-toggle="tooltip" title="<?php echo $button_discount_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-special">
                            <div class="table-responsive">
                                <table id="special" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $entry_customer_group; ?></td>
                                            <td class="text-right"><?php echo $entry_priority; ?></td>
                                            <td class="text-right"><?php echo $entry_price; ?></td>
                                            <td class="text-left"><?php echo $entry_date_start; ?></td>
                                            <td class="text-left"><?php echo $entry_date_end; ?></td>
                                            <td></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php $special_row = 0; ?>
                                        <?php foreach ($product_specials as $product_special) { ?>
                                            <tr id="special-row<?php echo $special_row; ?>">
                                                <td class="text-left"><select name="product_special[<?php echo $special_row; ?>][customer_group_id]" class="form-control">
                                                        <?php foreach ($customer_groups as $customer_group) { ?>
                                                            <?php if ($customer_group['customer_group_id'] == $product_special['customer_group_id']) { ?>
                                                                <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                                                            <?php } else { ?>
                                                                <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    </select></td>
                                                <td class="text-right"><input type="text" name="product_special[<?php echo $special_row; ?>][priority]" value="<?php echo $product_special['priority']; ?>" placeholder="<?php echo $entry_priority; ?>" class="form-control" /></td>
                                                <td class="text-right"><input type="text" name="product_special[<?php echo $special_row; ?>][price]" value="<?php echo $product_special['price']; ?>" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>
                                                <td class="text-left" style="width: 20%;"><div class="input-group date">
                                                        <input type="text" name="product_special[<?php echo $special_row; ?>][date_start]" value="<?php echo $product_special['date_start']; ?>" placeholder="<?php echo $entry_date_start; ?>" data-date-format="YYYY-MM-DD" class="form-control" />
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                        </span></div></td>
                                                <td class="text-left" style="width: 20%;"><div class="input-group date">
                                                        <input type="text" name="product_special[<?php echo $special_row; ?>][date_end]" value="<?php echo $product_special['date_end']; ?>" placeholder="<?php echo $entry_date_end; ?>" data-date-format="YYYY-MM-DD" class="form-control" />
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                        </span></div></td>
                                                <td class="text-left"><button type="button" onclick="$('#special-row<?php echo $special_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                            </tr>
                                            <?php $special_row++; ?>
                                        <?php } ?>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="5"></td>
                                            <td class="text-left"><button type="button" onclick="addSpecial();" data-toggle="tooltip" title="<?php echo $button_special_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-filter">
                            <input type="text" name="change_params" value="0" id="change_params">
                            <div class="table-responsive">
                                <table id="filter" class="table table-solid table-bordered table-hover">

                                    <thead>
                                        <tr>
                                            <td class="text-left" style="width:150px;">Все параметры категории</td>
                                            <td class="text-left">Все критерии</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach($filter_params as $filter_param){?>
                                            <tr>
                                                <td class="text-left">
                                                    <b><?php echo $filter_param['name'];?><?php echo $filter_param['unit']?" (".$filter_param['unit'].")":"";?></b>
                                                </td>
                                                <td class="text-left">
                                                    <?php if($filter_param["type_param"]==1) {?>
                                                        <div class="product_availparam_dispason">
                                                            <div class="param_block_wrapper">

                                                                <div class="param_block_cap">от</div>
                                                                <input type="text" class="param_inp form-control" name="param_value_d[<?php echo $filter_param["id"];?>][value1]" value="<?php echo $filter_param["list"]["value1"];?>" />
                                                                <div class="param_block_cap">до</div>
                                                                <input type="text" class="param_inp form-control" name="param_value_d[<?php echo $filter_param["id"];?>][value2]"  value="<?php echo $filter_param["list"]["value2"];?>" />
                                                            </div>
                                                        </div>
                                                    <?php }else{?>
                                                        <div class="product_availparam_list">
                                                            <?php foreach($filter_param["list"] as $param_item){?>
                                                                <div class="product_used_item <?php echo ($param_item["selected"])?"_active":""?>" rel="<?php $param_item["id"];?>">
                                                                    <input class="param_value_input" type="text" name="param_value[<?php echo $filter_param["id"];?>][<?php echo $param_item["id"];?>]" value="<?php echo $param_item["selected"];?>">
                                                                    <?php echo $param_item["param_value"];?>
                                                                </div>
                                                            <?php }?>
                                                        </div>
                                                    <?php } ?>

                                                </td>
                                            </tr>
                                        <?php }?>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-image">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $entry_image; ?></td>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <tr>
                                            <td class="text-left"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="table-responsive">
                                <table id="images" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $entry_additional_image; ?></td>
                                            <td class="text-right"><?php echo $entry_sort_order; ?></td>
                                            <td></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php $image_row = 0; ?>
                                        <?php foreach ($product_images as $product_image) { ?>
                                            <tr id="image-row<?php echo $image_row; ?>">
                                                <td class="text-left"><a href="" id="thumb-image<?php echo $image_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $product_image['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="product_image[<?php echo $image_row; ?>][image]" value="<?php echo $product_image['image']; ?>" id="input-image<?php echo $image_row; ?>" /></td>
                                                <td class="text-right"><input type="text" name="product_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $product_image['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>
                                                <td class="text-left"><button type="button" onclick="$('#image-row<?php echo $image_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                            </tr>
                                            <?php $image_row++; ?>
                                        <?php } ?>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="2"></td>
                                            <td class="text-left"><button type="button" onclick="addImage();" data-toggle="tooltip" title="<?php echo $button_image_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-reward">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-points"><span data-toggle="tooltip" title="<?php echo $help_points; ?>"><?php echo $entry_points; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="points" value="<?php echo $points; ?>" placeholder="<?php echo $entry_points; ?>" id="input-points" class="form-control" />
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $entry_customer_group; ?></td>
                                            <td class="text-right"><?php echo $entry_reward; ?></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($customer_groups as $customer_group) { ?>
                                            <tr>
                                                <td class="text-left"><?php echo $customer_group['name']; ?></td>
                                                <td class="text-right"><input type="text" name="product_reward[<?php echo $customer_group['customer_group_id']; ?>][points]" value="<?php echo isset($product_reward[$customer_group['customer_group_id']]) ? $product_reward[$customer_group['customer_group_id']]['points'] : ''; ?>" class="form-control" /></td>
                                            </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!--
                        <div class="tab-pane" id="tab-design">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td class="text-left"><?php echo $entry_store; ?></td>
                                            <td class="text-left"><?php echo $entry_layout; ?></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="text-left"><?php echo $text_default; ?></td>
                                            <td class="text-left"><select name="product_layout[0]" class="form-control">
                                                    <option value=""></option>
                                                    <?php foreach ($layouts as $layout) { ?>
                                                        <?php if (isset($product_layout[0]) && $product_layout[0] == $layout['layout_id']) { ?>
                                                            <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                                        <?php } else { ?>
                                                            <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                                        <?php } ?>
                                                    <?php } ?>
                                                </select></td>
                                        </tr>
                                        <?php foreach ($stores as $store) { ?>
                                            <tr>
                                                <td class="text-left"><?php echo $store['name']; ?></td>
                                                <td class="text-left"><select name="product_layout[<?php echo $store['store_id']; ?>]" class="form-control">
                                                        <option value=""></option>
                                                        <?php foreach ($layouts as $layout) { ?>
                                                            <?php if (isset($product_layout[$store['store_id']]) && $product_layout[$store['store_id']] == $layout['layout_id']) { ?>
                                                                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                                            <?php } else { ?>
                                                                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    </select></td>
                                            </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        -->
                        <div class="tab-pane" id="tab_iden">
                            <div class="wrap_iden">
                                <input type="hidden" name="iden_change1" id="iden_change1" value="0"/>
                                <input type="hidden" name="iden_change2" id="iden_change2" value="0"/>
                                <input type="hidden" name="iden_change3" id="iden_change3" value="0"/>
                                <input type="hidden" name="iden_change4" id="iden_change4" value="0"/>

                                <table class="table_iden">
                                    <thead>
                                        <tr>
                                            <td></td>
                                            <td colspan="2">Цвет</td>
                                            <td>Упаковка</td>
                                            <td>Сезон</td>
                                            <td>Применение</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>Код</td>
                                            <td>Название</td>
                                            <td>Название</td>
                                            <td>Название</td>
                                            <td>Название</td>
                                        </tr>
                                    </thead>
                                    <tbody>

<?php foreach($iden['categories'] as $key=>$category){?>
    <tr>
        <td colspan="6" class="iden_cat_name <?=$main_category_id==$key?'active':''?>" rel="<?=$key?>"><span><?=$category?></span></td>
    </tr>
    <?php foreach($iden['products'][$key] as $product){?>

    <tr <?=$main_category_id==$key?'':'style="display:none;"'?> rel="<?=$product['product_id'] ?>" class="tr_category_<?=$key?>  status_<?=$product['status']?> <?php echo ($product_id==$product['product_id']?'current':'');?>">
        <td class="iden_product_name">
            <?=$product['name']?>
        </td>
        <td>
            <input class="idenInput idenInput_code1" name="iden[<?=$product['product_id']?>][1][code]" type="text" value="<?php echo (isset($iden_links[$product['product_id']][1]['code'])?$iden_links[$product['product_id']][1]['code']:'');?>"/>
        </td>

        <td>
            <input class="idenInput idenInput_name1" name="iden[<?=$product['product_id']?>][1][name]" type="text" value="<?php echo (isset($iden_links[$product['product_id']][1]['name'])?$iden_links[$product['product_id']][1]['name']:'');?>"/>
        </td>

        <td>
            <input class="idenInput idenInput_name2" name="iden[<?=$product['product_id']?>][2][name]" type="text" value="<?php echo (isset($iden_links[$product['product_id']][2]['name'])?$iden_links[$product['product_id']][2]['name']:'');?>"/>
        </td>
        <td>
            <input class="idenInput idenInput_name3" name="iden[<?=$product['product_id']?>][3][name]" type="text" value="<?php echo (isset($iden_links[$product['product_id']][3]['name'])?$iden_links[$product['product_id']][3]['name']:'');?>"/>
        </td>
        <td>
            <input class="idenInput idenInput_name4" name="iden[<?=$product['product_id']?>][4][name]" type="text" value="<?php echo (isset($iden_links[$product['product_id']][4]['name'])?$iden_links[$product['product_id']][4]['name']:'');?>"/>
        </td>
    </tr>
    <?php }?>
<?php }?>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab_accompany">
                        
                            <div class="form-group">
                                <label style="text-align:left;" class="col-sm-2 control-label" for="input-accompany_select"><?php echo $entry_accompany_select; ?></label>
                                <div class="col-sm-10">
                                    <select id="input-accompany_select" name="accompany_select" class="form-control">
                                        <option value="0" selected="selected"><?php echo $text_none; ?></option>
                                        <?php foreach ($accompanies as $accompany) { ?>
                                            <option <?php echo $accompany['accompany_id']==$accompany_id?'selected':'';?> data-products="<?=$accompany['products']?>" value="<?=$accompany['accompany_id']?>"><?=$accompany['name'] ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
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
                            <div class="product_used_accompany <?php echo isset($products_related[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?></div>
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
                                    <div class="product_used_accompany <?php echo isset($products_related[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?></div>
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
                        <div class="tab-pane" id="tab_analog">
                        <div class="form-group">
                            <div class="btns_analog">
                                <div class="btn iden_apply" id="iden_apply">Заполнить из идентичных</div>
                                <div class="btn iden_reset">Очистить</div>
                            </div>
                        </div>

<div class="wrap_accia_products wrap_analog_products">

    <input name="products_change_analog" id="products_change_analog" type="hidden"/>
    <input name="products_analog" id="products_analog" type="hidden"/>

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
                            <div class="<?php echo ($product_id==$product['product_id']?'_current':'');?> product_used_analog <?php echo isset($product_analogs[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?></div>
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
                                    <div class="<?php echo ($product_id==$product['product_id']?'_current':'');?> product_used_analog <?php echo isset($product_analogs[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?></div>
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


                        <div class="tab-pane" id="tab_files">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-download"><span data-toggle="tooltip" title="<?php echo $help_download; ?>"><?php echo $entry_download; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="download" value="" placeholder="<?php echo $entry_download; ?>" id="input-download" class="form-control" />
                                    <div id="product-download" class="well well-sm" style="height: 150px; overflow: auto;">
                                        <?php foreach ($product_downloads as $product_download) { ?>
                                            <div id="product-download<?php echo $product_download['download_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product_download['name']; ?>
                                                <input type="hidden" name="product_download[]" value="<?php echo $product_download['download_id']; ?>" />
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
        <script type="text/javascript"><!--
<?php if ($ckeditor) { ?>
    <?php foreach ($languages as $language) { ?>
                                        ckeditorInit('input-description<?php echo $language['language_id']; ?>', getURLVar('token'));
    <?php } ?>
<?php } ?>
//--></script>

    <script type="text/javascript"><!--

    //--></script>


        <script type="text/javascript"><!--
        function products_selected(){
            var products_used=[];
            $(".product_used_accompany._active").each(function(){
                var product_id=$(this).attr("rel");
                products_used.push(product_id);
            });
            $("#products_change").val(1);
            $("#products").val(products_used.join(","));
        }
        function products_selected_analog(){
            var products_used=[];
            $(".product_used_analog._active").each(function(){
                var product_id=$(this).attr("rel");
                products_used.push(product_id);
            });
            console.log(products_used);
            $("#products_change_analog").val(1);
            $("#products_analog").val(products_used.join(","));
        }


        $(document).ready(function(){
            
            $(".accia_column_subcategory_caption").click(function(){
                
                if($(this).hasClass("active")){
                    $(this).removeClass("active");
                    $(this).closest(".accia_catalog_row").find(".product_used_analog").removeClass("_active")
                    $(this).closest(".accia_catalog_row").find(".product_used_accompany").removeClass("_active")                     
                }else{
                    $(this).addClass("active");
                    $(this).closest(".accia_catalog_row").find(".product_used_analog").addClass("_active")
                    $(this).closest(".accia_catalog_row").find(".product_used_accompany").addClass("_active")
                }
                var prnt_itm=$(this).closest(".wrap_accia_products");
                if(prnt_itm.hasClass("wrap_analog_products")){
                    products_selected_analog();
                }else{
                    products_selected();
                    
                }
            });
            /**/
            $("#input-video").change(function(){
                $.ajax({
                        url: 'index.php?route=catalog/product/videoPreview&token=<?php echo $token; ?>&video='+$(this).val(),
                        dataType: 'json',
                        success: function (json) {
                            var src="../image/"+json.preview;
                            $("#input-video_preview").val(json['preview']);
                            $("#image-video_preview").attr("src",src.toString());
                        }   
                })     
            });


            $("a[href='#tab-design']").parent().hide();

            $(".iden_cat_name").click(function(){
                var rel=$(this).attr("rel");
                console.log(rel);
                if($(this).hasClass("active")){
                   $(this).removeClass("active");
                   $(".tr_category_"+rel).hide();
                }else{
                   $(this).addClass("active");
                   $(".tr_category_"+rel).show();
                }
            });
            $("#iden_apply").click(function(){
                $(".product_used_analog").removeClass("_active");
                $(".table_iden tr:not(.current) .idenInput").each(function(){
                    if($(this).val()){
                        var rel=$(this).closest("tr").attr("rel");
                        $(".product_used_analog[rel='"+rel+"']").addClass("_active");
                    }
                });
                $(".wrap_analog_products .subcat_wrapper").hide();
                $(".product_used_analog._active").each(function(){
                    $(this).parents(".subcat_wrapper").show();
                });
                products_selected_analog();
            });

            $(".table_iden tr.current .idenInput_name1").change(function(){
                if($(this).val()==""){
                    $(".table_iden tr:not(.current) .idenInput_name1").prop("disabled","disabled");
                }else{
                    $(".table_iden tr:not(.current) .idenInput_name1").prop("disabled",false);
                }
            });
            $(".table_iden tr.current .idenInput_name2").change(function(){
                if($(this).val()==""){
                    $(".table_iden tr:not(.current) .idenInput_name2").prop("disabled","disabled");
                }else{
                    $(".table_iden tr:not(.current) .idenInput_name2").prop("disabled",false);
                }
            });
            $(".table_iden tr.current .idenInput_name3").change(function(){
                if($(this).val()==""){
                    $(".table_iden tr:not(.current) .idenInput_name3").prop("disabled","disabled");
                }else{
                    $(".table_iden tr:not(.current) .idenInput_name3").prop("disabled",false);
                }
            });
            $(".table_iden tr.current .idenInput_name4").change(function(){
                if($(this).val()==""){
                    $(".table_iden tr:not(.current) .idenInput_name4").prop("disabled","disabled");
                }else{
                    $(".table_iden tr:not(.current) .idenInput_name4").prop("disabled",false);
                }
            });
            if($(".table_iden tr.current .idenInput_name1").val()==""){
                $(".table_iden tr:not(.current) .idenInput_name1").prop("disabled","disabled");
            }
            if($(".table_iden tr.current .idenInput_name2").val()==""){
                $(".table_iden tr:not(.current) .idenInput_name2").prop("disabled","disabled");
            }
            if($(".table_iden tr.current .idenInput_name3").val()==""){
                $(".table_iden tr:not(.current) .idenInput_name3").prop("disabled","disabled");
            }
            if($(".table_iden tr.current .idenInput_name4").val()==""){
                $(".table_iden tr:not(.current) .idenInput_name4").prop("disabled","disabled");
            }


            $(".idenInput_code1,.idenInput_name1").change(function(){
                $("#iden_change1").val(1);
            });
            $(".idenInput_name2").change(function(){
                $("#iden_change2").val(1);
            });
            $(".idenInput_name3").change(function(){
                $("#iden_change3").val(1);
            });
            $(".idenInput_name4").change(function(){
                $("#iden_change4").val(1);
            });

            $("#input-accompany_select").change(function(){
                var products_str=$("#input-accompany_select option:selected").data("products");
                //console.log(products_str);
                $(".product_used_accompany").removeClass("_active");
                if(products_str!=""){
                   products_arr=products_str.split(",");
                   for(product in products_arr){
                        product_id=products_arr[product];
                        $(".product_used_accompany[rel='"+product_id+"']").addClass("_active");
                   }

                }
                $("#products_change").val(1);
                $("#products").val(products_str);
                //products_selected();
                $("#tab_accompany .subcat_wrapper").hide();
                $(".product_used_accompany._active").each(function(){
                    $(this).parents(".subcat_wrapper").show();
                });
            });

            $(".product_used_analog._active").each(function(){
                $(this).parents(".subcat_wrapper").show();
            });
            $(".product_used_accompany._active").each(function(){
                $(this).parents(".subcat_wrapper").show();
            });

            $(".product_used_accompany").click(function(){
                $("#input-accompany_select").val("0");
                $(this).toggleClass("_active");
                products_selected();
            });
            $(".iden_reset").click(function(){
                $(".product_used_analog").removeClass("_active");
                $("#products_change_analog").val(1);
                $("#products_analog").val("");
            });
            $(".product_used_analog").click(function(){
                if(!$(this).hasClass("_current")){
                    $(this).toggleClass("_active");
                    products_selected_analog();
                }
            });
            $(".acc_cat_caption").click(function(){
                var rel=$(this).attr("rel");
                $(".subcat_wrapper[rel='"+rel+"']").slideToggle(200);
                $(this).toggleClass("active");
            });
        });



            $(".product_used_item").click(function(){
                $("#change_params").val(1);
                if($(this).hasClass("_active")){
                    $(this).removeClass("_active");
                    $(this).find(".param_value_input").val("");
                }else{
                    $(this).addClass("_active");
                    $(this).find(".param_value_input").val(1);
                }
            });
            $(".param_inp").change(function(){
                $("#change_params").val(1);
            });

            function setCalcView(){
                $(".show_calc").hide();
                var calc_nomer=$("#input-calc").val();
                var calc_nomer_final=0;
                if(calc_nomer!=0){
                    calc_nomer_final=calc_nomer;
                }else{
                    calc_nomer_final=$("#input-calc_category").val();
                }
                $(".show_calc_"+calc_nomer_final).show();

            }

            //Калькуляторы
            setCalcView();
            $("#input-calc").change(function(){
                setCalcView();
            });

            // Manufacturer
            $('input[name=\'manufacturer\']').autocomplete({
                'source': function (request, response) {
                    $.ajax({
                        url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                        dataType: 'json',
                        success: function (json) {
                            json.unshift({
                                manufacturer_id: 0,
                                name: '<?php echo $text_none; ?>'
                            });

                            response($.map(json, function (item) {
                                return {
                                    label: item['name'],
                                    value: item['manufacturer_id']
                                }
                            }));
                        }
                    });
                },
                'select': function (item) {
                    $('input[name=\'manufacturer\']').val(item['label']);
                    $('input[name=\'manufacturer_id\']').val(item['value']);
                }
            });

     // Category
            $('input[name=\'category\']').autocomplete({
                'source': function (request, response) {
                    $.ajax({
                        url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                        dataType: 'json',
                        success: function (json) {
                            response($.map(json, function (item) {
                                return {
                                    label: item['name'],
                               value: item['category_     id']
                                }
                       })     );
                        }
               });
           },
                'select': function (item) {
                    $('input[name=\'category\']').val('');

                    $('#product-category' + item['value']).remove();

                    $('#product-category').append('<div id="product-category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_category[]" value="' + item['value'] + '" /></div>');
                }
            });

            $('#product-category').delegate('.fa-minus-circle', 'click', function () {
                $(this).parent().remove();
            });

     // Filter
            $('input[name=\'filter\']').autocomplete({
                'source': function (request, response) {
                    $.ajax({
                        url: 'index.php?route=catalog/filter/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                        dataType: 'json',
                        success: function (json) {
                            response($.map(json, function (item) {
                                return {
                                    label: item['name'],
                                    value: item['filter_id']
                                }
                            }));
                        }
                    });
                },
                'select': function (item) {
                    $('input[name=\'filter\']').val('');

                    $('#product-filter' + item['value']).remove();

                    $('#product-filter').append('<div id="product-filter' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_filter[]" value="' + item['value'] + '" /></div>');
                }
            });

            $('#product-filter').delegate('.fa-minus-circle', 'click', function () {
                $(this).parent().remove();
            });

// Downloads
            $('input[name=\'download\']').autocomplete({
                'source': function (request, response) {
                    $.ajax({
                        url: 'index.php?route=catalog/download/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                        dataType: 'json',
                        success: function (json) {
                            response($.map(json, function (item) {
                                return {
                                    label: item['name'],
                                    value: item['download_id']
                                }
                            }));
                        }
                    });
                },
                'select': function (item) {
                    $('input[name=\'download\']').val('');

                    $('#product-download' + item['value']).remove();

               $('#product-download').append('<div id="product-download' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_download[]" value="' + item['value'] + '" /></div>');
                }
            });

            $('#product-download').delegate('.fa-minus-circle', 'click', function () {
                $(this).parent().remove();
            });

            // Related, Analogs
            $('input[name=\'analog\']').autocomplete({
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
                    $('input[name=\'analog\']').val('');

                    $('#product-analog' + item['value']).remove();

                    $('#product-analog').append('<div id="product-analog' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_analog[]" value="' + item['value'] + '" /></div>');
                }
            });

            $('#product-analog').delegate('.fa-minus-circle', 'click', function () {
                $(this).parent().remove();
            });
            $('#product-benefits').delegate('.fa-minus-circle', 'click', function () {
                $(this).parent().remove();
            });
            $('#product-related').delegate('.fa-minus-circle', 'click', function () {
                $(this).parent().remove();
            });

            $('input[name=\'related\']').autocomplete({
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
                    $('input[name=\'related\']').val('');

                    $('#product-related' + item['value']).remove();

                    $('#product-related').append('<div id="product-related' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_related[]" value="' + item['value'] + '" /></div>');
                }
            });



            $('input[name=\'benefits\']').autocomplete({
                'source': function (request, response) {
                    $.ajax({
                        url: 'index.php?route=catalog/product/autocomplete_benefits&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                        dataType: 'json',
                        success: function (json) {
                            response($.map(json, function (item) {
                                return {
                                    label: item['name_admin'],
                                    value: item['benefit_id']
                                }
                            }));
                        }
                    });
                },
                'select': function (item) {
                    $('input[name=\'benefits\']').val('');

                    $('#product-benefit' + item['value']).remove();

                    $('#product-benefits').append('<div id="product-benefit' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_benefit[]" value="' + item['value'] + '" /></div>');
                }
            });

            $('#product-analog').delegate('.fa-minus-circle', 'click', function () {
                $(this).parent().remove();
            });

     //--></script>
  <script type="text/javascript"><!--
       var attribute_row = <?php echo $attribute_row; ?>;

      function addAttribute() {
          html = '<tr id="attribute-row' + attribute_row + '">';
          html += '  <td class="text-left" style="width: 20%;"><input type="text" name="product_attribute[' + attribute_row + '][name]" value="" placeholder="<?php echo $entry_attribute; ?>" class="form-control" /><input type="hidden" name="product_attribute[' + attribute_row + '][attribute_id]" value="" /></td>';
          html += '  <td class="text-left">';
                <?php foreach ($languages as $language) { ?>
              html += '<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span><textarea name="product_attribute[' + attribute_row + '][product_attribute_description][<?php echo $language['language_id']; ?>][text]" rows="5" placeholder="<?php echo $entry_text; ?>" class="form-control"></textarea></div>';
                <?php } ?>
          html += '  </td>';
          html += '  <td class="text-left"><button type="button" onclick="$(\'#attribute-row' + attribute_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
          html += '</tr>';

          $('#attribute tbody').append(html);

          attributeautocomplete(attribute_row);

          attribute_row++;
      }

      function attributeautocomplete(attribute_row) {
          $('input[name=\'product_attribute[' + attribute_row + '][name]\']').autocomplete({
              'source': function (request, response) {
                  $.ajax({
                      url: 'index.php?route=catalog/attribute/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                      dataType: 'json',
                      success: function (json) {
                          response($.map(json, function (item) {
                              return {
                                  category: item.attribute_group,
                                  label: item.name,
                                  value: item.attribute_id
                              }
                          }));
                      }
                  });
              },
              'select': function (item) {
                  $('input[name=\'product_attribute[' + attribute_row + '][name]\']').val(item['label']);
                  $('input[name=\'product_attribute[' + attribute_row + '][attribute_id]\']').val(item['value']);
              }
          });
      }

      $('#attribute tbody tr').each(function (index, element) {
          attributeautocomplete(index);
      });
                 //--></script>
                <script type="text/javascript"><!--
      var option_row = <?php echo $option_row; ?>;

      $('input[name=\'option\']').autocomplete({
          'source': function (request, response) {
              $.ajax({
                  url: 'index.php?route=catalog/option/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                  dataType: 'json',
                  success: function (json) {
                      response($.map(json, function (item) {
                          return {
                              category: item['category'],
                              label: item['name'],
                              value: item['option_id'],
                              type: item['type'],
                              option_value: item['option_value']
                          }
                      }));
                  }
              });
          },
          'select': function (item) {
              html = '<div class="tab-pane" id="tab-option' + option_row + '">';
              html += '	<input type="hidden" name="product_option[' + option_row + '][product_option_id]" value="" />';
              html += '	<input type="hidden" name="product_option[' + option_row + '][name]" value="' + item['label'] + '" />';
              html += '	<input type="hidden" name="product_option[' + option_row + '][option_id]" value="' + item['value'] + '" />';
              html += '	<input type="hidden" name="product_option[' + option_row + '][type]" value="' + item['type'] + '" />';

              html += '	<div class="form-group">';
              html += '	  <label class="col-sm-2 control-label" for="input-required' + option_row + '"><?php echo $entry_required; ?></label>';
              html += '	  <div class="col-sm-10"><select name="product_option[' + option_row + '][required]" id="input-required' + option_row + '" class="form-control">';
              html += '	      <option value="1"><?php echo $text_yes; ?></option>';
              html += '	      <option value="0"><?php echo $text_no; ?></option>';
              html += '	  </select></div>';
              html += '	</div>';

              if (item['type'] == 'text') {
                  html += '	<div class="form-group">';
                  html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
                  html += '	  <div class="col-sm-10"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" id="input-value' + option_row + '" class="form-control" /></div>';
                  html += '	</div>';
              }

              if (item['type'] == 'textarea') {
                  html += '	<div class="form-group">';
                  html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
                  html += '	  <div class="col-sm-10"><textarea name="product_option[' + option_row + '][value]" rows="5" placeholder="<?php echo $entry_option_value; ?>" id="input-value' + option_row + '" class="form-control"></textarea></div>';
                  html += '	</div>';
              }

              if (item['type'] == 'file') {
                  html += '	<div class="form-group" style="display: none;">';
                  html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
                  html += '	  <div class="col-sm-10"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" id="input-value' + option_row + '" class="form-control" /></div>';
                  html += '	</div>';
              }

              if (item['type'] == 'date') {
                  html += '	<div class="form-group">';
                  html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
                  html += '	  <div class="col-sm-3"><div class="input-group date"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" data-date-format="YYYY-MM-DD" id="input-value' + option_row + '" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></div>';
                  html += '	</div>';
              }

              if (item['type'] == 'time') {
                  html += '	<div class="form-group">';
                  html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
                  html += '	  <div class="col-sm-10"><div class="input-group time"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" data-date-format="HH:mm" id="input-value' + option_row + '" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></div>';
                  html += '	</div>';
              }

              if (item['type'] == 'datetime') {
                  html += '	<div class="form-group">';
                  html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
                  html += '	  <div class="col-sm-10"><div class="input-group datetime"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-value' + option_row + '" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></div>';
                  html += '	</div>';
              }

              if (item['type'] == 'select' || item['type'] == 'radio' || item['type'] == 'checkbox' || item['type'] == 'image') {
                  html += '<div class="table-responsive">';
                  html += '  <table id="option-value' + option_row + '" class="table table-striped table-bordered table-hover">';
                  html += '  	 <thead>';
                  html += '      <tr>';
                  html += '        <td class="text-left"><?php echo $entry_option_value; ?></td>';
                  html += '        <td class="text-right"><?php echo $entry_quantity; ?></td>';
                  html += '        <td class="text-left"><?php echo $entry_subtract; ?></td>';
                  html += '        <td class="text-right"><?php echo $entry_price; ?></td>';
                  html += '        <td class="text-right"><?php echo $entry_option_points; ?></td>';
                  html += '        <td class="text-right"><?php echo $entry_weight; ?></td>';
                  html += '        <td></td>';
                  html += '      </tr>';
                  html += '  	 </thead>';
                  html += '  	 <tbody>';
                  html += '    </tbody>';
                  html += '    <tfoot>';
                  html += '      <tr>';
                  html += '        <td colspan="6"></td>';
                  html += '        <td class="text-left"><button type="button" onclick="addOptionValue(' + option_row + ');" data-toggle="tooltip" title="<?php echo $button_option_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>';
                  html += '      </tr>';
                  html += '    </tfoot>';
                  html += '  </table>';
                  html += '</div>';

                  html += '  <select id="option-values' + option_row + '" style="display: none;">';

                  for (i = 0; i < item['option_value'].length; i++) {
                      html += '  <option value="' + item['option_value'][i]['option_value_id'] + '">' + item['option_value'][i]['name'] + '</option>';
                  }

                  html += '  </select>';
                  html += '</div>';
              }

              $('#tab-option .tab-content').append(html);

              $('#option > li:last-child').before('<li><a href="#tab-option' + option_row + '" data-toggle="tab"><i class="fa fa-minus-circle" onclick=" $(\'#option a:first\').tab(\'show\');$(\'a[href=\\\'#tab-option' + option_row + '\\\']\').parent().remove(); $(\'#tab-option' + option_row + '\').remove();"></i>' + item['label'] + '</li>');

              $('#option a[href=\'#tab-option' + option_row + '\']').tab('show');

              $('[data-toggle=\'tooltip\']').tooltip({
                  container: 'body',
                  html: true
              });

              $('.date').datetimepicker({
                  pickTime: false
              });

              $('.time').datetimepicker({
                  pickDate: false
              });

              $('.datetime').datetimepicker({
                  pickDate: true,
                  pickTime: true
              });

              option_row++;
          }
      });
//--></script>
  <script type="text/javascript"><!--
      var option_value_row = <?php echo $option_value_row; ?>;

      function addOptionValue(option_row) {
          html = '<tr id="option-value-row' + option_value_row + '">';
          html += '  <td class="text-left"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][option_value_id]" class="form-control">';
          html += $('#option-values' + option_row).html();
          html += '  </select><input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][product_option_value_id]" value="" /></td>';
          html += '  <td class="text-right"><input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][quantity]" value="" placeholder="<?php echo $entry_quantity; ?>" class="form-control" /></td>';
          html += '  <td class="text-left"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][subtract]" class="form-control">';
          html += '    <option value="1"><?php echo $text_yes; ?></option>';
          html += '    <option value="0"><?php echo $text_no; ?></option>';
          html += '  </select></td>';
          html += '  <td class="text-right"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price_prefix]" class="form-control">';
          html += '    <option value="+">+</option>';
          html += '    <option value="-">-</option>';
          html += '  </select>';
          html += '  <input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price]" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>';
          html += '  <td class="text-right"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points_prefix]" class="form-control">';
          html += '    <option value="+">+</option>';
          html += '    <option value="-">-</option>';
          html += '  </select>';
          html += '  <input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points]" value="" placeholder="<?php echo $entry_points; ?>" class="form-control" /></td>';
          html += '  <td class="text-right"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][weight_prefix]" class="form-control">';
          html += '    <option value="+">+</option>';
          html += '    <option value="-">-</option>';
          html += '  </select>';
          html += '  <input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][weight]" value="" placeholder="<?php echo $entry_weight; ?>" class="form-control" /></td>';
          html += '  <td class="text-left"><button type="button" onclick="$(this).tooltip(\'destroy\');$(\'#option-value-row' + option_value_row + '\').remove();" data-toggle="tooltip" rel="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
          html += '</tr>';

          $('#option-value' + option_row + ' tbody').append(html);
          $('[rel=tooltip]').tooltip();

          option_value_row++;
      }
//--></script>
  <script type="text/javascript"><!--
      var discount_row = <?php echo $discount_row; ?>;

      function addDiscount() {
          html = '<tr id="discount-row' + discount_row + '">';
          html += '  <td class="text-left"><select name="product_discount[' + discount_row + '][customer_group_id]" class="form-control">';
                                    <?php foreach ($customer_groups as $customer_group) { ?>
              html += '    <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo addslashes($customer_group['name']); ?></option>';
                                    <?php } ?>
          html += '  </select></td>';
          html += '  <td class="text-right"><input type="text" name="product_discount[' + discount_row + '][quantity]" value="" placeholder="<?php echo $entry_quantity; ?>" class="form-control" /></td>';
          html += '  <td class="text-right"><input type="text" name="product_discount[' + discount_row + '][priority]" value="" placeholder="<?php echo $entry_priority; ?>" class="form-control" /></td>';
          html += '  <td class="text-right"><input type="text" name="product_discount[' + discount_row + '][price]" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>';
          html += '  <td class="text-left" style="width: 20%;"><div class="input-group date"><input type="text" name="product_discount[' + discount_row + '][date_start]" value="" placeholder="<?php echo $entry_date_start; ?>" data-date-format="YYYY-MM-DD" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></td>';
          html += '  <td class="text-left" style="width: 20%;"><div class="input-group date"><input type="text" name="product_discount[' + discount_row + '][date_end]" value="" placeholder="<?php echo $entry_date_end; ?>" data-date-format="YYYY-MM-DD" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></td>';
          html += '  <td class="text-left"><button type="button" onclick="$(\'#discount-row' + discount_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
          html += '</tr>';

          $('#discount tbody').append(html);

          $('.date').datetimepicker({
              pickTime: false
          });

          discount_row++;
      }
//--></script>
  <script type="text/javascript"><!--
      var special_row = <?php echo $special_row; ?>;

      function addSpecial() {
          html = '<tr id="special-row' + special_row + '">';
          html += '  <td class="text-left"><select name="product_special[' + special_row + '][customer_group_id]" class="form-control">';
                                        <?php foreach ($customer_groups as $customer_group) { ?>
              html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo addslashes($customer_group['name']); ?></option>';
                                        <?php } ?>
          html += '  </select></td>';
          html += '  <td class="text-right"><input type="text" name="product_special[' + special_row + '][priority]" value="" placeholder="<?php echo $entry_priority; ?>" class="form-control" /></td>';
          html += '  <td class="text-right"><input type="text" name="product_special[' + special_row + '][price]" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>';
          html += '  <td class="text-left" style="width: 20%;"><div class="input-group date"><input type="text" name="product_special[' + special_row + '][date_start]" value="" placeholder="<?php echo $entry_date_start; ?>" data-date-format="YYYY-MM-DD" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></td>';
          html += '  <td class="text-left" style="width: 20%;"><div class="input-group date"><input type="text" name="product_special[' + special_row + '][date_end]" value="" placeholder="<?php echo $entry_date_end; ?>" data-date-format="YYYY-MM-DD" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></td>';
          html += '  <td class="text-left"><button type="button" onclick="$(\'#special-row' + special_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
          html += '</tr>';

          $('#special tbody').append(html);

          $('.date').datetimepicker({
              pickTime: false
          });

          special_row++;
      }
//--></script>
  <script type="text/javascript"><!--
      var image_row = <?php echo $image_row; ?>;

      function addImage() {
          html = '<tr id="image-row' + image_row + '">';
          html += '  <td class="text-left"><a href="" id="thumb-image' + image_row + '"data-toggle="image" class="img-thumbnail"><img src="<?php echo $tlaceholder; ?>" alt="" title="" data-placeholder="<?php echo $tlaceholder; ?>" /></a><input type="hidden" name="product_image[' + image_row + '][image]" value="" id="input-image' + image_row + '" /></td>';
          html += '  <td class="text-right"><input type="text" name="product_image[' + image_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
          html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + image_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
          html += '</tr>';

          $('#images tbody').append(html);

          image_row++;
      }
//--></script>
  <script type="text/javascript"><!--
      var recurring_row = <?php echo $recurring_row; ?>;

      function addRecurring() {
          html = '<tr id="recurring-row' + recurring_row + '">';
          html += '  <td class="left">';
          html += '    <select name="product_recurring[' + recurring_row + '][recurring_id]" class="form-control">>';
                                                <?php foreach ($recurrings as $recurring) { ?>
              html += '      <option value="<?php echo $recurring['recurring_id']; ?>"><?php echo $recurring['name']; ?></option>';
                                                <?php } ?>
          html += '    </select>';
          html += '  </td>';
          html += '  <td class="left">';
          html += '    <select name="product_recurring[' + recurring_row + '][customer_group_id]" class="form-control">>';
                                                <?php foreach ($customer_groups as $customer_group) { ?>
              html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
                                                <?php } ?>
          html += '    <select>';
          html += '  </td>';
          html += '  <td class="left">';
          html += '    <a onclick="$(\'#recurring-row' + recurring_row + '\').remove()" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a>';
          html += '  </td>';
          html += '</tr>';

          $('#tab-recurring table tbody').append(html);

          recurring_row++;
      }
                                                               //--></script>
                                                <script type="te                                                        xt/javascript"><!--
                                                          $('.date').                                                    datetimepicker({
          pickTim                                                        e: false
      });

                                                          $('.time').                                                    datetimepicker({
          pickDate: f                                                        alse
      });

      $('.                                                        datetime').datetimepicker                                                    ({
                                                     pickDate: true,
          pickTime: true
      });

//--></script>
  <script type="text/javascript"><!--
      $('#language a:first').tab('show');
      $('#option a:first').tab('show');
//--></script></div>
                                                        <?php echo $footer; ?>
