<ol class="breadcrumbs" itemscope itemtype="http://schema.org/BreadcrumbList">

<?php $i=0;foreach ($breadcrumbs as $breadcrumb) { ?>
    
    <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
        <meta itemprop="position" content="<?php echo $i+1;?>" />
        <?php if(!$i){?>
            <a itemprop="item" href="<?php echo $breadcrumb['href'];?>">
        
                <span class="bread_desc" itemprop="name"><?php echo $breadcrumb['text'];?></span>
                <span class="bread_mob bread_mob_home"></span>
            </a>
        <?php } else{ ?>
            <?php if($i!=(count($breadcrumbs)-1)){?>
                <a itemprop="item" href="<?php echo $breadcrumb['href'];?>">
                    <span itemprop="name"><?php echo $breadcrumb['text'];?></span>
                </a>
            <?php }else{ ?>
                <span itemprop="item">
                    <span itemprop="name" href="<?php echo $breadcrumb['href'];?>"><?php echo $breadcrumb['text'];?></span>
                </span>
            <?php }?>
        <?php }?>
    </li>	
    
    <?php $i++;} ?>
</ul>
