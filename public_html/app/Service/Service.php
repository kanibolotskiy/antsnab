<?php
namespace WS\Service;

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

use \Registry as Registry;

class Service extends IDEAutocompleteService {
	protected $registry;

	public function __construct(Registry $registry) {
		$this->registry = $registry;
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
}
