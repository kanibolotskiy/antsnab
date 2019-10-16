<div class="basket">
    <a href="<?=$cart?>" class="basket_link">
        <?=$total_str?>
    </a>
    <div class="header_favorite">
        <a class="favorite_link <?php echo ($favorite_count==0?"_empty":"");?>" href="favorite/">Избранное <div class="header_favorite_ico" id="favorite" ><?php echo $favorite_count;?></div></a>
    </div>
</div>
        