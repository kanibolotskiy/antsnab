<!-- Responsive breadcrumbs 
<div class="bread-crumbs" id="breadcrumbWrapee">
    <ul id="breadcrumbContainer" >
    </ul>
</div>
-->
<!--Particular breadcrumbs' templates
<script id="breadcrumbTemplate" type="text/template">
    <li>
        <a href="<%href%>">
            <%text%>
        </a>
    </li>
</script>
<script id="homeIconTemplate" type="text/template">
     <li class="home">
        <a href="/">
            <i class="material-icons">home</i>
        </a>
     </li>
</script>
<script id="intervalTemplate" type="text/template">
     <li class="interval">...</li>
</script>
-->

<div class="breadcrumbs" itemscope itemtype="http://schema.org/BreadcrumbList">
    <?php $i=0;foreach ($breadcrumbs as $breadcrumb) { ?>
    <span class="itembread" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
        <?php if(!$i){?>
            <a href="<?php echo $breadcrumb['href'];?>" itemprop="item ">
                <span class="bread_desc" itemprop="name"><?php echo $breadcrumb['text'];?></span>
                <span class="bread_mob"><i class="material-icons">home</i></span>
            </a>
        <?php } else{ ?>
            <a href="<?php echo $breadcrumb['href'];?>" itemprop="item ">
                <span itemprop="name"><?php echo $breadcrumb['text'];?></span>
            </a>
        <?php }?>
    </span>	
    
    <?php $i++;} ?>
</div>