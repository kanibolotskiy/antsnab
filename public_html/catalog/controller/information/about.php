<?php
class ControllerInformationAbout extends Controller {
	private $error = array();

	public function index() {

		//http://antsnab.cp06038.tmweb.ru/image/cache/catalog/svg/cust1-400x4601.jpg
		//$file='hnbrnocz.jpg';

		$file='image/catalog/jpeg_test.jpg';
		$image=  imagecreatefromjpeg($file);
		ob_start();
		imagejpeg($image,NULL,100);
		$cont=  ob_get_contents();
		ob_end_clean();
		imagedestroy($image);
		$content =  imagecreatefromstring($cont);
		imagewebp($content,'image/catalog/jpeg_test.webp');
		imagedestroy($content);


		$this->load->language('information/about');
		$this->load->model('catalog/about');

		$getAboutInfo=$this->model_catalog_about->getAboutInfo();

		$this->document->setTitle($getAboutInfo['meta_title']);
		$this->document->setDescription($getAboutInfo['meta_description']);
		$this->document->setKeywords($getAboutInfo['meta_keywords']);


		//title	content	meta_title	meta_h1	meta_description	meta_keywords	link_caption	link
		$data['heading_title']=$getAboutInfo['meta_h1'];
		$data['meta_title']=$getAboutInfo['meta_title'];
		$data['description']=html_entity_decode($getAboutInfo['content'], ENT_QUOTES, 'UTF-8');

		$data['content_cust']=html_entity_decode($getAboutInfo['content_cust'], ENT_QUOTES, 'UTF-8');
		$data['content_man']=html_entity_decode($getAboutInfo['content_man'], ENT_QUOTES, 'UTF-8');
		$data['content_off']=html_entity_decode($getAboutInfo['content_off'], ENT_QUOTES, 'UTF-8');
		$data['content_sklad']=html_entity_decode($getAboutInfo['content_sklad'], ENT_QUOTES, 'UTF-8');
		$data['content_req']=html_entity_decode($getAboutInfo['content_req'], ENT_QUOTES, 'UTF-8');
		$data['feedbackform']=true;
		

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $getAboutInfo['title'],
			'href' => $this->url->link('information/about')
		);

		//$data['heading_title'] = $this->language->get('heading_title');

		$data['text_location'] = $this->language->get('text_location');
		$data['text_store'] = $this->language->get('text_store');
		$data['text_address'] = $this->language->get('text_address');
		$data['text_telephone'] = $this->language->get('text_telephone');
		$data['text_fax'] = $this->language->get('text_fax');
		$data['text_open'] = $this->language->get('text_open');
		$data['text_comment'] = $this->language->get('text_comment');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_enquiry'] = $this->language->get('entry_enquiry');

