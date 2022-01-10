<?php
namespace WS\Override\Controller\Site\Extension\Module;
use BlueM\Tree\Node as Node;
use WS\Patch\Helper\ProductListHelper;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CategoryController extends \Controller
{
    private static $openedItems;

    
    public function index($isproduct=0)
    {
        $this->load->language('extension/module/category');
		$data['heading_title'] = $this->language->get('heading_title');

		$parts = array();
        $data['category_id'] = ROOT_CATEGORY_ID;
        $data['root'] = $this->url->link('product/category', 'path=' . ROOT_CATEGORY_ID);

        if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
			$data['category_id'] = array_pop($parts); 
		}
        //print_r($this->request->get['path']);
        $data['openeditems'] = self::$openedItems = $parts;
        $data['openeditems'][] = $data['category_id'];
       
        $data['categories'] = [];
        foreach(  $this->hierarhy->getRootNodes() as $node ) {
            $item = $node->toArray();
            $item['href'] = $this->url->link('product/category', 'path=' . $this->hierarhy->getPath($node->getId())); 
            $item['child'] = $this->recursiveGetItems($node);
            
            if(!$item['isseo']){
                $data['categories'][] = $item;
            }
        }
        //echo $data['category_id'];
       

        if($data['category_id']==ROOT_CATEGORY_ID){
            $data["show_params"]=false;
        }else{
            if($isproduct){
                $data["show_params"]=false;
            }else{
                $data["show_params"]=true;
            }
            
        }

        $show_filter=false;
        if(isset($this->request->get['param'])){
            if($this->request->get['param']){
                $show_filter=true;
            }
        }
        $data["show_filter"]=$show_filter;
        return $this->load->view('extension/module/app/category', $data);
    }

    private function recursiveGetItems(Node $rootNode)
    {
        $categories = [];
        foreach( $rootNode->getChildren() as $node ) {
            $item = $node->toArray();
            if(!$item['isseo']){
                $item['href'] = $this->url->link('product/category', 'path=' . $this->hierarhy->getPath($node->getId()));
                if( in_array($node->getId(), self::$openedItems) ) {
                    $item['child'] = $this->recursiveGetItems($node);    
                }
                
                $categories[] = $item;
            }
        }
                
        return $categories;
    }

}
