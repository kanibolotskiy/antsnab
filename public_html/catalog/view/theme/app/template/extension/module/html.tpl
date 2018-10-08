  <?php if($heading_title) { ?>
    <div class="content_inner article">
    <div class="title">
        <?php echo $heading_title; ?>
    </div>
  <?php }  else {?>
    <div class="article" style="background:none; padding-left:0; padding-right:0">
  <?php } ?>
  <?php echo $html; ?>
</div>

