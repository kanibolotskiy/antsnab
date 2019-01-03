<?php
// HTTP
define('HTTP_SERVER', 'http://ant-snab/admin/');
define('HTTP_CATALOG', 'http://ant-snab/');

// HTTPS
define('HTTPS_SERVER', 'https://ant-snab/admin/');
define('HTTPS_CATALOG', 'https://ant-snab/');

// DIR
define('DIR_APPLICATION', '/srv/http/ant-snab/public_html/admin/');
define('DIR_SYSTEM', '/srv/http/ant-snab/public_html/system/');
define('DIR_IMAGE', '/srv/http/ant-snab/public_html/image/');
define('DIR_LANGUAGE', '/srv/http/ant-snab/public_html/admin/language/');
define('DIR_TEMPLATE', '/srv/http/ant-snab/public_html/admin/view/template/');
define('DIR_CONFIG', '/srv/http/ant-snab/public_html/system/config/');
define('DIR_CACHE', '/srv/http/ant-snab/public_html/system/storage/cache/');
define('DIR_DOWNLOAD', '/srv/http/ant-snab/public_html/system/storage/download/');
define('DIR_LOGS', '/srv/http/ant-snab/public_html/system/storage/logs/');
define('DIR_MODIFICATION', '/srv/http/ant-snab/public_html/system/storage/modification/');
define('DIR_UPLOAD', '/srv/http/ant-snab/public_html/system/storage/upload/');
define('DIR_CATALOG', '/srv/http/ant-snab/public_html/catalog/');

// DB
define('DB_DRIVER', 'mpdo');
define('DB_HOSTNAME', 'localhost.localdomain');
define('DB_USERNAME', '');
define('DB_PASSWORD', '');
define('DB_DATABASE', '');
define('DB_PORT', '3306');
define('DB_PREFIX', 'oc_');
define('ROOT_CATEGORY_ID', 71);

/** @see changes in /srv/http/ant-snab/public_html/system/library/db/mpdo.php and https://stackoverflow.com/questions/1197005/how-to-get-numeric-types-from-mysql-using-pdo */
define('ATTR_EMULATE_PREPARES', false);
