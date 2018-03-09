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
 * @todo Refactor it 
 */

namespace WS\Helper;

class RouteHelper
{

    const DIR_APP = 'app/';
    const DIR_CONTROLLER_OVERRIDE = 'app/Controller/';
    const DIR_SERVICE = 'app/Service/';
    const DIR_VIEW_DECORATORS = 'app/Controller/TemplateDecorator';
    const SERVICE_PROGRAMM_LAYER = 'service';
    const CONTROLLER_OVERRIDE_PROGRAMM_LAYER = 'override';
    //const CONTROLLER_PROGRAMM_LAYER = 'controller';
    const VIEW_LAYER = 'view';
    const SERVICE_CLASS_POSTFIX = 'Service';
    const CONTROLLER_CLASS_POSTFIX = 'Controller';
    const VIEW_CLASS_POSTFIX = 'TemplateDecorator';
    const BASE_NAMESPACE = 'WS\\';
    const SERVICE_NAMESPACE = 'WS\\Service\\';
    const CONTROLLER_NAMESPACE = 'WS\\Controller\\';
    const VIEW_NAMESPACE = 'WS\\Controller\\TemplateDecorator\\';
    const ADMIN_CONTEXT = 'Admin';
    const SITE_CONTEXT = 'Site';

    public static function routeToFilename($route, $layer = null)
    {
        $postfix = self::getPostfix($layer);
        $parts = explode('/', $route);
        $filename = ucfirst(array_pop($parts)) . $postfix . '.php';
        return $filename;
    }

    public static function routeToPath($route, $layer = null)
    {
        switch ($layer) {
            case self::SERVICE_PROGRAMM_LAYER:
                $basePath = self::getSiteBase() . self::DIR_SERVICE;
                break;
            /* case self::CONTROLLER_PROGRAMM_LAYER:
              $basePath = DIR_APPLICATION . 'controller/';
              break; */
            case self::CONTROLLER_OVERRIDE_PROGRAMM_LAYER:
                $basePath = self::getSiteBase() . self::DIR_CONTROLLER_OVERRIDE . self::getPageContext() . '/';
                break;
            case self::VIEW_LAYER:
                $basePath = self::getSiteBase() . self::DIR_VIEW_DECORATORS . self::getPageContext() . '/';
                break;
            default:
                $basePath = self::getSiteBase() . self::DIR_APP;
        }
        $parts = explode('/', $route);
        array_pop($parts);
        foreach ($parts as &$part) {
            $part = ucfirst($part);
        }
        return $basePath . implode('/', $parts) . '/';
    }

    public static function routeToClassName($route, $layer = null)
    {
        $postfix = self::getPostfix($layer);
        $parts = explode('/', $route);
        $className = ucfirst(array_pop($parts)) . $postfix;
        return $className;
    }

    public static function routeToNamespace($route, $layer = null)
    {

        switch ($layer) {
            case self::SERVICE_PROGRAMM_LAYER:
                $baseNamespace = self::SERVICE_NAMESPACE;
                break;
            /* case self::CONTROLLER_PROGRAMM_LAYER:
              return '\\'; */
            case self::CONTROLLER_OVERRIDE_PROGRAMM_LAYER:
                $baseNamespace = self::CONTROLLER_NAMESPACE . self::getPageContext() . '\\';
                break;
            case self::VIEW_LAYER:
                $baseNamespace = self::VIEW_NAMESPACE . self::getPageContext() . '\\';
                break;
            default:
                $baseNamespace = self::BASE_NAMESPACE;
        }
        $parts = explode('/', $route);
        array_pop($parts);
        $nameSpace = $baseNamespace;
        foreach ($parts as $part) {
            $nameSpace .= ucfirst($part . '\\');
        }

        return $nameSpace;
    }

    public static function routeToFullClassName($route, $layer = null)
    {
        return self::routeToNamespace($route, $layer) . self::routeToClassName($route, $layer);
    }

    public static function routeToFullFilePath($route, $layer = null)
    {
        return self::routeToPath($route, $layer) . self::routeToFilename($route, $layer);
    }

    public static function getPageContext()
    {
        return ( false !== strpos(DIR_APPLICATION, 'admin') ) ? self::ADMIN_CONTEXT : self::SITE_CONTEXT;
    }

    public static function getSiteBase()
    {
        return ( false !== strpos(DIR_APPLICATION, 'admin') ) ?
            str_replace('admin/', '', DIR_APPLICATION) :
            str_replace('catalog/', '', DIR_APPLICATION);
    }

    public static function getPostfix($layer)
    {
        switch ($layer) {
            case self::SERVICE_PROGRAMM_LAYER:
                $postfix = self::SERVICE_CLASS_POSTFIX;
                break;
            /* case self::CONTROLLER_PROGRAMM_LAYER:
              return 'Controller' .  preg_replace('/[^a-zA-Z0-9]/', '', $route); */
            case self::CONTROLLER_OVERRIDE_PROGRAMM_LAYER:
                $postfix = self::CONTROLLER_CLASS_POSTFIX;
                break;
            case self::VIEW_LAYER:
                $postfix = self::VIEW_CLASS_POSTFIX;
                break;
            default:
                $postfix = '';
        }
        return $postfix;
    }

}
