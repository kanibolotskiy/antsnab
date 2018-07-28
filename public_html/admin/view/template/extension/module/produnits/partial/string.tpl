<?php /*php rendering used only for language strings & token, another is done in frontend tmpl lib*/?>
<tr>
    <td class="col-xs-7">
        <input type="text" 
               data-name="description" 
               value="{%=o['description']%}" 
               placeholder="<?=$column_strdescription?>" 
               class="form-control"/>

        {% if(undefined !== o.error.description ) { %} 
        <div class="text-danger">
            {%=o.error.description%}
        </div>
        {% } %}
    </td>

    <td class="col-xs-3">
        <input type="text" 
               data-name="value" 
               value="{%=o['value']%}" 
               placeholder="<?= $column_strvalue ?>" 
               class="form-control"/>

        {% if(undefined !== o.error.value ) { %} 
        <div class="text-danger">
            {%=o.error.value%}
        </div>
        {% } %}
    </td>

    <td class="col-xs-1">
        <input type="text" 
               data-name="sortOrder" 
               value="{%=o['sortOrder']%}" 
               placeholder="<?= $column_strSortOrder ?>" 
               class="form-control"/>

        {% if(undefined !== o.error.sortOrder ) { %} 
        <div class="text-danger">
            {%=o.error.sortOrder%}
        </div>
        {% } %}
    </td>

    <td style="width:2%">
        <button type="button" 
                onclick="stringForm.deleteRow(this)"
                data-toggle="tooltip" 
                title="Удалить" class="btn btn-danger delBut">
            <i class="fa fa-minus-circle"></i>
        </button>
    </td>
</tr>
