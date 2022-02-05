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
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-review" class="form-horizontal">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab">Основное</a></li>
                        <li class=""><a href="#tab-blocks" data-toggle="tab">Блоки</a></li>
                        <li class=""><a href="#tab-certs" data-toggle="tab">Сертификаты</a></li>
                        <li class=""><a href="#tab-forms" data-toggle="tab">Формы</a></li>

                        <li class=""><a href="#tab-products" data-toggle="tab">Продукты</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-title"><?php echo $entry_title; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="title" value="<?php echo $title; ?>" placeholder="<?php echo $entry_title; ?>" id="input-title" class="form-control" />
                                    <?php if ($error_title) { ?>
                                        <div class="text-danger"><?php echo $error_title; ?></div>
                                    <?php } ?>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-meta_title"><?php echo $entry_meta_title; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="meta_title" value="<?php echo $meta_title; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta_title" class="form-control" />
                                </div>
                            </div>

                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-seo_url">SEO URL</label>
                                <div class="col-sm-10">
                                    <input type="text" name="seo_url" value="<?php echo $seo_url; ?>" placeholder="SEO URL" id="input-seo_url" class="form-control" />
                                    <?php if ($error_seo_url) { ?>
                                        <div class="text-danger"><?php echo $error_seo_url; ?></div>
                                    <?php } ?>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-meta_description"><?php echo $entry_meta_description; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="meta_description" value="<?php echo $meta_description; ?>" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta_description" class="form-control" />
                                </div>
                            </div>                            

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-logotext"><?php echo $entry_logotext; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="logotext" value="<?php echo $logotext; ?>" placeholder="<?php echo $entry_logotext; ?>" id="input-logotext" class="form-control" />                                    
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_tp; ?></label>
                                <div class="col-sm-10">
                                    <select name="tp" id="input-status" class="form-control">
                                        <option value="0" <?=$tp==0?'selected':''?>>Дилеры</option>
                                        <option value="1" <?=$tp==1?'selected':''?>>Реклама</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                                <div class="col-sm-10">
                                    <select name="status" id="input-status" class="form-control">
                                        <?php if ($status) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-blocks">
                            <div class="form-groups">
                                <div class="wrap_form-groups_caption">
                                    <div class="checkbox">                                       
                                        <label class="form-groups_caption" for="block1_status">Блок1
                                            <input <?=$block1_status?'checked':'' ?> type="checkbox" name="block1_status" value="1" id="block1_status">
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block1_caption"><?php echo $entry_block1_caption; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block1_caption" value="<?php echo $block1_caption; ?>" placeholder="<?php echo $entry_block1_caption; ?>" id="input-block1_caption" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block1_image"><?php echo $entry_block1_image; ?></label>
                                    <div class="col-sm-10">
                                        <a href="" id="block1_thumb" data-toggle="image" class="img-thumbnail"><img src="<?php echo $block1_thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                        <input type="hidden" name="block1_image" value="<?php echo $block1_image; ?>" id="input-block1_image" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block1_form_status">Показывать форму</label>
                                    <div class="col-sm-10">
                                        <select name="block1_form_status" id="input-block1_form_status" class="form-control">                                            
                                            <?php if ($block1_form_status) { ?>
                                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                <option value="0"><?php echo $text_disabled; ?></option>
                                            <?php } else { ?>
                                                <option value="1"><?php echo $text_enabled; ?></option>
                                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                            <?php } ?>
                                        
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block1_form_caption">Заголовок формы:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block1_form_caption" value="<?php echo $block1_form_caption; ?>" placeholder="Заголовок формы" id="input-block1_form_caption" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block1_form_text">Проценты:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block1_form_text" value="<?php echo $block1_form_text; ?>" placeholder="Проценты" id="input-block1_form_text" class="form-control" />
                                    </div>
                                </div>
                                
                            </div>

                            <div class="form-groups">
                                <div class="wrap_form-groups_caption">
                                    <div class="checkbox">     
                                        <label class="form-groups_caption" for="block2_status">Блок2                                                                          
                                            <input <?=$block2_status?'checked':'' ?> type="checkbox" name="block2_status" value="1" id="block2_status">
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block2_caption"><?php echo $entry_block2_caption; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block2_caption" value="<?php echo $block2_caption; ?>" placeholder="<?php echo $entry_block2_caption; ?>" id="input-block2_caption" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block2_image"><?php echo $entry_block2_image; ?></label>
                                    <div class="col-sm-10">
                                        <a href="" id="block2_thumb" data-toggle="image" class="img-thumbnail"><img src="<?php echo $block2_thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                        <input type="hidden" name="block2_image" value="<?php echo $block2_image; ?>" id="input-block2_image" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block2_text">Текст:</label>
                                    <div class="col-sm-10">
                                        <textarea name="block2_text"
                                                    placeholder="Текст"
                                                    id="input-block2_text"
                                                    class="form-control summernote">
                                                    <?=$block2_text?>
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="form-groups">
                                <div class="wrap_form-groups_caption">  
                                    <div class="checkbox">     
                                        <label class="form-groups_caption" for="block3_status">Блок3 (Преимущества)
                                            <input <?=$block3_status?'checked':'' ?> type="checkbox" name="block3_status" value="1" id="block3_status">
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block3_caption">Заголовок</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block3_caption" value="<?php echo $block3_caption; ?>" placeholder="Заголовок" id="input-block2_caption" class="form-control" />
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <table id="block3_benefits" class="table table-striped table-bordered table-hover" data-row="<?=count($block3_benefits)?>">
                                        <thead>
                                            <tr>
                                                <td class="text-left">Изображение</td>
                                                <td class="text-left">Текст</td>
                                                <td class="text-right"><?php echo $entry_sort_order; ?></td>
                                                <td></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($block3_benefits as $key=>$block3_benefit) { ?>
                                                <tr id="benefit-row<?=$key ?>">
                                                    <td class="text-left">
                                                        <a href="" id="thumb-block3_benefit<?=$key; ?>" data-toggle="image" class="img-thumbnail">
                                                            <img src="<?=$block3_benefit['thumb'] ?>" data-placeholder="<?=$placeholder?>" />
                                                        </a>
                                                        <input id="input-block3_benefit<?=$key; ?>" type="hidden" name="block3_benefits[<?=$key?>][image]" value="<?=$block3_benefit['image']?>" /></td>
                                                    </td>

                                                    <td class="text-left">
                                                        <input type="text" name="block3_benefits[<?=$key ?>][text]" value="<?=$block3_benefit['text']; ?>" placeholder="Текст" class="form-control" />
                                                    </td>
                                                    <td class="text-left">
                                                        <input type="text" name="block3_benefits[<?=$key ?>][sort_order]" value="<?=$block3_benefit['sort_order']; ?>" placeholder="Порядок сортировки" class="form-control" />
                                                    </td>
                                                    <td class="text-left">
                                                        <button type="button" onclick="$('#benefit-row<?=$key ?>').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                                                    </td>
                                                </tr>
                                            <?php } ?>
                                            
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3"></td>
                                                <td class="text-left">
                                                    <button type="button" onclick="addBlock3Benefit();" data-toggle="tooltip" title="Добавить" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>

                            <div class="form-groups">
                                <div class="wrap_form-groups_caption">  
                                    <div class="checkbox">     
                                        <label class="form-groups_caption" for="block_benefit_pr_status">Преимущества (товары)
                                            <input <?=$block_benefit_pr_status?'checked':'' ?> type="checkbox" name="block_benefit_pr_status" value="1" id="block_benefit_pr_status">
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="table-responsive">
                                    <table id="block_benefit_pr_status_table" class="table table-striped table-bordered table-hover" data-row="<?=count($block_benefit_pr)?>">
                                        <thead>
                                            <tr>
                                                <td class="text-left">Изображение</td>
                                                <td class="text-left">Текст</td>
                                                <td class="text-right"><?php echo $entry_sort_order; ?></td>
                                                <td></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($block_benefit_pr as $key=>$block_benefit_pr) { ?>
                                                <tr id="benefit-pr-row<?=$key ?>">
                                                    <td class="text-left">
                                                        <a href="" id="thumb-block_benefit_pr<?=$key; ?>" data-toggle="image" class="img-thumbnail">
                                                            <img src="<?=$block_benefit_pr['thumb'] ?>" data-placeholder="<?=$placeholder?>" />
                                                        </a>
                                                        <input id="input-block_benefit_pr<?=$key; ?>" type="hidden" name="block_benefit_pr[<?=$key?>][image]" value="<?=$block_benefit_pr['image']?>" /></td>
                                                    </td>

                                                    <td class="text-left">
                                                        <input type="text" name="block_benefit_pr[<?=$key ?>][text]" value="<?=$block_benefit_pr['text']; ?>" placeholder="Текст" class="form-control" />
                                                    </td>
                                                    <td class="text-left">
                                                        <input type="text" name="block_benefit_pr[<?=$key ?>][sort_order]" value="<?=$block_benefit_pr['sort_order']; ?>" placeholder="Порядок сортировки" class="form-control" />
                                                    </td>
                                                    <td class="text-left">
                                                        <button type="button" onclick="$('#benefit-pr-row<?=$key ?>').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                                                    </td>
                                                </tr>
                                            <?php } ?>
                                            
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3"></td>
                                                <td class="text-left">
                                                    <button type="button" onclick="addProductsBenefit();" data-toggle="tooltip" title="Добавить" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                
                            </div>

                            <div class="form-groups">
                                <div class="wrap_form-groups_caption">
                                    <div class="checkbox">     
                                        <label class="form-groups_caption" for="block_video_status">Видео
                                            <input <?=$block_video_status?'checked':'' ?> type="checkbox" name="block_video_status" value="1" id="block_video_status">
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_video_caption">Заголовок</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block_video_caption" value="<?php echo $block_video_caption; ?>" placeholder="Заголовок" id="input-block_video_caption" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-groups">
                                <div class="wrap_form-groups_caption">
                                    <div class="checkbox">                                       
                                        <label class="form-groups_caption" for="block_map_status">Блок (Карта)
                                            <input <?=$block_map_status?'checked':'' ?> type="checkbox" name="block_map_status" value="1" id="block_map_status">
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_map_caption">Заголовок:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block_map_caption" value="<?=$block_map_caption ?>" placeholder="Заголовок" id="input-block_map_caption" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_map_text">Текст:</label>
                                    <div class="col-sm-10">
                                        <textarea name="block_map_text"
                                                    placeholder="Текст"
                                                    id="input-block_map_text"
                                                    class="form-control summernote">
                                                    <?=$block_map_text?>
                                        </textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_map_image">Карта:</label>
                                    <div class="col-sm-10">
                                        <a href="" id="block_map_thumb" data-toggle="image" class="img-thumbnail"><img src="<?=$block_map_thumb ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                        <input type="hidden" name="block_map_image" value="<?=$block_map_image; ?>" id="input-block_map_image" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-groups">
                                <div class="wrap_form-groups_caption">
                                    <div class="checkbox">                                       
                                        <label class="form-groups_caption" for="block_sot_status">Блок (О компании)
                                            <input <?=$block_sot_status?'checked':'' ?> type="checkbox" name="block_sot_status" value="1" id="block_sot_status">
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_sot_caption">Заголовок:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block_sot_caption" value="<?=$block_sot_caption ?>" placeholder="Заголовок" id="input-block_sot_caption" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_sot_subcaption">Подзаголовок:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block_sot_subcaption" value="<?=$block_sot_subcaption ?>" placeholder="Подзаголовок" id="input-block_sot_subcaption" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_sot_text">Текст:</label>
                                    <div class="col-sm-10">
                                        <textarea name="block_sot_text"
                                                    placeholder="Текст"
                                                    id="input-block_sot_text"
                                                    class="form-control summernote">
                                                    <?=$block_sot_text?>
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="form-groups">
                                <div class="wrap_form-groups_caption">
                                    <div class="checkbox">                                       
                                        <label class="form-groups_caption" for="block_bform_status">Блок (Нижняя форма)
                                            <input <?=$block_bform_status?'checked':'' ?> type="checkbox" name="block_bform_status" value="1" id="block_bform_status">
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_bform_caption">Заголовок формы:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block_bform_caption" value="<?=$block_bform_caption ?>" placeholder="Заголовок формы" id="input-block_bform_caption" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_bform_perc">Проценты:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="block_bform_perc" value="<?=$block_bform_perc ?>" placeholder="Заголовок формы" id="input-block_bform_perc" class="form-control" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="tab-pane" id="tab-certs">
                            <div class="wrap_form-groups_caption">
                                <div class="checkbox">                                       
                                    <label class="form-groups_caption" for="block_cert_status">Блок (Сертификаты)
                                        <input <?=$block_cert_status?'checked':'' ?> type="checkbox" name="block_cert_status" value="1" id="block_cert_status">
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-block_cert_caption">Заголовок:</label>
                                <div class="col-sm-10">
                                    <input type="text" name="block_cert_caption" value="<?=$block_cert_caption ?>" placeholder="Заголовок" id="input-block_cert_caption" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-cert_image">Изображение:</label>
                                <div class="col-sm-10">
                                    <a href="" id="block_cert_thumb" data-toggle="image" class="img-thumbnail"><img src="<?php echo $block_cert_thumb; ?>" alt="" title="" data-placeholder="<?=$placeholder; ?>" /></a>
                                    <input type="hidden" name="block_cert_image" value="<?php echo $block_cert_image; ?>" id="input-block_cert_image" />
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-block_cert1_caption">Название файла 1:</label>
                                <div class="col-sm-10">
                                    <input type="text" name="block_cert1_caption" value="<?=$block_cert1_caption ?>" placeholder="Название файла 1" id="input-block_cert1_caption" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-block_cert1_image">Файл 1:</label>
                                <div class="col-sm-10">
                                    <a href="" id="block_cert1_thumb" data-toggle="image" class="img-thumbnail"><img src="<?=$block_cert1_thumb ?>" alt="" title="" data-placeholder="<?=$placeholder; ?>" /></a>
                                    <input type="hidden" name="block_cert1_image" value="<?php echo $block_cert1_image; ?>" id="input-block_cert1_image" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-block_cert2_caption">Название файла 2:</label>
                                <div class="col-sm-10">
                                    <input type="text" name="block_cert2_caption" value="<?=$block_cert2_caption ?>" placeholder="Название файла 2" id="input-block_cert2_caption" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="block_cert2_image">Файл 2:</label>
                                <div class="col-sm-10">
                                    <a href="" id="block_cert2_thumb" data-toggle="image" class="img-thumbnail"><img src="<?=$block_cert2_thumb ?>" alt="" title="" data-placeholder="<?=$placeholder; ?>" /></a>
                                    <input type="hidden" name="block_cert2_image" value="<?php echo $block_cert2_image; ?>" id="input-block_cert2_image" />
                                </div>
                            </div>

                            
                        </div>
                        
                        <div class="tab-pane" id="tab-forms">
                           <div class="form-groups">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-mail1">Email:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="mail1" value="<?=$mail1 ?>" placeholder="Email" id="input-mail1" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_mailthanks">Текст спасибо (Верхняя форма):</label>
                                    <div class="col-sm-10">
                                        <textarea name="mailthanks"
                                                    placeholder="Текст"
                                                    id="input-mailthanks"
                                                    class="form-control summernote">
                                                    <?=$mailthanks?>
                                        </textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_mailthanks_full">Текст спасибо (Нижняя форма):</label>
                                    <div class="col-sm-10">
                                        <textarea name="mailthanks_full"
                                                    placeholder="Текст"
                                                    id="input-mailthanks_full"
                                                    class="form-control summernote">
                                                    <?=$mailthanks_full?>
                                        </textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-block_mailthanks_modal">Текст спасибо (Всплывающая форма):</label>
                                    <div class="col-sm-10">
                                        <textarea name="mailthanks_modal"
                                                    placeholder="Текст"
                                                    id="input-mailthanks_modal"
                                                    class="form-control summernote">
                                                    <?=$mailthanks_modal?>
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-products">
                           <div class="form-groups">
                                <div class="wrap_form-groups_caption">
                                    <div class="checkbox">                                       
                                        <label class="form-groups_caption" for="block_pr_status">Блок (Продукты)
                                            <input <?=$block_pr_status?'checked':'' ?> type="checkbox" name="block_pr_status" value="1" id="block_pr_status">
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="lang_products_header" rel="<?=count($tabs)?>">
                                    <ul>
                                        <?php foreach($tabs as $tab_key=>$tab){?>
                                            <li class="<?=($tab_key==0)?'active':''?>" data-rel="<?=$tab_key?>"><?=$tab['name']?></li>
                                        <?php }?>
                                    </ul>
                                    <button type="button" onclick="addTabProducts();" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Добавить"><i class="fa fa-plus-circle"></i></button>

                                </div>

