<?php

namespace Template;

final class Twig
{

    private $twig;
    private $data = [];

    public function __construct()
    {

        $loader = new \Twig_Loader_Array(array());

        $this->twig = new \Twig_Environment($loader, [
            'autoescape' => false,
            'cache' => DIR_SYSTEM . 'storage/cache/twig',
            'auto_reload' => true,
            'debug' => true
            ]
        );

        $this->twig->addExtension(new \Twig_Extension_Debug());
    }

    public function set($key, $value)
    {
        $this->data[$key] = $value;
    }

    public function render($template)
    {
        try {
            // load template
            $this->twig->getLoader()->setTemplate(
                'index', file_get_contents(DIR_TEMPLATE . $template)
            );

            return $this->twig->render('index', $this->data);
        } catch (Exception $e) {
            trigger_error('Error: Could not load template ' . $template . '!');
            exit();
        }
    }

}
