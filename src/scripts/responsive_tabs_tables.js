import './lib/easyResponsiveTabs';

/* Адаптивные табы в карточке продукта */
$('#demoTab').easyResponsiveTabs({tabidentify: 'vert'});

/* Адаптивные таблицы в статьях */
$(".article").find("table").each(function () {
    $(this).wrap('<div class="table-responsive"></div>');
});

