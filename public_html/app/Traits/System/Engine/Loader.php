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
 * 3. Автоматическая подгрузка шаблонизатора по расширению
 * 4. Загрузка моделей OpenCart с учетом контекста (админка или витрина) 
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
     */
    public function view($route, $data = array())
    {
        $output = null;

        // Sanitize the call
        $route = preg_replace('/[^a-zA-Z0-9_\/]/', '', (string) $route);

        // Trigger the pre events
        $result = $this->registry->get('event')->trigger('view/' . $route . '/before', array(&$route, &$data, &$output));

        if ($result) {
            return $result;
        }

        if (!$output) {

            //registry need for IDecorators
            $templateFileName = '';
            $template = $this->dispatchTemplate($route, $templateFileName);

            foreach ($data as $key => $value) {
                $template->set($key, $value);
            }

            $output = $template->render($templateFileName);
        }

        // Trigger the post events
        $result = $this->registry->get('event')->trigger('view/' . $route . '/after', array(&$route, &$data, &$output));

        if ($result) {
            return $result;
        }

        return $output;
    }

    public function model($route, $context = null)
    {
        // Sanitize the call
        $route = preg_replace('/[^a-zA-Z0-9_\/]/', '', (string) $route);

        // Trigger the pre events
        $this->registry->get('event')->trigger('model/' . $route . '/before', array(&$route));

        $originKey = 'model_' . str_replace(array('/', '-', '.'), array('_', '', ''), (string) $route);
        if (!$this->registry->has($originKey)) {
            $this->loadModelRespectingBaseDir(DIR_APPLICATION, $route, $originKey);
        }

        if (null !== $context) {
            $this->loadModelWithDispatchingContext($route, $context);
        }

        // Trigger the post events
        $this->registry->get('event')->trigger('model/' . $route . '/after', array(&$route));
    }

    /* $namespace with leading slash always */

    private function loadModelRespectingBaseDir($basedir, $route, $key, $namespace = '\\')
    {
        $file = $basedir . 'model/' . $route . '.php';
        $class = $namespace . 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $route);

        if (is_file($file)) {
            include_once(modification($file));

            $proxy = new \Proxy();

            foreach (get_class_methods($class) as $method) {
                $proxy->{$method} = $this->callback($this->registry, $route . '/' . $method, $file, $class, $key);
            }

            $this->registry->set($key, $proxy);
        } else {
            throw new \Exception('Error: Could not load model ' . $route . '!');
        }

        return true;
    }

    private function loadModelWithDispatchingContext($route, $context)
    {
        if (!in_array($context, [RouteHelper::ADMIN_CONTEXT, RouteHelper::SITE_CONTEXT])) {
            throw new \Exception('Error: Could not load model from context ' . $context . ' route: ' . $route);
        }

        $originKey = 'model_' . str_replace(array('/', '-', '.'), array('_', '', ''), (string) $route);
        $key = 'model_' . str_replace(array('/', '-', '.'), array('_', '', ''), (string) $route) .
            '_' . $context;

        if (!$this->registry->has($key)) {
            if (RouteHelper::getPageContext() === $context) {
                $this->registry->set($key, $this->registry->get($originKey));
            } else {
                $namespace = '\\';
                $contextDir = $this->resolveClassConflictsWhileDispatching($context, $route, $namespace);
                $this->loadModelRespectingBaseDir($contextDir, $route, $key, $namespace);
            }
        }

        return true;
    }

    /**
     * Для загрузки классов DAO (модели OC) в разных окружениях (в витрине,админке)
     * Из за одинакового названия классов могут возникать конфликты
     * @param string $context - запрашиваемый контекст DAO 
     * @param type $route
     * @return string - $contextDir реальный путь к DAO 
     * @throws \Exception
     */
    private function resolveClassConflictsWhileDispatching($context, $route, &$namespace = '\\')
    {
        $suffix = ( $context === RouteHelper::ADMIN_CONTEXT ) ? 'admin/' : 'catalog/';
        $contextDir = RouteHelper::getSiteBase() . $suffix;

        //проверим, а есть ли вообще нужный файл класса
        $file = $contextDir . 'model/' . $route . '.php';

        if (!is_file($file)) {
            throw new \Exception('Error: Could not load model ' . $route . '!');
        }

        //если класс еще не подключался  - все окей
        $class = $namespace . 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $route);
        if (!class_exists($class)) {
            return $contextDir;
        }

        //определяем структуру каталогов во временной директории
        $temporaryDirBase = DIR_CACHE . 'TempModelClasses/' . $suffix;
        $routeAr = explode('/', $route);
        $tempFileName = array_pop($routeAr) . '.php';
        $routePath = implode('/', $routeAr);
        $temporaryDir = $temporaryDirBase . 'model/' . $routePath . '/';
        $temporaryFile = $temporaryDir . $tempFileName;
        $temporaryNamespace = 'Temp' . $context;

        //вероятно файл уже был создан ранее
        if (is_file($temporaryFile)) {
            $contextDir = $temporaryDirBase;
            $namespace = "\\" . $temporaryNamespace . "\\";
            return $contextDir;
        }

        //иначе подготавливаем структуру
        if (false === @mkdir($temporaryDir, 0775, true) && !is_dir($temporaryDir)) {
            throw new \Exception('Cant create DAO (model) temporary classes' . $route . '!');
        }

        //разбираемся с файлами
        $temporaryFileDescriptor = fopen($temporaryFile, 'w+');
        if (false === $temporaryFileDescriptor) {
            throw new \Exception('Cant create temporary DAO (model) class file' . $route . '!');
        }
        $originalFileContents = file_get_contents($file);

        //считываем оригинальный файл и подготавливаем его (добавляем namespace) 
        $pattern = '<?php';
        $startPos = stripos($originalFileContents, $pattern);
        if (false === $startPos) {
            throw new \Exception('Error: Could not load model ' . $route . '!');
        }
        $finPos = $startPos + strlen($pattern);
        $originalFileContents = substr($originalFileContents, $finPos);

        $temporaryFileContents = $pattern . "\n" . "namespace " . $temporaryNamespace . ";\n";
        $temporaryFileContents .= "use \Model as Model;\n" . $originalFileContents;

        //записали
        fwrite($temporaryFileDescriptor, $temporaryFileContents);
        fclose($temporaryFileDescriptor);

        //возращаем новые значения
        $namespace = "\\" . $temporaryNamespace . "\\";
        $contextDir = $temporaryDirBase;

        return $contextDir;
    }

    /**
     * Автоматически определяет тип шаблонизатора, который нужно применить
     * @param string $route - маршрут
     *               контекста (админка или витрина). Определяется в стр 65
     *               каким то там событием
     */
    protected function dispatchTemplate($route, &$templateFileName)
    {
        //@task - think better place for initializing registry in decorator. 
        //@task - think if it is a good place for dispatching view routes? (deleted standart events)
        //@task - refactor swithes and ifs
        Template::$registry = $this->registry;
        $config = $this->registry->get('config');


        if (!$config->get($config->get('config_theme') . '_status')) {
            exit('Error: A theme has not been assigned to this store!');
        }

        // This is only here for compatibility with older extensions
        if (substr($route, -3) == 'tpl') {
            $route = substr($route, 0, -3);
        }

        $templateEngine = null;
        switch (RouteHelper::getPageContext()) {
            case RouteHelper::ADMIN_CONTEXT:
                if (is_file(DIR_TEMPLATE . $route . '.twig')) {
                    $templateEngine = new Template('twig');
                    $templateFileName = $route . '.twig';
                } elseif (is_file(DIR_TEMPLATE . $route . '.tpl')) {
                    $templateEngine = new Template('php');
                    $templateFileName = $route . '.tpl';
                } else {
                    throw new \Exception('Template file not found route:' . $route);
                }
                break;
            default:

                // If the default theme is selected we need to know which directory its pointing to
                if ($config->get('config_theme') == 'theme_default') {
                    $theme = $config->get('theme_default_directory');
                } else {
                    $theme = $config->get('config_theme');
                }

                if (is_file(DIR_TEMPLATE . $theme . '/template/' . $route . '.twig')) {
                    $templateEngine = new Template('twig');
                    $templateFileName = $theme . '/template/' . $route . '.twig';
                } elseif (is_file(DIR_TEMPLATE . 'default/template/' . $route . '.twig')) {
                    $templateEngine = new Template('twig');
                    $templateFileName = 'default/template/' . $route . '.twig';
                } elseif (is_file(DIR_TEMPLATE . $theme . '/template/' . $route . '.tpl')) {
                    $templateEngine = new Template('php');
                    $templateFileName = $theme . '/template/' . $route . '.tpl';
                } elseif (is_file(DIR_TEMPLATE . 'default/template/' . $route . '.tpl')) {
                    $templateEngine = new Template('php');
                    $templateFileName = 'default/template/' . $route . '.tpl';
                } else {
                    throw new \Exception('Template file not found route:' . $route);
                }
        }

        return $templateEngine;
    }

    protected function callback($registry, $route, $file, $class, $key)
    {
        return function($args) use($registry, &$route, $file, $class, $key) {
            static $model = array();

            $output = null;

            // Trigger the pre events
            // @task is it need or possible in context of DAO
            $result = $registry->get('event')->trigger('model/' . $route . '/before', array(&$route, &$args, &$output));

            if ($result) {
                return $result;
            }

            // Store the model object
            if (!isset($model[$key . $route])) {
                if (is_file($file)) {
                    //include_once(modification($file));

                    $model[$key . $route] = new $class($registry);
                } else {
                    throw new \Exception('Error: Could not load model ' . substr($route, 0, strrpos($route, '/')) . '!');
                }
            }

            $method = substr($route, strrpos($route, '/') + 1);

            $callable = array($model[$key . $route], $method);

            if (is_callable($callable)) {
                $output = call_user_func_array($callable, $args);
            } else {
                throw new \Exception('Error: Could not call model/' . $key . '.' .$route . '!');
            }

            // Trigger the post events
            $result = $registry->get('event')->trigger('model/' . $route . '/after', array(&$route, &$args, &$output));

            if ($result) {
                return $result;
            }

            return $output;
        };
    }
}
    