<div id="pagination_container">
<?php if ($pagination->getTotalNumberOfPages() != 0 && $pagination->getTotalNumberOfPages()>1 ): ?>
    <div class="page-navigation page-navigation2">
        <ul>
            <?php $style = (1 !== $pagination->getCurrentPageNumber())?'':'style="display:none"'?>
            <li class="first-child">
                <a <?=$style?> class="prevbut" href="<?= $pageUrl($pagination->getPreviousPageNumber()) ?>">
                    Предыдущая
                </a>
            </li>

            <?php foreach ($pagination->getPages() as $p): ?> 
                <li>
                    <?php if ($p == $pagination->getCurrentPageNumber()): ?>
                        <a class="active numberbut" href="<?= $pageUrl($pagination->getPreviousPageNumber()) ?>"><?=$p?></a>
                    <?php else: ?>
                        <a class="numberbut" href="<?= $pageUrl($p) ?>"><?=$p?></a>
                <?php endif; ?>
                </li>
            <?php endforeach ?>

            <?php $style = ($pagination->getCurrentPageNumber() != $pagination->getLastPageNumber())?'':'style="display:none"'?>
            <li class="last-child">
                <a <?=$style?> class="nextbut" href="<?= $pageUrl($pagination->getNextPageNumber()) ?>">
                    Следующая
                </a>
            </li>
        </ul>
    </div>
<?php endif; ?>
</div>
