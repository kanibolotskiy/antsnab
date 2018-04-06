<a href="" class="basket">
    <?php if ($products || $vouchers) { ?>
    <?= $text_items ?>
    <?php  } else { ?>
    <?= $text_empty ?>
    <?php } ?>
</a>
