        
<div class="wrapper_basket">
    <div class="header_compare">
        <a class="compare_link <?php echo ($compare_count==0?"_empty":"");?>" href="compare/">
            <div class="compare_div"></div>
        </a>
    </div>
    <div class="header_divider"></div>
    <div class="header_fav">
        <a class="favorite_link <?php echo ($favorite_count==0?"_empty":"");?>" href="favorite/">
            <div class="favorite_div"></div>
        </a>
    </div>
    <div class="header_divider"></div>
    <div class="basket <?php echo ($total_count?'bask_full':'');?>">
        <a href="<?=$cart?>" class="basket_link">
            <?=$total_str?>
        </a>
    </div>
</div>