		$data['button_map'] = $this->language->get('button_map');

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['enquiry'])) {
			$data['error_enquiry'] = $this->error['enquiry'];
		} else {
			$data['error_enquiry'] = '';
		}

		$data['button_submit'] = $this->language->get('button_submit');

		$this->load->model('tool/image');

		if ($this->config->get('config_image')) {
			$data['image'] = $this->model_tool_image->resize($this->config->get('config_image'), $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
		} else {
			$data['image'] = false;
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');


		$data['about_block']=$this->model_catalog_about->getAboutBlock();
		$customers_data=$this->model_catalog_about->getAboutCustomers();

		$this->load->model('module/referrer');
		$contact_data_referrer=$this->model_module_referrer->getContactsReferrer();

		foreach($customers_data as $customer){
			$cust=$customer;
			if($customer['phone']){
				$phone = $customer['phone'];
			}else{
				if(isset($contact_data_referrer['phone'])){
					$phone = $contact_data_referrer['phone'];
				}else{
					$phone = $this->config->get('config_telephone');
				}
				
			}
			if($customer['email']){
				$email = $customer['email'];
			}else{
				if(isset($contact_data_referrer['email'])){
					$email = $contact_data_referrer['email'];
				}else{
					$email = $this->config->get('config_email_site');
				}
			}
			$cust['phone'] = $phone;
			$cust['email'] = $email;
			$cust['thumb'] = $this->model_tool_image->myResize($customer['image'], 400,460,1);
			$data['customers'][]=$cust;
		}
		
		$off_data=$this->model_catalog_about->getAboutOff();
		$off=[];
		foreach($off_data as $off_row){
			if($off_row['video']){
				preg_match("#(?<=v=)[a-zA-Z0-9-]+(?=&)|(?<=v\/)[^&\n]+(?=\?)|(?<=v=)[^&\n]+|(?<=youtu.be/)[^&\n]+#", $off_row['video'], $matches);
				if(isset($matches[0])){
					$video_id=$matches[0];
				}else{
					$video_id="";
				}
				if($off_row['image']){
					$img=$this->model_tool_image->myResize($off_row['image'], 400,400,1);
				}else{
					$img='//img.youtube.com/vi/'.$video_id.'/maxresdefault.jpg';
				}
				$off[]=Array(
					'caption'=>$off_row['caption'],
					'video'=>'1',
					'thumb'=>$img,
					'url'=>$off_row['video']
				);
				
			}else{
				$off[]=Array(
					'caption'=>$off_row['caption'],
					'video'=>'0',
					'thumb'=>$this->model_tool_image->myResize($off_row['image'], 400,400,1),
					'url'=>"image/".$off_row['image']
				);
			}
			
		}
		$data['off']=$off;



		$man_data=$this->model_catalog_about->getAboutMan();
		$man=[];
		foreach($man_data as $man_row){
			if($man_row['video']){
				preg_match("#(?<=v=)[a-zA-Z0-9-]+(?=&)|(?<=v\/)[^&\n]+(?=\?)|(?<=v=)[^&\n]+|(?<=youtu.be/)[^&\n]+#", $man_row['video'], $matches);
				if(isset($matches[0])){
					$video_id=$matches[0];
				}else{
					$video_id="";
				}
				if($man_row['image']){
					$img=$this->model_tool_image->myResize($man_row['image'], 400,400,1);
				}else{
					$img='//img.youtube.com/vi/'.$video_id.'/maxresdefault.jpg';
				}
				$man[]=Array(
					'caption'=>$man_row['caption'],
					'video'=>'1',
					'thumb'=>$img,
					'url'=>$man_row['video']
				);
				
			}else{
				$man[]=Array(
					'caption'=>$man_row['caption'],
					'video'=>'0',
					'thumb'=>$this->model_tool_image->myResize($man_row['image'], 400,400,1),
					'url'=>"image/".$man_row['image']
				);
			}
			
		}
		$data['man']=$man;

		
		$sklad_data=$this->model_catalog_about->getAboutSklad();
		$sklad=[];
		foreach($sklad_data as $sklad_row){
			if($sklad_row['video']){
				preg_match("#(?<=v=)[a-zA-Z0-9-]+(?=&)|(?<=v\/)[^&\n]+(?=\?)|(?<=v=)[^&\n]+|(?<=youtu.be/)[^&\n]+#", $sklad_row['video'], $matches);
				if(isset($matches[0])){
					$video_id=$matches[0];
				}else{
					$video_id="";
				}
				if($sklad_row['image']){
					$img=$this->model_tool_image->myResize($sklad_row['image'], 400,400,1);
				}else{
					$img='//img.youtube.com/vi/'.$video_id.'/maxresdefault.jpg';
				}
				$sklad[]=Array(
					'caption'=>$sklad_row['caption'],
					'video'=>'1',
					'thumb'=>$img,
					'url'=>$sklad_row['video']
				);
				
			}else{
				$sklad[]=Array(
					'caption'=>$sklad_row['caption'],
					'video'=>'0',
					'thumb'=>$this->model_tool_image->myResize($sklad_row['image'], 400,400,1),
					'url'=>"image/".$sklad_row['image']
				);
			}
			
		}
		$data['sklad']=$sklad;

		$sert_data=$this->model_catalog_about->getAboutSert();
		$sert=[];
		foreach($sert_data as $sert_row){	
			$sert[]=Array(
				'caption'=>$sert_row['caption'],
				'image'=>"image/".$sert_row['image']
			);
		}
		$data['sert']=$sert;


		$this->load->model('file/file');
		$files_data = $this->model_file_file->getAboutFiles(1);			
		
		$information_files=[];
		foreach ($files_data as $file) {
			$file_link = HTTP_SERVER . 'files/' . $file['filename']; 
			if($file_link){
				$information_files[] = array(
					'name' 	    => $file['name'],
					'file_link' => $file_link
				);
			}
		}
		$data['files']=$information_files;
		
		$this->response->setOutput($this->load->view('information/about', $data));
	}

}

/*
if($product_info['video']){
				preg_match("#(?<=v=)[a-zA-Z0-9-]+(?=&)|(?<=v\/)[^&\n]+(?=\?)|(?<=v=)[^&\n]+|(?<=youtu.be/)[^&\n]+#", $product_info['video'], $matches);
				if(isset($matches[0])){
					$video_id=$matches[0];
					
					$data['video_link'] = $product_info['video'];
					
					//$data['video_img']='//img.youtube.com/vi/'.$video_id.'/sddefault.jpg';
					if($product_info['altvideo']){
						$data['video_img']='//img.youtube.com/vi/'.$video_id.'/sddefault.jpg';
					}else{
						$data['video_img']='//img.youtube.com/vi/'.$video_id.'/maxresdefault.jpg';
					}
				}
			}
			 */