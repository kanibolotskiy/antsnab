<?php
class ControllerInformationInformation extends Controller {
	public function index() {
		$this->load->language('information/information');

		$this->load->model('catalog/information');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}
		/*
		if($information_id==6){
			//яндекс карты во всплывающем модале
			$this->document->addScript('https://api-maps.yandex.ru/2.0/?lang=ru_RU&load=package.standard','header');
			$data['locations'] = array();

			$this->load->model('localisation/location');
			$this->load->model('file/file');
			

			//$registry->get('load')->model('localisation/location');
			//$registry->get('load')->model('file/file');
			
			foreach ((array)$this->config->config_location as $location_id) {
				$location_info = $this->model_localisation_location->getLocation($location_id);

				if ($location_info) {
					if ($location_info['image']) {
						$image = $this->model_tool_image->resize($location_info['image'], $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
					} else {
						$image = false;
					}

					$location_files=[];
					$files_data = $registry->get('model_file_file')->getLocationFiles($location_id);
					foreach ($files_data as $file) {
						$file_link = HTTP_SERVER . 'files/' . $file['filename']; 
						if($file_link){
							$location_files[] = array(
								'name' 	    => $file['name'],
								'file_link' => $file_link
							);
						}
					}
					$data['locations'][] = array(
						'location_id' => $location_info['location_id'],
						'name'        => $location_info['name'],
						'address'     => nl2br($location_info['address']),
						'geocode'     => $location_info['geocode'],
						'telephone'   => $location_info['telephone'],
						'fax'         => $location_info['fax'],
						'image'       => $image,
						'open'        => nl2br($location_info['open']),
						'comment'     => $location_info['comment'],
						'map'         => html_entity_decode($location_info['map']),
						'files'       => $location_files
					);
				}
			}

			foreach ($data['locations'] as &$location) {
				$geocode = str_replace(' ', '', $location['geocode']);
				$parts = explode(',', $geocode);
				if (count($parts) >=2) {
					$location['latitude'] = $parts[0];
					$location['longitude'] = $parts[1];
				} else {
					$location['latitude'] = '';
					$location['longitude'] = '';
				}
			}
			
		}
	*/
		$information_info = $this->model_catalog_information->getInformation($information_id);
		if (($information_info) and ($information_id!=15) and ($information_id!=17))  {

			if ($information_info['meta_title']) {
				$this->document->setTitle($information_info['meta_title']);
			} else {
				$this->document->setTitle($information_info['title']);
			}

			$this->document->setDescription($information_info['meta_description']);
			$this->document->setKeywords($information_info['meta_keyword']);
			
			if($information_info['noindex']){
				$this->document->setNoindex('<meta name="robots" content="noindex">');
			}
			
			
			$data['breadcrumbs'][] = array(
				'text' => $information_info['title'],
				'href' => $this->url->link('information/information', 'information_id=' .  $information_id)
			);

			if ($information_info['meta_h1']) {
				$data['heading_title'] = $information_info['meta_h1'];
			} else {
				$data['heading_title'] = $information_info['title'];
			}

			$this->load->model('file/file');
			$files_data = $this->model_file_file->getInformationFiles($information_id);			
			
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
			if($information_id==4){
				$data['feedbackform']=true;
			}else{
				$data['feedbackform']=false;
			}
			$data_description=html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');
			if($information_id==6){
				/**Таблицы со стоимостью доставки */
				$data_table = $this->model_catalog_information->getCouriers();
				foreach($data_table as $itm){
					if(is_numeric($itm["price"])){
						$price_str=number_format($itm["price"]*1,0,"."," ").'&nbsp;<div class="rur">i</div>';
					}else{
						$price_str=$itm["price"];
					}
					if(is_numeric($itm["price_urgent"])){
						$price_urgent_str=number_format ($itm["price_urgent"]*1,0,"."," ").'&nbsp;<div class="rur">i</div>';
					}else{
						$price_urgent_str=$itm["price_urgent"];
					}
					$data_table1["data_table"][]=Array(
						"weight"=>$itm["weight_str"],
						"price"=>$price_str,
					);
					$data_table2["data_table"][]=Array(
						"weight"=>$itm["weight_str"],
						"price"=>$price_urgent_str,
					);
				}
				$data_table1_str=$this->load->view('partial/price_table', $data_table1);
				$data_table2_str=$this->load->view('partial/price_table', $data_table2);
				$data_description=str_replace("[+price_table1]",$data_table1_str,$data_description);
				$data_description=str_replace("[+price_table2]",$data_table2_str,$data_description);
				
				/**Карта */
				//яндекс карты во всплывающем модале
				//$this->document->addScript('https://api-maps.yandex.ru/2.0/?lang=ru_RU&load=package.standard','header');

				$data['locations'] = array();
		
				$this->load->model('localisation/location');
				$this->load->model('file/file');
				
				//foreach ((array)$this->config->config_location as $location_id) {
					$location_id=1;
					$location_info = $this->model_localisation_location->getLocation($location_id);
		
					if ($location_info) {
						if ($location_info['image']) {
							$image = $this->model_tool_image->resize($location_info['image'], $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
						} else {
							$image = false;
						}
		
						$location_files=[];
						$files_data = $this->model_file_file->getLocationFiles($location_id);
						foreach ($files_data as $file) {
							$file_link = HTTP_SERVER . 'files/' . $file['filename']; 
							if($file_link){
								$location_files[] = array(
									'name' 	    => $file['name'],
									'file_link' => $file_link
								);
							}
						}
						//echo "ok";
						$data['locations'][] = array(
							'location_id' => $location_info['location_id'],
							'name'        => $location_info['name'],
							'address'     => nl2br($location_info['address']),
							'geocode'     => $location_info['geocode'],
							'telephone'   => $location_info['telephone'],
							'fax'         => $location_info['fax'],
							'image'       => $image,
							'open'        => nl2br($location_info['open']),
							'comment'     => $location_info['comment'],
							'map'         => html_entity_decode($location_info['map']),
							'files'       => $location_files
						);
					}
				//}
				/*
				foreach ($data['locations'] as &$location) {
					$geocode = str_replace(' ', '', $location['geocode']);
					$parts = explode(',', $geocode);
					if (count($parts) >=2) {
						$location['latitude'] = $parts[0];
						$location['longitude'] = $parts[1];
					} else {
						$location['latitude'] = '';
						$location['longitude'] = '';
					}
				}
				*/
			}

			$data['description'] = $data_description;

			$data['files']=$information_files;
			
			$data['button_continue'] = $this->language->get('button_continue');

			

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('information/information', $data));
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('information/information', 'information_id=' . $information_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function agree() {
		$this->load->model('catalog/information');

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$output = '';

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
		}

		$this->response->setOutput($output);
	}
}