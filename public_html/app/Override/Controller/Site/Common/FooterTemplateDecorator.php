<?php
/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Site\Common
 */

namespace WS\Override\Controller\Site\Common;

use WS\Override\Controller\IDecorator;

/**
 * Описание класса 
 * 
 * @version    1.0, Mar 25, 2018  7:36:16 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class FooterTemplateDecorator implements IDecorator 
{
    public function process($data, $registry)
    {
        $config = $registry->get('config');

        // Fields
        $data['telephone'] = $config->get('config_telephone');
        $data['telephone2'] = $config->get('config_fax');
        $data['address'] = nl2br( $config->get('config_address') );
        $data['email'] = $config->get('config_email');
        $data['confidence'] = $registry->get('url')->link('information/information', 'information_id=3');

        // Analytics
		$registry->get('load')->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $registry->get('model_extension_extension')->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($registry->get('config')->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $registry->get('load')->controller('extension/analytics/' . $analytic['code'], $registry->get('config')->get($analytic['code'] . '_status'));
			}
		}

        // gun88 menu_editor module
        $data['top_menu'] = array();
        if ($config->get('menu_editor_enabled') == 1) {
            $registry->get('load')->model('extension/module/menueditor');
            $data['top_menu'] = $registry->get('model_extension_module_menueditor')->getEntries();
        }

        return $data;
    }
}
