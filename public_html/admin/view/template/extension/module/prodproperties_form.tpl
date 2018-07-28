<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <form action="<?= $action ?>" method="post" enctype="multipart/form-data" id="form-property">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default">
                        <i class="fa fa-reply"></i>
                    </a>
                    <button type="submit" form="form-prodproperty" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="<?php echo $button_save; ?>">
                        <i class="fa fa-save"></i>
                    </button>
                </div>
                <h1><?php echo $form_title; ?></h1><br/>
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
                    <h3 class="panel-title"><i class="fa fa-cogs"></i> <?php echo $form_title; ?></h3>
                </div>
                <div class="panel-body">
                    <input name="category_id" type="hidden" value="<?= $category_id ?>"/>
                    <input name="category_prodproperty_id" type="hidden" value="<?= $category_prodproperty_id ?>"/>

                    <!-- @task it is always 1, delete later -->
                    <input name="type_id" type="hidden" value="1"/>

                    <div class="form-group row required">
                        <label class="col-sm-2 control-label" for="input-name">
                            <?= $entry_name ?>
                        </label>
                        <div class="col-sm-10">
                            <input type="text" name="name" value="<?= $name ?>" placeholder="<?= $entry_name ?>" id="input-name" class="form-control">
                            <?php if (isset($error_fields['name'])) : ?>
                                <div class="text-danger"><?php echo $error_fields['name'] ?></div>
                            <?php endif; ?>

                        </div>
                    </div>
                    <div class="form-group row required">
                        <label class="col-sm-2 control-label" for="input-default">
                            <?= $entry_default ?>
                        </label>
                        <div class="col-sm-10">
                            <input type="text" name="default" value="<?= $default ?>" placeholder="<?= $entry_default ?>" id="input-default" class="form-control">
                             <?php if (isset($error_fields['default']) ) : ?>
                                 <div class="text-danger"><?php echo $error_fields['default'] ?></div>
                             <?php endif; ?>

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label" for="input-unit">
                            <?= $entry_unit ?>
                        </label>
                        <div class="col-sm-10">
                            <input type="text" name="unit" value="<?= $unit ?>" placeholder="<?= $entry_unit ?>" id="input-unit" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 control-label" for="input-showInSummary">
                            <?= $entry_showInSummary ?>
                        </label>
                        <div class="col-sm-3">
                            <?php if ($showInSummary == 1): ?>
                                <input type="checkbox" checked name="showInSummary" value="1" id="input-showInSummary" class="form-control">
                            <?php else: ?>
                                <input type="checkbox"  name="showInSummary" value="1" id="input-showInSummary" class="form-control">
                            <?php endif; ?>
                        </div>

                        <label class="col-sm-3 control-label" for="input-showInProdPreview">
                            <?= $entry_showInProdPreview ?>
                        </label>
                        <div class="col-sm-3">
                            <?php if ($showInProdPreview == 1) : ?>
                                <input type="checkbox" checked name="showInProdPreview" value="1" id="input-showInProdpreview" class="form-control">
                            <?php else: ?>
                                <input type="checkbox"  name="showInProdPreview" value="1" id="input-showInProdpreview" class="form-control">
                            <?php endif; ?>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label" for="input-sortOrder">
                            <?= $entry_sortOrder ?>
                        </label>
                        <div class="col-sm-10">
                            <input type="text" name="sortOrder" value="<?= $sortOrder ?>" placeholder="<?= $entry_sortOrder ?>" id="input-name" class="form-control">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <?php echo $footer; ?>