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
                        <li><a href="#tab-cust" data-toggle="tab"><?php echo $tab_cust; ?></a></li>
                        <li><a href="#tab-off" data-toggle="tab"><?php echo $tab_off; ?></a></li>
                        <li><a href="#tab-man" data-toggle="tab"><?php echo $tab_man; ?></a></li>
                        <li><a href="#tab-sklad" data-toggle="tab"><?php echo $tab_sklad; ?></a></li>
                        <li><a href="#tab-req" data-toggle="tab"><?php echo $tab_req; ?></a></li>
                        <li><a href="#tab-sert" data-toggle="tab"><?php echo $tab_sert; ?></a></li>
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
                                <div class="about_rows">

                                    <?php foreach($about_info as $key=>$about_row) {?>
                                        <div class="about_row" rel="<?=$key?>">



                                            <div class="about_row_image">
        <a href="" id="thumb-image_<?=$key?>"   class="img-thumbnail" data-toggle='image'>
            <img src="<?php echo $about_row['thumb']; ?>" alt="" title="" data-placeholder="<?=$image_placeholder?>"/>
            <input id="input-image_<?=$key?>" type="hidden" readonly name="block_about[<?=$key?>][image]" value="<?=$about_row['data']['image']?>" class="form-control"/>
        </a>
        
                                            </div>

                                            <div class="about_row_data">
                                                <div class="wrp_about_row_caption">
                                                    <div class="about_row_caption">
                                                        <div class="about_row_title _first">Заголовок</div>
                                                        <input class="form-control" type="text" name="block_about[<?=$key?>][caption]" value="<?=$about_row['data']['caption']?>" placeholder="Заголовок" />
                                                    </div>
                                                    <!--<button type="button" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>-->
                                                </div>
                                                
                                                <div class="about_row_text">
                                                    <div class="about_row_title">Текст</div>
                                                    <textarea class="form-control summernote" name="block_about[<?=$key?>][text]"><?=$about_row['data']['text']?></textarea>
                                                </div>
                                                <div class="about_row_caption">
                                                    <div class="">
                                                        <div class="about_row_title">Подзаголовок</div>
                                                        <input type="text" name="block_about[<?=$key?>][subcaption]" value="<?=$about_row['data']['subcaption']?>" placeholder="" class="form-control" />
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="wrapper_about_row_list">
                                                <div class="about_row_title">Список</div>
                                                <div class="about_row_lists">
                                                    <input class="input_list_change" type="hidden" value="0" name="change_list[<?=$key?>]">
                                                    <?php foreach($about_row['list'] as $list_row) {?>
                                                        <div class="about_row_list">
                                                            <div class="about_row_listrow">
                                                                <div class="about_row_listrow_caption">
                                                                    <input class="list_change form-control marg_right" name="about_block[<?=$key?>][list][caption][]" type="text" value="<?=$list_row['caption']?>" placeholder="Заголовок"/>
                                                                    <button type="button" title="" class="list_row_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                                                                </div>
                                                                <div class="about_row_listrow_text">
                                                                    <textarea class="list_change form-control" name="about_block[<?=$key?>][list][text][]" placeholder="Текст"><?=$list_row['text']?></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <?php }?>
                                                    <?php if(!$about_row['list']){ ?>
                                                        <div class="about_row_list">
                                                            <div class="about_row_listrow">
                                                                <div class="about_row_listrow_caption">
                                                                    <input class="list_change form-control marg_right" type="text" name="about_block[<?=$key?>][list][caption][]" value="" placeholder="Заголовок" />
                                                                    <button type="button" title="" class="list_row_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                                                                </div>
                                                                <div class="about_row_listrow_text">
                                                                    <textarea class="list_change form-control" name="about_block[<?=$key?>][list][text][]" placeholder="Текст"></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <?php }?>
                                                </div>
                                                <!--<div class="append_row_about_list">Добавить пункт</div>-->
                                                <button type="button" class="btn btn-primary append_row_about_list"><i class="fa fa-plus-circle"></i></button>
                                            </div>
                                        </div>
                                    <?php }?>
                                </div>
                                <!--<div class="append_block_about">Добавить блок</div>-->
                            </div>

                        </div>
                        <div class="tab-pane" id="tab-cust">
                            <div class="form-group">

                                <div class="cust_rows">

