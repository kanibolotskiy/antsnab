<?php
class ModelCatalogInformation extends Model {
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
			$a = preg_replace("%(href=\S(?!$site_url))%i", 'rel="nofollow" $1', $a);
		} elseif (preg_match("%href=\S(?!$site_url)%i", $a)){
			$a = preg_replace('/rel=S(?!nofollow)\S*/i', 'rel="nofollow"', $a);
		}
		return $a;
	}
	public function cleanText($text){
		$text=html_entity_decode($text, ENT_QUOTES, 'UTF-8');
		/*
		$text_arr=explode("<a",$text);
		for($i=0;$i<count($text_arr);$i++){

		}
		*/
		//$html = preg_replace('/(alt=")(.*?)(")/i', '$1'.$post_title.'$3', $text);
		//$html = str_replace('/>', 'title="'.$post_title.'" />', $html);

		$text = preg_replace_callback('/<a[^>]+/', array($this, 'cleanInternalUrl'), $text);
		
		$text=str_replace("₽","<div class='rur'>i</div>",$text);
		$text=str_replace('<b ','<span class="textBold"',$text);
		$text=str_replace('<b>','<span class="textBold">',$text);
		$text=str_replace('<strong','<span class="textBold"',$text);
		$text=str_replace('</b>','</span>',$text);
		$text=str_replace('</strong>','</span>',$text);
		return $text;
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
}