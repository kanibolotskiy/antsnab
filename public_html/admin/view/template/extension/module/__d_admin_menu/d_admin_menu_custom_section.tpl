<div class="well well-sm">
  <div style="float: right;">
    <button type="button" id="button-collapse-custom" class="btn btn-sm" >Collapse All</button>
    <button type="button" id="button-expand-custom" class="btn btn-sm">Expand All</button>
  </div>
  <button type="button" id="button-add-custom" class="btn btn-sm btn-primary" ><i class="fa fa-plus" aria-hidden="true"></i> Item</button>
  <button type="button" id="button-add-custom-route" class="btn btn-sm btn-basic" ><i class="fa fa-plus" aria-hidden="true"></i> {{ button_custom_route_item }}</button>

</div>

{% if (not custom_menu_data) %}
<ol class="dd-list dd-nodrag main-custom-list">
</ol>
{% endif %}


{% if (custom_menu_data) %}
<ol class="dd-list dd-nodrag main-custom-list">

      <!-- first level -->
      {% for cmd_first_item in custom_menu_data %}
      <li id="dd_custom_{{ cmd_first_item['id'] }}" class="dd-item dd-nodrag custom-menu-item" data-id="{{ cmd_first_item['id'] }}">

        <div class="dd-handle">

          <span class="item-icon-picker btn-group">
            <button type="button" class="btn btn-default iconpicker-component"><i class="fa fa-fw fa-heart"></i></button>
            <button type="button" class="icp icp-dd btn dropdown-toggle supericon-yep" data-selected="{{ cmd_first_item['icon'] }}" data-id="{{ cmd_first_item['id'] }}" data-toggle="dropdown">
              <span class="caret"></span>
              <span class="sr-only">Toggle Dropdown</span>
            </button>
            <span class="dropdown-menu"></span>
            <input type="hidden" name="custom-menu[{{ cmd_first_item['id'] }}][icon]" value="{{ cmd_first_item['icon'] }}">
          </span>

          <span class="item-name">
            <input type="item-name" name="custom-menu[{{ cmd_first_item['id'] }}][name]" value="{{ cmd_first_item['name'] }}" class="custom-item-name" placeholder="{{ cmd_first_item['name'] }}">
          </span>
          <span class="item-link">

            {% if cmd_first_item['custom_route'] %}

              <input type="hidden" name="custom-menu[{{ cmd_first_item['id'] }}][custom_route]" value="1">
              <input type="text" name="custom-menu[{{ cmd_first_item['id'] }}][item_link]" value="{{ cmd_first_item['custom_route'] }}" class="custom-item-link custom_route_input" placeholder="{{ text_custom_route }}" title="{{ help_custom_route }}" data-toggle="tooltip" data-placement="bottom">

            {% else %}

              <select name="custom-menu[{{ cmd_first_item['id'] }}][item_link]" class="input-sm custom-item-link">
                {% for mfl in modules_for_links %}
                <optgroup label="{{ mfl['text'] }}">
                {% if (not mfl['extra']) %}
                <!-- ? -->
                {% else %}
                {% for ex_mfl in mfl['extra'] %}
                <option {{ ex_mfl['edit'] in cmd_first_item['href'] ? 'selected' : '' }} value="{{ ex_mfl['edit'] }}">{{ ex_mfl['name'] }}</option>
                {% endfor %}
                {% endif %}
                </optgroup>
                {% endfor %}
              </select>

            {% endif %}

          </span>
          <span class="item-icons-custom dd-nodrag">
            <span class="fa fa-times fa-lg custom-removebtn" style="color: red;" data-del-id="{{ cmd_first_item['id'] }}"></span>
          </span>
        </div>


        <!-- second level -->
        {% if (cmd_first_item['children']) %}
        <ol class="dd-list dd-nodrag">
        {% for cmd_second_item in cmd_first_item['children'] %}

        <li id="dd_custom_{{ cmd_second_item['id'] }}" class="dd-item dd-nodrag custom-menu-item" data-id="{{ cmd_second_item['id'] }}">


          <div class="dd-handle">

            <span class="item-icon-picker btn-group">
              <button type="button" class="btn btn-default iconpicker-component"><i class="fa fa-fw fa-heart"></i></button>
              <button type="button" class="icp icp-dd btn dropdown-toggle supericon-yep" data-selected="{{ cmd_second_item['icon'] }}" data-id="{{ cmd_second_item['id'] }}" data-toggle="dropdown">
                <span class="caret"></span>
                <span class="sr-only">Toggle Dropdown</span>
              </button>
              <span class="dropdown-menu"></span>
              <input type="hidden" name="custom-menu[{{ cmd_second_item['id'] }}][icon]" value="{{ cmd_second_item['icon'] }}">
            </span>

            <span class="item-name">
              <input type="item-name" name="custom-menu[{{ cmd_second_item['id'] }}][name]" value="{{ cmd_second_item['name'] }}" class="custom-item-name" placeholder="{{ cmd_second_item['name'] }}">
            </span>
            <span class="item-link">

              {% if cmd_second_item['custom_route'] %}

                <input type="hidden" name="custom-menu[{{ cmd_second_item['id'] }}][custom_route]" value="1">
                <input type="text" name="custom-menu[{{ cmd_second_item['id'] }}][item_link]" value="{{ cmd_second_item['custom_route'] }}" class="custom-item-link" placeholder="{{ text_custom_route }}"  title="{{ help_custom_route }}" data-toggle="tooltip" data-placement="bottom">

              {% else %}

                <select name="custom-menu[{{ cmd_second_item['id'] }}][item_link]" class="input-sm custom-item-link">
                  {% for mfl in modules_for_links %}
                  <optgroup label="{{ mfl['text'] }}">
                  {% if (not mfl['extra']) %}
                  <!-- ? -->
                  {% else %}
                  {% for ex_mfl in mfl['extra'] %}
                  <option {{ ex_mfl['edit'] in cmd_second_item['href'] ? 'selected' : '' }} value="{{ ex_mfl['edit'] }}">{{ ex_mfl['name'] }}</option>
                  {% endfor %}
                  {% endif %}
                  </optgroup>
                  {% endfor %}
                </select>

              {% endif %}

            </span>
            <span class="item-icons-custom dd-nodrag">
              <span class="fa fa-times fa-lg custom-removebtn" style="color: red;" data-del-id="{{ cmd_second_item['id'] }}"></span>
            </span>
          </div>


          <!-- third level -->
          {% if (cmd_second_item['children']) %}
          <ol class="dd-list dd-nodrag">
          {% for cmd_third_item in cmd_second_item['children'] %}
          <li id="dd_custom_{{ cmd_third_item['id'] }}" class="dd-item dd-nodrag custom-menu-item" data-id="{{ cmd_third_item['id'] }}">

            <div class="dd-handle">

              <span class="item-icon-picker btn-group">
                <button type="button" class="btn btn-default iconpicker-component"><i class="fa fa-fw fa-heart"></i></button>
                <button type="button" class="icp icp-dd btn dropdown-toggle supericon-yep" data-selected="{{ cmd_third_item['icon'] }}" data-id="{{ cmd_third_item['id'] }}" data-toggle="dropdown">
                  <span class="caret"></span>
                  <span class="sr-only">Toggle Dropdown</span>
                </button>
                <span class="dropdown-menu"></span>
                <input type="hidden" name="custom-menu[{{ cmd_third_item['id'] }}][icon]" value="{{ cmd_third_item['icon'] }}">
              </span>

              <span class="item-name">
                <input type="item-name" name="custom-menu[{{ cmd_third_item['id'] }}][name]" value="{{ cmd_third_item['name'] }}" class="custom-item-name" placeholder="{{ cmd_third_item['name'] }}">
              </span>
              <span class="item-link">

                {% if cmd_third_item['custom_route'] %}

                  <input type="hidden" name="custom-menu[{{ cmd_third_item['id'] }}][custom_route]" value="1">
                  <input type="text" name="custom-menu[{{ cmd_third_item['id'] }}][item_link]" value="{{ cmd_third_item['custom_route'] }}" class="custom-item-link" placeholder="{{ text_custom_route }}"  title="{{ help_custom_route }}" data-toggle="tooltip" data-placement="bottom">

                {% else %}

                  <select name="custom-menu[{{ cmd_third_item['id'] }}][item_link]" class="input-sm custom-item-link">
                    {% for mfl in modules_for_links %}
                    <optgroup label="{{ mfl['text'] }}">
                    {% if (not mfl['extra']) %}
                    <!-- ? -->
                    {% else %}
                    {% for ex_mfl in mfl['extra'] %}
                    <option {{ ex_mfl['edit'] in cmd_third_item['href'] ? 'selected' : '' }} value="{{ ex_mfl['edit'] }}">{{ ex_mfl['name'] }}</option>
                    {% endfor %}
                    {% endif %}
                    </optgroup>
                    {% endfor %}
                  </select>

                {% endif %}

              </span>
              <span class="item-icons-custom dd-nodrag">
                <span class="fa fa-times fa-lg custom-removebtn" style="color: red;" data-del-id="{{ cmd_third_item['id'] }}"></span>
              </span>
            </div>

          </li>
          {% endfor %}
          </ol>
          {% endif %}


        </li>
        {% endfor %}
        </ol>
        {% endif %}


      </li>
      {% endfor %}

