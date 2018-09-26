<?php
/**
* Инициирует кэш иерархии каталога 
*
* @category   WS patches 
* @package    WS_OpenCart_Patch
* @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
* @author     Sergey Lapshin (http://vk.com/wslapshin) 
*/
use WS\Override\Gateway\Hierarhy as Hierarhy;

class ControllerStartupHierarhy extends Controller
{
    public function index()
    {
        $hierarhy = new Hierarhy($this->registry); 
        $this->registry->set('hierarhy', $hierarhy);
    }
}


