<?php
// Version
define('VERSION', '2.3.0.2.3');

// Configuration
if (is_file('../admin/config.php')) {
	require_once('../admin/config.php');
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');
chdir(__DIR__ . '/../');
include_once __DIR__ . '/framework.php';

$registry->get('config')->set('config_language', 'ru-ru');

