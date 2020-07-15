<table style="border-collapse:collapse;">
    <tr>
        <td style="width:100px;"><img width="95" height="95" src="https://ant-snab.ru/<?=$logo?>"></td>
        <td style="padding:4px 10px;font-weight: bold;font-size: 16px;color: green;"><?php echo $caption;?></td>
    </tr>
    <?php foreach($data_content as $data_row) {?>
        <tr>
            <td style="border:1px solid #ddd;padding:4px 10px;"><?php echo $data_row[0];?></td>
            <td style="border:1px solid #ddd;padding:4px 10px;"><?php echo $data_row[1];?></td>
        </tr>
    <?php }?>
</table>