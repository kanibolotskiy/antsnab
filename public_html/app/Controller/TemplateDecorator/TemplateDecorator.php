<?php
/**
 * @category WS patches 
 * @package  WS
 */
namespace WS\Controller\TemplateDecorator;
use \Template as OpenCartTemplate;
use WS\Helper\RouteHelper as RouteHelper;

/**
 * Вызывается в \Loader::view() вместо оригинального \Template и декорирует последний
 * 
 * Реализует возможность модификации переменных шаблона, 
 * сформированных в контроллере, до рендеринга view 
 * 
 * @version    1.0, Mar 9, 2018  3:19:59 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class TemplateDecorator
{

    const DECORATOR_INTERFACE = 'WS\\Controller\\TemplateDecorator\\IDecorator';

    const TEMPLATE_DIR_PATTERN = '/template/';

    /** @var \Registry - регистр OpenCart */
    static public $registry;
    
    /** @var \Template Original OCs' template class */
    private $wrapee;

    /** @var WS\TemplateDecorator\IDecorator|null Concrete data decorator */
    private $decorator = null;

    /** @var string|null */
    private $currentRoute = null;

    /** @var array Template variables */
    private $data = [];

    /**
     * @param string $adaptor - тип конкретного шаблонизатора (config.template_type)
     */
    public function __construct($adaptor)
    {
        $this->wrapee = new OpenCartTemplate($adaptor); 
    }

    /**
     * Установить переменную шабона
     *  
     * @param string $key
     * @param string $value
     * @return void
     */
    public function set($key, $value)
    {
       $this->data[$key] = $value; 
    }

    /**
     * Рендеринг шаблона с установленными переменными
     *  
     * @param string $template - шаблон 
     * @return string
     */
    public function render($template)
    {
        $route = $this->dispatchRouteFromTemplate($template);

        if( $this->currentRoute != $route ) {
            $this->decorator = $this->getDecorator($route);
            $this->currentRoute = $route;
        }

        if( null !== $this->decorator ) {
            $modifiedData = $this->decorator->process($this->data, self::$registry);
            $this->setDataArray($modifiedData);
        }

        $this->extractDataToWrapee();

        return $this->wrapee->render($template);
    }

    /**
     * Factory method 
     * @param type $route
     */
    private function getDecorator($route)
    {
        $decorator = null; 
        $decoratorClass = RouteHelper::routeToFullClassName($route, RouteHelper::VIEW_LAYER);
        if( $this->checkDecorator($decoratorClass) ) {
            $decorator = new $decoratorClass();
        }
        return $decorator;
    }

    private function dispatchRouteFromTemplate($template)
    {
        $opencartRoute = str_replace('.tpl', '', $template);
        $opencartRoute = str_replace('.twig', '', $opencartRoute);
        
        if ( RouteHelper::getPageContext() === RouteHelper::SITE_CONTEXT ) {
            $startPos = strpos($template, self::TEMPLATE_DIR_PATTERN);
            if( false === $startPos ) {
                throw new \Exception ("Wrong template path given, cant dispatch programmatical route [" . $template . "]");
            }
            $startPos += strlen(self::TEMPLATE_DIR_PATTERN);
            $opencartRoute = substr($opencartRoute, $startPos);
        }

        return $opencartRoute;
    }

    private function checkDecorator($className)
    {
        $implementsInterface = false;
        $classExists = class_exists($className);

        if( $classExists ) {
            $implementsInterface = in_array(self::DECORATOR_INTERFACE, class_implements($className));
        }
        return $classExists && $implementsInterface;
    }

    private function setDataArray($data)
    {
        foreach($data as $key => $value) {
            $this->set($key, $value);
        }
    }

    private function extractDataToWrapee()
    {
        foreach($this->data as $key => $value) {
            $this->wrapee->set($key, $value);
        }
    }
}
