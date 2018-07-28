<!-- filter in list, not used yet -->
<div class="well">
    <div class="row">
        <div class="col-sm-12">
            <div class="form-group">
                <label class="control-label" for="input-filter_category">
                    <?php echo $entry_filter_category; ?>
                </label>
                <input value="<?= $filter_category_value ?>" name="filter_category" id="input-filter_category" class="form-control"/>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <button data-url="<?= $filter ?>" type="button" id="button-filter" class="btn btn-primary pull-right">
                <i class="fa fa-filter"></i> <?php echo $button_filter; ?></button>
        </div>
    </div>
</div>
<script>
    $(window).on('load', function () {
        $('#button-filter').on('click', function (e) {
            e.preventDefault();
            var filter_val = $('#input-filter_category').val(),
                    url = $(this).attr('data-url');
            window.location.href = url + '&filter_name=' + filter_val
        });
    });
</script>
