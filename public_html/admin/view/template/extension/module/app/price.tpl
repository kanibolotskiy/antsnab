<?php

use WS\Override\Controller\Admin\Extension\Module\PriceController;

echo $header;
?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-menu_editor" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-menu_editor" class="form-horizontal">
                    <!-- STATUS -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                        <div class="col-sm-10">
                            <select name="<?= $status_field_name ?>" id="input-status" class="form-control">
                                <?php if ($module_status) { ?>
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
                        <label class="col-sm-2 control-label" >
                            <?php echo $entry_pdfroute; ?>
                        </label>
                        <div class="col-sm-10">
                            <input name="<?= PriceController::CONFIG_KEY_PDF_ROUTE ?>"  value="<?= ${PriceController::CONFIG_KEY_PDF_ROUTE} ?>"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" >
                            <?php echo $entry_xlsroute; ?>
                        </label>
                        <div class="col-sm-10">
                            <input name="<?= PriceController::CONFIG_KEY_XLS_ROUTE ?>"  value="<?= ${PriceController::CONFIG_KEY_XLS_ROUTE} ?>"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" >
<?php echo $entry_rootcategory; ?>
                        </label>
                        <div class="col-sm-10">
                            <input name="<?= PriceController::CONFIG_KEY_START_CATEGORY_PARENT_ID ?>"  value="<?= ${PriceController::CONFIG_KEY_START_CATEGORY_PARENT_ID} ?>"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" >
<?php echo $entry_startcategory; ?>
                        </label>
                        <div class="col-sm-10">
                            <input name="<?= PriceController::CONFIG_KEY_START_CATEGORY_ID ?>"  value="<?= ${PriceController::CONFIG_KEY_START_CATEGORY_ID} ?>"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>