<div id="hidden_products" style="display:none;">
    <div class="wrap_accia_products wrap_analog_products">
        <?php foreach($categories_tree as $category){?>
            <div class="accia_catalog_row acc_cat_caption" rel="<?php echo $category['category_id'];?>">
                <div class="accia_catalog_left">
                    <div class="accia_column_category_caption"><?php echo $category["name"];?></div>
                </div>
                <div class="accia_catalog_right"></div>
            </div>
            <?php if(isset($category["list"])){ ?>
                <div class="subcat_wrapper" rel="<?php echo $category['category_id'];?>">
                <?php foreach($category["list"] as $category_item){?>

                    <div class="accia_catalog_row acc_cat_caption" rel="<?php echo $category_item['category_id'];?>">
                        <div class="accia_catalog_left">
                            <div class="accia_column_subcategory_caption"><?php echo $category_item["name"];?></div>
                        </div>
                        <div class="accia_catalog_right">
                            <?php if(isset($products[$category_item["category_id"]])){ foreach($products[$category_item["category_id"]] as $product){?>
                                <div class="product_used_analog <?php echo isset($product_analogs[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo html_entity_decode($product["name"]);?></div>
                            <?php }}?>
                        </div>
                    </div>

                    <?php if(isset($category_item["list"])){ ?>
                        <div class="subcat_wrapper" rel="<?php echo $category_item['category_id'];?>">
                            <?php foreach($category_item["list"] as $category_item_child){?>
                            <div class="accia_catalog_row">
                                <div class="accia_catalog_left">
                                    <div class="accia_column_subcategory_caption _sub"><?php echo $category_item_child["name"];?></div>
                                </div>
                                <div class="accia_catalog_right">
                                    <?php if(isset($products[$category_item_child["category_id"]])){ foreach($products[$category_item_child["category_id"]] as $product){?>
                                        <div class="product_used_analog <?php echo isset($product_analogs[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo html_entity_decode($product["name"]);?></div>
                                    <?php }}?>
                                </div>
                                
                            </div>
                            <?php }?>
                        </div>
                    <?php }?>
                <?php }?>
                </div>
            <?php }?>
        <?php }?>
    </div>
