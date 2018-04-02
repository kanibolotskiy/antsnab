<?php
/**
 * Переписанные оригинальные классы помечены @override
 * @category WS patches 
 * @package  WS\Traits
 */

namespace WS\Traits\System\Engine;

use WS\Helper\RouteHelper as RouteHelper;

/**
 * Override контроллеров OpenCart 
 * 
 * @version    1.0, Mar 10, 2018  5:59:20 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
trait Action
{
    protected static $OVERRIDE_BASE_NAMESPACE = "WS\\Controller\\"; 

    /** @var string Overrided controller filepath */
    private $override;   

    /** @var string Original controller filepath */ 
    private $file;

    /**
     * @override 
     * Try to find overriding controller in $OVERRIDE_BASE_NAMESPACE 
     */
    public function __construct($route) {
		$this->id = $route;

        $parts = explode('/', preg_replace('/[^a-zA-Z0-9_\/]/', '', (string)$route));

        // Break apart the route
		while ($parts) {
			$file = DIR_APPLICATION . 'controller/' . implode('/', $parts) . '.php';
            if( $route == 'extension/module/category' ) {
                xdebug_break();
            }
            $override = RouteHelper::routeToFullFilePath(implode('/', $parts), RouteHelper::CONTROLLER_OVERRIDE_PROGRAMM_LAYER);

			if (is_file($file) || is_file($override) ) {
				$this->route = implode('/', $parts);		
				
				break;
			} else {
				$this->method = array_pop($parts);
			}
		}
        
	    $this->override = ( is_file($override) )?$override:null;
        $this->file = ( is_file($file) )?$file:null; 


        if( null === $this->override && null === $this->file ) {
            return new \Exception('Error: Could not find class file for: ' . $this->route . '/' . $this->method . '!'); 
        }
    }

    /**
     * @override
     */
    public function execute($registry, array $args = array()) {
		// Stop any magical methods being called
		if (substr($this->method, 0, 2) == '__') {
			return new \Exception('Error: Calls to magic methods are not allowed!');
		}
        
		// Initialize the class
        $controllerInstance = null;

        // include core controller to have ability for extending, when override
        if ( null !== $this->file ) {
            include_once(modification($this->file));
        }

        // try to find override class and check if method exsist
		if ( null !== $this->override ) {
			include_once($this->override);

			$controllerInstance = $this->getInstance( 
                RouteHelper::routeToFullClassName(
                    $this->route, 
                    RouteHelper::CONTROLLER_OVERRIDE_PROGRAMM_LAYER
                ), 
                $args, 
                $registry
            );
		} 

        //  override is not successful, try origin
        if ( null === $controllerInstance ) {

            $originalClass = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $this->route);
            $controllerInstance = $this->getInstance( 
                //RouteHelper::routeToFullClassName($this->route, RouteHelper::CONTROLLER_PROGRAMM_LAYER), 
                $originalClass,
                $args, 
                $registry
            );
        } 

        // not found
        if ( null === $controllerInstance) {
			return new \Exception('Error: Could not call ' . $this->route . '/' . $this->method . '!');
        } else {
			return call_user_func_array(array($controllerInstance, $this->method), $args);
        }
		
	}

    private function getInstance($class, $args, $registry)
    {
		$reflection = new \ReflectionClass($class);
        $instance = null;
        if ( $reflection->hasMethod($this->method) && 
             $reflection->getMethod($this->method)->getNumberOfRequiredParameters() <= count($args) ) {
            $instance = new $class($registry); 
        }

        return $instance;
    } 
}
