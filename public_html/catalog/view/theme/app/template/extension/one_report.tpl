<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><?php echo $title; ?></title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000;">
<table style="border-collapse:collapse;">
        <tr>
                <td style="width:100px;"><img width="95" height="95" src="<?php echo $logo;?>"></td>
                <td style="padding:4px 10px;font-weight: bold;font-size: 16px;color: green;"><?php echo $caption;?></td>
        </tr>
</table>

<div style="width: 680px;">


<table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;" name="order">
<!--
    <tr>
        <td style="width:100px;"><img width="95" height="95" src="<?php echo $logo;?>"></td>
        <td style="padding:4px 10px;font-weight: bold;font-size: 16px;color: green;"><?php echo $caption;?></td>
    </tr>
-->
    <?php foreach($data_content as $data_row) {?>
        <tr>
            <td style="border:1px solid #ddd;padding:4px 10px;"><?php echo $data_row[0];?></td>
            <td style="border:1px solid #ddd;padding:4px 10px;"><?php echo $data_row[1];?></td>
        </tr>
    <?php }?>
   
</table>

<table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;" name="tag">
    <tr>
        <td colspan="2" style="background-color: #EFEFEF;font-size: 12px;border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;font-weight:bold;">Метки</td>
    </tr>
    <?php foreach($data_utm as $data_row) {?>
        <tr>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_name"><?php echo $data_row[0];?></td>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_value"><?php echo $data_row[1];?></td>
        </tr>
    <?php }?>
</table>
<!---->
</div>
</body>
</html>