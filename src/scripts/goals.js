$(document).ready(function(){
    $(".add-to-card").click(function(){
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'add-to-card');
        }
    });
    $(".btn-request-call").click(function(){
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'callme');
        };
    });
    $(".cart_button_buy").click(function(){
        if (typeof ym != 'undefined') {
            ym(14496178, 'reachGoal', 'related-products');
        }
    });

    $(".with_goal").click(function(){
        var goal=$(this).attr("goal");
        if(goal!=""){
            console.log(goal);
            ym(14496178, 'reachGoal', goal);
        }
    });
    $(".resp-tabs-list li").click(function(){
        var goal_data=$(this).attr("goal_data");
        if (typeof ym != 'undefined') {
            switch(goal_data) {
                case 'card-pack':     //Упаковка
                    ym(14496178, 'reachGoal', 'tab-packaging');
                    break;          
                case 'card-calc':     //Калькулятор
                    ym(14496178, 'reachGoal', 'tab-calculator');
                    break;
                case 'card-video':     //Видео
                    ym(14496178, 'reachGoal', 'watch-video');
                    break;

                case 'tabdat_0':     //Применение
                    ym(14496178, 'reachGoal', 'tab-use');
                    break;

                case 'tabdat_1':     //Хранение
                    ym(14496178, 'reachGoal', 'tab-save');
                    break;

                case 'tabdat_2':     //Скидки
                    ym(14496178, 'reachGoal', 'tab-sale');
                    break;

                case 'card-review':     //Отзывы
                    ym(14496178, 'reachGoal', 'tab-comments');
                    break;
                
                case 'card-description':     //Описание
                    ym(14496178, 'reachGoal', 'tab-catalog-card-description');
                    break;
                default:
            }
        }
    });
});
