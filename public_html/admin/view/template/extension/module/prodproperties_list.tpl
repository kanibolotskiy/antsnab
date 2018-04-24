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
                                    <?= $column_sortorder ?>
                                </td>
                                <td style="width:75px;" class="text-center">
                                    <?= $column_showInSummary ?>
                                </td>
                                <td style="width:80px;" class="text-center">
                                    <?= $column_showInPreview ?>
                                </td>
                                <!--<td class="text-center"><?= $column_showInProdTab ?></td>-->
                                <td class="text-center"><?= $column_name ?></td>
                                <td class="text-center"><?= $column_defval ?></td>
                                <td class="text-center"><?= $column_unit ?></td>
                                <!--<td class="text-center"><?= $column_type ?></td>-->
                                <td class="text-center" style="width: 57px;" >
                                    <?php echo $column_action; ?>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if ($properties) : ?>
                                <?php foreach ($properties as $p) : ?>
                                    <tr>
                                        <td class="text-center">
                                            <input type="checkbox" name="selected[]" value="<?php echo $p['category_prodproperty_id']; ?>" />
                                        </td>
                                        <td class="text-center">
                                           <?=$p['sortOrder']?>
                                        </td>
                                        <td class="text-center">
                                           <?=( (1 == $p['showInSummary'] )?$yes:$no ) ?>
                                        </td>
                                        <td class="text-center">
                                           <?=( (1 == $p['showInProdPreview'] )?$yes:$no ) ?> 
                                        </td>
                                        <!--<td>
                                           <?//$p['showInProdTab']?>
                                        </td>-->
                                        <td>
                                           <?=$p['name']?>
                                        </td>
                                        <td>
                                           <?=$p['default']?>
                                        </td>
                                        <td>
                                           <?=$p['unit']?>
                                        </td>
                                        <td class="text-right">
                                            <a href="<?php echo $edit . '&prop_id=' . $p['category_prodproperty_id'] ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary">
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