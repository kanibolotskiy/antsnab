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
    <?php if ($customer_id) { ?>
    <p style="margin-top: 0px; margin-bottom: 20px;"><?php echo $text_link; ?></p>
    <p style="margin-top: 0px; margin-bottom: 20px;"><a href="<?php echo $link; ?>"><?php echo $link; ?></a></p>
    <?php } ?>
    <?php if ($download) { ?>
    <p style="margin-top: 0px; margin-bottom: 20px;"><?php echo $text_download; ?></p>
    <p style="margin-top: 0px; margin-bottom: 20px;"><a href="<?php echo $download; ?>"><?php echo $download; ?></a></p>
    <?php } ?>
    <?php if ($text_capred) { ?>
        <p style="color:#ff0000;"><?php echo $text_capred;?></p>
    <?php }?>
    <table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;" name="info">
        <thead>
            <tr>
                <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: 7px; color: #222222;" colspan="2"><?php echo $text_order_detail; ?></td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"><b><?php echo $text_order_id; ?></b> <span name="order_id"><?php echo $order_id; ?></span><br />
                    <b><?php echo $text_date_added; ?></b> <span name="order_date"><?php echo $date_added; ?></span><br />
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
                    <b><?php echo $text_name; ?></b> <span name="order_name"><?php echo $name; ?></span><br />
                    <b><?php echo $text_email; ?></b> <span name="order_email"><?php echo $email; ?></span><br />
                    <b><?php echo $text_telephone; ?></b> <span name="order_phone"><?php echo $telephone; ?></span><br />
                    <b><?php echo $text_inn; ?></b> <span name="order_inn"><?php echo $inn; ?></span><br />
                    <b><?php echo $text_ip; ?></b> <span name="order_ip"><?php echo $ip; ?></span><br />
            </tr>
        </tbody>
    </table>
    <?php if ($comment) { ?>
    <table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;">
        <thead>
            <tr>
                <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: 7px; color: #222222;"><?php echo $text_instruction; ?></td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"><?php echo $comment; ?></td>
            </tr>
        </tbody>
    </table>
    <?php } ?>
    <table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;">
        <thead>
            <tr>
                <?php if ($shipping_address) { ?>
                    <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: 7px; color: #222222;"><?php echo $text_shipping_address; ?></td>
                <?php } ?>
            </tr>
        </thead>
        <tbody>
            <tr>
                <?php if ($shipping_address) { ?>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"><?php echo $shipping_address; ?></td>
                <?php } ?>
            </tr>
        </tbody>
    </table>
    <table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;" name="order">
        <thead>
            <tr>
                <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: 7px; color: #222222;"><?php echo $text_product; ?></td>
                <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: 7px; color: #222222;">Артикул</td>
                <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: right; padding: 7px; color: #222222;"><?php echo $text_quantity; ?></td>
                <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: 7px; color: #222222;"><?php echo $text_unit; ?></td>
                <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: right; padding: 7px; color: #222222;"><?php echo $text_price; ?></td>
                <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: right; padding: 7px; color: #222222;"><?php echo $text_total; ?></td>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($products as $product) { ?>
            <tr name="product_row">
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;" name="product_name"><?php echo $product['name']; ?>
                    <?php foreach ($product['option'] as $option) { ?>
                    <br />
                    &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                    <?php } ?></td>
                    
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;" name="product_articul"><?php echo $product['model'];?></td>

                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;" name="product_quantity"><?php echo $product['quantity']; ?></td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;" name="product_unit"><?php echo $product['unit']; ?></td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;" name="product_price"><?php echo $product['price']; ?></td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;" name="product_total"><?php echo $product['total']; ?></td>
            </tr>
            <?php } ?>
            <?php foreach ($vouchers as $voucher) { ?>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"><?php echo $voucher['description']; ?></td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"></td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;">1</td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;"><?php echo $voucher['amount']; ?></td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;"><?php echo $voucher['amount']; ?></td>
            </tr>
            <?php } ?>
        </tbody>
        <tfoot>
            <?php foreach ($totals as $total) { ?>
            <tr>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;" colspan="5"><b><?php echo $total['title']; ?>:</b></td>
                <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;"><?php echo $total['text']; ?></td>
            </tr>
            <?php } ?>
        </tfoot>
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
    <p style="margin-top: 0px; margin-bottom: 20px;"><?php echo $text_footer; ?></p>
</div>
</body>
</html>