<?php foreach($cust_info as $key=>$cust_row){?>
    <div class="cust_row about_item_row">
        <div class="about_row_image">
            <a href="" id="thumb-image_cust_<?=$key?>"  class="img-thumbnail" data-toggle='image'>
                <img src="<?php echo $cust_row['thumb']; ?>" alt="" title="" data-placeholder="<?=$image_placeholder?>" />
                <input type="hidden" class="cust_change form-control" id="input-image_cust_<?=$key?>"  readonly name="customer[<?=$key?>][image]" value="<?=$cust_row['image']?>" />
            </a>
        </div>
        <div class="cust_row_info">
            <input class="about_item_row_delete" type="hidden" name="customer[<?=$key?>][delete]" value="0"/>
            <div class="about_row_title _first">ФИО</div>
            <div class="wrap_row_info">
                <input type="text" class="cust_change form-control" name="customer[<?=$key?>][fio]" value="<?=$cust_row['fio']?>" />    
                <button type="button" class="r_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>
            </div>
            <div class="about_row_title">Должность:</div>
            <input type="text" class="cust_change form-control" name="customer[<?=$key?>][position]" value="<?=$cust_row['position']?>" />
            <div class="about_row_title">Телефон:</div>
            <input type="text" class="cust_change form-control" name="customer[<?=$key?>][phone]" value="<?=$cust_row['phone']?>" />
            <div class="about_row_title">Код:</div>
            <input type="text" class="cust_change form-control" name="customer[<?=$key?>][code]" value="<?=$cust_row['code']?>" />
            <div class="about_row_title">Email:</div>
            <input type="text" class="cust_change form-control" name="customer[<?=$key?>][email]" value="<?=$cust_row['email']?>" />
            <div class="about_row_title">Порядок сортировки:</div>
            <input type="text" class="cust_change form-control" name="customer[<?=$key?>][sort_order]" value="<?=$cust_row['sort_order']?>" />
        </div>
    </div>
<?php }?>
                                </div>
                                <div class="wrpapper_append_button">
                                    <button type="button" class="btn btn-primary append_row_cust"><i class="fa fa-plus-circle"></i></button>
                                </div>
                                
                            </div>
                            <div class="form-group">
                               
                                <label class="col-sm-2 control-label" for="input-content_cust"><?php echo $entry_content_cust; ?></label>
                                <div class="col-sm-10">
                                    <textarea name="content_cust" placeholder="<?php echo $entry_content_cust; ?>" id="input-content_cust" class="form-control summernote"><?php echo isset($content_cust) ? $content_cust : ''; ?></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-off">
                            <div class="form-group">
                                <div class="media_group">
<div class="about_row_title _first">Изображения/видео</div>
<div class="wrapper_media_rows">
    <div class="media_rows media_rows_off">
    
        <?php foreach($off_info as $key=>$off_row) {?>
        <div class="media_row about_item_row">
            <input class="about_item_row_delete" type="hidden" name="off[<?=$key?>][delete]" value="0"/>
            <div class="about_row_image">
                <div class="wrapper_row_image">
                    <a href="" id="thumb-image_off_<?=$key?>"  class="img-thumbnail" data-toggle='image'>
                        <img src="<?php echo $off_row['thumb']; ?>" alt="" title="" data-placeholder="<?=$image_placeholder?>" />
                        <input name="off[<?=$key?>][image]" value="<?=$off_row['image']?>" type="hidden" class="cust_change form-control" id="input-image_off_<?=$key?>"  readonly  />
                    </a>
                </div>
                <div class="wrapper_row_info">
                    <div class="wrap_row_info">
                        <input name="off[<?=$key?>][caption]" value="<?=$off_row['caption']?>" placeholder="Заголовок" type="text" class="cust_change form-control" />    
                        <button type="button" class="r_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                    </div>
                    <input name="off[<?=$key?>][video]" value="<?=$off_row['video']?>" placeholder="Видео" class="video_input form-control" />
                    
                    <input placeholder="Порядок сортировки" type="text" class="margtop_form-control form-control" name="off[<?=$key?>][sort_order]" value="<?=$off_row['sort_order']?>" />
                </div>
            </div>
        </div>
        <?php }?>
    </div>
    <div class="wrpapper_append_button">
        <button type="button" class="btn btn-primary append_row_off" nm="off"><i class="fa fa-plus-circle"></i></button>
    </div>
</div>
                                </div>
                                <label class="col-sm-2 control-label" for="input-content_off"><?php echo $entry_content_off; ?></label>
                                <div class="col-sm-10">
                                    <textarea name="content_off" placeholder="<?php echo $entry_content_off; ?>" id="input-content_off" class="form-control summernote"><?php echo isset($content_off) ? $content_off : ''; ?></textarea>
                                </div>
                            </div>                           
                        </div>
                        <div class="tab-pane" id="tab-man">
                            <div class="form-group">
                                <div class="media_group">
