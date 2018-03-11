<?php
/**
 * Переписанные оригинальные классы помечены @override
 * @category WS patches 
 * @package WS\Traits  
 */

namespace WS\Traits\System\Library;

/**
 * Автоматическая подгрузка файла конфигурации патча
 * system/config/app.php 
 * 
 * @version    1.0, Mar 9, 2018  8:18:47 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
trait Config
{
    /** @var array Loaded config files stack * */
    private $loaded = array();

    /** @var string Filename * */
    protected static $PATCH_CONFIG_FILENAME = 'app';

    /**
     * Autoload patch config file added
     */
    public function __construct()
    {
        $this->loadPatchConfig();
    }

    /**
     * @override
     * Collect loaded config stack added 
     */
    public function load($filename)
    {
        $file = DIR_CONFIG . $filename . '.php';

        if (file_exists($file) && !$this->isLoaded($filename) ) {
            $_ = array();

            require(modification($file));

            $this->data = array_merge($this->data, $_);
            $this->loaded[] = $filename;
        } elseif ( !file_exists ($file) ) {
            trigger_error('Error: Could not load config ' . $filename . '!');
            exit();
        }
    }

    private function isLoaded($filename)
    {
        return in_array($filename, $this->loaded);
    }

    private function loadPatchConfig()
    {
        $this->load(self::$PATCH_CONFIG_FILENAME);
    }

}