</div>

                                <div class="lang_products_blocks">
                                    <?php foreach($tabs as $tab_key=>$tab){?>
                                        <div class="lang_products_block" data-rel="<?=$tab_key?>" <?=($tab_key==0)?'style="display:block;"':'' ?>>

<input name="change[<?=$tab_key?>]" id="land_product_change<?=$tab_key?>" type="hidden"/>
<input name="product_list[<?=$tab_key?>]" id="land_product_list<?=$tab_key?>" type="hidden"/>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-tab<?=$tab_key?>_name">Название блока:</label>
                                                <div class="col-sm-10">
                                                    <input class="land_tab_name form-control" type="text" name="tab[<?=$tab_key?>][name]" value="<?=$tab['name'] ?>" placeholder="Название" id="input-tab<?=$tab_key?>_name" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-tab_caption">Заголовок:</label>
                                                <div class="col-sm-10">
                                                    <input type="text" name="tab[<?=$tab_key?>][caption]" value="<?=$tab['caption'] ?>" placeholder="Заголовок" id="input-tab<?=$tab_key?>_caption" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-tab<?=$tab_key?>_button">Кнопка:</label>
                                                <div class="col-sm-10">
                                                    <input type="text" name="tab[<?=$tab_key?>][button]" value="<?=$tab['button'] ?>" placeholder="Кнопка" id="input-tab<?=$tab_key?>_button" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-tab<?=$tab_key?>_file">Файл:</label>
                                                <div class="col-sm-10">
                                                    <div class="input-group">
                                                        <input type="text" name="tab[<?=$tab_key?>][file]" value="<?=$tab['file'] ?>" placeholder="Имя файла" id="input-tab<?=$tab_key?>_file" class="form-control">
                                                        <span class="input-group-btn">
                                                        <button  class="upload_butts btn btn-primary" data-rel="input-tab<?=$tab_key?>_file" type="button" id="button-button-tab<?=$tab_key?>_file" data-loading-text="Загрузка..."><i class="fa fa-upload"></i> Загрузить</button>
                                                        </span> 
                                                    </div>
                                                </div>    
                                            </div>
                                            <div class="landing_block_products">
<div class="wrap_accia_products wrap_analog_products">

    <?php foreach($categories_tree as $category){?>
        <div class="accia_catalog_row acc_cat_caption" rel="<?php echo $category['category_id'];?>">
            <div class="accia_catalog_left">
                <div class="accia_column_category_caption"><?php echo $category["name"];?></div>
            </div>
            <div class="accia_catalog_right"></div>
        </div>
        <?php if(isset($category["list"])){ ?>
            <div class="subcat_wrapper" rel="<?php echo $category['category_id'];?>">
            <?php foreach($category["list"] as $category_item){?>

                <div class="accia_catalog_row acc_cat_caption" rel="<?php echo $category_item['category_id'];?>">
                    <div class="accia_catalog_left">
                        <div class="accia_column_subcategory_caption"><?php echo $category_item["name"];?></div>
                    </div>
                    <div class="accia_catalog_right">
                        <?php if(isset($products[$category_item["category_id"]])){ foreach($products[$category_item["category_id"]] as $product){?>
                            <div class="product_used_analog <?php echo in_array($product['product_id'], $product_list[$tab_key])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo html_entity_decode($product["name"]);?></div>
                        <?php }}?>
                    </div>
                </div>

                <?php if(isset($category_item["list"])){ ?>
                    <div class="subcat_wrapper" rel="<?php echo $category_item['category_id'];?>">
                        <?php foreach($category_item["list"] as $category_item_child){?>
                        <div class="accia_catalog_row">
                            <div class="accia_catalog_left">
                                <div class="accia_column_subcategory_caption _sub"><?php echo $category_item_child["name"];?></div>
                            </div>
                            <div class="accia_catalog_right">
                                <?php if(isset($products[$category_item_child["category_id"]])){ foreach($products[$category_item_child["category_id"]] as $product){?>
                                    <div class="product_used_analog <?php echo in_array($product['product_id'], $product_list[$tab_key])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo html_entity_decode($product["name"]);?></div>
                                <?php }}?>
                            </div>
                            
                        </div>
                        <?php }?>
                    </div>
                <?php }?>
            <?php }?>
            </div>
        <?php }?>
    <?php }?>
</div>
                                            </div>
                                        </div>
                                    <?php }?>

                                
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

