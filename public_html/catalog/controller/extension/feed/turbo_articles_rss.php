<?php class ControllerExtensionFeedTurboArticlesRSS extends Controller {
	private $from_charset = 'utf-8';
	public function index() {
		
			$this->load->model('extension/feed/turbo_articles_rss');
			
			$articles=$this->model_extension_feed_turbo_articles_rss->getArticles();
			
						$items='';
			foreach($articles as $article){
				$url=$this->url->link('newsblog/article', 'newsblog_path=&newsblog_article_id=' . $article['article_id']);
				
				//$text = iconv('windows-1251//IGNORE', 'UTF-8//IGNORE', $article['description']);
				//$text=$article['description'];

				//$text = mb_convert_encoding($article['description'], 'utf-8', 'windows-1251');

				$text=htmlspecialchars_decode($article['description']);
				

				$items.='<item turbo="true">
				<title>'.$article['name'].'</title>
				<link>'.$url.'</link>
				<turbo:content>
					<![CDATA[
					<header>
						<h1>'.($article['meta_h1']?$article['meta_h1']:$article['name']).'</h1>
						<figure>
						<img src="https://ant-snab.ru/'.$article['image'].'">
						</figure>
					</header>
					'.$text.'
						
						]]>
					</turbo:content>
				</item>';
			}
			
			$text = str_replace("../", "/", $items);
			$output = '<?xml version="1.0" encoding="utf-8"?>
			<rss xmlns:yandex="http://news.yandex.ru" xmlns:media="http://search.yahoo.com/mrss/" 
			xmlns:turbo="http://turbo.yandex.ru" version="2.0">
				<channel>
					<title>Ант-Снаб</title>
					<link>https://ant-snab.ru</link>
					<description/>
					<language>ru</language>
					'.$items.'
				</channel>
			</rss>';


			$this->response->addHeader('Content-Type: application/rss+xml;charset=utf-8');
			$this->response->setOutput($output);
		
	}

	
}