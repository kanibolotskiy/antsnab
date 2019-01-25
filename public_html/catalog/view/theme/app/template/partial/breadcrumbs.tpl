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

<div class="breadcrumbs" vocab="http://schema.org/" typeof="BreadcrumbList">
    <?php $i=0;foreach ($breadcrumbs as $breadcrumb) { ?>
    <span class="itembread" property="itemListElement" typeof="ListItem">
        <meta property="position" content="<?php echo $i+1;?>">
        <?php if(!$i){?>
            <a property="item" typeof="WebPage" href="<?php echo $breadcrumb['href'];?>">
                <span class="bread_desc" property="name"><?php echo $breadcrumb['text'];?></span>
                <span class="bread_mob"><i class="material-icons">home</i></span>
            </a>
        <?php } else{ ?>
            <?php if($i!=(count($breadcrumbs)-1)){?>
                <a property="item" typeof="WebPage" href="<?php echo $breadcrumb['href'];?>">
                    <span property="name"><?php echo $breadcrumb['text'];?></span>
                </a>
            <?php }else{ ?>
                <span property="item" typeof="WebPage" href="<?php echo $breadcrumb['href'];?>">
                    <span property="name"><?php echo $breadcrumb['text'];?></span>
                </span>
            <?php }?>
        <?php }?>
    </span>	
    
    <?php $i++;} ?>
</div>