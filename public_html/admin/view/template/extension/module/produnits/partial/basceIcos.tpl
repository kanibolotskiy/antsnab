<!-- This template doesnt used yet. For icons, showing bases in unit rows -->
<div class="unit_ico_container">
    {% if(o.isSaleBase) { %}
    <div class="unit_ico">
        <i class="fa fa-cart-arrow-down"></i><?= $column_isSaleBase ?>
    </div>
    {% } %}

    {% if(o.isPriceBase) { %}
    <div class="unit_ico">
        <i class="fa fa-dollar"></i><?= $column_isPriceBase ?> 
    </div>
    {% } %}

    {% if(o.isPackageBase) { %}
    <div class="unit_ico" >
        <i class="fa fa-dropbox "></i><?= $column_isPackageBase ?>
    </div>
    {% } %}
</div>
