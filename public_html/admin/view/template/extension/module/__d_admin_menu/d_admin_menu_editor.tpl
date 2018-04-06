{{ header }}{{ column_left }}

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="form-inline pull-right">
                <button id="save_and_stay" data-toggle="tooltip" title="{{ button_save_and_stay }}" class="btn btn-success"><i class="fa fa-save"></i></button>
                <a href="{{ cancel }}" data-toggle="tooltip" title="{{ button_cancel }}" class="btn btn-default"><i class="fa fa-reply"></i></a>
            </div>
            <h1>{{ heading_title }} {{ version }}</h1>
            <ul class="breadcrumb">
                {% for breadcrumb in breadcrumbs %}
                <li><a href="{{ breadcrumb['href'] }}">{{ breadcrumb['text'] }}</a></li>
                {% endfor %}
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        {% if (error['warning'] is not empty) %}
        <div class="alert alert-danger">
            <i class="fa fa-exclamation-circle"></i> {{ error['warning'] }}
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        {% endif %}
        {% if (error['shopunity'] is not empty) %}
        <div class="alert alert-danger">
            <i class="fa fa-exclamation-circle"></i>
            {{ error['shopunity'] }}
        </div>
        {% endif %}
        {% if (success is not empty) %}
        <div class="alert alert-success">
            <i class="fa fa-exclamation-circle"></i> {{ success }}
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        {% endif %}

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> {{ text_edit }}</h3>
            </div>
            <div class="panel-body">
                <form action="{{ save_and_stay }}" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">

                  <ul  class="nav nav-tabs">
                    <li class="active">
                        <a href="#setting" data-toggle="tab">
                            <span class="fa fa-cog"></span>
                            {{ tab_setting }}
                        </a>
                    </li>
                    <li>
                        <a href="#instruction" data-toggle="tab">
                            <span class="fa fa-graduation-cap"></span>
                            {{ tab_instruction }}
                        </a>
                    </li>
                  </ul>

                  <div class="tab-content">

                      <div class="tab-pane active" id="setting" >
                          <div class="tab-body">
                            <div class="row">

                              <div class="col-sm-12">
                                <div class="tab-content">


                                  <div id="d_menu" class="tab-pane active">

                                    <div class="row">
                                      <!-- HOME CONTENT -->

                                      <div class="col-lg-6">
                                          <div class="form-group">
                                              <label class="col-sm-4 control-label" for="input_status"><span data-toggle="tooltip" title="{{ help_status }}">{{ entry_status }}</span></label>
                                              <div class="col-sm-8">
                                                  <input type="checkbox" value="1" name="{{ id }}_status" id="input_status" data-on-color="success"  data-bs-status="true" {{ attribute(_context, id ~ '_status') == '1' ? 'checked="checked"' : '' }} class="form-control" />
                                              </div>
                                          </div>
                                      </div>

                                      <div class="col-lg-6">
                                          <div class="form-group">
                                              <label class="col-sm-4 control-label" for="input_work_mode"><span data-toggle="tooltip" title="{{ help_work_mode }}">{{ entry_work_mode }}</span></label>
                                              <div class="col-sm-8">
                                                  <input type="checkbox" value="1" name="{{ id }}_work_mode" id="input_work_mode" data-on-color="primary" data-off-color="primary" data-on-text="{{ text_inherit }}" data-off-text="{{ text_replace }}" data-label-width="20" data-bs-status="true" {{ attribute(_context, id ~ '_work_mode') == '1' ? 'checked="checked"' : '' }} class="form-control" />
                                              </div>
                                          </div>
                                      </div>

                                    </div>

                                    <hr>

                                    <div class="col-sm-12">

                                      <!-- STANDART MENU -->
                                      <div class="panel-group col-sm-12 col-md-12 col-lg-5">
                                        <h3 class="page-header">
                                            <span class="fa fa-bookmark-o fa-fw"></span> <span>{{ text_standart_menu }}</span>
                                        </h3>
                                        <div id="standart-menu">
                                          <div class="dd nestable" id="nestable-standart">
                                            {{ standart_menu }}
                                          </div>
                                        </div>
                                      </div>

                                      <!-- CUSTOM MENU -->
                                      <div class="panel-group col-sm-12 col-md-12 col-lg-7">
                                        <h3 class="page-header">
                                            <span class="fa fa-bookmark fa-fw"></span> <span>{{ text_custom_menu }}</span>
                                        </h3>
                                        <div id="custom-menu">
                                          <div class="dd nestable" id="nestable-custom">
                                            {{ custom_menu }}
                                          </div>
                                        </div>
                                      </div>

                                    </div>
                                  </div>

                                </div>
                              </div>

                            </div>
                          </div>
                      </div>

                      <div class="tab-pane" id="instruction" >
                          <div class="tab-body">
                              {{ text_instruction }}
                          </div>
                      </div>

                  </div>

                </form>
            </div>
        </div>



    </div>

</div>

