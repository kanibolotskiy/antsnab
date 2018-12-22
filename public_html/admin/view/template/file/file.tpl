<?php /*///3274///*/ ?>
<div class="tab-pane" id="tab-file">
	<div class="table-responsive">
		<table id="files" class="table table-striped table-bordered table-hover">
			<thead>
			  <tr>
				<td class="text-left"><?php echo $entry_file; ?></td>
				<td class="text-center"><?php echo $entry_file_image; ?></td>				
				<td class="text-left"><?php echo $entry_file_name; ?></td>
				<td class="text-left"><?php echo $entry_file_title; ?></td>
				<td class="text-left"><?php echo $entry_sort_order; ?></td>
				<td class="text-right"><?php echo $entry_status; ?></td>
				<td></td>
			  </tr>
			</thead>
			<tbody>
			<?php $file_row = 3274; ?>
			<input type="hidden" id="delete" name="delete" value="">
			<?php foreach ($product_files as $product_file) { ?>
			<tbody id="file-row<?php echo $file_row; ?>"> 
			  <input type="hidden" name="product_file[<?php echo $file_row; ?>][file_id]" value="<?php echo $product_file['file_id']; ?>">			
			  <tr>
				<td class="text-left"><input type="text" class="form-control" id="i<?php echo $file_row; ?>" name="product_file[<?php echo $file_row; ?>][file]" value="<?php echo $product_file['file']; ?>" /> <a id="button-upload<?php echo $file_row; ?>" class="button"><?php echo $button_upload_file; ?></a><?php if($product_file['file_delete']){ ?><div class="error" id="e<?php echo $file_row; ?>"><?php echo $error_file_exists; ?></div><?php } ?></td>
					<td class="text-center file_image_cell">
						<a href="" id="thumb-image<?php echo $file_row; ?>" data-toggle="image" class="img-thumbnail">
						  <img src="<?php echo $product_file['thumb']; ?>" data-placeholder="<?php echo $placeholder; ?>" />
						</a>
						<input type="hidden" name="product_file[<?php echo $file_row; ?>][file_image]" value="<?php echo $product_file['image']; ?>" id="input-file<?php echo $file_row; ?>" />
					</td>
					<td class="text-left">
					<?php foreach ($languages as $language) { ?>
						<input style="background:#fff url(view/image/flags/<?php echo $language['image']; ?>)right center no-repeat;" type="text" class="form-control" id="n<?php echo $file_row; ?><?php echo $language['language_id']; ?>" name="product_file[<?php echo $file_row; ?>][description][<?php echo $language['language_id']; ?>][name]" value="<?php echo $product_file['description'][$language['language_id']]['name']; ?>" />
					<?php } ?>
					</td>
					<td class="text-left">
					<?php foreach ($languages as $language) { ?>
						<input style="background:#fff url(view/image/flags/<?php echo $language['image']; ?>)right center no-repeat;" type="text" class="form-control" name="product_file[<?php echo $file_row; ?>][description][<?php echo $language['language_id']; ?>][title]" value="<?php echo $product_file['description'][$language['language_id']]['title']; ?>" />
					<?php } ?>
					</td>		
				<td class="text-left"><input type="text" class="form-control" name="product_file[<?php echo $file_row; ?>][sort_order]" value="<?php echo $product_file['sort_order']; ?>" size="2" /></td>
				<td>
					<select name="product_file[<?php echo $file_row; ?>][status]" class="form-control">
					  <?php if ($product_file['status']) { ?>
					  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					  <option value="0"><?php echo $text_disabled; ?></option>
					  <?php } else { ?>
					  <option value="1"><?php echo $text_enabled; ?></option>
					  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					  <?php } ?>
					</select>
				</td>
				<td class="text-left"><button type="button" onclick="$('#delete').val($('#delete').val()+'<?php echo $product_file['file_id']; ?>,'); $('#file-row<?php echo $file_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
			  </tr>
			</tbody>
			<?php $file_row++; ?>
			<?php } ?>	
		  </tbody>
		  <tfoot>
			<tr>
			  <td colspan="6"></td>
			  <td class="text-left"><button type="button" onclick="addFile();" data-toggle="tooltip" title="<?php echo $button_add_file; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
			</tr>
		  </tfoot>		
		</table>		
	</div>
