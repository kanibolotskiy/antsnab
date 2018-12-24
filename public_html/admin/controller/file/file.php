<?php
///3274///
class ControllerFileFile extends Controller {
	public function index() {
		$this->load->model('file/file');
		
		$this->model_file_file->checkDBTables();		
		
		$this->load->language('catalog/file');
		$data['tab_file'] = $this->language->get('tab_file');
		$data['entry_file'] = $this->language->get('entry_file');
		$data['entry_file_image'] = $this->language->get('entry_file_image');
		$data['entry_file_name'] = $this->language->get('entry_file_name');
		$data['entry_file_title'] = $this->language->get('entry_file_title');
		$data['button_upload_file'] = $this->language->get('button_upload_file');
		$data['button_add_file'] = $this->language->get('button_add_file');
		$data['error_file_exists'] = $this->language->get('error_file_exists');
			
		$this->load->language('catalog/product');	
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_customer_group'] = $this->language->get('entry_customer_group');			
		$data['button_remove'] = $this->language->get('button_remove');
    	$data['text_enabled'] = $this->language->get('text_enabled');
    	$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_image_manager'] = $this->language->get('text_image_manager');
		$data['text_browse'] = $this->language->get('text_browse');
		$data['text_clear'] = $this->language->get('text_clear');
		
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();		

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		
		$data['token'] = $this->session->data['token'];
		
		if (isset($this->request->post['product_file'])) {
			$product_files = $this->request->post['product_file'];
		} elseif (isset($this->request->get['product_id'])) {
			$product_files = $this->model_file_file->getProductFiles($this->request->get['product_id']);
		} else {
			$product_files = array();
		}
	
		$data['product_files'] = array();
		
		foreach ($product_files as $product_file) {
			if ($product_file['image'] && file_exists(DIR_IMAGE . $product_file['image'])) {
				$image = $product_file['image'];
			} else {
				$image = 'no_image.jpg';
			}

			$data['product_files'][] = array(
				'file_id' => $product_file['file_id'],
				'file' => $product_file['file'],
				'image'      => $image,
				'file_delete'=> (file_exists(str_replace("system/storage/download", "files", str_replace("system/storage/download", "files", DIR_DOWNLOAD)) . $product_file['file']))?false:true,
				'thumb'      => $this->model_tool_image->resize($image, 100, 100),
				'sort_order' => $product_file['sort_order'],
				'status' => $product_file['status'],
				'page_id' => $product_file['page_id'],
				'page_type' => $product_file['page_type'],
				'description' => $product_file['file_description']			
			);
		}
		
		return $this->load->view('file/file', $data);	
		
	}
	
	public function transform($string){
        $arr = array( 
                       'А' => 'A' , 'Б' => 'B' , 'В' => 'V'  , 'Г' => 'G', 
                       'Д' => 'D' , 'Е' => 'E' , 'Ё' => 'JO' , 'Ж' => 'ZH', 
                       'З' => 'Z' , 'И' => 'I' , 'Й' => 'JJ' , 'К' => 'K', 
                       'Л' => 'L' , 'М' => 'M' , 'Н' => 'N'  , 'О' => 'O', 
                       'П' => 'P' , 'Р' => 'R' , 'С' => 'S'  , 'Т' => 'T', 
                       'У' => 'U' , 'Ф' => 'F' , 'Х' => 'KH' , 'Ц' => 'C', 
                       'Ч' => 'CH', 'Ш' => 'SH', 'Щ' => 'SHH', 'Ъ' => '"', 
                       'Ы' => 'Y' , 'Ь' => '', 'Э' => 'EH' , 'Ю' => 'JU', 
                       'Я' => 'JA', 
                       'а' => 'a' , 'б' => 'b'  , 'в' => 'v' , 'г' => 'g', 'д' => 'd', 
                       'е' => 'e' , 'ё' => 'jo' , 'ж' => 'zh', 'з' => 'z', 'и' => 'i', 
                       'й' => 'jj', 'к' => 'k'  , 'л' => 'l' , 'м' => 'm', 'н' => 'n', 
                       'о' => 'o' , 'п' => 'p'  , 'р' => 'r' , 'с' => 's', 'т' => 't', 
                       'у' => 'u' , 'ф' => 'f'  , 'х' => 'kh', 'ц' => 'c', 'ч' => 'ch', 
                       'ш' => 'sh', 'щ' => 'shh', 'ъ' => '"' , 'ы' => 'y', 'ь' => '_', 
                       'э' => 'eh', 'ю' => 'ju' , 'я' => 'ja', ' ' => '_'
                     ); 
		$key = array_keys($arr);
		$val = array_values($arr);
		$translate = str_replace($key, $val, $string);
		return $translate;
	}

	public function upload_file() {
		if($this->request->get['delete_old']){
			if(file_exists(str_replace("system/storage/download", "files", DIR_DOWNLOAD) . $this->request->get['delete_old'])) {			
				unlink(str_replace("system/storage/download", "files", DIR_DOWNLOAD) . $this->request->get['delete_old']);
			}
		}
		$json = array();
		if (!empty($this->request->files['file']['name'])){
			$filename = $this->transform($this->request->files['file']['name']);
			$filename_original = explode('.', $this->request->files['file']['name']);
			
			if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 1000)) {
				$json['error'] = $this->language->get('error_filename');
			}
			if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {
				$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
			}
		} else {
			$json['error'] = $this->language->get('error_upload');
		}

		if (!isset($json['error'])) {
			if(!file_exists(str_replace("system/storage/download", "files", DIR_DOWNLOAD) . $filename)) {	
				move_uploaded_file($this->request->files['file']['tmp_name'], str_replace("system/storage/download", "files", DIR_DOWNLOAD) . $filename);
				$json['file'] = $filename;
			}else{
				$filename_rand = rand(5, 15) . $filename;
				move_uploaded_file($this->request->files['file']['tmp_name'], str_replace("system/storage/download", "files", DIR_DOWNLOAD) . $filename_rand);
				$json['file'] = $filename_rand;
			}
			$json['name'] = $filename_original[0];
			$json['success'] = "File upload!"; 
		}

		$this->response->setOutput(json_encode($json));
	}
}
?>