<script>

  function alert_handler(json)
  {
    if (typeof json === 'string') {
      json = JSON.parse(json);
    }

    if (json['error']) {

      for (i in json['error']) {
          alertify.error(json['error'][i]);
      }
    }

    if (json['success']) {
      alertify.success(json['success']);
    }
  }

  function goose_templating(some_html, some_json)
  {
    var re = /%%([^%%]+)?%%/g, match;
    while(match = re.exec(some_html)) {
        some_html = some_html.replace(match[0], some_json[match[1]]);
    };
    return some_html;
  }

  function updateOutput(e)
  {
      var list   = e.length ? e : $(e.target),
          output = list.data('output');
      if (window.JSON) {
          output.val(window.JSON.stringify(list.nestable('serialize')));
      } else {
          output.val('JSON browser support required for this demo.');
      }
  };

  function changeCustomItemsType(serialize_data)
  {

    for (var i = serialize_data.length - 1; i >= 0; i--) {
      if ("children" in serialize_data[i]) {

        $('#dd_custom_' + serialize_data[i]['id'] + ' > .dd-handle .item-link').css('display', 'none');

        // second children
        for (var ii = serialize_data[i]['children'].length - 1; ii >= 0; ii--) {
          if ("children" in serialize_data[i]['children'][ii]) {
            $('#dd_custom_' + serialize_data[i]['children'][ii]['id'] + ' > .dd-handle .item-link').css('display', 'none');
          } else {
            $('#dd_custom_' + serialize_data[i]['children'][ii]['id'] + ' > .dd-handle .item-link').css('display', 'inline-block');
          }
        }

      } else {
        $('#dd_custom_' + serialize_data[i]['id'] + ' > .dd-handle .item-link').css('display', 'inline-block');
      }

    }
  }

  $(document).ready(function()
  {

      $('#nestable-standart').nestable_nodrag({maxDepth: '3', group: "standart"});

      $('#nestable-custom').nestable({maxDepth: '3', group: "custom"})
      .on('change', function(){
        changeCustomItemsType($('#nestable-custom').nestable('serialize'));
      });
      changeCustomItemsType($('#nestable-custom').nestable('serialize'));

      $('#nestable-standart').nestable_nodrag('collapseAll');

      $('[data-bs="true"]').bootstrapSwitch();
      $('[data-bs-status="true"]').bootstrapSwitch();

      if ($('#input_work_mode').prop('checked')) {
        $('#standart-menu').css('pointer-events', 'none');
        $('#standart-menu').fadeTo('slow', 0.3);
      }

      $('#input_work_mode').on('switchChange.bootstrapSwitch', function(event, state) {
          if (state == true) {
            $('#standart-menu').css('pointer-events', 'none');
            $('#standart-menu').fadeTo('slow', 0.3);
          } else {
            $('#standart-menu').css('pointer-events', 'all');
            $('#standart-menu').fadeTo('slow', 1);
          }
      });

      $('[data-bs="true"]').on('switchChange.bootstrapSwitch', function(event, state) {
        var tmp_vis = 1;
        if (state == true) { tmp_vis = 1; } else { tmp_vis = 0; };
        $(this).val(tmp_vis);
      });

      // restore default setting (standart-menu)
      $('#button-restore-standart').on('click', function() {
        $('[data-bs="true"]').each(function() {
          $(this).bootstrapSwitch('state', true, true);
        });
      });

      // collapse-expand buttons
      $('#button-collapse-standart').on('click', function()
      { $('#nestable-standart').nestable_nodrag('collapseAll'); });

      $('#button-expand-standart').on('click', function()
      { $('#nestable-standart').nestable_nodrag('expandAll'); });

      $('#button-collapse-custom').on('click', function()
      { $('#nestable-custom').nestable('collapseAll'); });

      $('#button-expand-custom').on('click', function()
      { $('#nestable-custom').nestable('expandAll'); });


      // add new custom element (button)
      $('#button-add-custom').on('click', function()
      {
        var tmp_new_id = 0;
        $('.custom-removebtn').each(function() {
          if ($(this).data('delId') > tmp_new_id) {
            tmp_new_id = $(this).data('delId');
          }
        });
        tmp_new_id = tmp_new_id + 1;

        var html = $('#new_custom_item').html();
        var tmp_json = {
          new_custom_id: tmp_new_id
        };
        html = goose_templating(html, tmp_json);
        $('.main-custom-list').append(html);
        console.log('create custom element ID: ', tmp_new_id);

        // iconpicker re-init
        $('.supericon-yep').each(function() {
          $(this).iconpicker();
        });

        return false;
      });

      // add new custom element (button)
      $('#button-add-custom-route').on('click', function()
      {
        var tmp_new_id = 0;
        $('.custom-removebtn').each(function() {
          if ($(this).data('delId') > tmp_new_id) {
            tmp_new_id = $(this).data('delId');
          }
        });
        tmp_new_id = tmp_new_id + 1;

        var html = $('#new_custom_route_item').html();
        var tmp_json = {
          new_custom_id: tmp_new_id
        };
        html = goose_templating(html, tmp_json);
        $('.main-custom-list').append(html);
        console.log('create custom element ID: ', tmp_new_id);

        // iconpicker re-init
        $('.supericon-yep').each(function() {
          $(this).iconpicker();
        });

        return false;
      });

      // remove custom element
      $(document).on('click','.custom-removebtn', function() {
        $(('#dd_custom_' + $(this).data('delId'))).remove();
        console.log('removing custom element ID: ', $(this).data('delId'));
      });


      // iconpicker init
      $('.supericon-yep').each(function() {
        $(this).iconpicker();
      });

      // icon input update
      $(document).on('iconpickerSelected', '.icp', function(e) {
        $("input[name='custom-menu[" + $(this).data('id') +"][icon]']").val(e.iconpickerValue);
      });

      // TOOLTIP
      $('.custom_route_input').tooltip();

  });

  $(document).on('click', '#save_and_stay', function() {

    var jsn = {
      'menus-data': $('#form').serializeArray(),
      'custom-nested-data': $('#nestable-custom').nestable('serialize')
    };

    $.ajax({
        type: 'post',
        url: $('#form').attr('action'),
        data: jsn,
        beforeSend: function() {
            $('#form').fadeTo('slow', 0.5);
        },
        complete: function() {
            $('#form').fadeTo('slow', 1);
        },
        success: function(json) {
            alert_handler(json);
        },
        error: function(json) {
            alert_handler(json);
        }
    });
  });



</script>

{{ footer }}
