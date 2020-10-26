<?php
class ControllerExtensionModuleNewsBlogArticles extends Controller {

	public function index($setting) {

		$this->load->language('module/newsblog_articles');

		$this->load->model('newsblog/article');

		if (isset($setting['module_description'][$this->config->get('config_language_id')])) {
			$data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
			$data['html'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');
		} else {
			$data['heading_title'] = false;
			$data['html'] = false;
		}

		$data['text_more'] = $this->language->get('text_more');

		$data['text_date_added'] = $this->language->get('text_date_added');

		$data['articles'] = array();

		$show_categories= $setting['show_categories'];
		$sort			= $setting['sort_by'];
		$order			= $setting['sort_direction'];
		$date_format	= $setting['date_format'];

		$filter_data = array(
					'filter_categories'  => $show_categories,
					'sort'               => $sort,
					'order'              => $order,
					'start'              => 0,
					'limit'              => $setting['limit']
		);
        //echo "!".print_r($show_categories)."!";
        $template='newsblog_articles.tpl';
        if ($setting['template']) $template=$setting['template'];

        if($template=='newsblog_articles.tpl'){
            $filter_data['sort']='rand()';
        }
		$data['link_to_category']=false;
		/** @task нихера не понятно как она формируется - переосмыслить */
		//if (count($show_categories)==1) $data['link_to_category']=$this->url->link('newsblog/category', 'newsblog_path=' . $show_categories[0]);
		if( $template == 'newsblog_articles.tpl' ) {
			$data['link_to_category']=$this->url->link('newsblog/category', 'newsblog_path=2');
		} else {
			$data['link_to_category']=$this->url->link('newsblog/category', 'newsblog_path=1');
		}

		$results = $this->model_newsblog_article->getArticles($filter_data);
		$this->load->model('tool/image');


		foreach ($results as $result) {
			if ($result['image']) {
				$original	= HTTP_SERVER.'image/'.$result['image'];
 				$thumb 		= $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
 			} else {
 				$original 	= false;
 				$thumb 		= false;
 			}

			$mainCategoryId =  $this->model_newsblog_article->getArticleMainCategoryId($result['article_id']);
			
			/** @task move to override */
			$preview = strip_tags(html_entity_decode($result['preview'], ENT_QUOTES, 'UTF-8'));
			if( empty($preview) ) {
				$preview = strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'));
			}
			$preview = mb_substr($preview, 0, $setting['desc_limit']) . '...';

			$image_webp=str_replace(".jpg",".webp",$thumb);
            $image_webp=str_replace(".png",".webp",$image_webp);

			$data['articles'][] = array(
				'article_id'  		=> $result['article_id'],
				'original' 			=> $original,
				'thumb' 			=> $thumb,
				'thumb_webp'		=> $image_webp,
				'name'        		=> $result['name'],
				'preview'  			=> $preview,
				'attributes'  		=> $result['attributes'],
				'href'         		=> $this->url->link('newsblog/article', 'newsblog_path=' . $mainCategoryId . '&newsblog_article_id=' . $result['article_id']),
				'date'   			=> ($date_format ? date($date_format, strtotime($result['date_available'])) : false),
				'date_modified'   	=> ($date_format ? date($date_format, strtotime($result['date_modified'])) : false),
				'viewed' 			=> sprintf($this->language->get('text_viewed'), $result['viewed']),
			);


		}



		return $this->load->view('extension/module/'.$template, $data);

	}
}
