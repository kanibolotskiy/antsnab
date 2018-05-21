<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default">
                    <i class="fa fa-reply"></i>
                </a>
                <a href="<?php echo $add; ?>" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="<?=$button_add?>">
                    <i class="fa fa-plus"></i>
                </a>
                <button type="button" 
                        data-toggle="tooltip" 
                        title="" 
                        class="btn btn-danger" 
                        onclick="confirm('Вы уверены?') ? $('#form-templates').submit() : false;" 
                        data-original-title="<?php $button_delete?>">
                    <i class="fa fa-trash-o"></i>
                </button>
            </div>
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
                <h3 class="panel-title"><i class="fa fa-cogs"></i> <?php echo $module_title; ?></h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <form method="post" action="<?=$delete?>" enctype="multipart/form-data" id="form-templates"> 
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <td style="width: 1px;" class="text-center">
                                        <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);">
                                    </td>
                                    <td class="text-center"><?= $column_template ?></td>
                                    <td style="width: 107px;" >
                                        <?php echo $column_action; ?>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($templates) : ?>
                                    <?php foreach ($templates as $template) : ?>
                                        <tr>
                                            <td> <input type="checkbox" name="selected[]" value="<?=$template['produnit_template_id']?>"></td>
                                            <td class="left">
                                               <?php echo $template['name']; ?>
                                            </td>
                                            <td class="text-right">
                                                <a href="<?php echo $editLink . '&template_id=' . $template['produnit_template_id'] ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary">
                                                    <i class="fa fa-pencil"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <?php echo $footer; ?>