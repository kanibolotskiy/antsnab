<?php
namespace WS\Override\Controller\Site\Information;

use WS\Override\Controller\Site\Newsblog\CategoryController as BlogCategoryController;
use BlueM\Tree as Tree;

class SitemapController extends \Controller {
	public function index() {
		$this->load->language('information/sitemap');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->setDescription($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('information/sitemap')
		);

		$data['heading_title'] = $this->language->get('heading_title');


		$data['text_information'] = $this->language->get('text_information');
		$data['text_contact'] = $this->language->get('text_contact');
        $data['contact'] = $this->url->link('information/contact'); 


        $categories = $this->hierarhy->getTree();
		$data['categories'] = $this->prepareCategoryList($categories,'product/category','path');
        $data['heading_categories'] = $this->language->get('heading_categories');

        $this->load->model('newsblog/category');

        //Новости
        $newsCats = $this->model_newsblog_category->getCategories(BlogCategoryController::NEWS_CATEGORY_ID);
        $newsTree = new Tree($newsCats, ['rootid'=>BlogCategoryController::NEWS_CATEGORY_ID, 
                                         'id'=>'category_id', 
                                         'parent'=>'parent_id']
                    );
        $data['news'] = $this->prepareCategoryList($newsTree, 'newsblog/category', 'newsblog_path');
        $data['heading_news'] = $this->language->get('heading_news');


        //Статьи
        $articleCats = $this->model_newsblog_category->getCategories(BlogCategoryController::ARTICLES_CATEGORY_ID);
        $articleTree = new Tree($articleCats, ['rootid'=>BlogCategoryController::ARTICLES_CATEGORY_ID, 
                                         'id'=>'category_id', 
                                         'parent'=>'parent_id']
                    );
        $data['articles'] = $this->prepareCategoryList($articleTree, 'newsblog/category', 'newsblog_path');
        $data['heading_articles'] = $this->language->get('heading_articles');
        

		$this->load->model('catalog/information');

		$data['informations'] = array();

		//$exclude_ids=[10]; //Исключаем лишние страницы

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if(!$result['notinmap']){
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}
		
        

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('information/sitemap', $data));
	}

    private function prepareCategoryList(Tree $tree, $routeName, $pathName)
    {
        $data['categories'] = [];

        //$categories_1 = $this->model_catalog_category->getCategories(0);
        
		$categories_1 = $tree->getRootNodes();
		
		foreach ($categories_1 as $category_1) {
			
			$level_2_data = array();

			//$categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);
            $categories_2 = $category_1->getChildren();

			foreach ($categories_2 as $category_2) {
				$level_3_data = array();

				//$categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);
                $categories_3 = $category_2->getChildren();

				foreach ($categories_3 as $category_3) {

                    $level_4_data = array();
                    $categories_4 = $category_3->getChildren();
                    foreach( $categories_4 as $category_4 ) {
						$path4 = $this->hierarhy->getPath($category_4->getId());
						if(!$category_4->get('isseo')){
							$level_4_data[] = array(
								'name' => $category_4->get('name'),
								'href' => $this->url->link($routeName, $pathName . '=' . $path4), 
							);
						}
                    }

					$path3 = $this->hierarhy->getPath($category_3->getId());
					if(!$category_3->get('isseo')){
						$level_3_data[] = array(
							'name' => $category_3->get('name'),
							'children' => $level_4_data,
							'href' => $this->url->link($routeName, $pathName . '=' . $path3)
						);
					}
				}

				$path2 = $this->hierarhy->getPath($category_2->getId());
				if(!$category_2->get('isseo')){
					$level_2_data[] = array(
						'name'     => $category_2->get('name'),
						'children' => $level_3_data,
						'href'     => $this->url->link($routeName, $pathName . '=' . $path2),
					);
				}
			}
		
				$data['categories'][] = array(
					'name'     => $category_1->get('name'),
					'children' => $level_2_data,
					'href'     => $this->url->link($routeName, $pathName . '=' . $category_1->getId())
				);
		
		}

        return $data['categories'];
    }
}
