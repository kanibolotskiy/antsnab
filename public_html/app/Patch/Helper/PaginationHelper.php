<?php
namespace WS\Patch\Helper;

use AshleyDawson\SimplePagination\Paginator;
use AshleyDawson\SimplePagination\Pagination;

class PaginationHelper
{

    /** @const int Default max pages' links in pagination, when more, goes through */
    const PAGE_RANGE = 10;

    /** @const string pattern to build a pagination link*/
    const LINK_PATTERN = '~baseUrl~&page=~page~';
    const LINK_PATTERN_FILTER = '~baseUrl~?page=~page~';

    /** @const route (in OC terms) to pagination template */
    const PAGINATION_TEMPLATE = 'partial/pagination';

    /** @const route (in OC terms) to lazy pagination template */
    const LAZY_PAGINATION_TEMPLATE = 'partial/lazyload';

    /**
     * Получить модель для пагинации
     * @see https://packagist.org/packages/ashleydawson/simple-pagination
     * @param int $total - общее количество записей
     * @param int $itemsPerPage - количество записей на странице
     * @param int $page - текущая страница
     * @param int $pagesRange - всего страниц 
     * @return \AshleyDawson\SimplePagination\Pagination
     */
    public static function getPaginationModel($total, $itemsPerPage, $page = 1, $pagesRange = null)
    {
        $paginator = new Paginator();
        $pagesRange = $pagesRange??static::PAGE_RANGE;
        $paginator->setItemsPerPage($itemsPerPage)->setPagesInRange($pagesRange);
        $paginator->setItemTotalCallback(function() use ($total) {
            // не используем эти возможноси библиотеки, просто явно задаем количество записей
            return $total;
        });
        $paginator->setSliceCallback(function($offset, $length) { 
            // не используем эти возможности библиотеки, нам не нужны сами записи, только странички
            return []; 
        });
        //$page=3;
        if(isset($_GET['load_pages'])){
            $page=(int)$_GET['load_pages'];
        }
        $pagination = $paginator->paginate($page);
        return $pagination;
    }


    /**
     * Рендер пагинации 
     * @param \Registry $registry - контейнер OC
     * @param string $baseUrl - базовая ссылка страниц
     * @return string HTML rendered
     */
    public static function render(\Registry $registry, $baseUrl, Pagination $paginationModel) 
    {
        
        $load = $registry->get('load');
        $document = $registry->get('document');
        $pageUrl = static::getPageUrl($baseUrl); 

        if (null !== $paginationModel->getPreviousPageNumber() ) {
            $document->addLink($pageUrl($paginationModel->getPreviousPageNumber()), 'prev'); 
        }
 
        if (null !== $paginationModel->getNextPageNumber() ) {
            $document->addLink($pageUrl($paginationModel->getNextPageNumber()), 'next');
            //$document->addLink($baseUrl, 'canonical');            
        }
        //$document->addLink('canonical',$baseUrl);
        $baseUrl_arr=explode("?",$baseUrl);
        $document->addLink($baseUrl_arr[0],'canonical');
        return $load->view(static::PAGINATION_TEMPLATE, ['pagination' => $paginationModel, 'pageUrl' => $pageUrl]);
    }

    /**
     * Рендер ленивой пагинации
     * @return string HTML rendered
     */
    public static function renderLazy(\Registry $registry, $baseUrl, Pagination $paginationModel, $isAjax = false) 
    {
        $load = $registry->get('load');
        $document = $registry->get('document');
        $pageUrl = static::getPageUrl($baseUrl); 
        if( !$isAjax ) {
            $document->addScript('/catalog/view/javascript/lazyload.js');
        }
        return $load->view(static::LAZY_PAGINATION_TEMPLATE, ['pagination' => $paginationModel, 'pageUrl' => $pageUrl]);
    }

    /**
     * Подготовить ответ для фронт-энд обработчика ленивой загрузки
     * @see catalog/view/javascript/lazyload.js
     * @param \Registry $registry - контейнер OC
     * @param array $params - набор параметров, все поля обязательные
     *       'items' => <string[] массив срендеренных элементов загрузки> 
     *       'total' => <int общее количество элементов>
     *       'itemsPerPage' => <int количество элементов на страницу>, 
     *       'page' => <int текущая страница> 
     *       'paginationBaseUrl' => <string базовый url для пагинации>,  
     *       'lazyLoadBaseUrl' => <string базовый url для леновй пагинации> 
     * @return string - json-строка - ответ для обработчика
     */
    public static function getLazyLoadResponse(\Registry $registry, $params)
    {
        $paginationModel = static::getPaginationModel($params['total'], $params['itemsPerPage'], $params['page']);
        $pagination = PaginationHelper::render($registry, $params['paginationBaseUrl'], $paginationModel);
        $paginationLazy = PaginationHelper::renderLazy($registry, $params['lazyLoadBaseUrl'], $paginationModel, true);

        $result['result'] = [ 
           'items' => $params['items'],
           'pagination' => $pagination,
           'showMore' => $paginationLazy
        ];
        return json_encode($result, JSON_HEX_QUOT);
    }

   /**
    * Получить замыкание для генерации ссылок на страницы внутри шаблона 
    * @return Callable
    */
    private static function getPageUrl($baseUrl)
    {
        $urlPattern = static::LINK_PATTERN;
        $pageUrlCallback = function($page) use ($urlPattern, $baseUrl){
            if ( $page == 1 ) {
                return $baseUrl;
            }
            if(!strpos($baseUrl, '?')){
                $urlPattern=str_replace('&page', '?page',$urlPattern);
            }
            $out = str_replace(['~page~', '~baseUrl~'], [$page, $baseUrl], $urlPattern);

            
            return $out;
        };
        return $pageUrlCallback;
    }
}
