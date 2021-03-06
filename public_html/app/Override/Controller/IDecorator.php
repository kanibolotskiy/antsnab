<?php
/**
 * @category WS patches 
 * @package  WS
 */

namespace WS\Override\Controller;

/**
 * Интерфейс конкретного декоратора \Template
 * @see WS\TemplateDecorator 
 * 
 * @version    1.0, Mar 9, 2018  3:53:15 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */

interface IDecorator
{
    /**
     * Воркер декоратора. Модифицирует/добавляет переменные шаблона 
     * @param array $data - переменные шаблона из контроллера
     * @param \Registry - реестр OpenCart
     * @return array $data;
     */
    public function process($data, $registry);
}
