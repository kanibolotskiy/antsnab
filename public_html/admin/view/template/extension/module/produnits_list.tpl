<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
                <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                <button onclick="confirm('Удаление приведет так же к удалению всех значений в продуктах данной категории. Вы уверены?') ? $('#form-property').submit() : false;"  data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger">
                    <i class="fa fa-trash-o"></i>
                </button>
            </div>
            <h1><?php echo $lists_title; ?></h1><br/>
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
                <h3 class="panel-title"><i class="fa fa-cogs"></i> <?php echo $lists_title; ?></h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <form action="<?=$delete?>" method="post" enctype="multipart/form-data" id="form-property">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <td style="width: 1px;" class="text-center">
                                    <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
                                </td>
                                <td style="width:40px;" class="text-center">
                                    <?= $column_isPrice ?>
                                </td>
                                <td style="width:75px;" class="text-center">
                                    <?= $column_showInSwitch ?>
                                </td>
                                <td style="width:80px;" class="text-center">
                                    <?= $column_switchSortOrder ?>
                                </td>
                                <td class="text-center">
                                    <?= $column_isPackage ?>
                                </td>
                                <td class="text-center">
                                    <?= $column_name ?>
                                </td>
                                <td class="text-center"></td>
                                <td class="text-center">
                                    <?= $column_calcKoef?>
                                </td>
                                <td class="text-center">
                                    <?= $column_partial_name?>
                                </td>
                                <td class="text-center" style="width: 57px;" >
                                    <?php echo $column_action; ?>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if ($units) : ?>
                                <?php foreach ($units as $u) : ?>
                                    <tr>
                                        <td class="text-center">
                                            <input type="checkbox" name="selected[]" value="<?php echo $u['category_produnit_id']; ?>" />
                                        </td>
                                        <td class="text-center">
                                           <?=( (1 == $u['isPrice'] )?$yes:$no ) ?>
                                        </td>

                                        <td class="text-center">
                                           <?=( (1 == $u['showInSwitch'] )?$yes:$no ) ?>
                                        </td>

                                        <td class="text-center">
                                           <?=$u['switchSortOrder']?>
                                        </td>

                                        <td class="text-center">
                                           <?=( (1 == $u['isPackage'] )?$yes:$no ) ?>
                                        </td>
                                        
                                        <td>
                                           <?=$u['name']?>
                                        </td>
                                        <td>
                                           <?= $column_calcKoef?>
                                        </td>
                                        <td>
                                           <?=$u['calcKoef']?>
                                        </td>
                                        <td>
                                           <?=$u['partial_name']?> 
                                        </td>
                                        <td class="text-right">
                                            <a href="<?php echo $edit . '&unit_id=' . $u['category_prodproperty_id'] ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary">
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