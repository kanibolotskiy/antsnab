<script type="text/javascript">
    function getUrlParams (href) {
        var match,
            pl     = /\+/g,  // Regex for replacing addition symbol with a space
            search = /([^&=]+)=?([^&]*)/g,
            decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); };

        urlParams = {};
        while (match = search.exec(href)) {
           urlParams[decode(match[1])] = decode(match[2]);
        }
        return urlParams;
    }

    document.addEventListener("DOMContentLoaded", function(){
        function showMoreHandler(e) {
            e.preventDefault();
            var href = $(this).attr('href'),
                urlParams = getUrlParams(href),
                
                endPoint = '/index.php?route=newsblog/category/showmore';

            $.post(endPoint, {
                    newsblog_path:urlParams.newsblog_path, 
                    page: urlParams.page, 
                    filter_year: urlParams.filter_year
                })
                .done(function(dataJson){
                    var data = $.parseJSON(dataJson),
                        $container = $('#lazy-load_container'),
                        $pagination = $('#pagination_container'),
                        template = $('#news-block').html();

                    if( null === data.result ) {
                        alert( 'Error response: ' + data.error);
                        return false;
                    }
                    
                    var articles = data.result.articles,
                        pagination = data.result.pagination;

                    $.each( articles, function(index, article){
                        var regex = new RegExp('<%.*%>', 'g'), 
                            html = template.replace(regex, function(match){
                                var substr = '',
                                    varName = match.replace('<%', '').replace('%>', '');
                                if( undefined !== article[varName] ) {
                                    substr = article[varName];
                                }
                                return substr;
                            });
                        var $append = $(html);
                        $container.append($append);
                        $append.slideDown('slow');
                    });

                    $pagination.html(pagination);
                    setTimeout( function() { $('#showMore').on('click', showMoreHandler) }, 100 );
                })
                .fail(function(){
                    alert('Server Error');
                });
        };
        $('#showMore').on('click', showMoreHandler);
    });
</script>
