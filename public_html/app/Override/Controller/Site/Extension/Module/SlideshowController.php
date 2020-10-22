<?php

namespace WS\Override\Controller\Site\Extension\Module;

//put your use statements here

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 23, 2018  9:00:40 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class SlideshowController extends \Controller
{

    /**
     * @removed owlcarousel css and js 
     */
    public function index($setting) {
		static $module = 0;		

		$this->load->model('design/banner');
		$this->load->model('tool/image');
		$this->load->model('catalog/sale');

		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);
		
		/**Добавляем баннеры из акций */
		$activeAccias=$this->model_catalog_sale->activeAccias();
		foreach($activeAccias as $accia){
			$accia_url=$this->url->link('sale/sale', 'sale_id=' . $accia["accia_id"]);
			if($accia['image']){
				$data['banners'][] = array(
					'title' => "Акция",
					'link'  => $accia_url,
					'descr' => $accia["shorttext"],
					'image' => $this->model_tool_image->cropsize($accia['image'], 1100, 540)
				);
			}
		}
		$activeAcciasDiscount=$this->model_catalog_sale->activeAcciaDiscount();
		//print_r($activeAcciasDiscount);
        if($activeAcciasDiscount){
            if($activeAcciasDiscount["image"]){
                //$banners[]=array(
				$data['banners'][]=array(
                    'title' => "Акция",
                    'link'  => "sales/".$activeAcciasDiscount["keyword"]."/",
					'image' => $this->model_tool_image->cropsize($activeAcciasDiscount["image"], 1100,540),
					'descr'=>$activeAcciasDiscount['shorttext'] //'Товар дня'
                );
            }
        }
		
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
                    'descr' => html_entity_decode($result['descr']),
					//'image' => $this->model_tool_image->cropsize($result['image'], $setting['width'], $setting['height'])
					'image' => $this->model_tool_image->cropsize($result['image'],  781, 385)
				);
			}
		}

		$data['module'] = $module++;

		return $this->load->view('extension/module/app/slideshow', $data);
	}

}
