$(document).ready(function(){
  
    $("#inputSearch" ).autocomplete({
      serviceUrl: '/index.php?route=product/search/bestSearch',
         
        //dataType: 'json',
        deferRequestBy: 300,
        minChars: 3,
        zIndex:1,
        appendTo:$(".wrapper_search"),
        onSelect: function (suggestion) {
          location.href=suggestion.data;
          //alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
        }
    });
    /*
    $("#input_search").autocomplete({
        dataType: "jsonp",
        deferRequestBy:300,
        // параметры запроса, передаваемые на сервер (последний - подстрока для поиска):
        data:{
            text: $("#input_search").val()
        },
        source: '/index.php?route=product/search/liveSearch', // url-адрес
        minLength: 2, // минимальное количество для совершения запроса
        success: function(data){
            // приведем полученные данные к необходимому формату и передадим в предоставленную функцию response
            console.log(data)
            
          }
      });
    */
    
});