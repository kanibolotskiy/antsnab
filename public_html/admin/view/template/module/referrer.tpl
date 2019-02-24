<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
          <div class="pull-right">
            <button type="submit" form="form-featured" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
	<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
                
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
			<a id="insert" class="btn btn-success"><i class="fa fa-plus"></i> <span><?php echo $button_insert; ?></span></a>
            <a id="btn-delete" class="btn btn-danger"><i class="fa fa-times"></i> <span><?php echo $button_delete; ?></span></a>
			<hr>
			<style>
			table td{
				padding: 4px 10px;
			}
			</style>
            <div id="form-add" style="display:none;padding:15px 0 20px 0;">
                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form-insert">
                    <table class="form">
                        
                        <tr><td><?php echo $text_utm_source ?>:</td><td><input type="text" name="utm_source" size="60" placeholder="google, yandex, vk, facebook"/></td></tr>
                        <tr><td><?php echo $text_utm_medium ?>:</td><td><input type="text" name="utm_medium" size="60" placeholder="cpc, email, banner, article"/></td></tr>
                        <tr><td><?php echo $text_utm_campaign ?>:</td><td><input type="text" name="utm_campaign" size="60" placeholder="promo, discount, sale"/></td></tr>
                        <tr><td><?php echo $text_utm_term ?>:</td><td><input type="text" name="utm_term" size="60" placeholder="link, landing page"/></td></tr>
                        <tr><td><?php echo $text_utm_content ?>:</td><td><input type="text" name="utm_content" size="60" placeholder="free, -30%, registration"/></td></tr>

                        <tr><td><?php echo $text_phone ?>:</td><td><input type="text" name="phone" size="60" /></td></tr>
                        <tr><td><?php echo $text_email ?>:</td><td><input type="text" name="email" size="60" /></td></tr>

                        <!--
                        <tr><td><?php echo $text_url_mask ?>:</td><td><input type="text" name="url_mask" size="60" /></td></tr>
                        <tr><td><?php echo $text_url_param ?>:</td><td><input type="text" name="url_param" size="60" /></td></tr>

                        <td class="left"><?php echo $pattern['utm_source']; ?></td>
                        <td class="left"><?php echo $pattern['utm_medium']; ?></td>
                        <td class="left"><?php echo $pattern['utm_campaign']; ?></td>
                        <td class="left"><?php echo $pattern['utm_term']; ?></td>
                        <td class="left"><?php echo $pattern['utm_content']; ?></td>
                        -->

                        <tr><td></td><td align="left">
                                <a onclick="$('#form-insert').submit();" class="btn btn-success"><span><i class="fa fa-save"></i></span></a>
                                <a onclick="fnCancel();" class="btn btn-default"><span><i class="fa fa-times"></i></span></a>
                                <input type="hidden" name="pattern_id" value="0">
                            </td></tr>
                    </table
                </form>
            </div>
            <!-- FORM -->
            <form action="delete" method="post" id="form"></form>
            <form action="<?php echo $delete ?>" method="post" enctype="multipart/form-data" id="form-list">
                <table class="list">
                    <thead>
                    <tr>
                        <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
                        
                        <td class="center"><?php if ($sort == 'utm_source') { ?>
                            <a href="<?php echo $sort_utm_source; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_utm_source; ?></a>
                            <?php } else { ?>
                            <a href="<?php echo $sort_utm_source; ?>"><?php echo $column_utm_source; ?></a>
                            <?php } ?></td>
                        <td class="center"><?php if ($sort == 'utm_medium') { ?>
                            <a href="<?php echo $sort_utm_medium; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_utm_medium; ?></a>
                            <?php } else { ?>
                            <a href="<?php echo $sort_utm_medium; ?>"><?php echo $column_utm_medium; ?></a>
                            <?php } ?></td>
                        <td class="center"><?php if ($sort == 'utm_campaign') { ?>
                            <a href="<?php echo $sort_utm_campaign; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_utm_campaign; ?></a>
                            <?php } else { ?>
                            <a href="<?php echo $sort_utm_campaign; ?>"><?php echo $column_utm_campaign; ?></a>
                            <?php } ?></td>
                        <td class="center"><?php if ($sort == 'utm_term') { ?>
                            <a href="<?php echo $sort_utm_term; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_utm_term; ?></a>
                            <?php } else { ?>
                            <a href="<?php echo $sort_utm_term; ?>"><?php echo $column_utm_term; ?></a>
                            <?php } ?></td>
                        <td class="center"><?php if ($sort == 'utm_content') { ?>
                            <a href="<?php echo $sort_utm_content; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_utm_content; ?></a>
                            <?php } else { ?>
                            <a href="<?php echo $sort_utm_content; ?>"><?php echo $column_utm_content; ?></a>
                            <?php } ?></td>

                        <td class="center"><?php if ($sort == 'phone') { ?>
                            <a href="<?php echo $sort_phone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_phone; ?></a>
                            <?php } else { ?>
                            <a href="<?php echo $sort_phone; ?>"><?php echo $column_phone; ?></a>
                            <?php } ?></td>
                        <td class="center"><?php if ($sort == 'email') { ?>
                            <a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email; ?></a>
                            <?php } else { ?>
                            <a href="<?php echo $sort_email; ?>"><?php echo $column_email; ?></a>
                            <?php } ?></td>
                            
                        <td class="right"><?php echo $column_action; ?></td>
                    </tr>
                    </thead>
                    <tbody>
                    <?php if ($patterns) { ?>
                    <?php foreach ($patterns as $pattern) { ?>
                    <tr class="tr<?php echo $pattern['pattern_id']; ?>">
                        <td style="text-align: center;"><?php if ($pattern['selected']) { ?>
                            <input type="checkbox" name="selected[]" value="<?php echo $pattern['pattern_id']; ?>" checked="checked" />
                            <?php } else { ?>
                            <input type="checkbox" name="selected[]" value="<?php echo $pattern['pattern_id']; ?>" />
                            <?php } ?></td>
                        <td class="left"><?php echo $pattern['utm_source']; ?></td>
                        <td class="left"><?php echo $pattern['utm_medium']; ?></td>
                        <td class="left"><?php echo $pattern['utm_campaign']; ?></td>
                        <td class="left"><?php echo $pattern['utm_term']; ?></td>
                        <td class="left"><?php echo $pattern['utm_content']; ?></td>
                        <td class="left"><?php echo $pattern['phone']; ?></td>
                        <td class="left"><?php echo $pattern['email']; ?></td>
                        <td class="right">[ <a onclick="itemEdit(<?php echo $pattern['pattern_id']; ?>)"><?php echo $pattern['action_text']; ?></a> ]</td>
                    </tr>
                    <?php } ?>
                    <?php } else { ?>
                    <tr>
                        <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
                    </tr>
                    <?php } ?>
                    </tbody>
                </table>
            </form>
            <div class="pagination"><?php echo $pagination; ?></div>
        </div>
    </div>
	<div class="alert alert-info"><i class="fa fa-cloud-download" aria-hidden="true"></i> Еще больше модулей <strong>Opencart <?php echo VERSION; ?></strong> доступно для скачивания <a target="_blank;" class="alert-link" href="http://ocmod.net?utm_source=module&utm_medium=link&utm_campaign=<?php echo $heading_title; ?>"><i class="fa fa-hand-o-right" aria-hidden="true"></i> на нашем сайте</a>!<button type="button" class="close" data-dismiss="alert"><i class="fa fa-times" aria-hidden="true"></i></button></div>
