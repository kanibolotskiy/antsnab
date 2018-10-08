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

		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
                    'descr' => html_entity_decode($result['descr']),
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
				);
			}
		}

		$data['module'] = $module++;

		return $this->load->view('extension/module/app/slideshow', $data);
	}

}
