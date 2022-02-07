<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><?php echo $title; ?></title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000;">

<table style="border-collapse:collapse;">
    <tr>
        <td style="width:100px;"><img width="95" height="95" src="https://ant-snab.ru/image/catalog/logo.jpg"></td>
        <td style="padding:4px 10px;font-weight: bold;font-size: 16px;color: red;"><?php echo $caption;?></td>
    </tr>
</table>

<div style="width: 680px;">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight:bold; color: #000000;">
        <?=$text?>
    </p>
    <table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;" name="info">
        <tbody>
            <tr>
                <td style="font-size:12px;border-right:1px solid #dddddd;border-bottom:1px solid #dddddd;background-color:#efefef;font-weight:bold;text-align:left;padding:7px;color:#222222" colspan="2">Информация</td>
            </tr>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    Лендинг
                </td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    <?php echo $landing; ?>
                </td>
            </tr>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    Телефон
                </td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    <span name="order_phone"><?php echo $phone; ?></span>
                </td>
            </tr>
            
            <?php if(isset($name)){ ?>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    Имя
                </td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    <span name="order_name"><?php echo $name; ?></span>
                </td>
            </tr>
            <?php }?>

            <?php if(isset($email)){ ?>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    Email
                </td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    <span name="order_email"><?php echo $email; ?></span>
                </td>
            </tr>
            <?php }?>

            <?php if(isset($product)){ ?>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    Товар
                </td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    <span name="order_product"><?php echo $product; ?></span>
                </td>
            </tr>
            <?php }?>

            <?php if(isset($inn)){ ?>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    ИНН
                </td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    <span name="order_inn"><?php echo $inn; ?></span>
                </td>
            </tr>
            <?php }?>

            <?php if(isset($firma)){ ?>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    Название компании
                </td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    <span name="order_client"><?php echo $firma; ?></span>
                </td>
            </tr>
            <?php }?>
            
            <?php if(isset($site)){ ?>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    Сайт
                </td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    <span name="order_site"><?php echo $site; ?></span>
                </td>
            </tr>
            <?php }?>
        </tbody>
    </table>
    <table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;" name="tag">
        <tr>
            <td colspan="2" style="background-color: #EFEFEF;font-size: 12px;border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;font-weight:bold;">Метки</td>
        </tr>
        <tr>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_name">UTM Source</td>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_value"><?=$utm_source?></td>
        </tr>
        <tr>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_name">UTM Medium</td>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_value"><?=$utm_medium?></td>
        </tr>
        <tr>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_name">UTM Campaign</td>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_value"><?=$utm_campaign?></td>
        </tr>
        <tr>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_name">UTM Term</td>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_value"><?=$utm_content?></td>
        </tr>
        <tr>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_name">UTM Content</td>
            <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; padding: 7px;" name="UTM_value"><?=$utm_term?></td>
        </tr>                                
    </table> 
</div>
</body>
</html>