<div class="about_row_title _first">Изображения/видео</div>
<div class="wrapper_media_rows">
    <div class="media_rows media_rows_man">
    
        <?php foreach($man_info as $key=>$man_row) {?>
        <div class="media_row about_item_row">
            <input class="about_item_row_delete" type="hidden" name="man[<?=$key?>][delete]" value="0"/>
            <div class="about_row_image">
                <div class="wrapper_row_image">
                    <a href="" id="thumb-image_man_<?=$key?>"  class="img-thumbnail" data-toggle='image'>
                        <img src="<?php echo $man_row['thumb']; ?>" alt="" title="" data-placeholder="<?=$image_placeholder?>" />
                        <input name="man[<?=$key?>][image]" value="<?=$man_row['image']?>" type="hidden" class="cust_change form-control" id="input-image_man_<?=$key?>"  readonly  />
                    </a>
                </div>
                <div class="wrapper_row_info">
                    <div class="wrap_row_info">
                        <input name="man[<?=$key?>][caption]" value="<?=$man_row['caption']?>" placeholder="Заголовок" type="text" class="cust_change form-control" />    
                        <button type="button" class="r_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                    </div>
                    <input name="man[<?=$key?>][video]" value="<?=$man_row['video']?>" placeholder="Видео" class="video_input form-control" />
                </div>
            </div>
        </div>
        <?php }?>
    </div>
    <div class="wrpapper_append_button">
        <button type="button" class="btn btn-primary append_row_off" nm="man"><i class="fa fa-plus-circle"></i></button>
    </div>
</div>
                                </div>
                                <label class="col-sm-2 control-label" for="input-content_man"><?php echo $entry_content_man; ?></label>
                                <div class="col-sm-10">
                                    <textarea name="content_man" placeholder="<?php echo $entry_content_man; ?>" id="input-content_man" class="form-control summernote"><?php echo isset($content_man) ? $content_man : ''; ?></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-sklad">
                            <div class="form-group">
                                <div class="media_group">
<div class="about_row_title _first">Изображения/видео</div>
<div class="wrapper_media_rows">
    <div class="media_rows media_rows_sklad">
    
        <?php foreach($sklad_info as $key=>$sklad_row) {?>
        <div class="media_row about_item_row">
            <input class="about_item_row_delete" type="hidden" name="sklad[<?=$key?>][delete]" value="0"/>
            <div class="about_row_image">
                <div class="wrapper_row_image">
                    <a href="" id="thumb-image_sklad_<?=$key?>"  class="img-thumbnail" data-toggle='image'>
                        <img src="<?php echo $sklad_row['thumb']; ?>" alt="" title="" data-placeholder="<?=$image_placeholder?>" />
                        <input name="sklad[<?=$key?>][image]" value="<?=$sklad_row['image']?>" type="hidden" class="margtop_form-control form-control" id="input-image_sklad_<?=$key?>"  readonly  />
                    </a>
                </div>
                <div class="wrapper_row_info">
                    <div class="wrap_row_info">
                        <input name="sklad[<?=$key?>][caption]" value="<?=$sklad_row['caption']?>" placeholder="Заголовок" type="text" class="cust_change form-control" />    
                        <button type="button" class="r_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                    </div>
                    <input name="sklad[<?=$key?>][video]" value="<?=$sklad_row['video']?>" placeholder="Видео" class="video_input form-control" />
                </div>
            </div>
        </div>
        <?php }?>
    </div>
    <div class="wrpapper_append_button">
        <button type="button" class="btn btn-primary append_row_off" nm="sklad"><i class="fa fa-plus-circle"></i></button>
    </div>
