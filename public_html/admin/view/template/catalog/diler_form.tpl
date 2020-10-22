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
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-video" class="form-horizontal">
            
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                        <li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
                    </UL>
                    <div class="tab-content">
                    
                        <div class="tab-pane active" id="tab-general">
                            <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-title"><?php echo $entry_title; ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="title" value="<?php echo isset($title) ? $title : ''; ?>" placeholder="<?php echo $entry_title; ?>" id="input-title" class="form-control" />
                            </div>
                            </div>

                            <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-content"><?php echo $entry_content; ?></label>
                            <div class="col-sm-10">
                                <textarea name="content" placeholder="<?php echo $entry_content; ?>" id="input-content" class="form-control summernote"><?php echo isset($content) ? $content : ''; ?></textarea>
                            </div>
                            </div>

                            <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-meta_title"><?php echo $entry_meta_title; ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="meta_title" value="<?php echo isset($meta_title) ? $meta_title : ''; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta_title" class="form-control" />
                            </div>
                            </div>
                            
                            <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-meta_h1"><?php echo $entry_h1; ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="meta_h1" value="<?php echo isset($meta_h1) ? $meta_h1 : ''; ?>" placeholder="<?php echo $entry_h1; ?>" id="input-meta_h1" class="form-control" />
                            </div>
                            </div>
                            
                            <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-meta_description"><?php echo $entry_meta_description; ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="meta_description" value="<?php echo isset($meta_description) ? $meta_description : ''; ?>" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta_description" class="form-control" />
                            </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-meta_keywords"><?php echo $entry_meta_keywords; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="meta_keywords" value="<?php echo isset($meta_keywords) ? $meta_keywords : ''; ?>" placeholder="<?php echo $entry_meta_keywords; ?>" id="input-meta_keywords" class="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-data">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-link_caption"><?php echo $entry_link_caption; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="link_caption" value="<?php echo isset($link_caption) ? $link_caption : ''; ?>" placeholder="<?php echo $entry_link_caption; ?>" id="input-link_caption" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-link"><?php echo $entry_link; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="link" value="<?php echo isset($link) ? $link : ''; ?>" placeholder="<?php echo $entry_link; ?>" id="input-link" class="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
    
    

  </div>
<script type="text/javascript"><!--
<?php if ($ckeditor) { ?>
    <?php foreach ($languages as $language) { ?>
        ckeditorInit('input-content', getURLVar('token'));
    <?php } ?>
<?php } ?>
//--></script>

<?php echo $footer; ?>