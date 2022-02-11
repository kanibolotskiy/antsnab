<?php echo $caption_telega; ?>
Лендинг: <b><?php echo $landing; ?></b>
Телефон: <b><?php echo $phone; ?></b> 
<?php if(isset($file_kp)){echo "КП: <b>".$file_kp."</b>\n";}?>
<?php if(isset($name)){echo "Имя: <b>".$name."</b>\n";}?>
<?php if(isset($email)){echo "Email: <b>".$email."</b>\n";}?>
<?php if(isset($inn)){echo "ИНН: <b>".$inn."</b>\n";}?>
<?php if(isset($firma)){echo "Название компании: <b>".$firma."</b>\n";}?>
<?php if(isset($site)){echo "Сайт: <b>".$site."</b>\n";}?>
<?php if(isset($product) and $product){echo "Товар: <b>".trim($product)."</b>\n";}?>
<?php if(isset($sku)){echo "Артикул: <b>".$sku."</b>\n";}?>
 
UTM Source: <?php echo $utm_source;?> 
UTM Medium: <?php echo $utm_medium;?> 
UTM Campaign: <?php echo $utm_campaign;?> 
UTM Term: <?php echo $utm_term;?> 
UTM Content: <?php echo $utm_content;?> 