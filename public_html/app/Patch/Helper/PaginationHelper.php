<?php
namespace WS\Patch\Helper;

use AshleyDawson\SimplePagination\Paginator;
use AshleyDawson\SimplePagination\Pagination;

class PaginationHelper
{

    /** @const int Max pages' links in pagination, when more, goes through */
    const PAGE_RANGE = 10;

    /** @const string pattern to build a pagination link*/
    const LINK_PATTERN = '~baseUrl~&page=~page~';

    /** @const index in meta info of Pagination model for base Url, mandatory when build it*/
    const BASE_URL_META_INDEX = 'baseUrl';

    /** @const route (in OC terms) to pagination */
    const PAGINATION_ROUTE = 'partial/pagination';

    /**
     * Получить модель для пагинации
     * @see https://packagist.org/packages/ashleydawson/simple-pagination
     * @param int $total - общее количество записей
     * @parma int $page - текущая страница
     * @param array $slice - отображаемый срез записей
     * @param string[] $meta - дополнительная мета-информация, поле baseUrl - обязательное
     * @return \AshleyDawson\SimplePagination\Pagination
     */
    public static function getPaginationModel($total, $itemsPerPage, $page, $slice, $meta)
    {
        if ( null === $meta[static::BASE_URL_META_INDEX] ) {
            throw new Exception('Cant create Pagination model. Meta-field baseUrl is mandatory');
        }
        $paginator = new Paginator();
        $paginator->setItemsPerPage($itemsPerPage)->setPagesInRange(static::PAGE_RANGE);
        $paginator->setItemTotalCallback(function() use ($total) {
            return $total;
        });
        $paginator->setSliceCallback(function($offset, $length) use ($slice) {
            return $slice;
        });
        $pagination = $paginator->paginate($page);
        $pagination->setMeta($meta);

        return $pagination;
    }

    /**
     * Получить ссылку навигации для страницы 
     * @param string $baseUrl - базовый урл пагинированных записей
     * @param int $page - номер страницы
     * @return string - сформированная ссылка
     */
    public static function getPaginationHref($baseUrl, $page)
    {
        if ( $page == 1 ) {
           return $baseUrl;
        }

        return str_replace(['~page~', '~baseUrl~'], [$page, $baseUrl], static::LINK_PATTERN);
    }

    /**
     * Устанавливает мета теги <link> 
     * @see http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html 
     * @param \Document $document
     * @param Pagination $pagination
     * @throws Exception
     */
    public static function setDocumentLinks(\Document $document, Pagination $pagination)
    {
        $meta = $pagination->getMeta();
        if  (null === $meta[static::BASE_URL_META_INDEX] ) {
            throw new Exception('Cant set Pagination Document Links. Meta field baseUrl is mandatory in Pagination model');
        }

        $baseUrl = $meta[static::BASE_URL_META_INDEX];

        if (null !== $pagination->getPreviousPageNumber() ) {
           $document->addLink(static::getPaginationHref($baseUrl, $pagination->getPreviousPageNumber()), 'prev');
        }

        if (null !== $pagination->getNextPageNumber() ) {
           $document->addLink(static::getPaginationHref($baseUrl, $pagination->getNextPageNumber()), 'next');
        }

        return true;
    }
    
    /**
     * Рендеринг пагинации для вывода в шаблон 
     * @param \Loader $load
     * @param Pagination $pagination
     * @return string HTML rendered
     */
    public static function render(\Loader $load, Pagination $pagination)
    {
       $result = $load->view(static::PAGINATION_ROUTE, ['pagination'=>$pagination]);
       return $result; 
    }

}
