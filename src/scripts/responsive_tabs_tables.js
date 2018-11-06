import './lib/easyResponsiveTabs';

/* Адаптивные табы в карточке продукта */
$('#demoTab').easyResponsiveTabs(
    {
        tabidentify: 'vert',
        active_border_color: '#fff',
        active_content_border_color: '#fff',
        inactive_bg: "#EFEEEC"
    }
);

/* Адаптивные таблицы в статьях */
$(".article").find("table").each(function () {
    $(this).wrap('<div class="table-responsive"></div>');
});