</div>
                                </div>
                                <label class="col-sm-2 control-label" for="input-content_sklad"><?php echo $entry_content_sklad; ?></label>
                                <div class="col-sm-10">
                                    <textarea name="content_sklad" placeholder="<?php echo $entry_content_sklad; ?>" id="input-content_sklad" class="form-control summernote"><?php echo isset($content_sklad) ? $content_sklad : ''; ?></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-req">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-content_req"><?php echo $entry_req; ?></label>
                                <div class="col-sm-10">
                                    <textarea name="content_req" placeholder="<?php echo $entry_req; ?>" id="input-content_req" class="form-control summernote"><?php echo isset($content_req) ? $content_req : ''; ?></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-download"><span data-toggle="tooltip" title="<?php echo $help_download; ?>"><?php echo $entry_download; ?></span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="download" value="" placeholder="<?php echo $entry_download; ?>" id="input-download" class="form-control" />
                                    <div id="information-download" class="well well-sm" style="height: 150px; overflow: auto;">
                                        <?php foreach ($information_downloads as $information_download) { ?>
                                            <div id="information-download<?php echo $information_download['download_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $information_download['name']; ?>
                                                <input type="hidden" name="information_download[]" value="<?php echo $information_download['download_id']; ?>" />
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-sert">
                            <div class="form-group">

                                <div class="media_group">
<div class="about_row_title _first">Сертификаты</div>
<div class="wrapper_media_rows">
    <div class="media_rows media_rows_sert">
    
        <?php foreach($sert_info as $key=>$sert_row) {?>
        <div class="media_row about_item_row">
            <input class="about_item_row_delete" type="hidden" name="sert[<?=$key?>][delete]" value="0"/>
            <div class="about_row_image">
                <div class="wrapper_row_image">
                    <a href="" id="thumb-image_sert_<?=$key?>"  class="img-thumbnail" data-toggle='image'>
                        <img src="<?php echo $sert_row['thumb']; ?>" alt="" title="" data-placeholder="<?=$image_placeholder?>" />
                        <input name="sert[<?=$key?>][image]" value="<?=$sert_row['image']?>" type="hidden" class="cust_change form-control" id="input-image_sert_<?=$key?>"  readonly  />
                    </a>
                </div>
                <div class="wrapper_row_info">
                    <div class="wrap_row_info">
                        <input name="sert[<?=$key?>][caption]" value="<?=$sert_row['caption']?>" placeholder="Заголовок" type="text" class="cust_change form-control" />    
                        <button type="button" class="r_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                    </div>
                    <input placeholder="Порядок сортировки" type="text" class="margtop_form-control form-control" name="sert[<?=$key?>][sort_order]" value="<?=$sert_row['sort_order']?>" />
                </div>
            </div>
        </div>
        <?php }?>
    </div>
    <div class="wrpapper_append_button">
        <button type="button" class="btn btn-primary append_row_sert"><i class="fa fa-plus-circle"></i></button>
    </div>
</div>
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
    $(document).ready(function(){
            // Downloads
        $('input[name=\'download\']').autocomplete({
            'source': function (request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/download/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                    dataType: 'json',
                    success: function (json) {
                        response($.map(json, function (item) {
                            return {
                                label: item['name'],
                                value: item['download_id']
                            }
                        }));
                    }
                });
            },
            'select': function (item) {
                $('input[name=\'download\']').val('');

                $('#information-download' + item['value']).remove();

            $('#information-download').append('<div id="information-download' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="information_download[]" value="' + item['value'] + '" /></div>');     
            }
        });

        $('#information-download').delegate('.fa-minus-circle', 'click', function () {
            $(this).parent().remove();
        });
        
        $(document).on("click",".r_remove",function(){
            var itm=$(this).closest(".about_item_row");
            itm.addClass("_remove");
            itm.find(".about_item_row_delete").val("1");
        });

        $(document).on("click",".list_row_remove",function(){
            $(this).closest(".wrapper_about_row_list").find(".input_list_change").val("1");
            $(this).closest(".about_row_listrow").remove();
        });
        $(document).on("change",".list_change",function(){
            $(this).closest(".wrapper_about_row_list").find(".input_list_change").val("1");
        });


        $(".append_row_sert").click(function(){
            var rand_id=Math.random();
            var rand_str=rand_id.toString().replace(".", "");
            
            var new_itm='<div class="media_row about_item_row">'+
            '    <input class="about_item_row_delete" type="hidden" name="sert[new][delete][]" value="0"/>'+
            '    <div class="about_row_image">'+
            '        <div class="wrapper_row_image">'+
            '            <a href="" id="thumb-image_sert_'+rand_str+'"  class="img-thumbnail" data-toggle="image">'+
            '                <img src="<?=$image_placeholder?>" alt="" title="" data-placeholder="<?=$image_placeholder?>" />'+
            '                <input name="sert[new][image][]" value="" type="hidden" class="cust_change form-control" id="input-image_sert_'+rand_str+'"  readonly  />'+
            '            </a>'+
            '        </div>'+
            '        <div class="wrapper_row_info">'+
            '            <div class="wrap_row_info">'+
            '                <input name="sert[new][caption][]" value="" placeholder="Заголовок" type="text" class="cust_change form-control" />'+
            '                <button type="button" class="r_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>'+
            '            </div>'+
            '        </div>'+
            '    </div>'+
            '</div>';


            $(".media_rows_sert").append(new_itm);

        });

        $(".append_row_off").click(function(){
            var nm=$(this).attr("nm");

            var rand_id=Math.random();
            var rand_str=rand_id.toString().replace(".", "");;
            var new_itm='<div class="media_row about_item_row">'+
            '    <input class="about_item_row_delete" type="hidden" name="'+nm+'[new][delete][]" value="0"/>'+
            '    <div class="about_row_image">'+
            '       <div class="wrapper_row_image">'+
            '           <a href="" id="thumb-image_'+nm+'_'+rand_str+'"  class="img-thumbnail" data-toggle="image">'+
            '               <img src="<?=$image_placeholder?>" alt="" title="" data-placeholder="<?=$image_placeholder?>" />'+
            '               <input name="'+nm+'[new][image][]" value="" type="hidden" class="cust_change form-control" id="input-image_'+nm+'_'+rand_str+'"  readonly  />'+
            '           </a>'+
            '        </div>'+
            '        <div class="wrapper_row_info">'+
            '            <div class="wrap_row_info">'+
            '                <input name="'+nm+'[new][caption][]" value="" placeholder="Заголовок" type="text" class="cust_change form-control" />'+
            '                <button type="button" class="r_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>'+
            '            </div>'+
            '            <input name="'+nm+'[new][video][]" value="" placeholder="Видео" class="video_input form-control" />'+
            '        </div>'+
            '    </div>'+
            '</div>';


            $(".media_rows_"+nm).append(new_itm);

        });

        $(".append_row_cust").click(function(){
            var rand_id=Math.random();
            var rand_str=rand_id.toString().replace(".", "");;
            var new_itm='<div class="cust_row about_item_row">'+
            '    <div class="about_row_image">'+
'<a href="" id="thumb-image_cust_'+rand_str+'"  class="img-thumbnail" data-toggle="image">'+
'    <img src="<?=$image_placeholder?>" alt="" title="" data-placeholder="<?=$image_placeholder?>" />'+
'    <input type="hidden" class="cust_change form-control" id="input-image_cust_'+rand_str+'"  readonly name="customer[new][image][]" value="" />'+
'</a>'+
            '    </div>'+
            '    <div class="cust_row_info">'+
            '        <input class="about_item_row_delete" type="hidden" name="customer[new][delete][]" value="0">'+
            '        <div class="about_row_title _first">ФИО</div>'+
            '        <div class="wrap_row_info">'+
            '            <input type="text" class="cust_change form-control" name="customer[new][fio][]" value="">'+
            '            <button type="button" class="r_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>'+
            '        </div>'+
            '        <div class="about_row_title">Должность</div>'+
            '        <input type="text" class="cust_change form-control" name="customer[new][position][]" value="">'+
            '        <div class="about_row_title">Телефон</div>'+
            '        <input type="text" class="cust_change form-control" name="customer[new][phone][]" value="">'+
            '        <div class="about_row_title">Код</div>'+
            '        <input type="text" class="cust_change form-control" name="customer[new][code][]" value="">'+
            '        <div class="about_row_title">Email</div>'+
            '        <input type="text" class="cust_change form-control" name="customer[new][email][]" value="">'+
            '    </div>'+
            '</div>';
            $(".cust_rows").append(new_itm);
        });


        $(".append_row_about_list").click(function(){
            var prnt=$(this).closest(".about_row")
            var rel=prnt.attr("rel");
            $(this).closest(".wrapper_about_row_list").find(".input_list_change").val("1");

            var new_itm='<div class="about_row_list">'+
                '<div class="about_row_listrow">'+
                '    <div class="about_row_listrow_caption">'+
                '        <input class="list_change form-control marg_right" name="about_block['+rel+'][list][caption][]" type="text" value="" placeholder="Заголовок" />'+
                '        <button type="button" title="" class="list_row_remove btn btn-danger"><i class="fa fa-minus-circle"></i></button>'+
                '    </div>'+
                '    <div class="about_row_listrow_text">'+
                '        <textarea class="list_change form-control" name="about_block['+rel+'][list][text][]" placeholder="Текст"></textarea>'+
                '    </div>'+
                '</div>'+
            '</div>';
            prnt.find(".about_row_lists").append(new_itm);
            
        });
    });
//--></script>  
<script type="text/javascript"><!--
<?php if ($ckeditor) { ?>
    <?php foreach ($languages as $language) { ?>
        ckeditorInit('input-content', getURLVar('token'));
    <?php } ?>
<?php } ?>
//--></script>
<?php echo $footer; ?>