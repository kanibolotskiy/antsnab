<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-courier" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-courier" class="form-horizontal">
                    <div class="form-group required">
                        <label class="col-sm-2 control-label" for="input-courier"><?php echo $entry_name; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="name" value="<?php echo $courier; ?>" placeholder="<?php echo $entry_name; ?>" id="input-courier" class="form-control" />
                            <?php if ($error_name) { ?>
                                <div class="text-danger"><?php echo $error_name; ?></div>
                            <?php } ?>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-weight"><?php echo $entry_weight; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="weight" value="<?php echo $weight; ?>" placeholder="<?php echo $entry_weight; ?>" id="input-weight" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-weight_str"><?php echo $entry_weight_str; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="weight_str" value="<?php echo $weight_str; ?>" placeholder="<?php echo $entry_weight_str; ?>" id="input-weight_str" class="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-price"><?php echo $entry_price; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="price" value="<?php echo $price; ?>" placeholder="<?php echo $entry_price; ?>" id="input-price" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-price_urgent"><?php echo $entry_price_urgent; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="price_urgent" value="<?php echo $price_urgent; ?>" placeholder="<?php echo $entry_price_urgent; ?>" id="input-price_urgent" class="form-control" />
                        </div>
                    </div>


                    <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-price_ico"><?php echo $entry_price_ico; ?></label>
                        <div class="col-sm-10">
                            <label>
                                <?php if ($price_ico) { ?>
                                <input  type="checkbox" name="price_ico" value="1" checked="checked" id="input-price_ico" />
                                <?php } else { ?>
                                <input type="checkbox" name="price_ico" value="1" id="input-price_ico" />
                                <?php } ?>
                                &nbsp; </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-caption"><?php echo $entry_caption; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="courier_caption" value="<?php echo $courier_caption; ?>" placeholder="<?php echo $entry_caption; ?>" id="input-caption" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-description"><?php echo $entry_description; ?></label>
                      <div class="col-sm-10">
                        <textarea name="courier_description" placeholder="<?php echo $entry_description; ?>" id="input-description" class="form-control summernote"><?php echo isset($courier_description) ? $courier_description : ''; ?></textarea>
                      </div>
                    </div>
                    
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                      <div class="col-sm-10">
                        <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                      </div>
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
    
    

  </div>
                <?php echo $footer; ?>