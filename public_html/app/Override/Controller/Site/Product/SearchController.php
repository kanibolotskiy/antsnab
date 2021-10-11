<?php

namespace WS\Override\Controller\Site\Product;

use WS\Patch\Helper\ProductListHelper;
use WS\Patch\Helper\PaginationHelper;

class SearchController extends \Controller
{	
	
	public function bestSearch(){
		
		$this->load->model('catalog/search');
		$query=$_GET["query"];
		
		$query = preg_replace('/\s/', ' ', $query);
			
		$query_arr=explode(" ",$query);
		
		$query_rez=[];
		foreach($query_arr as $itm){
			if(mb_strlen($itm)>1){
				$query_rez[]=$itm;
			}
		}
		$search_results=$this->model_catalog_search->searchBase($query_rez,10);
		$json["suggestions"]=[];
		
		foreach($search_results as $search_result){
			//echo $search_result;
			//echo "!".$search_result["meta_h1"]."!=".html_entity_decode($search_result["meta_h1"]);

			$json["suggestions"][]=Array(
				
				//"value"=>$search_result["meta_h1"],
				"value"=>html_entity_decode($search_result["meta_h1"]),
				//"value"=>html_entity_decode($search_result["meta_h1"]),
				"data"=>$this->url->link('product/product', '&product_id=' . $search_result["product_id"])
			);
		}
		echo json_encode($json);
		
	}
	public function liveSearch(){
		$json["suggestions"]=[];
		if(isset($this->request->get['query'])){
			$url_search="https://catalogapi.site.yandex.net/v1.0?apikey=4a4f0a45-0b05-437e-b0dc-5edca1573563&text=".urlencode($this->request->get['query'])."&searchid=2365979&per_page=10";
			$products_search=file_get_contents($url_search);
			$products_search_arr=json_decode($products_search,TRUE);	
			
			/*
			$product_ids=[];
			$json["suggestions"]=array(
				["value"=>"test1","data"=>"test2"],
				["value"=>"test3","data"=>"test4"],
			);
*/
			if(isset($products_search_arr['documents'])){
				foreach($products_search_arr["documents"] as $itm){
					
					//$json["suggestions"][]='<a href="'.($this->url->link('product/product', 'product_id=' . $itm['id'])).'">'.$itm['name'].'</a>';
					$json["suggestions"][]=array("value"=>"test1","data"=>"test2");
					/*
					$product_ids[]=Array(
						"id" => $itm['id'],
						"name" => $itm['name'],
						"href" => $this->url->link('product/product', 'product_id=' . $itm['id'])
					);
					*/
				}	
			}

		}
		
		
		echo json_encode($json);
		//echo $json;
	}
    public function index()
    {
		
        $this->load->language('product/search');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');
		
		if (isset($this->request->get['search'])) {
			$search = $this->request->get['search'];
		} else {
			$search = '';
		}

		if (isset($this->request->get['tag'])) {
			$tag = $this->request->get['tag'];
		} elseif (isset($this->request->get['search'])) {
			$tag = $this->request->get['search'];
		} else {
			$tag = '';
		}

		if (isset($this->request->get['description'])) {
			$description = $this->request->get['description'];
		} else {
			$description = '';
		}

		if (isset($this->request->get['category_id'])) {
			$category_id = $this->request->get['category_id'];
		} else {
			$category_id = 0;
		}

		if (isset($this->request->get['sub_category'])) {
			$sub_category = $this->request->get['sub_category'];
		} else {
			$sub_category = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			if($this->request->get['limit']=="all"){
				$limit=999999;
			}else{
				$limit = (int)$this->request->get['limit'];
			}
			
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}
		/*
		if(isset($_GET["limit"])){
			if($_GET["limit"]=="all"){
				$limit=999999;
			}else{
				$limit=$_GET["limit"]*1;
			}            
		}else{
			$limit=(int) $this->config->get($this->config->get('config_theme') . '_product_limit');
		}
		*/

		

		

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
        
		$url = '';

		if (isset($this->request->get['text'])) {
			$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['tag'])) {
			$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['description'])) {
			$url .= '&description=' . $this->request->get['description'];
		}

		if (isset($this->request->get['category_id'])) {
			$url .= '&category_id=' . $this->request->get['category_id'];
		}

		if (isset($this->request->get['sub_category'])) {
			$url .= '&sub_category=' . $this->request->get['sub_category'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('product/search', $url)
		);

		

		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_search'] = $this->language->get('text_search');
		$data['text_keyword'] = $this->language->get('text_keyword');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_sub_category'] = $this->language->get('text_sub_category');
		$data['text_quantity'] = $this->language->get('text_quantity');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_model'] = $this->language->get('text_model');
		$data['text_price'] = $this->language->get('text_price');
		$data['text_tax'] = $this->language->get('text_tax');
		$data['text_points'] = $this->language->get('text_points');
		$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$data['text_sort'] = $this->language->get('text_sort');
		$data['text_limit'] = $this->language->get('text_limit');

		$data['entry_search'] = $this->language->get('entry_search');
		$data['entry_description'] = $this->language->get('entry_description');

		$data['button_search'] = $this->language->get('button_search');
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['button_list'] = $this->language->get('button_list');
		$data['button_grid'] = $this->language->get('button_grid');

		$data['compare'] = $this->url->link('product/compare');


		$this->load->model('catalog/category');

		
		
		
		$cat_view1="active";
        $cat_view2="";
        $cat_view_class="tab-block2";
        if(isset($_COOKIE["cat_view"])){
            if($_COOKIE["cat_view"]=="view2"){
                $cat_view1="";                
                $cat_view2="active";
                $cat_view_class="";
            }
        }
        $data["cat_view1"]=$cat_view1;
        $data["cat_view2"]=$cat_view2;
		$data["cat_view_class"]=$cat_view_class;
		
		// 3 Level Category Search
		$data['categories'] = array();

		$categories_1 = $this->model_catalog_category->getCategories(0);

		foreach ($categories_1 as $category_1) {
			$level_2_data = array();

			$categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);

			foreach ($categories_2 as $category_2) {
				$level_3_data = array();

				$categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);

				foreach ($categories_3 as $category_3) {
					$level_3_data[] = array(
						'category_id' => $category_3['category_id'],
						'name'        => $category_3['name'],
					);
				}

				$level_2_data[] = array(
					'category_id' => $category_2['category_id'],
					'name'        => $category_2['name'],
					'children'    => $level_3_data
				);
			}

			$data['categories'][] = array(
				'category_id' => $category_1['category_id'],
				'name'        => $category_1['name'],
				'children'    => $level_2_data
			);
		}

	
		//print_r($products_search);
		


		$data['products'] = array();
		$data['products_popular']=[];
		$this->load->model('catalog/search');
		//echo "ok1";
		$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->request->get['search']);
		$data['heading_title'] = $this->language->get('heading_title');
		if (isset($this->request->get['search'])) {
			//echo "ok2";
			$page_str="";
			if (isset($this->request->get['page'])) {
				$page_str="&page=".($this->request->get['page']-1);
			}
			
			//if(trim($this->request->get['text'])){
			//	$url_search="https://catalogapi.site.yandex.net/v1.0?apikey=876ae57f-736c-456f-b961-7cae3d9d8942&text=".urlencode($this->request->get['text'])."&searchid=2367774&per_page=9".$page_str;
			//	$products_search=file_get_contents($url_search);
			//	$products_search_arr=json_decode($products_search,TRUE);
			//	//print_r($products_search_arr);
			//}
			
			//$products_search_arr=$products_search

			
			$query=$_GET["search"];

			$query=str_replace(["«","»"],"",$query);
			$query=str_replace([",","-",":","(",")","/","!"]," ",$query);
			$query = preg_replace('/\s/', ' ', $query);
			$query_arr=explode(" ",$query);
			
			$query_rez=[];
			foreach($query_arr as $itm){
				if(mb_strlen($itm)>1){
					$query_rez[]=$itm;
				}
			}
			$search_results=$this->model_catalog_search->searchBase($query_rez,0);

			//$product_total=0;
			//if(isset($products_search_arr["documents"])){

			//print_r($search_results);
			$product_total=0;

			if(count($search_results)){
				$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->request->get['search']);
				$data['heading_title'] = $this->language->get('heading_title');
				$per_page=$limit;
				
				if (isset($this->request->get['page'])) {
					$pg=($this->request->get['page'])-1;
				}else{
					$pg=0;
				}
				

				$product_ids=[];
				foreach($search_results as $itm){
					$product_ids[]=$itm["product_id"];
				}
				$product_total=count($search_results);
				$filter_data['product_ids']=implode(",",$product_ids);
				$filter_data['sort']="ids";
				$filter_data['order']="ids";

				$filter_data['limit']=$per_page;
				$filter_data['start']=$pg*$per_page;
				$productsHelper = new ProductListHelper($this->registry);
				
				$results = $productsHelper->getProducts($filter_data);

				$data['products'] = $results;
				
			}else{
				
				$this->document->setTitle($this->language->get('heading_title_nofound') .  ' - ' . $this->request->get['search']);
				
				$data['heading_title'] = $this->language->get('heading_title_nofound');
			
				$products_popular=$this->model_catalog_product->getProductsPopular(4);
				
				foreach ($products_popular as $product_popular_id) {
					$result=$this->model_catalog_product->getProduct($product_popular_id);
					if ($result['image']) {
						//$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
						$image = $this->model_tool_image->myResize($result['image'], 200,200,1);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
					}
	
					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price_val=$this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax'));
						//$price = $this->currency->format($price_val, );
						$price = number_format($price_val,0,".", " ");
	
		
					} else {
						$price = false;
						$price_val=0;
					}
	
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}
	
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}
	
					if ($this->config->get('config_review_status')) {
						$rating = round($result['rating'],1);
					} else {
						$rating = false;
					}
					$discount=0;
					
					//if($result['price_wholesaleold']*1){
					//	$discount = (int)(($result['price_wholesale']/$result['price_wholesaleold']-1)*100);
					//}
					
					$discount = $result['discount_percent'];
	
					$data['products_popular'][] = array(
						'product_id'  => $result['product_id'],
						'thumb'       => $image,
						'name'        => $result['name'],
						'meta_h1'     => $result['meta_h1'],
						'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'price_val'	  => $price_val,
						'special'     => $special,
						'tax'         => $tax,
						'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id']),
						'discount'	  => $discount
					);
				}
			}
			$url = '';
			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}
			
			$searchUrl = $this->url->link('product/search', $url);


			if($limit!=9){
                $url.='&limit='.$limit;
			}
			
			$paginationBaseUrl = $this->url->link('product/search', $url);
			
			
			$data['showby_9']='';
			$data['showby_18']='';
			$data['showby_all']='';
			
			if($limit==9){
				$data['showby_9']='active';
				$data['showby_9_link']='';	
			}else{
				$data['showby_9_link']=$searchUrl;
			}
			if($limit==18){
				$data['showby_18']='active';
				$data['showby_18_link']='';
			}else{
				$data['showby_18_link']=$searchUrl."&limit=18";
			}
			if($limit==999999){
				$data['showby_all']='active';
				$data['showby_all_link']='';
			}else{
				$data['showby_all_link']=$searchUrl."&limit=all";
			}

            $lazyLoadBaseUrl = $this->url->link('product/search/showmore', $url);
            $paginationModel = PaginationHelper::getPaginationModel($product_total, (int)$limit, (int)$page);
            $data['pagination'] = PaginationHelper::render($this->registry, $paginationBaseUrl, $paginationModel);
			$data['paginationLazy'] = PaginationHelper::renderLazy($this->registry, $lazyLoadBaseUrl, $paginationModel);
			
			if ($page == 1) {
			    $this->document->addLink($this->url->link('product/search', '', true), 'canonical');
			} elseif ($page == 2) {
			    $this->document->addLink($this->url->link('product/search', '', true), 'prev');
			} else {
			    $this->document->addLink($this->url->link('product/search', $url . '&page='. ($page - 1), true), 'prev');
			}

			if (isset($this->request->get['search']) && $this->config->get('config_customer_search')) {
				$this->load->model('account/search');

				if ($this->customer->isLogged()) {
					$customer_id = $this->customer->getId();
				} else {
					$customer_id = 0;
				}

				if (isset($this->request->server['REMOTE_ADDR'])) {
					$ip = $this->request->server['REMOTE_ADDR'];
				} else {
					$ip = '';
				}

				$search_data = array(
					'keyword'       => $search,
					'category_id'   => $category_id,
					'sub_category'  => $sub_category,
					'description'   => $description,
					'products'      => $product_total,
					'customer_id'   => $customer_id,
					'ip'            => $ip
				);

				$this->model_account_search->addSearch($search_data);
			}
			
		}

		$data['search'] = $search;
		$data['description'] = $description;
		$data['category_id'] = $category_id;
		$data['sub_category'] = $sub_category;

		$data['sort'] = $sort;
		$data['order'] = $order;
		$data['limit'] = $limit;

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		$this->response->setOutput($this->load->view('product/search', $data));
		
    }

    private function getFilter($category_id, &$limit, &$page = 1)
    {
        if (isset($this->request->get['search'])) {
			$search = $this->request->get['search'];
		} else {
			$search = '';
		}

		if (isset($this->request->get['tag'])) {
			$tag = $this->request->get['tag'];
		} elseif (isset($this->request->get['search'])) {
			$tag = $this->request->get['search'];
		} else {
			$tag = '';
		}

		if (isset($this->request->get['description'])) {
			$description = $this->request->get['description'];
		} else {
			$description = '';
        }

        if (isset($this->request->get['sub_category'])) {
			$sub_category = $this->request->get['sub_category'];
		} else {
			$sub_category = '';
		}

        if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}
        
        $filter_data = array(
            'filter_name'         => $search,
            'filter_tag'          => $tag,
            'filter_description'  => $description,
            'filter_category_id'  => $category_id,
            'filter_sub_category' => $sub_category,
            'sort'                => $sort,
            'order'               => $order,
            'start'               => ($page - 1) * $limit,
            'limit'               => $limit
        );

        return $filter_data;
    }

    public function showmore()
    {
        $this->load->model('catalog/product');
        if (isset($this->request->get['category_id'])) {
			$category_id = $this->request->get['category_id'];
		} else {
			$category_id = 0;
		}

        $filter_data = $this->getFilter($category_id, $limit, $page);
        $products_total = $this->model_catalog_product->getTotalProducts($filter_data);
        $productsHelper = new ProductListHelper($this->registry);
        $products = $productsHelper->getProducts($filter_data);

        $url = '';

        if (isset($this->request->get['search'])) {
            $url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
        }

        if (isset($this->request->get['tag'])) {
            $url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
        }

        if (isset($this->request->get['description'])) {
            $url .= '&description=' . $this->request->get['description'];
        }

        if (isset($this->request->get['category_id'])) {
            $url .= '&category_id=' . $this->request->get['category_id'];
        }

        if (isset($this->request->get['sub_category'])) {
            $url .= '&sub_category=' . $this->request->get['sub_category'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $paginationBaseUrl = $this->url->link('product/search', $url);
        $lazyLoadBaseUrl = $this->url->link('product/search/showmore', $url);

        $items = [];
        foreach( $products as $p ){
            $items[] = $this->load->view("partial/product_item", ['p'=>$p]);
        }

        $lazyLoadResponse = PaginationHelper::getLazyLoadResponse($this->registry, [
            'items' => $items, 
            'total' => (int)$products_total,
            'itemsPerPage' => (int)$limit,
            'page' => (int)$page,
            'paginationBaseUrl' => $paginationBaseUrl,
            'lazyLoadBaseUrl' => $lazyLoadBaseUrl,
        ]); 

        $this->response->setOutput($lazyLoadResponse);
    }
}