</ol>
{% endif %}

<template id="new_custom_item">
  <li id="dd_custom_%%new_custom_id%%" class="dd-item dd-nodrag custom-menu-item" data-id="%%new_custom_id%%">

      <div class="dd-handle">
          <span class="item-icon-picker btn-group">
            <button type="button" class="btn btn-default iconpicker-component"><i class="fa fa-fw fa-flask"></i></button>
            <button type="button" class="icp icp-dd btn dropdown-toggle supericon-yep" data-selected="fa-flask" data-id="%%new_custom_id%%" data-toggle="dropdown">
              <span class="caret"></span>
              <span class="sr-only">Toggle Dropdown</span>
            </button>
            <span class="dropdown-menu"></span>
            <input type="hidden" name="custom-menu[%%new_custom_id%%][icon]" value="fa-flask">
          </span>

        <span class="item-name">
          <input type="item-name" name="custom-menu[%%new_custom_id%%][name]" value="Shopunity" class="custom-item-name" placeholder="{{ text_phd_item_name }}">
        </span>

        <span class="item-link">
          <select name="custom-menu[%%new_custom_id%%][item_link]" class="input-sm custom-item-link">
            {% for mfl in modules_for_links %}
            <optgroup label="{{ mfl['text'] }}">
            {% if (not mfl['extra']) %}
            <!-- ? -->
            {% else %}
            {% for ex_mfl in mfl['extra'] %}
            <option {{ (ex_mfl['edit'] == 'extension/module/d_shopunity') ? 'selected' : '' }} value="{{ ex_mfl['edit'] }}">{{ ex_mfl['name'] }}</option>
            {% endfor %}
            {% endif %}
            </optgroup>
            {% endfor %}
          </select>
        </span>

        <span class="item-icons-custom dd-nodrag">
          <span class="fa fa-times fa-lg custom-removebtn" style="color: red;" data-del-id="%%new_custom_id%%" aria-hidden="true"></span>
        </span>
      </div>
  </li>
