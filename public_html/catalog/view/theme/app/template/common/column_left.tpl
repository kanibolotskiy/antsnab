<div class="sidebar">
    <div class="search-form">
        <form action="<?=$search_link?>" method="post">
            <input type="text" name="search" placeholder="Поиск по каталогу...">
            <input type="submit" value="">
        </form>
    </div>
    <?php if ($modules) { ?>
        <?php foreach ($modules as $module) { ?>
            <?php echo $module; ?>
        <?php } ?>
    <?php } ?>
</div>
<!--<script>
    /* Search */
    $('#search input[name=\'search\']').parent().find('button').on('click', function () {
        var url = $('base').attr('href') + 'index.php?route=product/search';

        var value = $('header #search input[name=\'search\']').val();

        if (value) {
            url += '&search=' + encodeURIComponent(value);
        }

        location = url;
    });

    $('#search input[name=\'search\']').on('keydown', function (e) {
        if (e.keyCode == 13) {
            $('header #search input[name=\'search\']').parent().find('button').trigger('click');
        }
    });
</script>-->