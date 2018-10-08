<?php
namespace WS\Override\Controller\Site\Common;
use WS\Override\Controller\IDecorator;

class SearchTemplateDecorator implements IDecorator
{
    public function process($data, $registry): array
    {
        $data['search_url'] = $registry->get('url')->link('product/search'); 
        return $data;
    }
}