</template>

<template id="new_custom_route_item">
  <li id="dd_custom_%%new_custom_id%%" class="dd-item dd-nodrag custom-menu-item" data-id="%%new_custom_id%%">

      <div class="dd-handle">
          <span class="item-icon-picker btn-group">
            <button type="button" class="btn btn-default iconpicker-component"><i class="fa fa-fw fa-flask"></i></button>
            <button type="button" class="icp icp-dd btn dropdown-toggle supericon-yep" data-selected="fa-flask" data-id="%%new_custom_id%%" data-toggle="dropdown">
              <span class="caret"></span>
              <span class="sr-only">Toggle Dropdown</span>
            </button>
            <span class="dropdown-menu"></span>
            <input type="hidden" name="custom-menu[%%new_custom_id%%][icon]" value="fa-flask">
          </span>

        <span class="item-name">
          <input type="item-name" name="custom-menu[%%new_custom_id%%][name]" value="Shopunity" class="custom-item-name" placeholder="{{ text_phd_item_name }}">
        </span>

        <span class="item-link">
          <input type="hidden" name="custom-menu[%%new_custom_id%%][custom_route]" value="1">
          <input type="text" name="custom-menu[%%new_custom_id%%][item_link]" value="" class="custom-item-link" placeholder="{{ text_custom_route }}"  title="{{ help_custom_route }}" data-toggle="tooltip" data-placement="bottom">
        </span>

        <span class="item-icons-custom dd-nodrag">
          <span class="fa fa-times fa-lg custom-removebtn" style="color: red;" data-del-id="%%new_custom_id%%" aria-hidden="true"></span>
        </span>
      </div>
  </li>
</template>

