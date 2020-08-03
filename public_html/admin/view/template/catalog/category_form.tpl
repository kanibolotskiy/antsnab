<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-category" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-category" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
            <li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
            <li><a href="#tab-filter" data-toggle="tab"><?php echo $tab_filter; ?></a></li>
            <li><a href="#tab-search" data-toggle="tab"><?php echo $tab_search; ?></a></li>
            <!--<li><a href="#tab-design" data-toggle="tab"><?php echo $tab_design; ?></a></li>-->
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-general">
              <ul class="nav nav-tabs" id="language">
                <?php foreach ($languages as $language) { ?>
                <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                <?php } ?>
              </ul>
              <div class="tab-content">
                <?php foreach ($languages as $language) { ?>
                <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                  
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="category_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                      <?php if (isset($error_name[$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                      <?php } ?>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-isseo">
                        <?php echo $entry_isseo; ?>
                    </label>
                    <div class="col-sm-1">
                      <div class="checkbox">
                        <label>
                          <?php if($isseo) { ?>
                          <input  type="checkbox" name="isseo" value="1" checked="checked" id="input-isseo" />
                          <?php } else { ?>
                          <input type="checkbox" name="isseo" value="1" id="input-isseo" />
                          <?php } ?>
                          &nbsp; </label>
                      </div>
                    </div>
                    
                  </div>

                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-isbrand">
                        <?php echo $entry_isbrand; ?>
                    </label>
                    <div class="col-sm-1">
                      <div class="checkbox">
                        <label>
                          <?php if($isbrand) { ?>
                          <input  type="checkbox" name="isbrand" value="1" checked="checked" id="input-isbrand" />
                          <?php } else { ?>
                          <input type="checkbox" name="isbrand" value="1" id="input-isbrand" />
                          <?php } ?>
                          &nbsp; </label>
                      </div>
                    </div>
                    
                  </div>

                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-notshowisseo">
                        <?php echo $entry_notshowisseo; ?>
                    </label>
                    <div class="col-sm-1">
                      <div class="checkbox">
                        <label>
                          <?php if($notshowisseo) { ?>
                          <input  type="checkbox" name="notshowisseo" value="1" checked="checked" id="input-notshowisseo" />
                          <?php } else { ?>
                          <input type="checkbox" name="notshowisseo" value="1" id="input-notshowisseo" />
                          <?php } ?>
                          &nbsp; </label>
                      </div>
                    </div>
                    
                  </div>


                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                    <div class="col-sm-10">
                      <textarea name="category_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['description'] : ''; ?></textarea>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-meta-title<?php echo $language['language_id']; ?>"><?php echo $entry_meta_title; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="category_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_title'] : ''; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title<?php echo $language['language_id']; ?>" class="form-control" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-meta-h1<?php echo $language['language_id']; ?>"><?php echo $entry_meta_h1; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="category_description[<?php echo $language['language_id']; ?>][meta_h1]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_h1'] : ''; ?>" placeholder="<?php echo $entry_meta_h1; ?>" id="input-meta-h1<?php echo $language['language_id']; ?>" class="form-control" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-meta-description<?php echo $language['language_id']; ?>"><?php echo $entry_meta_description; ?></label>
                    <div class="col-sm-10">
                      <textarea name="category_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-meta-keyword<?php echo $language['language_id']; ?>"><?php echo $entry_meta_keyword; ?></label>
                    <div class="col-sm-10">
                      <textarea name="category_description[<?php echo $language['language_id']; ?>][meta_keyword]" rows="5" placeholder="<?php echo $entry_meta_keyword; ?>" id="input-meta-keyword<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-bottom_text<?php echo $language['language_id']; ?>"><?php echo $entry_bottom_text; ?></label>
                    <div class="col-sm-10">
                      <textarea name="category_description[<?php echo $language['language_id']; ?>][bottom_text]" rows="5" placeholder="<?php echo $entry_bottom_text; ?>" id="input-meta-keyword<?php echo $language['language_id']; ?>" class="form-control summernote"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['bottom_text'] : ''; ?></textarea>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-discount"><?php echo $entry_discount; ?></label>
                    <div class="col-sm-10">
                        <select id="input-discount" name="discount" class="form-control">
                            <option value="0" selected="selected"><?php echo $text_none; ?></option>
                            <?php foreach ($discounts as $discount_itm) { ?>
                                <?php if ($discount_itm['discount_id'] == $discount) { ?>
                                    <option value="<?php echo $discount_itm['discount_id']; ?>" selected="selected"><?php echo $discount_itm['name']; ?></option>
                                <?php } else { ?>
                                    <option value="<?php echo $discount_itm['discount_id']; ?>"><?php echo $discount_itm['name']; ?></option>
                                <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                  </div>
                </div>
                <?php } ?>
              </div>
            </div>
            <div class="tab-pane" id="tab-data">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-parent"><?php echo $entry_parent; ?></label>
                <div class="col-sm-10">
                  <select name="parent_id" class="form-control">
                    <option value="0" selected="selected"><?php echo $text_none; ?></option>
                    <?php foreach ($categories as $category) { ?>
                    <?php if ($category['category_id'] == $parent_id) { ?>
                    <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>

              
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-isfinal">
                    <span data-toggle="tooltip">
                        <?php echo $entry_isfinal; ?>
                    </span>
                </label>
                <div class="col-sm-1">
                  <div class="checkbox">
                    <label>
                      <?php if ($isfinal) { ?>
                      <input  type="checkbox" name="isfinal" value="1" checked="checked" id="input-isfinal" />
                      <?php } else { ?>
                      <input type="checkbox" name="isfinal" value="1" id="input-isfinal" />
                      <?php } ?>
                      &nbsp; </label>
                  </div>
                </div>
                <div class="col-sm-9">
                    <?php if ($isfinal) : ?>
                       <a target="_blank" id="category_prodproperties_link" href="<?=$category_prodproperties?>">
                        <?=$entry_category_prodproperties?>
                       </a>
                    <?php else: ?>
                       <a target="_blank" style="display:none" id="category_prodproperties_link" href="<?=$category_prodproperties?>">
                        <?=$entry_category_prodproperties?>
                       </a>
                    <?php endif ?>
                </div>
                    <script type="text/javascript">
                        $(window).on('load', function(){
                            $('#input-isfinal').on('change', function(){
                                var $el = $(this),
                                    state = $el.prop("checked"),
                                    $link = $('#category_prodproperties_link');

                                if( true === state ) {
                                    $link.css('display', 'block');
                                } else {
                                    $link.css('display', 'none');
                                }
                            });
                        });
                    </script>
              </div>  
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-filter"><span data-toggle="tooltip" title="<?php echo $help_filter; ?>"><?php echo $entry_filter; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="filter" value="" placeholder="<?php echo $entry_filter; ?>" id="input-filter" class="form-control" />
                  <div id="category-filter" class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($category_filters as $category_filter) { ?>
                    <div id="category-filter<?php echo $category_filter['filter_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $category_filter['name']; ?>
                      <input type="hidden" name="category_filter[]" value="<?php echo $category_filter['filter_id']; ?>" />
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_store; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <div class="checkbox">
                      <label>
                        <?php if (in_array(0, $category_store)) { ?>
                        <input type="checkbox" name="category_store[]" value="0" checked="checked" />
                        <?php echo $text_default; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="category_store[]" value="0" />
                        <?php echo $text_default; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php foreach ($stores as $store) { ?>
                    <div class="checkbox">
                      <label>
                        <?php if (in_array($store['store_id'], $category_store)) { ?>
                        <input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                        <?php echo $store['name']; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" />
                        <?php echo $store['name']; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-benefits"><?php echo $entry_benefits; ?></span></label>
                  <div class="col-sm-10">
                      <input type="text" name="benefits" value="" placeholder="<?php echo $entry_benefits; ?>" id="input-benefits" class="form-control" />
                      <div id="product-benefits" class="well well-sm" style="height: 150px; overflow: auto;">
                          <?php foreach ($product_benefits as $product_benefit) { ?>
                              <div id="product-benefit<?php echo $product_benefit['benefit_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product_benefit['name']; ?>
                                  <input type="hidden" name="product_benefit[]" value="<?php echo $product_benefit['benefit_id']; ?>" />
                              </div>
                          <?php } ?>
                      </div>
                  </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-calc"><?php echo $entry_calc; ?></label>
                <div class="col-sm-10">
                    <select id="input-calc" name="calc" class="form-control">
                        <option value="0" selected="selected"><?php echo $text_none; ?></option>
                        <?php foreach ($calcs as $calc_itm) { ?>
                            <?php if ($calc_itm['calc_id'] == $calc) { ?>
                                <option value="<?php echo $calc_itm['calc_id']; ?>" selected="selected"><?php echo $calc_itm['name']; ?></option>
                            <?php } else { ?>
                                <option value="<?php echo $calc_itm['calc_id']; ?>"><?php echo $calc_itm['name']; ?></option>
                            <?php } ?>
                        <?php } ?>
                    </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-keyword"><span data-toggle="tooltip" title="<?php echo $help_keyword; ?>"><?php echo $entry_keyword; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="keyword" value="<?php echo $keyword; ?>" placeholder="<?php echo $entry_keyword; ?>" id="input-keyword" class="form-control" />
                  <?php if ($error_keyword) { ?>
                  <div class="text-danger"><?php echo $error_keyword; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_image; ?></label>
                <div class="col-sm-10"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-top"><span data-toggle="tooltip" title="<?php echo $help_top; ?>"><?php echo $entry_top; ?></span></label>
                <div class="col-sm-10">
                  <div class="checkbox">
                    <label>
                      <?php if ($top) { ?>
                      <input type="checkbox" name="top" value="1" checked="checked" id="input-top" />
                      <?php } else { ?>
                      <input type="checkbox" name="top" value="1" id="input-top" />
                      <?php } ?>
                      &nbsp; </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-column"><span data-toggle="tooltip" title="<?php echo $help_column; ?>"><?php echo $entry_column; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="column" value="<?php echo $column; ?>" placeholder="<?php echo $entry_column; ?>" id="input-column" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
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
            </div>

            <div class="tab-pane" id="tab-filter">
              <div class="table-responsive">
                <input type="text" name="change_params" value="0" id="change_params"/>

                <table id="filters" class="table table-solid table-bordered table-hover">
                    <thead>
                        <tr>
                            <td class="text-left" style="width:200px;">Название параметра</td>
                            <td class="text-left" style="width:100px;">Транслит</td>
                            <td class="text-left" style="min-width:100px;">Ед. изм.</td>
                            <td class="text-left" style="min-width:200px;">Тип<br/>параметра</td>
                            <td class="text-left" style="min-width:200px;">Тип сортировки<br/>значений параметров</td>
                            <td class="text-left" style="width:700px;">Возможные значения</td>
                            <td class="text-left" style="width: 80px;">Сортировка</td>
                            <td></td>
                        </tr>
                    </thead>
                    <tbody>

                      <?php $z=0;for($i=0;$i<count($cat_filters);$i++){?>
                        <tr id="filter-row<?php echo $i; ?>">
                          <td class="text-left">
                            <input type="text" name="cat_filter[<?php echo $cat_filters[$i]["id"];?>][name]" value="<?php echo $cat_filters[$i]['name']; ?>" class="change_form_param form-control" />
                          </td>
                          <td class="text-left">
                            <input type="text" name="cat_filter[<?php echo $cat_filters[$i]["id"];?>][translit]" value="<?php echo $cat_filters[$i]['translit']; ?>" class="change_form_param form-control" />
                          </td>

                          <td class="text-left">
                            <input type="text" name="cat_filter[<?php echo $cat_filters[$i]["id"];?>][unit]" value="<?php echo $cat_filters[$i]['unit']; ?>" class="change_form_param form-control" />
                          </td>
                          
                          <td class="text-left">  
                            <?php if(count($cat_filters[$i]["products"])){?>
                              <input type="hidden" name="cat_filter[<?php echo $cat_filters[$i]["id"];?>][type_param]" value="<?php echo $cat_filters[$i]['type_param'];?>">
                            <?php }?>
                            <select  <?php echo count($cat_filters[$i]["products"])?"disabled='disabled'":"";?>  class="form-control change_form_param change_form_paramlist" name="cat_filter[<?php echo $cat_filters[$i]["id"];?>][type_param]" value="<?php $cat_filters[$i]['type_param'];?>">
                              <option value="0" <?php echo ($cat_filters[$i]['type_param']==0?"selected":"");?> >Значение</option>
                              <option value="1" <?php echo ($cat_filters[$i]['type_param']==1?"selected":"");?> >Диапазон</option>
                              <option value="2" <?php echo ($cat_filters[$i]['type_param']==2?"selected":"");?> >Значение(совпадение)</option>
                            </select>
                          </td>
                          <td class="text-left">
                            <div class="param_block1">
                              <select class="form-control change_form_param" name="cat_filter[<?php echo $cat_filters[$i]["id"];?>][param_sort_type]" value="<?php $cat_filters[$i]['param_sort_type'];?>">
                                <option class="param_block1" <?php echo ($cat_filters[$i]['type_param']==1?"style='display:none;'":""); ?> value="0" <?php echo (($cat_filters[$i]['param_sort_type']==0 and $cat_filters[$i]['type_param']!=1)?"selected":"");?> >По релевантности</option>
                                <option class="param_block1" <?php echo ($cat_filters[$i]['type_param']==1?"style='display:none;'":""); ?> value="1" <?php echo (($cat_filters[$i]['param_sort_type']==1 and $cat_filters[$i]['type_param']!=1)?"selected":"");?> >По алфавиту</option>
                                <option class="param_block2" <?php echo ($cat_filters[$i]['type_param']==1?"":"style='display:none;'"); ?> value="0" <?php echo (($cat_filters[$i]['param_sort_type']==0 and $cat_filters[$i]['type_param']==1)?"selected":"");?> >Диапазон(темп)</option>
                                <option class="param_block2" <?php echo ($cat_filters[$i]['type_param']==1?"":"style='display:none;'"); ?> value="1" <?php echo (($cat_filters[$i]['param_sort_type']==1 and $cat_filters[$i]['type_param']==1)?"selected":"");?> >Диапазон</option>
                              </select>
                            </div>

                          
                            

                          </td>
                          <td class="text-left">
                              
                              <div class="param_block1" <?php echo ($cat_filters[$i]["type_param"]==1)?'style="display:none;"':'style="display:block;"';?>>
                                <div class="product_availparam_list" rel="<?php echo $cat_filters[$i]["id"];?>">
                                    <?php foreach($cat_filters[$i]["list"] as $param_item){?>
                                        <div class="wrp_used_item">
                                          <input class="input_param_hidden" name="param_value[<?php echo $cat_filters[$i]['id']; ?>][<?php echo $param_item["id"];?>]" type="text" value="<?php echo $param_item["param_value"];?>" />
                                          <span class="used_item" rel="<?php echo $param_item["id"];?>">
                                            <div class="input_param_wrp">
                                              <div class="input_param_val"><?php echo $param_item["param_value"];?></div>                
                                            </div>
                                            <div class="del_used_item del_used_item_<?php echo count($param_item["products"]);?>">
                                              <div class="del_used_items" rel="<?php echo count($param_item["products"]);?>">
                                                <?php foreach($param_item["products"] as $linked_prod){?>
                                                  <div class="unable_delete_list_row">
                                                    <a href="<?php echo $linked_prod["url"];?>" target="_blank"><?php echo $linked_prod["name"];?></a>
                                                  </div>
                                                <?php }?>
                                              </div>
                                            </div>
                                          </span>
                                        </div>
                                    <?php }?>
                                </div>
                                <div class="wrp_add_paramvalue">
                                    <div class="add_param_caption">Добавить значение:</div> 
                                    <input type="text" class="add_param_input form-control"/> 
                                    <div class="add_param">>></div>
                                </div>
                              </div>
                              <div class="param_block2" <?php echo ($cat_filters[$i]["type_param"]==1)?'style="display:block;"':'style="display:none;"';?>>
                                <div class="wrp_step_input">
                                  <div class="add_param_caption">Шаг:</div> 
                                  <input type="text" name="cat_filter[<?php echo $cat_filters[$i]["id"];?>][step]" class="change_form_param step_input form-control" value="<?php echo $cat_filters[$i]['step'];?>" /> 
                                </div>
                              </div>
                              <div class="unable_delete">
                                <div class="unable_delete_cap">Невозможно удалить значение:</div>
                                <div class="unable_delete_subcap">Связанные продукты:</div>
                                <div class="unable_delete_list"></div>
                              </div>
                              
                          </td>
                          <td class="text-left">
                            <input type="number" name="cat_filter[<?php echo $cat_filters[$i]["id"];?>][sort_order]" value="<?php echo $cat_filters[$i]['sort_order']; ?>" class="change_form_param form-control sort_order_filter" />
                          </td>

                          
                          <td class="text-left">
                            <button class="remove_item_param btn-danger btn btn-danger_<?php echo count($cat_filters[$i]["products"]);?>" type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>"><i class="fa fa-minus-circle"></i>
                              <div class="del_used_items">
                                <?php foreach($cat_filters[$i]["products"] as $linked_prod){?>
                                  <div class="unable_delete_list_row">
                                    <a href="<?php echo $linked_prod["url"];?>" target="_blank"><?php echo $linked_prod["name"];?></a>
                                  </div>
                                <?php }?>
                              </div>
                            </button>
                          </td>

                        </tr>
                        
                      <?php $z++;}?>

                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="7"></td>
                            <td class="text-left"><button type="button" onclick="addFilter();" data-toggle="tooltip" title="<?php echo $button_filter_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            </div>
            <div class="tab-pane" id="tab-search">
              <div class="wrap_accia_products search_catalog_products">
                <?php foreach($categories_tree as $category){?>
                  <div class="cat_products_fnd accia_catalog_row acc_cat_caption" rel="<?php echo $category['category_id'];?>">
                      <div class="accia_catalog_left">
                          <div class="accia_column_category_caption"><?php echo $category["name"];?></div>
                      </div>
                      <div class="accia_catalog_right"></div>
                  </div>
                  <?php if(isset($products_list[$category['category_id']])){?>
                    <div class="cat_product_list" rel="<?php echo $category['category_id'];?>">
                      <?php foreach($products_list[$category['category_id']] as $itm){?>
                        <div class="accia_catalog_row">
                          <div class="accia_catalog_left accia_product_left">
                            <?=$itm["name"] ?>
                          </div>
                          <div class="accia_catalog_right">
                            <textarea rows="1" class="search_append_text" name=""><?=$itm['search']?></textarea>
                          </div>
                        </div>
                      <?php }?>
                    </div>
                  <?php }?>
                  <?php if(isset($category["list"])){ ?>
                      <div class="subcat_wrapper" rel="<?php echo $category['category_id'];?>">
                      <?php foreach($category["list"] as $category_item){?>
                          
                          <div class="cat_products_fnd accia_catalog_row acc_cat_caption" rel="<?php echo $category_item['category_id'];?>">
                              <div class="accia_catalog_left">
                                  <div class="accia_column_subcategory_caption"><?php echo $category_item["name"];?></div>
                              </div>
                              
                              <!--
                              <div class="accia_catalog_right">
                                  <?php if(isset($products[$category_item["category_id"]])){ foreach($products[$category_item["category_id"]] as $product){?>
                                      <div class="product_used_item <?php echo isset($productAccia[$product['product_id']])?"_active":""; ?>" rel="<?php echo $product['product_id'];?>"><?php echo $product["name"];?></div>
                                  <?php }}?>
                              </div>
                              -->
                          </div>
                          <?php if(isset($products_list[$category_item['category_id']])){?>
                            <div class="cat_product_list"  rel="<?php echo $category_item['category_id'];?>">
                              <?php foreach($products_list[$category_item['category_id']] as $itm){?>
                                <div class="accia_catalog_row">
                                  <div class="accia_catalog_left accia_product_left">
                                    <?php echo $itm["name"];?>
                                  </div>
                                  <div class="accia_catalog_right">
                                    <textarea name="" value="тут1"></textarea>
                                  </div>
                                </div>
                              <?php }?>
                            </div>
                          <?php }?>
                          <?php if(isset($category_item["list"])){ ?>
                              <div class="subcat_wrapper" rel="<?php echo $category_item['category_id'];?>">
                                  <?php foreach($category_item["list"] as $category_item_child){?>
                                  <div class="cat_products_fnd accia_catalog_row">
                                      <div class="accia_catalog_left">
                                          <div class="accia_column_subcategory_caption _sub"><?php echo $category_item_child["name"];?></div>
                                      </div>
                                      <div class="accia_catalog_right">
                                        <textarea name="" value="тут2"></textarea>
                                      </div>
                                  </div>
                                  <?php if(isset($products_list[$category_item['category_id']])){?>
                                    <div class="cat_product_list" rel="<?php echo $category_item['category_id'];?>">
                                      <?php foreach($products_list[$category_item['category_id']] as $itm){?>
                                        <div class="accia_catalog_row">
                                          <div class="accia_catalog_left accia_product_left">
                                            <?php echo $itm["name"];?>
                                          </div>
                                          <div class="accia_catalog_right">
                                            <textarea name="" value="тут3"></textarea>
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
                  <?php }?>
              <?php }?>
              </div>
            </div>
            
          </div>
        </form>
      </div>
    </div>
  </div>

  <script type="text/javascript"><!--
      var filter_row = $("#filters tbody tr").length;
      var last_added_new=filter_row;
      function autosize(){
        var el = this;
        setTimeout(function(){
          el.style.cssText = 'height:auto; padding:0';
          el.style.cssText = 'height:' + el.scrollHeight + 'px';
        },0);
      }
      function addFilter() {
          
          var last_order=-1;
          $(".sort_order_filter").each(function(){
            if(last_order<$(this).val()){
              last_order=$(this).val();
            }
          });
          last_order++;

          
          html = '<tr id="filter-row' + filter_row + '" new_row="'+last_added_new+'">';
          html += '  <td class="text-left"><input type="text" name="cat_filter_new['+last_added_new+'][name]" value="" class="form-control change_form_param" /></td>';
          html += '  <td class="text-left"><input type="text" name="cat_filter_new['+last_added_new+'][translit]" value="" class="form-control change_form_param " /></td>';
          html += '  <td class="text-left"><input type="text" name="cat_filter_new['+last_added_new+'][unit]" value="" class="form-control change_form_param " /></td>';

          html += '  <td class="text-left"><select name="cat_filter_new['+last_added_new+'][type_param]" class="form-control change_form_param change_form_paramlist" value="0"><option value="0">Значение</option><option value="1">Диапазон</option><option value="2">Значение(совпадение)</option></select></td>';
          html += '  <td class="text-left"><select name="cat_filter_new['+last_added_new+'][param_sort_type]" class="form-control change_form_param" value="0"><option class="param_block1" value="0">По релевантности</option><option class="param_block1" value="1">По алфавиту</option><option class="param_block2" style="display:none;" value="0">Диапазон(темп)</option><option class="param_block2" style="display:none;" value="1">Диапазон</option></select></td>';

          html += ' <td class="text-left"><div class="param_block1" style="display:block;"><div class="product_availparam_list"></div><div class="wrp_add_paramvalue"><div class="add_param_caption">Добавить значение:</div> <input type="text" class="add_param_input form-control"> <div class="add_param">&gt;&gt;</div></div></div>';
          html += ' <div class="param_block2" style="display:none;"><div class="wrp_step_input"><div class="add_param_caption">Шаг:</div> <input type="text" name="cat_filter_new['+last_added_new+'][step]" class="change_form_param step_input form-control" value="1" /></div></div></td>';

                          
          html += '  <td class="text-left"><input type="number" name="cat_filter_new['+last_added_new+'][sort_order]" value="'+last_added_new+'" class="form-control sort_order_filter change_form_param" /></td>';
          html += '  <td class="text-left"><button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="remove_item_param btn btn-danger btn-danger_0"><i class="fa fa-minus-circle"></i></button></td>';
          
          html += '</tr>';

          $('#filters tbody').append(html);

          last_added_new++;
          filter_row++;
      }
/*-------------------------------------------*/
    function add_param_value(itm){
      var itm_val=itm.find("input");
      var itm_list=itm.closest("td").find(".product_availparam_list");

      var flag_add=true;
      if($.trim(itm_val.val())==""){
          flag_add=false;
      }else{
          itm.closest("td").find(".used_item").each(function(){
            if($.trim(itm_val.val()).toLowerCase()==$.trim($(this).text()).toLowerCase()){
              flag_add=false;
            }
          });
      }
      if(!flag_add){ 
          itm_val.addClass("_error");
      }else{
          itm_val.removeClass("_error");
          //var new_item='<span class="used_item _added" rel="0">'+itm_val.val()+'<div class="del_used_item"></div></span>';
          
          var new_row=itm.closest("tr").attr("new_row");
          
          if(new_row){
            var new_item_name='param_value_new['+new_row+'][]';
          }else{
            var new_item_name='param_value['+itm_list.attr("rel")+'][new][]';
          }
          var new_item='<div class="wrp_used_item">';
          new_item+='  <input class="input_param_hidden nitem" name="'+new_item_name+'" type="text" value="">';
          new_item+='  <span class="used_item" rel="0">';
          new_item+='    <div class="input_param_wrp">';
          new_item+='      <div class="input_param_val nitem_text">'+itm_val.val()+'</div>';
          new_item+='    </div>';
          new_item+='    <div class="del_used_item del_used_item_0"></div>';
          new_item+='  </span>';
          new_item+='</div>';
      
          

          itm_list.append(new_item);
          $(".nitem").val(itm_val.val());
          $(".nitem_text").text(itm_val.val());
          //$(".nitem").val("<sup>2</sup>");
          $(".nitem").removeClass("nitem");
          $(".nitem_text").removeClass("nitem_text");

          itm_val.val("");
          $("#change_params").val(1);
          itm_val.focus();
      }
    };
    /*-----------------------------------------------*/
    $(document).ready(function(){
      $('.search_append_text').on('keydown', autosize)
      $(".cat_products_fnd").click(function(){
          var rel=$(this).attr("rel");
          $(".cat_product_list[rel='"+rel+"']").slideToggle(200);
          $(this).toggleClass("active");
      });
      $(".acc_cat_caption").click(function(){
          //console.log("ok");
          var rel=$(this).attr("rel");
          $(".subcat_wrapper[rel='"+rel+"']").slideToggle(200);
          $(this).toggleClass("active");
      });
      $(document).on("click",".remove_item_param",function(){
          
          if($(this).hasClass("btn-danger_0")){
            $(this).closest("tr").remove();
            $("#change_params").val(1);

          }else{
            var itm=$(this).closest("tr").find(".unable_delete");
            itm.find(".unable_delete_list").html($(this).children(".del_used_items").html())
            itm.fadeIn();
          }
        });
        $(document).on("change",".change_form_paramlist",function(){
          if($(this).val()==1){
            $(this).closest("tr").find(".param_block1").hide();
            $(this).closest("tr").find(".param_block2").show();
          }else{
            $(this).closest("tr").find(".param_block1").show();
            $(this).closest("tr").find(".param_block2").hide();
          }
        })

        $(document).on("change",".change_form_param",function(){
            $("#change_params").val(1);
        });
        $(document).on("keyup",".input_param_hidden",function(){

            $(this).closest(".wrp_used_item").find(".input_param_val").html($(this).val());
            $("#change_params").val(1);
        });
        $(document).on("keypress",".add_param_input",function(e){
            if (e.which == 13) {
              e.preventDefault();
              var itm=$(this).closest(".wrp_add_paramvalue");
              add_param_value(itm);
            }
        });
        $(document).on("click",".add_param",function(){
            var itm=$(this).closest(".wrp_add_paramvalue");
            add_param_value(itm);
        });
        $(".unable_delete").click(function(){
          $(this).hide();
        });
        $(document).on("click",".del_used_item",function(){

            if($(this).hasClass("del_used_item_0")){
              var itm=$(this).closest(".wrp_used_item");
              itm.addClass("_remove");
              itm.find(".input_param_hidden").val("remove");

              $("#change_params").val(1);
                
            }else{
              var itm=$(this).closest("td").find(".unable_delete");
              itm.children(".unable_delete_list").html($(this).children(".del_used_items").html())
              itm.fadeIn();

                
            }
            
        });
    });
    
//--></script>


  <script type="text/javascript"><!--
  <?php if ($ckeditor) { ?>
    <?php foreach ($languages as $language) { ?>
        ckeditorInit('input-description<?php echo $language['language_id']; ?>', getURLVar('token'));
    <?php } ?>
  <?php } ?>
  //--></script>
  <script type="text/javascript"><!--
    $('#product-benefits').delegate('.fa-minus-circle', 'click', function () {
        $(this).parent().remove();
    });

    $('input[name=\'benefits\']').autocomplete({
        'source': function (request, response) {
            $.ajax({
                url: 'index.php?route=catalog/product/autocomplete_benefits&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                dataType: 'json',
                success: function (json) {
                    response($.map(json, function (item) {
                        return {
                            label: item['name'],
                            value: item['benefit_id']
                        }
                    }));
                }
            });
        },
        'select': function (item) {
            $('input[name=\'benefits\']').val('');

            $('#product-benefit' + item['value']).remove();

            $('#product-benefits').append('<div id="product-benefit' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_benefit[]" value="' + item['value'] + '" /></div>');
        }
    });
    
$('input[name=\'path\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				json.unshift({
					category_id: 0,
					name: '<?php echo $text_none; ?>'
				});

				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['category_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'path\']').val(item['label']);
		$('input[name=\'parent_id\']').val(item['value']);
	}
});
//--></script> 
  <script type="text/javascript"><!--
$('input[name=\'filter\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/filter/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['filter_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'filter\']').val('');

		$('#category-filter' + item['value']).remove();

		$('#category-filter').append('<div id="category-filter' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="category_filter[]" value="' + item['value'] + '" /></div>');
	}
});

$('#category-filter').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
//--></script> 
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script></div>
<?php echo $footer; ?>
