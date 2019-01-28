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
 * @version    1.0, Mar 25, 2018  7:47:42 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class HeaderTemplateDecorator implements IDecorator
{

    public function process($data, $registry)
    {
        $config = $registry->get('config');
        $data['telephone2'] = $config->get('config_fax');

        /* @task  XSS attack posibble. change css and markup later. now used '<p>sometext</p>' */
        $data['worktime'] = nl2br($config->get('config_open')); 

        //callback form
        $data['captcha_key'] = $registry->get('config')->get('google_captcha_key');
        $data['redirect'] = $_SERVER['REQUEST_URI'];
        $data['action'] = $registry->get('url')->link('extension/module/callform');
        $data['thank_you'] = false;
        $data['form_errors'] = array();
        $callform['data'] = array();
        $session = $registry->get('session');
        if (isset($session->data['callform'])) {
            $callform = $session->data['callform'];
            $data['form_errors'] = $callform['errors'];
            $data['thank_you'] = $callform['show_thankyou'];
            unset($session->data['callform']);
        }
        $data['form_data']['name'] = isset($callform['data']['name']) ? $callform['data']['name'] : '';
        $data['form_data']['phone'] = isset($callform['data']['phone']) ? $callform['data']['phone'] : '';
        $data['form_data']['text'] = isset($callform['data']['text']) ? $callform['data']['text'] : '';
        $data['form_data']['workemail'] = isset($callform['data']['workemail']) ? $callform['data']['workemail'] : '';        


        // gun88 menu_editor module
        $data['top_menu'] = array();
        if ($config->get('menu_editor_enabled') == 1) {
            $registry->get('load')->model('extension/module/menueditor');
            $data['top_menu'] = $registry->get('model_extension_module_menueditor')->getEntries();
        }

        // no scripts in header
        $data['scripts'] = [];

        return $data;
    }

}
