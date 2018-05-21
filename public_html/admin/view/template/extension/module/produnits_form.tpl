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
                    <div class="form-group row required">
                        <label class="col-sm-3 control-label" for="input-name">
                            <?= $entry_name ?>
                        </label>
                        <div class="col-sm-9">
                            <input type="text" name="name" value="<?= $name ?>" placeholder="<?= $entry_name ?>" id="input-name" class="form-control">
                            <?php if (isset($error_fields['name'])) : ?>
                                <div class="text-danger"><?php echo $error_fields['name'] ?></div>
                            <?php endif; ?>

                        </div>
                    </div>
                    <div class="form-group row required">
                        <label class="col-sm-3 control-label" for="input-default">
                            <?= $entry_calcKoefVerb ?>
                        </label>
                        <div class="col-sm-5">
                            <input type="text" 
                                   name="calcKoef" 
                                   value="<?= $calcKoef ?>" 
                                   placeholder="<?= $entry_calcKoef ?>" 
                                   id="input-default" class="form-control">
                             <?php if (isset($error_fields['default']) ) : ?>
                                 <div class="text-danger"><?php echo $error_fields['default'] ?></div>
                             <?php endif; ?>

                        </div>
                        <div class="col-sm-4">
                            <select class="form-control" name="category_produnit_rel_id">
                                <?php foreach($units_list as $relUnit):?>
                                    <?php if( $relUnit['category_produnit_id'] === $category_produnit_rel_id):?>
                                        <option selected="selected"
                                                value="<?=$relUnit['category_produnit_id']?>">
                                            <?=$relUnit['name']?>
                                        </option>
                                    <?php else: ?>
                                        <option value="<?=$relUnit['category_produnit_id']?>">
                                            <?=$relUnit['name']?>
                                        </option>
                                    <?php endif; ?>
                                <?php endforeach;?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="text-right col-sm-2 control-label" for="input-showInSwitch">
                            <?= $entry_showInSwitch ?>
                        </label>
                        <div class="col-sm-1">
                            <?php if ($showInSwitch == 1): ?>
                                <input type="checkbox" checked name="showInSwitch" value="1" id="input-showInSwitch" class="form-control">
                            <?php else: ?>
                                <input type="checkbox"  name="showInSwitch" value="1" id="input-showInSwitch" class="form-control">
                            <?php endif; ?>
                        </div>

                        <label class="text-right col-sm-2 control-label" for="input-switchSortOrder">
                            <?= $entry_switchSortOrder ?>
                        </label>
                        <div class="col-sm-1">
                            <input type="text" name="switchSortOrder" value="<?= $switchSortOrder ?>" placeholder="<?= $entry_switchSortOrder ?>" id="input-name" class="form-control">
                        </div>


                        <label class="text-right col-sm-2 control-label" for="input-isPrice">
                            <?= $entry_isPrice ?>
                        </label>
                        <div class="col-sm-1">
                            <?php if ($isPrice == 1) : ?>
                                <input type="checkbox" checked name="isPrice" value="1" id="input-isPrice" class="form-control">
                            <?php else: ?>
                                <input type="checkbox"  name="isPrice" value="1" id="input-isPrice" class="form-control">
                            <?php endif; ?>
                        </div>

                         <label class="text-right col-sm-2 control-label" for="input-isPackage">
                            <?= $entry_isPackage ?>
                        </label>
                        <div class="col-sm-1">
                            <?php if ($isPackage == 1) : ?>
                                <input type="checkbox" checked name="isPackage" value="1" id="input-isPackage" class="form-control">
                            <?php else: ?>
                                <input type="checkbox"  name="isPackage" value="1" id="input-isPackage" class="form-control">
                            <?php endif; ?>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </form>
    <?php echo $footer; ?>