</div>
<style>
	.button{cursor:pointer;}
	.error{color:red;}
</style>
<script type="text/javascript"><!--
var file_row = <?php echo $file_row; ?>;
function addFile(){ 
	html = '<tbody id="file-row' + file_row + '">';
	html += '  <tr>';
	html += '	<td class="text-left"><input class="form-control" type="text" id="i' + file_row + '" name="product_file[' + file_row + '][file]" value="" /> <a id="button-upload' + file_row + '" class="button"><?php echo $button_upload_file; ?></a></td>';
	html += '  <td class="text-center"><a href="" id="thumb-image' + file_row + '"data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /><input type="hidden" name="product_file[' + file_row + '][file_image]" value="" id="input-image' + file_row + '" /></td>';	
	html += '	<td class="text-left">';
	<?php foreach ($languages as $language) { ?>
	html += '	<input style="background:#fff url(view/image/flags/<?php echo $language['image']; ?>)right center no-repeat;" class="form-control" type="text" id="n' + file_row + '<?php echo $language['language_id']; ?>" name="product_file[' + file_row + '][description][<?php echo $language['language_id']; ?>][name]" value="" />';	
	<?php } ?>
	html += '	</td>';
	html += '	<td class="text-left">';
	<?php foreach ($languages as $language) { ?>
	html += '	<input style="background:#fff url(view/image/flags/<?php echo $language['image']; ?>)right center no-repeat;" class="form-control" type="text" name="product_file[' + file_row + '][description][<?php echo $language['language_id']; ?>][title]" value="" />';	
	<?php } ?>
	html += '	</td>';
	html += '	<td class="text-left"><input class="form-control" type="text" name="product_file[' + file_row + '][sort_order]" value="" size="2" /></td>';	
	html += '	<td>';
	html += '		<select class="form-control" name="product_file[' + file_row + '][status]">';
	html += '		  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '		  <option value="0"><?php echo $text_disabled; ?></option>';
	html += '		</select>';
	html += '	</td>'; 
	html += '	<td class="text-left"><button type="button" onclick="$(\'#file-row' + file_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '  </tr>';
	html += '</tbody>';	
	
	$('#files tfoot').before(html); 
	ajaxUp(file_row);	
	file_row++;
}
//--></script> 
<script type="text/javascript" src="view/javascript/ajaxupload_file.js"></script>
<script type="text/javascript"><!--
	function ajaxUp(elId) {
	  delete_old = $('#i' + elId).val();
	  new AjaxUpload('button-upload'+elId, {
		action: 'index.php?route=file/file/upload_file&token=<?php echo $token; ?>&delete_old='+delete_old,
		name: 'file',
		autoSubmit: true,
		responseType: 'json',
		onSubmit: function(file, extension) {
			$('#button-upload'+elId).text('Download...');
			$('#button-upload'+elId).attr('disabled', true);
		},
		onComplete: function(file, json) {
			$('#button-upload'+elId).text('<?php echo $button_upload_file; ?>');
			$('#button-upload'+elId).attr('disabled', false);
			if (json['success']){
				$('#i' + elId).attr('value', json['file']);
				$('#e' + elId).slideUp(150);
				<?php foreach ($languages as $language) { ?>
					$('#n' + elId+<?php echo $language['language_id']; ?>).attr('value', json['name']);
				<?php } ?>
			}
			if (json['error']) {
				alert(json['error']);
			}
			$('.loading').remove();
		}
	  });
	}
	
	<?php $i = 3274; foreach ($product_files as $product_file) { ?>
		ajaxUp(<?php echo $i; ?>);
	<?php $i++;} ?>
//--></script>
