$(document).ready(function(){
    $("#input_search" ).autocomplete({
        source: '/index.php?route=product/search/liveSearch',
         
        dataType: 'json',
        deferRequestBy: 300
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