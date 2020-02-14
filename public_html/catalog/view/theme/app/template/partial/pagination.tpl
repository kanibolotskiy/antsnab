<div id="pagination_container">
<?php if ($pagination->getTotalNumberOfPages() != 0 && $pagination->getTotalNumberOfPages()>1 ): ?>
    <div class="page-navigation page-navigation2">
   
        <ul>
            <?php if($pagination->getCurrentPageNumber()!==1) { ?>
                <li class="first-child">
                    <a class="prevbut" href="<?php echo str_replace('&page','?page',$pageUrl($pagination->getPreviousPageNumber())); ?>">
                        Предыдущая
                    </a>
                </li>    
            <?php }?>

            <?php foreach ($pagination->getPages() as $p): ?> 
                <li>
                    <?php if ($p == $pagination->getCurrentPageNumber()): ?>
                        <!--<a class="active numberbut" href="<?= $pageUrl($pagination->getPreviousPageNumber()) ?>"><?=$p?></a>-->
                        <div class="active numberbut"><?=$p?></div>
                    <?php else: ?>
                        <a class="numberbut" href="<?php echo str_replace('&page','?page',$pageUrl($p)); ?>"><?=$p?></a>
                        
                <?php endif; ?>
                </li>
            <?php endforeach ?>

            
            <?php if ($pagination->getCurrentPageNumber() != $pagination->getLastPageNumber()){?>
                <li class="last-child">
                    <a class="nextbut" href="<?php echo str_replace('&page','?page',$pageUrl($pagination->getNextPageNumber())); ?>">
                        Следующая
                    </a>
                </li>
            <?php }?>
            
        </ul>
    </div>
<?php endif; ?>
</div>
