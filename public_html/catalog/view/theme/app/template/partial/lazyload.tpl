<?php if ($pagination->getTotalNumberOfPages() != 0 ): ?>
    <?php if ($pagination->getCurrentPageNumber() != $pagination->getLastPageNumber()): ?>
        <button  id="showMore"
            data-href="<?= $pageUrl($pagination->getNextPageNumber()) ?>" 
            data-container="#lazy-load_container"
            data-pagincontainer ="#pagination_container"
            class="show-more">
            Показать еще
        </button>
    <?php endif; ?>
<?php endif;?>