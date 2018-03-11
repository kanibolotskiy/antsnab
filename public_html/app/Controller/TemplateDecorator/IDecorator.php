<?php
/**
 * @category WS patches 
 * @package  WS
 */

namespace WS;

/**
 * Интерфейс конкретного декоратора \Template
 * @see WS\TemplateDecorator 
 * 
 * @version    1.0, Mar 9, 2018  3:53:15 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
namespace WS\Controller\TemplateDecorator;

interface IDecorator
{
    /**
     * Воркер декоратора. Модифицирует переменные шаблона 
     * @param array $data - переменные шаблона из контроллера
     * @return array;
     */
    public function process($data);
}
