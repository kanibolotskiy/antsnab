<?php
/**
* Краткое описание файла
*
* Длинное описание файла (если есть)
*
* @category   WS patches 
* @package    WS_OpenCart_Patch
* @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
* @author     Sergey Lapshin (http://vk.com/wslapshin) 
*/

namespace WS\Controller\Site\Example;

class TestController extends \Controller
{
    public function index()
    {
        echo(' im test overriding controller');
    }
}