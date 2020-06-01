<div class="table-responsive price_table_block">
    <table class="table table-striped table-bordered">
        <tbody>
            <tr>
                <?php foreach($data_table as $itm){?>
                    <td class="price_table_weight"><?=$itm["weight"]?></td>
                <?php }?>
            </tr>
            <tr>
                <?php foreach($data_table as $itm){?>
                    <td class="price_table_price"><?=$itm["price"]?></td>
                <?php }?>
            </tr>
        </tbody>
    </table>
</div>