<script type="text/javascript"><!--
    $(".lang_products_block").each(function(){
        var rel=$(this).data("rel");
        products_selected_analog(rel);
    });
    
    $(document).on("click",".accia_column_subcategory_caption",function(){           
        if($(this).hasClass("active")){
            $(this).removeClass("active");
            $(this).closest(".accia_catalog_row").find(".product_used_analog").removeClass("_active")
            $(this).closest(".accia_catalog_row").find(".product_used_accompany").removeClass("_active")                     
        }else{
            $(this).addClass("active");
            $(this).closest(".accia_catalog_row").find(".product_used_analog").addClass("_active")
            $(this).closest(".accia_catalog_row").find(".product_used_accompany").addClass("_active")
        }
        var rel=$(this).closest(".lang_products_block").data("rel")
        products_selected_analog(rel);
    });
    
    $(".product_used_analog._active").each(function(){
        $(this).parents(".subcat_wrapper").show();
    });
    $(document).on("click",".product_used_analog",function(e){
        if(e.ctrlKey){
            var rel=$(this).attr("rel");
            window.open("../admin/index.php?route=catalog/product/edit&token=<?=$token?>&product_id="+rel+"&tab=tab-lp");
        }else{
            $(this).toggleClass("_active");
            var rel=$(this).closest(".lang_products_block").data("rel")
            products_selected_analog(rel);
        }
    });
    function products_selected_analog(rel){
        var products_used=[];

        $(".lang_products_block[data-rel='"+rel+"'] .product_used_analog._active").each(function(){
            var product_id=$(this).attr("rel");
            products_used.push(product_id);
        });
        //console.log(products_used);
        $("#land_product_change"+rel).val(1);
        $("#land_product_list"+rel).val(products_used.join(","));

        //$("#land_product_change").val(1);
        //$("#products_analog").val(products_used.join(","));
        
        //<input name="change[<?=$tab_key?>]" class="land_product_change"

    }
    var landing_block_products=$("#hidden_products").html();
    function addTabProducts(){
        //var cnt=$(".lang_products_header").data("tab")*1;
        var cnt=$(".lang_products_header").attr("rel")*1;
        $(".lang_products_header li").removeClass("active")
        $(".lang_products_block").hide();

        var new_tab='<li class="active" data-rel="'+cnt+'">Новая вкладка</li>';
        $(".lang_products_header ul").append(new_tab);

        

        var new_block='<div class="lang_products_block" data-rel="'+cnt+'" style="display: block;">'+
            '<input name="change['+cnt+']" id="land_product_change'+cnt+'" type="hidden"/>'+
            '<input name="product_list['+cnt+']" id="land_product_list'+cnt+'" type="hidden"/>'+
            '<div class="form-group">'+
            '    <label class="col-sm-2 control-label" for="input-tab'+cnt+'_name">Название блока:</label>'+
            '    <div class="col-sm-10">'+
            '        <input class="land_tab_name form-control" type="text" name="tab['+cnt+'][name]" value="" placeholder="Название" id="input-tab'+cnt+'_name">'+
            '    </div>'+
            '</div>'+
            '<div class="form-group">'+
            '    <label class="col-sm-2 control-label" for="input-tab_caption">Заголовок:</label>'+
            '    <div class="col-sm-10">'+
            '        <input type="text" name="tab['+cnt+'][caption]" value="" placeholder="Заголовок" id="input-tab'+cnt+'_caption" class="form-control">'+
            '    </div>'+
            '</div>'+
            '<div class="form-group">'+
            '    <label class="col-sm-2 control-label" for="input-tab'+cnt+'_button">Кнопка:</label>'+
            '    <div class="col-sm-10">'+
            '        <input type="text" name="tab['+cnt+'][button]" value="" placeholder="Кнопка" id="input-tab'+cnt+'_button" class="form-control">'+
            '    </div>'+
            '</div>'+
            '<div class="form-group">'+
            '    <label class="col-sm-2 control-label" for="input-tab'+cnt+'_file">Файл:</label>'+
            '    <div class="col-sm-10">'+
            '        <div class="input-group">'+
            '            <input type="text" name="tab['+cnt+'][file]" value="" placeholder="Имя файла" id="input-tab'+cnt+'_file" class="form-control">'+
            '            <span class="input-group-btn">'+
            '            <button class="upload_butts btn btn-primary" data-rel="input-tab'+cnt+'_file" type="button" id="button-tab'+cnt+'_file" data-loading-text="Загрузка..."><i class="fa fa-upload"></i> Загрузить</button>'+
            '            </span>'+
            '        </div>'+
            '    </div>'+
            '</div>'+
            '<div class="landing_block_products">'+landing_block_products+'</div>'+
        '</div>';
        
        
        $(".lang_products_blocks").append(new_block);
        $(".lang_products_header").attr("rel",(cnt*1+1))
        //$(".lang_products_header").data("tab",17)
        
    }

    $(document).on("keyup",".land_tab_name",function(){
        var vl=$(this).val();
        var rel=$(this).closest(".lang_products_block").data("rel");
        
        $(".lang_products_header li[data-rel='"+rel+"']").html(vl);
    });

    $(document).on("click",".acc_cat_caption",function(){
        var rel=$(this).attr("rel");
        $(".subcat_wrapper[rel='"+rel+"']").slideToggle(200);
        $(this).toggleClass("active");
    });
    
    $(document).on("click",".lang_products_header li",function(){
        $(".lang_products_header li").removeClass("active");
        $(this).addClass("active");
        var rel=$(this).data("rel");
        $(".lang_products_block").hide();
        $(".lang_products_block[data-rel='"+rel+"']").show();
    });

