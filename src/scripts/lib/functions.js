export function getDelivery(){
    //var koef=$("#priceSwitcher .active").attr("data-sale_to_ui_koef")*1;
    var koef=eval($("#priceSwitcher .active").attr("data-sale_to_ui_koef"));
    var base_weight=$("#priceSwitcher").attr("data-base_weight")*1;
    var product_id=$("#product_id").data("product_id");
    //console.log(koef);
    if(!koef){
        koef=1;
    }
    var qnt=$(".quantity-buy .qnt").val()
    //var base_count=$("#product_count_add").val()/koef;
    var base_count=qnt/koef;

    var weight=base_count*base_weight;
    //console.log($("#product_count_add").val()+"/"+koef);
    //var data={};
    $.ajax({
        url: '/index.php?route=product/product/ajaxDelivery/',
        data: '&product_id='+product_id+'&weight='+weight,
        type: 'POST',
        dataType: 'json',
        success: function(json) {
            if(json['success']){
                var str_delivery='<span class="nowrap">'+json['date_delivery']+'</span>,<br/>'+json['price_delivery'];
                $("#delivery_text").html(str_delivery);

                $("#caption_delivery").html(json['caption_delivery']);
                $("#text_delivery").html(json['text_delivery']);
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            console.error(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });    
}