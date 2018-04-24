<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
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
                <h3 class="panel-title"><i class="fa fa-cogs"></i> <?php echo $module_title; ?></h3>
            </div>
            <div class="panel-body">
                <div class="well">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label" for="input-filter_category">
                                    <?php echo $entry_filter_category; ?>
                                </label>
                                <input value="<?=$filter_category_value?>" name="filter_category" id="input-filter_category" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <button data-url="<?=$filter?>" type="button" id="button-filter" class="btn btn-primary pull-right">
                                <i class="fa fa-filter"></i> <?php echo $button_filter; ?></button>
                        </div>
                    </div>
                </div>
                <script>
                    $(window).on('load', function(){
                        $('#button-filter').on('click', function(e){
                            e.preventDefault();
                            var filter_val = $('#input-filter_category').val(),
                                url = $(this).attr('data-url');
                            window.location.href = url + '&filter_name=' + filter_val
                        });
                    });
                </script>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <td style="width: 1px;" class="text-left"><?= $column_active ?></td>
                                <td class="text-center"><?= $column_category ?></td>
                                <td style="width: 107px;" >
                                    <?php echo $column_action; ?>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if ($categories) : ?>
                                <?php foreach ($categories as $category) : ?>
                                    <tr>
                                        <td class="text-center">
                                            <?=( (1 == $category['isfinal'] )?$yes:$no ) ?> 
                                        </td>
                                        <td class="left">
                                           <?php echo $category['name']; ?>
                                        </td>
                                        <td class="text-right">
                                            <a href="<?php echo $editLink . '&category_id=' . $category['category_id'] ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary">
                                                <i class="fa fa-pencil"></i>
                                            </a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <?php echo $footer; ?>