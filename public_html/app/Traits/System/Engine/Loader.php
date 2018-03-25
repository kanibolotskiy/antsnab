<?php
/**
 * Переписанные оригинальные классы помечены @override
 * @category WS patches 
 * @package  WS\Traits
 */

namespace WS\Traits\System\Engine;

use WS\Helper\RouteHelper as RouteHelper;
use WS\Controller\TemplateDecorator\TemplateDecorator as Template;

/**
 * 1. Вместо нативного \Template используется декоратор @see WS\TemplateDecorator & here 11, 116 lines
 * 2. Добавлена возможность подгрузки сервисов через Load::service('<path1>/<path2>/...');
 *    Становятся доступны из registry как service_<path1>_<path2> etc... 
 * 
 * @version    1.0, Mar 10, 2018  6:32:05 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
trait Loader
{
    public function service($route)
    {
        // Sanitize the call
        $route = preg_replace('/[^a-zA-Z0-9_\/]/', '', (string) $route);

        // Trigger the pre events
        $this->registry->get('event')->trigger('service/' . $route . '/before', array(&$route));

        if (!$this->registry->has('service_' . str_replace(array('/', '-', '.'), array('_', '', ''), $route))) {
            $file = RouteHelper::routeToFullFilePath($route, RouteHelper::SERVICE_PROGRAMM_LAYER);
            $class = RouteHelper::routeToFullClassName($route, RouteHelper::SERVICE_PROGRAMM_LAYER);

            if (is_file($file)) {
                include_once($file);

                $proxy = new Proxy();

                foreach (get_class_methods($class) as $method) {
                    $proxy->{$method} = $this->serviceCallback($this->registry, $route . '/' . $method);
                }

                $this->registry->set('service_' . str_replace(array('/', '-', '.'), array('_', '', ''), (string) $route), $proxy);
            } else {
                throw new \Exception('Error: Could not load service ' . $route . '!');
            }
        }

        // Trigger the post events
        $this->registry->get('event')->trigger('service/' . $route . '/after', array(&$route));
    }

    private function serviceCallback($registry, $route)
    {
        $classRoute = substr($route, 0, strrpos($route, '/'));
        return function($args) use($registry, &$route, $classRoute) {
            static $service = array();

            $output = null;

            // Trigger the pre events
            $result = $registry->get('event')->trigger('service/' . $route . '/before', array(&$route, &$args, &$output));

            if ($result) {
                return $result;
            }

            // Store the service object
            if (!isset($service[$classRoute])) {
                $class = RouteHelper::routeToFullClassName($classRoute, RouteHelper::SERVICE_PROGRAMM_LAYER);
                $service[$classRoute] = new $class($registry);
            }

            $method = substr($route, strrpos($route, '/') + 1);

            $callable = array($service[$classRoute], $method);

            if (is_callable($callable)) {
                $output = call_user_func_array($callable, $args);
            } else {
                throw new \Exception('Error: Could not call service/' . $route . '!');
            }

            // Trigger the post events
            $result = $registry->get('event')->trigger('service/' . $route . '/after', array(&$route, &$args, &$output));

            if ($result) {
                return $result;
            }

            return $output;
        };
    }

    /**
     * @override 
     * На самом деле сам метод на 100% оригинальный
     * Нужен здесь только для того, чтобы использовался другой Template класс @see 11, 116 lines
     */
    public function view($route, $data = array()) {
		$output = null;
		
		// Sanitize the call
		$route = preg_replace('/[^a-zA-Z0-9_\/]/', '', (string)$route);
		
		// Trigger the pre events
		$result = $this->registry->get('event')->trigger('view/' . $route . '/before', array(&$route, &$data, &$output));
		
		if ($result) {
			return $result;
		}
		
		if (!$output) {
            //@task - think better place for initializing registry in decorator. 
            //registry need for concrete decorators
            Template::$registry = $this->registry;
			$template = new Template($this->registry->get('config')->get('template_type'));
			
			foreach ($data as $key => $value) {
				$template->set($key, $value);
			}
		
			$output = $template->render($route . '.tpl');
		}
		
		// Trigger the post events
		$result = $this->registry->get('event')->trigger('view/' . $route . '/after', array(&$route, &$data, &$output));
		
		if ($result) {
			return $result;
		}
		
		return $output;
	}

}
