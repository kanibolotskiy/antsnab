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
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-discount
                " class="form-horizontal">
                    <div class="form-group required">
                        <label class="col-sm-2 control-label" for="input-discount"><?php echo $entry_name; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="name" value="<?php echo $discount; ?>" placeholder="<?php echo $entry_name; ?>" id="input-discount" class="form-control" />
                            <?php if ($error_name) { ?>
                                <div class="text-danger"><?php echo $error_name; ?></div>
                            <?php } ?>
                        </div>
                    </div>
                    
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-description"><?php echo $entry_description; ?></label>
                      <div class="col-sm-10">
                        <textarea name="discount_description" placeholder="<?php echo $entry_description; ?>" id="input-description" class="form-control summernote"><?php echo isset($discount_description) ? $discount_description : ''; ?></textarea>
                      </div>
                    </div>
                    
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-goal"><?php echo $entry_goal; ?></label>
                      <div class="col-sm-10">
                        <input type="text" name="goal" value="<?php echo $goal; ?>" placeholder="<?php echo $entry_goal; ?>" id="input-goal" class="form-control" />
                      </div>
                    </div>

                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-label"><?php echo $entry_label; ?></label>
                      <div class="col-sm-10">
                        <input type="text" name="label" value="<?php echo $label; ?>" placeholder="<?php echo $entry_label; ?>" id="input-label" class="form-control" />
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