</div>
</div>
<script type="text/javascript"><!--
    function itemEdit(pattern_id) {
        /*$('input[name="name"]').val($('.tr'+pattern_id+' td:eq(1)').text());
        $('input[name="url_mask"]').val($('.tr'+pattern_id+' td:eq(2)').text());
        $('input[name="url_param"]').val($('.tr'+pattern_id+' td:eq(3)').text());
        */
        $('input[name="utm_source"]').val($('.tr'+pattern_id+' td:eq(1)').text());
        $('input[name="utm_medium"]').val($('.tr'+pattern_id+' td:eq(2)').text());
        $('input[name="utm_campaign"]').val($('.tr'+pattern_id+' td:eq(3)').text());
        $('input[name="utm_term"]').val($('.tr'+pattern_id+' td:eq(4)').text());
        $('input[name="utm_content"]').val($('.tr'+pattern_id+' td:eq(5)').text());
        $('input[name="phone"]').val($('.tr'+pattern_id+' td:eq(6)').text());
        $('input[name="email"]').val($('.tr'+pattern_id+' td:eq(7)').text());

        $('input[name="pattern_id"]').val(pattern_id);
        $('#form-add').show();
        $('input[name="name"]').focus();
        return false;
    }
    function fnCancel() {
        $('#form-add').hide();
        $('input[name="name"]').val('');
        $('input[name="url_mask"]').val('');
        $('input[name="url_param"]').val('');
        $('input[name="pattern_id"]').val('0');
        return false;
    }

    $('#insert').click(function() {
        fnCancel();
        $('#form-add').show();
        return false;
    });

    $(document).ready(function() {
        $('#btn-delete').click(function() {
            if (!confirm('Удаление невозможно отменить! Вы уверены, что хотите это сделать?')) {
                return false;
            } else {
                $('#form-list').submit();
            }
        });
    });
    //--></script>
<?php echo $footer; ?>