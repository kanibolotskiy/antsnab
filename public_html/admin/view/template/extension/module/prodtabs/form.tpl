<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <form action="<?= $action ?>" method="post" enctype="multipart/form-data" id="form-tab">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default">
                        <i class="fa fa-reply"></i>
                    </a>
                    <button type="submit" form="form-tab" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="<?php echo $button_save; ?>">
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
                    <input name="category_prodtab_id" type="hidden" value="<?= $category_prodtab_id ?>"/>

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
                            <textarea name="default" placeholder="<?= $entry_default ?>" id="input-default" class="form-control summernote" ><?= $default ?></textarea>
                             <?php if (isset($error_fields['default']) ) : ?>
                                 <div class="text-danger"><?php echo $error_fields['default'] ?></div>
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
    <script src='view/javascript/tinymce/tinymce.min.js'></script>
          <script>

		  function elFinderBrowser (callback, value, meta) {
		  try {
			  var fm = $('<div/>').dialogelfinder({
				  url : 'index.php?route=elfinder/connector&token=' + getURLVar('token'),
				  lang : 'ru',
				  width : 900,
				  height: 400,
				  destroyOnClose : true,
			  getFileCallback : function(file, fm) {
					var info = file.name + ' (' + fm.formatSize(file.size) + ')';
					callback(file.url, {alt: info});
			  },
			  commandsOptions : {
				  getfile : {
					  oncomplete : 'close',
					  multiple : false,
					  folders : false
				  }
			  }
				}).dialogelfinder('instance');
		  } catch (err) {
			//$('#filePickerError').modal('show');
          $.ajax({
								url: 'index.php?route=common/filemanager&token=' + getURLVar('token'),
								dataType: 'html',
								beforeSend: function() {
									$('#button-image i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
									$('#button-image').prop('disabled', true);
								},
								complete: function() {
									$('#button-image i').replaceWith('<i class="fa fa-upload"></i>');
									$('#button-image').prop('disabled', false);
								},
								success: function(html) {
								
									$('body').append('<div id="modal-image" class="modal">' + html + '</div>');
									
									$('#modal-image').modal('show');
									
									$('#modal-image').delegate('a.thumbnail', 'click', function(e) {
										e.preventDefault();
										
										//$(element).summernote('insertImage', $(this).attr('href'));
										callback($(this).attr('href'));							
										$('#modal-image').modal('hide');
									});
								}
							});
		  }
		  return false;
		}
    $('.summernote').addClass('tinymce');
          $('.summernote').removeClass('summernote');
          tinymce.init({
            selector: '.tinymce',
            skin: 'bootstrap',
            language: 'ru',
            height:300,
            file_picker_callback : elFinderBrowser,
            plugins: [
              'advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker',
              'searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking',
              'save table contextmenu directionality emoticons template paste textcolor colorpicker'
            ],
            toolbar: 'formatselect bold italic sizeselect fontselect fontsizeselect | hr alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | insertfile undo redo | forecolor backcolor emoticons superscript | code ',
            fontsize_formats: "8pt 10pt 12pt 14pt 18pt 24pt 36pt",
          });
          
          </script>
    <?php echo $footer; ?>