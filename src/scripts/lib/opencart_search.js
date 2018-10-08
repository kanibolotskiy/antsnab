/* Search */
$('#search input[name=\'search\']').parent().find('button').on('click', function (e) {
    e.preventDefault();
    var url = $(this).attr('data-search-url');

    var value = $('#search input[name=\'search\']').val();

    if (value) {
        url += '&search=' + encodeURIComponent(value);
    }

    location = url;
});

$('#search input[name=\'search\']').on('keydown', function (e) {
    if (e.keyCode == 13) {
        $('#search input[name=\'search\']').parent().find('button').trigger('click');
    }
});

