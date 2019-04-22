<?php

/**
 * Подгрузка модулей из Ovveride директории патча.
 * Данный класс неотъемлемая часть патча
 * 
 * Важное ограничение по использованию модулей через override
 * 
 * do not use same extensions' names in lower case (Foo and foo - same) 
 * and dont use 'controller' word in extension name 
 * 
 * @version    0.1, Sep 28, 2018  11:22:58 AM 
 * @author     Sergey Lapshin 
 */

namespace WS\Override\Controller\Admin\Extension\Extension;
use WS\Helper\RouteHelper;

class ModuleController extends \ControllerExtensionExtensionModule
{
    protected function getList()
    {
        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_layout'] = sprintf($this->language->get('text_layout'), $this->url->link('design/layout', 'token=' . $this->session->data['token'], true));
        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_confirm'] = $this->language->get('text_confirm');

        $data['text_hide_modules'] = sprintf($this->language->get('text_hide_modules'), $this->url->link('user/user_permission', 'token=' . $this->session->data['token'], 'SSL'));

        $data['column_name'] = $this->language->get('column_name');
        $data['column_action'] = $this->language->get('column_action');

        $data['button_add'] = $this->language->get('button_add');
        $data['button_edit'] = $this->language->get('button_edit');
        $data['button_delete'] = $this->language->get('button_delete');
        $data['button_install'] = $this->language->get('button_install');
        $data['button_uninstall'] = $this->language->get('button_uninstall');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        $extensions = $this->model_extension_extension->getInstalled('module');

        /** @changed */
        $files = $this->scanFiles();
        $extCodes = [];
        foreach($files as $file) {
            $extCodes[] = $this->getExtCodeByFileName($file);
        }

        foreach ($extensions as $key => $value) {
            if ( !in_array($value, $extCodes) ) {
                $this->model_extension_extension->uninstall('module', $value);
                unset($extensions[$key]);
                $this->model_extension_module->deleteModulesByCode($value);
            }
        }
        /** \\\ */

        $data['extensions'] = array();

        $this->load->model('user/user_group');

        $user_group_info = $this->model_user_user_group->getUserGroup($this->user->user_group_id);

        if (isset($user_group_info['permission']['hiden'])) {
            $hiden = $user_group_info['permission']['hiden'];
        } else {
            $hiden = array();
        }

        $data['hiden'] = false;
        if ($files) {
            foreach ($files as $file) {

                /** @changed */
                $extension = $this->getExtCodeByFileName($file);

                if (!in_array('extension/module/' . $extension, $hiden)) {
                    $this->load->language('extension/module/' . $extension);

                    $module_data = array();

                    $modules = $this->model_extension_module->getModulesByCode($extension);

                    foreach ($modules as $module) {
                        $module_data[] = array(
                            'module_id' => $module['module_id'],
                            'name' => $module['name'],
                            'edit' => $this->url->link('extension/module/' . $extension, 'token=' . $this->session->data['token'] . '&module_id=' . $module['module_id'], true),
                            'delete' => $this->url->link('extension/extension/module/delete', 'token=' . $this->session->data['token'] . '&module_id=' . $module['module_id'], true)
                        );
                    }

                    $data['extensions'][] = array(
                        'name' => $this->language->get('heading_title'),
                        'module' => $module_data,
                        'install' => $this->url->link('extension/extension/module/install', 'token=' . $this->session->data['token'] . '&extension=' . $extension, true),
                        'uninstall' => $this->url->link('extension/extension/module/uninstall', 'token=' . $this->session->data['token'] . '&extension=' . $extension, true),
                        'installed' => in_array($extension, $extensions),
                        'edit' => $this->url->link('extension/module/' . $extension, 'token=' . $this->session->data['token'], true)
                    );
                }
            }
        }

        $sort_order = array();


        foreach ($data['extensions'] as $key => $value) {
            $sort_order[$key] = $value['name'];
        }

        array_multisort($sort_order, SORT_ASC, $data['extensions']);

        $this->response->setOutput($this->load->view('extension/extension/module', $data));
    }

    private function scanFiles()
    {

        $files = glob(DIR_APPLICATION . 'controller/{extension/module,module}/*.php', GLOB_BRACE);
        $patchExtensions = glob(RouteHelper::getSiteBase() . RouteHelper::DIR_CONTROLLER_OVERRIDE . '/Admin/Extension/Module/*.php', GLOB_BRACE);

        return array_merge($files, $patchExtensions);
    }

    private function getExtCodeByFileName($file)
    {
        return str_replace('controller', '', strtolower(basename($file, '.php')));
    }

}
