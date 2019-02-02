$(document).ready(function(){
    $(".add-to-card").click(function(){
        ym(14496178, 'reachGoal', 'add-to-card');
    });
    $(".btn-request-call").click(function(){
        ym(14496178, 'reachGoal', 'callme');
    });
    $(".resp-tabs-list li").click(function(){
        var goal_data=$(this).attr("goal_data");
        switch(goal_data) {
            case 'card-pack':     //Упаковка
                ym(14496178, 'reachGoal', 'tab-packaging');
                console.log("Упаковка");
                break;          
            case 'card-calc':     //Калькулятор
                ym(14496178, 'reachGoal', 'tab-calculator');
                console.log("Калькулятор");
                break;
            
            case 'tabdat_0':     //Применение
                ym(14496178, 'reachGoal', 'tab-use');
                console.log("Применение");
                break;

            case 'tabdat_1':     //Хранение
                ym(14496178, 'reachGoal', 'tab-save');
                console.log("Хранение");
                break;

            case 'tabdat_2':     //Скидки
                ym(14496178, 'reachGoal', 'tab-sale');
                console.log("Скидки");
                break;

            case 'card-review':     //Отзывы
                ym(14496178, 'reachGoal', 'tab-comments');
                console.log("Отзывы");
                break;
            
            case 'card-description':     //Описание
                ym(14496178, 'reachGoal', 'tab-catalog-card-description');
                console.log("Описание");
                break;
            default:
          }
    });
});
