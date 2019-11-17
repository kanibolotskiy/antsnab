<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default">
                    <i class="fa fa-reply"></i>
                </a>
                <button type="submit" form="form-units" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="<?php echo $button_save; ?>">
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
                <div class="alert alert-warning">
                    <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning_bases; ?>
                </div>
            </div>
            <div class="panel-body">
                <input type="hidden" id="token" value="<?=$token?>"/>
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="#tab-templ" data-toggle="tab">

                                <?php echo $tab_templ; ?>
                            </a>
                        </li>
                        <?php if (null !== $templateId ): ?> 
                        <li>
                            <a href="#tab-unit" data-toggle="tab">
                                <?php echo $tab_unit; ?>
                            </a>
                        </li>
                        <li>
                            <a href="#tab-base" data-toggle="tab">
                                <?php echo $tab_base; ?>
                            </a>
                        </li>
                        <li>
                            <a href="#tab-strings" data-toggle="tab">
                                <?php echo $tab_strings; ?>
                            </a>
                        </li>
                        <?php endif; /* null !== $templateId */ ?>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-templ">
                            <form action="" 
                              method="post" 
                              enctype="multipart/form-data" 
                              id="form-units" class="form-horizontal">
                                <input type="hidden" id="templateId" value="<?=$templateId?>"/>
                                <div class="tab-pane active" id="tab-templ">
                                    <div class="form-group row required">
                                        <label class="col-sm-3 control-label" for="input-name">
                                            <?= $entry_name ?>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="text" name="name" value="<?= $name ?>" placeholder="<?= $entry_name ?>" id="input-name" class="form-control">
                                            <?php if ( isset($error_fields['name'] )) : ?>
                                                <div class="text-danger"><?php echo $error_fields['name'] ?></div>
                                            <?php endif; ?>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-3 control-label" for="input-description">
                                            <?= $entry_description ?>
                                        </label>
                                        <div class="col-sm-9">
                                            <textarea name="description" 
                                                      placeholder="<?= $entry_description ?>" 
                                                      id="input-description" class="form-control"><?=$description?></textarea>
                                            <?php if ( isset($error_fields['description'] )) :  ?>
                                                <div class="text-danger"><?php echo $error_fields['description']?></div>
                                            <?php endif; ?>
                                        </div>
                                    </div>
                                </div>
                            </form> <?php /* template form without units, bases or strings*/ ?>
                        </div>    
                        <?php if (null !== $templateId ): ?> 
                        <div class="tab-pane" id="tab-unit">
                            
                            <table id="unittable" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th class="text-center" colspan="3">
                                            <?= $column_common ?>
                                        </th>
                                        <th colspan="2" class="text-center">
                                            <?= $column_sortOrders ?>
                                        </th>
                                        <th class="text-center" rowspan="2">
                                            <?= $column_weight ?>
                                        </th>
                                        <th colspan="2" class="text-center">
                                            <?= $column_strings ?>
                                        </th>

                                        <th rowspan="2">
                                            <?= $column_actions ?>
                                        </th> 
                                    </tr>
                                    <tr>
                                        <th>
                                            <?= $column_name ?>
                                        </th>
                                        <th>
                                            <?= $column_calcKoef ?>
                                        </th>
                                        <th>
                                            <?= $column_calcRel ?>
                                        </th>
                                        <th class="text-center">
                                            <?= $column_switchSortOrder ?>
                                        </th>
                                        <th class="text-center">
                                            <?= $column_loadingSortOrder ?>
                                        </th>
                                        <th class="text-center">
                                            <?= $column_name_strings ?>
                                        </th>
                                        <th class="text-center">
                                            <?= $column_package_strings ?>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="unitBody">
                                    <script type="text/x-tmpl" id="unit_rows">
                                        <?php include_once __DIR__ . '/partial/unitRow.tpl' ?>    
                                    </script>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="8"></td>
                                        <td>
                                            <button type="button" 
                                                    onclick="unitForm.addRow()" 
                                                    data-toggle="tooltip" title="Добавить" class="btn btn-primary">
                                                <i class="fa fa-plus-circle"></i>
                                            </button>
                                        </td>
                                    </tr> 
                                </tfoot>
                            </table>
                        </div>
                        <div class="tab-pane" id="tab-base">
                            <div style="display:none" id="baseError" class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label" for="input-priceBase">
                                    <?= $entry_priceBase ?>
                                </label>
                                <div class="col-sm-10">
                                    <select 
                                            data-baseselect 
                                            data-val="<?=$priceBase?>" 
                                            data-name="isPriceBase" class="form-control">
                                        <option value="">Нет</option>
                                        <?php /*Set only default value, other done by js*/?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label" for="input-saleBase">
                                    <?= $entry_saleBase ?>
                                </label>
                                <div class="col-sm-10">
                                    <select 
                                            data-baseselect 
                                            data-val="<?=$saleBase?>" 
                                            data-name="isSaleBase" class="form-control">
                                        <option value="">Нет</option>
                                        <?php /*Set only default value, other done by js*/?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label" for="input-packageBase">
                                    <?= $entry_packageBase ?>
                                </label>
                                <div class="col-sm-10">
                                    <select 
                                            data-baseselect 
                                            data-val="<?=$packageBase?>" 
                                            data-name="isPackageBase" class="form-control">
                                        <option value="">Нет</option>
                                        <?php /*Set only default value, other done by js*/?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-strings">
                            <div class="row">
                                <div class="col-xs-12">
                                    <!--@task language hardcoded-->
                                    Генерировать строки: 
                                    <button type="button" 
                                            onclick="stringForm.generate()" 
                                            data-toggle="tooltip" title="" 
                                            class="btn btn-primary" 
                                            data-original-title="Генерировать">
                                                <i class="fa fa-plus-circle"></i>
                                     </button>
                                    Сохранить:
                                    <button id ="saveStringsBut"
                                            disabled = "disabled"
                                            type="button" 
                                            onclick="stringForm.saveAll()" 
                                            data-toggle="tooltip" title="" 
                                            class="btn btn-primary" 
                                            data-original-title="Сохранить">
                                                <i class="fa fa-save"></i>
                                     </button> 
                                </div>
                            </div>
                            <table id="stringstable" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th><?=$column_strdescription?></th>
                                        <th><?=$column_strvalue?></th>
                                        <th><?=$column_strSortOrder?></th>
                                        <th><?=$column_actions?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                      <tbody id="strings">
                                        <script type="text/x-tmpl" id="stringsTmpl">
                                            <?php include_once __DIR__ . '/partial/string.tpl' ?>    
                                        </script>
                                    </tbody>  
                                </tbody>
                                <tfoot>
                                   <tr>
                                        <td colspan="3"></td>
                                        <td>
                                            <button type="button" 
                                                    onclick="stringForm.addRow()" 
                                                    data-toggle="tooltip" title="Добавить" class="btn btn-primary">
                                                <i class="fa fa-plus-circle"></i>
                                            </button>
                                        </td>
                                    </tr>  
                                </tfoot>
                            </table> 
                        </div>
                        <?php endif; /* null!==$templateId */ ?>

                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- https://github.com/blueimp/JavaScript-Templates -->
<script type="text/javascript" src="/admin/view/javascript/app/tmpl.js"></script>
<script type="text/javascript" src="/admin/view/template/extension/module/produnits/resources/produnits.js"></script>
<style>
    .saveBut {
        margin-top: 10px;
    }
    .dict_cell > input {
        margin-top: 5px;
    }
    #unittable {
        max-width: 1300px;
        margin:auto;
    }
    #unittable tbody tr:hover td {
        background: inherit !important;     
    }
    #unittable tbody tr:nth-child(2n) {
        background: #f5f5f5;
    }
    #unittable td {
        position:relative;
    }
    .text-danger {
        position: absolute;
        position: bottom;
        bottom: 0;
        font-size: 9px;
        text-align: center;
        width: 80%;
    }
    .unit_ico_container {
        position: absolute;
        top: 8px;
    }
    .unit_ico {
        font-size:9px;
    }
    .unit_ico>i {
        width: 11px;
        margin-right: 2px;
        text-align: center;
        color: green;
    }
</style>
<?php echo $footer; ?>
