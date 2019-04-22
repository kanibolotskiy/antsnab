<?php
namespace WS\Override\Controller\Admin\Extension\Module;

use WS\Override\Controller\Admin\Extension\AModuleController;
/**
 * Вывод отзывов на странице отзывов 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ContactpageController extends AModuleController
{
    CONST CONF_REKVIZITI_LINK = 'information/information&information_id=4';

    protected function getCode()
    {
        return 'contactpage';
    }

    public function index()
    {
        parent::commonIndex();

       $this->response->setOutput($this->load->view('extension/module/app/contactpage', $this->data));
    }
    
    public function install()
    {
        parent::install();

    }

    public function uninstall()
    {
        parent::uninstall();
    }
}