<?php

/**
 * @category WS patches 
 * @package  WS\Controller\TemplateDecorator\Site\Common
 */

namespace WS\Controller\TemplateDecorator\Site\Common;

use WS\Controller\TemplateDecorator\IDecorator as IDecorator;

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
        $data['worktime'] = htmlspecialchars_decode($config->get('config_open'));

        // gun88 menu_editor module
        if ($config->get('menu_editor_enabled') == 1) {
            $pre_menu = array();
            $post_menu = array();
            $menu_editor_entries = $config->get('menu_editor_entries');

            foreach ($menu_editor_entries as $menu_editor_entry) {
                if ($menu_editor_entry['position'] == 0) {
                    $pre_menu[] = array('name' => $menu_editor_entry['names'][$config->get('config_language_id')],
                        'children' => array(),
                        'column' => 1,
                        'href' => $menu_editor_entry['href'],
                        'isactive' => $this->isUrlActive($menu_editor_entry['href']),
                        'target' => $menu_editor_entry['target']);
                } else {
                    $post_menu[] = array('name' => $menu_editor_entry['names'][$config->get('config_language_id')],
                        'children' => array(),
                        'column' => 1,
                        'href' => $menu_editor_entry['href'],
                        'isactive' => $this->isUrlActive($menu_editor_entry['href']),
                        'target' => $menu_editor_entry['target']);
                }
            }
            $data['top_menu'] = array_merge($pre_menu, $post_menu);
        }

        return $data;
    }

    private function isUrlActive($url)
    {

        //clean from special
        $url = html_entity_decode($url);
        //clean the given url from domain and protocol without afterward slash
        $pattern = "~^(https?:\/\/|www\.)" . $_SERVER['HTTP_HOST'] . "~";
        $url = preg_replace($pattern, "", $url);

        //we need exactly one leading slash 
        $url = preg_replace("/^\/*/", "/", $url);

        return $url === $_SERVER['REQUEST_URI'];
    }

}
