<?php /*php rendering used only for language strings & token, another is done in frontend tmpl lib*/?>
<tr>
    <td class="col-xs-2">
        <input type="text" 
               data-name="name" 
               value="{%=o['name']%}" 
               placeholder="<?= $column_name ?>" 
               class="form-control"/>

        {% if(undefined !== o.error.name ) { %} 
        <div class="text-danger">
            {%=o.error.name%}
        </div>
        {% } %}

        <br/>
        <label>

        {% if(o['force_step_by_one']){ %}
            <input type="checkbox" style="margin-right: 5px;display: inline-block;vertical-align:sub;"
               data-name="force_step_by_one" 
               checked="checked"
               class="form-control"/>
                <span>Кратно</span>
            </label>
        {% } else { %}
            <input type="checkbox" style="margin-right: 5px;display: inline-block;vertical-align:sub;"
               data-name="force_step_by_one" 
               class="form-control"/>
                <span>Кратно</span>
            </label>
        {% } %}
        
        
    </td>

    <td class="col-xs-1">
        <input type="text" 
               data-name="calcKoef" 
               value="{%=o['calcKoef']%}" 
               placeholder="<?= $column_calcKoef_placeholder ?>" 
               class="form-control"/>

        {% if(undefined !== o.error.calcKoef ) { %} 
        <div class="text-danger">
            {%=o.error.calcKoef%}
        </div>
        {% } %}
    </td>

    <td class="col-xs-2">
            <select data-relselect data-val="{%=o['calcRel']%}" data-name="calcRel" class="form-control">
                <option value="">Не делится</option>
                <?php /*Set only default value, other done by js*/?>
            </select>
    </td>

    <td class="col-xs-1">
        <div style="position:relative">
            <input type="text" 
                   data-name="switchSortOrder" 
                   value="{%=o['switchSortOrder']%}" 
                   class="form-control" 
                   placeholder="<?= $column_order ?>" />

            {% if(undefined !== o.error.switchSortOrder ) { %} 
            <div class="text-danger">
                {%=o.error.switchSortOrder%}
            </div>
            {% } %}
        </div>

        <?= $column_price_writing ?>
        <input type="text" 
               data-name="name_price" 
               value="{%=o['name_price']%}" 
               placeholder="<?= $column_name_price ?>" 
               title="<?= $help_name_price ?>"
               class="form-control">

        {% if(undefined !== o.error.name_price ) { %} 
        <div class="text-danger">
            {%=o.error.name_price%}
        </div>
        {% } %}

    </td>
    <td class="col-xs-1">
        <div style="position:relative">
            <input type="text" 
                   data-name="loadingSortOrder" 
                   value="{%=o['loadingSortOrder']%}" 
                   placeholder="<?= $column_order ?>" 
                   class="form-control">

            {% if(undefined !== o.error.loadingSortOrder ) { %} 
            <div class="text-danger">
                {%=o.error.loadingSortOrder%}
            </div>
            {% } %}
        </div>
    </td>
    <td class="col-xs-1">
        <input type="text" 
               data-name="weight" 
               value="{%=o['weight']%}" 
               placeholder="<?= $column_weight_placeholder ?>" 
               class="form-control">

        {% if(undefined !== o.error.weight ) { %} 
        <div class="text-danger">
            {%=o.error.weight%}
        </div>
        {% } %}

    </td>
    <td class="col-xs-2 dict_cell">

        <input type="text" 
               data-name="name_plural" 
               value="{%=o['name_plural']%}" 
               placeholder="<?= $column_name_plural ?>"
               title="<?= $help_name_plural ?>"
               class="form-control">

        <input type="text" 
               data-name="name_package_dimension" 
               value="{%=o['name_package_dimension']%}" 
               placeholder="<?= $column_name_package_dimension ?>"
               title="<?= $help_name_package_dimension ?>"
               class="form-control">

        <input type="text" 
               data-name="name_in_package" 
               value="{%=o['name_in_package']%}" 
               placeholder="<?= $column_name_in_package ?>"
               title="<?= $help_name_in_package ?>"
               class="form-control">

        {% if(undefined !== o.error.name_strings ) { %} 
        <div class="text-danger">
            {%=o.error.name_strings%}
        </div>
        {% } %}

    </td>
    <td class="col-xs-2 dict_cell">
        <input type="text" 
               data-name="package_width" 
               value="{%=o['package_width']%}" 
               placeholder="<?= $column_package_width ?>" 
               class="form-control">
        <input type="text" 
               data-name="package_length" 
               value="{%=o['package_length']%}" 
               placeholder="<?= $column_package_length ?>" 
               class="form-control">
        <input type="text" 
               data-name="package_height" 
               value="{%=o['package_height']%}" 
               placeholder="<?= $column_package_height ?>" 
               class="form-control">

        {% if(undefined !== o.error.package_strings ) { %} 
        <div class="text-danger">
            {%=o.error.package_strings%}
        </div>
        {% } %}
    </td>

    <td style="width:2%">
        {% var id = (undefined === o['id'])?'new':o['id']; %}
        <button type="button" 
                onclick="unitForm.deleteRow(this)"
                data-id="{%=id%}"
                data-toggle="tooltip" 
                title="Удалить" class="btn btn-danger delBut">
            <i class="fa fa-minus-circle"></i>
        </button>
         <button type="button" disabled
                onclick="unitForm.saveRow(this)" 
                data-id="{%=id%}"
                data-toggle="tooltip" title="Сохранить" class="btn btn-primary saveBut">
            <i class="fa fa-save"></i>
        </button>
    </td>
</tr>