function addProductsBenefit(){
    var i=$("#block_benefit_pr_status_table").data("row")*1;

    var new_item='<tr id="benefit-pr-row'+i+'">'+
                '   <td class="text-left">'+
                '       <a href="" id="thumb-block_benefit_pr'+i+'" data-toggle="image" class="img-thumbnail">'+
                '           <img src="<?=$placeholder?>" data-placeholder="<?=$placeholder?>" />'+
                '       </a>'+
                '       <input id="input-block_benefit_pr'+i+'" type="hidden" name="block_benefit_pr['+i+'][image]" value="" /></td>'+
                '   </td>'+
                '   <td class="text-left">'+
                '       <input type="text" name="block_benefit_pr['+i+'][text]" value="" placeholder="Текст" class="form-control" />'+
                '   </td>'+
                '   <td class="text-left">'+
                '       <input type="text" name="block_benefit_pr['+i+'][sort_order]" value="" placeholder="Порядок сортировки" class="form-control" />'+
                '   </td>'+
                '   <td class="text-left">'+
                '       <button type="button" onclick="$(\'#benefit-pr-row'+i+'\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>'+
                '   </td>'+
                '</tr>';
    //console.log(new_item);
    $("#block_benefit_pr_status_table tbody").append(new_item);
    $("#block_benefit_pr_status_table").data("row",i+1)
}

    function addBlock3Benefit(){
    var i=$("#block3_benefits").data("row")*1;
    //<table id="block3_benefits" class="table table-striped table-bordered table-hover" data-row="<?=count($block3_benefits)?>">

    var new_item='<tr id="benefit-row'+i+'">'+
                '   <td class="text-left">'+
                '       <a href="" id="thumb-block3_benefit'+i+'" data-toggle="image" class="img-thumbnail">'+
                '           <img src="<?=$placeholder?>" data-placeholder="<?=$placeholder?>" />'+
                '       </a>'+
                '       <input id="input-block3_benefit'+i+'" type="hidden" name="block3_benefits['+i+'][image]" value="" /></td>'+
                '   </td>'+
                '   <td class="text-left">'+
                '       <input type="text" name="block3_benefits['+i+'][text]" value="" placeholder="Текст" class="form-control" />'+
                '   </td>'+
                '   <td class="text-left">'+
                '       <input type="text" name="block3_benefits['+i+'][sort_order]" value="" placeholder="Порядок сортировки" class="form-control" />'+
                '   </td>'+
                '   <td class="text-left">'+
                '       <button type="button" onclick="$(\'#benefit-row'+i+'\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>'+
                '   </td>'+
                '</tr>';
    //console.log(new_item);
    $("#block3_benefits tbody").append(new_item);
    $("#block3_benefits").data("row",i+1)
}

$(document).on('click','.upload_butts', function() {
    var rel=$(this).data("rel");
	$('#form-upload').remove();
	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
	$('#form-upload input[name=\'file\']').trigger('click');
	
	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}
	
	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);		
			
			$.ajax({
				url: 'index.php?route=catalog/landing/upload&token=<?=$token ?>',
				type: 'post',		
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,		
				beforeSend: function() {
					$('#button-upload').button('loading');
				},
				complete: function() {
					$('#button-upload').button('reset');
				},	
				success: function(json) {
					if (json['error']) {
						alert(json['error']);
					}								
					if (json['success']) {
						alert(json['success']);
						//$('input[name=\'filename\']').val(json['filename']);
                        $("#"+rel).val(json['filename']);

						//$('input[name=\'mask\']').val(json['mask']);
					}
				},			
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>


<script type="text/javascript">
  <?php if ($ckeditor) { ?>
      ckeditorInit('input-description', getURLVar('token'));
  <?php } ?>

</script>

<?php echo $footer; ?>