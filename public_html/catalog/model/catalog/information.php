<?php
class ModelCatalogInformation extends Model {
	public function getBanner($banner_id){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner_image WHERE banner_id='".$banner_id."' order by sort_order ASC");
		return $query->rows;
	}
	private function cleanInternalUrl($matches){
		$a = $matches[0];
		//echo "!".$this->data['base']."!";

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$site_url = $this->config->get('config_ssl');
		} else {
			$site_url = $this->config->get('config_url');
		}

		//$site_url = $base;
	
		if (strpos($a, 'rel') === false){
			$a = preg_replace("%(href=\S(?!$site_url))%i", 'rel="nofollow noopener" target="_blank" $1', $a);
		} elseif (preg_match("%href=\S(?!$site_url)%i", $a)){
			$a = preg_replace('/rel=S(?!nofollow)\S*/i', 'rel="nofollow noopener" target="_blank"', $a);
		}
		return $a;
	}
	public function makeWebP($file_f){
		$out=false;
		if(is_file($file_f)){
			$info_f = pathinfo($file_f);
			$ext_f=$info_f['extension'];
			if($ext_f=='jpg' or $ext_f=='png'){
				$new = $info_f['dirname'] . '/' . $info_f['filename'] . '.' . 'webp';
				if(!is_file($new)){
					if($ext_f=='jpg'){
						$img = imageCreateFromJpeg($file_f);
					}
					if($ext_f=='png'){
						$img = imageCreateFromPng($file_f);
					}
					imageWebp($img, $new, 100);
					if (filesize($new) % 2 == 1) {
						file_put_contents($new, "\0", FILE_APPEND);
					}
					imagedestroy($img);
					$out=$new;
				}
				$out=$new;
			}
		}
		return $out;
	}
	public function cleanText($text){
		$arr_site_replace=Array(
			"http://ant-snab.ru/","https://www.ant-snab.ru/","http://www.ant-snab.ru/",
			"http://ant-snab.ru","https://www.ant-snab.ru","http://www.ant-snab.ru",
		);
		
		
		$text=str_replace($arr_site_replace,"https://ant-snab.ru/", $text);
		
		

		$text = html_entity_decode($text, ENT_QUOTES, 'UTF-8');
		if($text){
			$dom = new DOMDocument();
			$dom->loadHTML(mb_convert_encoding($text, 'HTML-ENTITIES', 'UTF-8'));
			foreach( $dom->getElementsByTagName("img") as $pnode ) {
				$src_img=$pnode->getAttribute('src');
				$src_img=str_replace ("../","", $src_img);
				$src_img=str_replace ("https://ant-snab.ru/","", $src_img);
				$webp_file=$this->makeWebP($src_img);
				if($webp_file){
					$new_div_clone = $pnode->cloneNode();
					$nodeDiv_jpeg = $dom->createElement("source", "");
					$nodeDiv_jpeg->setAttribute("type","image/jpeg");
					$nodeDiv_jpeg->setAttribute("srcset",$src_img);
					
					$nodeDiv_webp = $dom->createElement("source", "");
					$nodeDiv_webp->setAttribute("type","image/webp");
					if($webp_file){
						$nodeDiv_webp->setAttribute("srcset",$webp_file);
					}

					$nodeDiv = $dom->createElement("picture", "");
					$nodeDiv->appendChild($nodeDiv_jpeg);
					$nodeDiv->appendChild($nodeDiv_webp);
					$nodeDiv->appendChild($new_div_clone);
					$pnode->parentNode->replaceChild($nodeDiv, $pnode);
				}
			}
			
			$xpath = new DOMXPath($dom);
			$body = $xpath->query('/html/body');
			$text = $dom->saveXml($body->item(0));
			
			$text=str_replace("&#13;","", $text);
		}
		/*
		<picture>
			<source type="image/webp" srcset="http://antsnab.cp06038.tmweb.ru/image/cache/no_image-400x4002.webp">
			<source type="image/jpeg" srcset="http://antsnab.cp06038.tmweb.ru/image/cache/no_image-400x4002.png">
			<img class="wrp_fly_image" itemprop="image" src="http://antsnab.cp06038.tmweb.ru/image/cache/no_image-400x4002.png" alt="Мастика МБР-Х-65" title="Мастика МБР-Х-65">
		</picture>
		*/
		$text=str_replace(['<body>','</body>','<html>','</html>'],'',$text);

		$text = preg_replace('/title="([^"]+)"/i', '', $text);
		$text = preg_replace('/alt="([^"]+)"/i', 'alt="$1" title="$1"', $text);
		
		
		$text = preg_replace_callback('/<a[^>]+/', array($this, 'cleanInternalUrl'), $text);
		
		///$text=str_replace("₽","<div class='rur'>i</div>",$text);
		$text=str_replace('<b ','<span class="textBold"',$text);
		$text=str_replace('<b>','<span class="textBold">',$text);
		$text=str_replace('<strong','<span class="textBold"',$text);
		$text=str_replace('</b>','</span>',$text);
		$text=str_replace('</strong>','</span>',$text);
		return $text;
	}
	public function getInformationMain() {
		
		$query = $this->db->query("SELECT DISTINCT * FROM dopinfo_main where doc_id = '1'");
		return $query->row;
	}
	public function getInformation($information_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE i.information_id = '" . (int)$information_id . "' AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1'");

		return $query->row;
	}

	public function getInformations() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' ORDER BY i.sort_order, LCASE(id.title) ASC");
		return $query->rows;
	}

	public function getInformationLayoutId($information_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");

		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return 0;
		}
	}
	public function minmaxPrice(){
		$query = $this->db->query("SELECT min(price) as min_price, max(price) as max_price FROM " . DB_PREFIX . "product WHERE price>0");
		if ($query->num_rows) {
			return round($query->row['min_price'],0).'rub-'.round($query->row['max_price'],0).'rub';
		}else{
			return 0;
		}
	}
	public function getCouriers(){
		$query = $this->db->query("SELECT * FROM dopinfo_couriers order by sort_order");

		return $query->rows;
	}
}