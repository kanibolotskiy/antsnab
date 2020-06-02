<div class="table-responsive price_table_block">
    <table class="table table-striped table-bordered">
        <tbody>
            <tr>
                <?php for($i=0;$i<count($data_table)-1;$i++){?>
                    <td class="price_table_weight"><?=$data_table[$i]["weight"]?></td>
                <?php }?>
            </tr>
            <tr>
                <?php for($i=0;$i<count($data_table)-1;$i++){?>
                    <td class="price_table_price"><?=$data_table[$i]["price"]?></td>
                <?php }?>
            </tr>
        </tbody>
    </table>
</div>