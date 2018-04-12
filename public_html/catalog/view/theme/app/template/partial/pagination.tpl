<?php

use WS\Patch\Helper\PaginationHelper as PH;

$meta = $pagination->getMeta();
$baseUrl = $meta[PH::BASE_URL_META_INDEX];
$lazy = ( isset($meta['lazy']) )?$meta['lazy']:false;
?>
<div id="pagination_container">
<?php if (count($pagination->getPages()) > 1): ?>

    <?php if ($pagination->getCurrentPageNumber() != $pagination->getLastPageNumber() && $lazy): ?>
        <a id="showMore"  href="<?= PH::getPaginationHref($baseUrl, $pagination->getNextPageNumber()) ?>" class="show-more">
            Показать еще
        </a>
    <?php endif; ?>

    <div class="page-navigation page-navigation2">
        <ul>
            <?php if (1 !== $pagination->getCurrentPageNumber()): ?>
                <li class="first-child">
                    <a href="<?= PH::getPaginationHref($baseUrl, $pagination->getPreviousPageNumber()) ?>">
                        Предыдущая
                    </a>
                </li>
            <?php endif; ?>

            <?php foreach ($pagination->getPages() as $p): ?> 
                <li>
                    <?php if ($p == $pagination->getCurrentPageNumber()): ?>
                        <a class="active" href="<?= PH::getPaginationHref($baseUrl, $p) ?>"><?=$p?></a>
                    <?php else: ?>
                        <a href="<?= PH::getPaginationHref($baseUrl, $p) ?>"><?=$p?></a>
                <?php endif; ?>
                </li>
            <?php endforeach ?>

            <?php if ($pagination->getCurrentPageNumber() != $pagination->getLastPageNumber()): ?>
                <li class="last-child">
                    <a href="<?= PH::getPaginationHref($baseUrl, $pagination->getNextPageNumber()) ?>">
                        Следующая
                    </a>
                </li>
            <?php endif; ?>
        </ul>
    </div>
<?php endif; ?>
</div>
