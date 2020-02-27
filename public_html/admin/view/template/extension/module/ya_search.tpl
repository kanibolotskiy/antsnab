<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-total" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-total" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-ya_search_key_api"><span data-toggle="tooltip" title="<?php echo $help_discount; ?>"><?php echo $entry_discount; ?></span></label>
            <div class="col-sm-10">
             <input type="text" name="ya_search_key_api" id="input-ya_search_key_api" class="form-control" value="<?php echo $ya_search_key_api ; ?>">
            </div>
          </div>
			<div class="form-group">
            <label class="col-sm-2 control-label" for="input-ya_search_id"><span data-toggle="tooltip" title="<?php echo $help_id; ?>"><?php echo $entry_id; ?></span></label>
            <div class="col-sm-10">
             <input type="text" name="ya_search_id" id="input-ya_search_id" class="form-control" value="<?php echo $ya_search_id ; ?>">
            </div>
          </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-ya_search_description"><span data-toggle="tooltip" title="<?php echo $help_description; ?>"><?php echo $entry_description; ?></span></label>
            <div class="col-sm-10">
             <input type="text" name="ya_search_description" id="input-ya_search_description" class="form-control" value="<?php echo (isset($ya_search_description) ? $ya_search_description: 'В наличии') ; ?>">
            </div>
          </div>
        </form>
      </div>
      <div style="margin-top:25px;border-top:1px dashed #ccc;padding:15px 0;text-align:center;"><? echo $text_help; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>