<?php
namespace WS\Override\Controller\Site\Extension\Module;

use WS\Override\Controller\Admin\Extension\Module\ContactpageController as AdminModule;

/**
 * Модуль вывода контента страницы контактов
 *
 * @version    1.0, Apr 2, 2018  9:04:28 AM
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin)
 */
class ContactpageController extends \Controller
{
    public function index()
    {
        $this->load->language('information/contact');

        $this->document->setTitle($this->language->get('heading_title'));

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('information/contact')
        );

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_location'] = $this->language->get('text_location');
        $data['text_store'] = $this->language->get('text_store');
        $data['text_contact'] = $this->language->get('text_contact');
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

        $this->load->model('tool/image');
        $this->load->model('catalog/information');

        if ($this->config->get('config_image')) {
            $data['image'] = $this->model_tool_image->resize($this->config->get('config_image'), $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
        } else {
            $data['image'] = false;
        }

        $data['store'] = $this->config->get('config_name');
        $data['address'] = nl2br($this->config->get('config_address'));
        $data['geocode'] = $this->config->get('config_geocode');
        $data['geocode_hl'] = $this->config->get('config_language');
        
        //$data['telephone'] = $this->config->get('config_telephone');
        //$data['fax'] = $this->config->get('config_fax');

        

		$this->load->model('module/referrer');
        $contact_data_referrer=$this->model_module_referrer->getContactsReferrer();

		if(isset($contact_data_referrer['email'])){
			$data['email_site']=$contact_data_referrer['email'];
		}else{
			$data['email_site']=$this->config->get('config_email_site');
        }
        if(isset($contact_data_referrer['phone'])){
            $data['telephone']=$contact_data_referrer['phone'];
			$data['fax'] = '';
		}else{
            $data['telephone'] = $this->config->get('config_telephone');
			$data['fax'] = $this->config->get('config_fax');
        }
        $data['requisites'] = $this->model_catalog_information->cleanText($this->config->get('config_req'));

        $data['open'] = nl2br($this->config->get('config_open'));
        $data['comment'] = $this->config->get('config_comment');
        //$data['email_site'] = $this->config->get('config_email_site');

        $data['link_vk']=$this->config->get('config_soc_vk');
        $data['link_fb']=$this->config->get('config_soc_fb');
        $data['link_tw']=$this->config->get('config_soc_tw');
        $data['link_in']=$this->config->get('config_soc_in');

        $data['m_telegram']=$this->config->get('config_m_telegram');
        $data['m_whatsapp']=$this->config->get('config_m_whatsapp');
        $data['m_viber']=$this->config->get('config_m_viber');

        

        $data['locations'] = array();

        $this->load->model('localisation/location');
        
        $this->load->model('file/file');
    
        

        foreach ((array)$this->config->get('config_location') as $location_id) {
            $location_info = $this->model_localisation_location->getLocation($location_id);
    
            
            if ($location_info) {
                if ($location_info['image']) {
                    $image = $this->model_tool_image->resize($location_info['image'], $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
                } else {
                    $image = false;
                }

                $files_data = $this->model_file_file->getLocationFiles($location_id);
                
                $location_files=[];
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
        /*
        $config = $this->config;
        $data['shop_email'] = $config->get('config_email');
        */

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

        $this->load->model('catalog/information');
        $sklads = $this->model_catalog_information->getBanner(9);
        $data['sklads']=[];
        foreach($sklads as $sklad){
            
			$thumb = $this->model_tool_image->resize($sklad["image"], 300, 300, 1);
				
            $image_webp=str_replace(".jpg",".webp",$thumb);
            $image_webp=str_replace(".png",".webp",$image_webp);

                
            $data['sklads'][]=Array(
                "title"=>$sklad["title"],
                "image"=>$this->model_tool_image->resize($sklad["image"], 1000,750, 1),
                "thumb"=>$thumb,
                "thumb_webp"=>$image_webp
            );
        }
        //$data['sklads']=
        
        /*
        $data['sklads']=Array(
            Array("image"=>"catalog/image/sklad/image55.png","title"=>"test1"),
            Array("image"=>"catalog/image/sklad/image56.png","title"=>"test2"),
            Array("image"=>"catalog/image/sklad/image55.png","title"=>"test3"),
            Array("image"=>"catalog/image/sklad/image55.png","title"=>"test4"),
            Array("image"=>"catalog/image/sklad/image55.png","title"=>"test5"),
        );
        */

        $yamap = 'https://api-maps.yandex.ru/2.0/?lang=ru_RU&load=package.standard';
        //$this->document->addScript($yamap, 'footer');
        $this->document->addScript($yamap, 'header');
        $data['rekviziti'] = $this->url->link(AdminModule::CONF_REKVIZITI_LINK) . "#rekvizit";
        $data['home'] = $this->url->link('common/home');
        return $this->load->view('extension/module/app/contacts', $data);
    }
}
