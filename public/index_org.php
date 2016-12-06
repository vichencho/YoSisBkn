<?php
/**
 * KumbiaPHP web & app Framework
 *
 * LICENSE
 *
 * This source file is subject to the new BSD license that is bundled
 * with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://wiki.kumbiaphp.com/Licencia
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@kumbiaphp.com so we can send you a copy immediately.
 *
 * @copyright  Copyright (c) 2005-2014 Kumbia Team (http://www.kumbiaphp.com)
 * @license    http://wiki.kumbiaphp.com/Licencia     New BSD License
 */

function mb_strlen($string){ return strlen($string); }
function mb_strpos($haystack,$needle,$offset=0){ return strpos($haystack,$needle,$offset); }
function mb_strrpos($haystack,$needle,$offset=0){ return strrpos($haystack,$needle,$offset); }
function mb_strtolower($string){ return strtolower($string); }
function mb_strtoupper($string){ return strtoupper($string); }
function mb_substr($string,$start,$length=NULL){ return substr($string,$start,$length); }


/**
 * @TODO
 * REVISAR ESTA SECCIÓN
 *
 */
define('APP_CHARSET', 'UTF-8');

/**
 * 
 */
date_default_timezone_set('America/Caracas');

/**
 * Indicar si la aplicacion se encuentra en produccion
 * directamente desde el index.php
 */
define('PRODUCTION', FALSE);

/**
 * Establece polí­tica de informe de errores
 */
error_reporting(E_ALL ^ E_STRICT);ini_set('display_errors', 'On');

/**
 * Define marca de tiempo en que inicio el Request
 */
define('START_TIME', microtime(TRUE));

/**
 * Define el APP_PATH
 *
 * APP_PATH:
 * - Ruta al directorio de la aplicación (por defecto la ruta al directorio app)
 * - Esta ruta se utiliza para cargar los archivos de la aplicacion
 * - En producción, es recomendable ponerla manual
 */
define('APP_PATH', dirname(__DIR__) . '/app/');

/**
 * Define el CORE_PATH
 *
 * CORE_PATH:
 * - Ruta al directorio que contiene el núcleo de Kumbia (por defecto la ruta al directorio core)
 */
define('CORE_PATH', dirname(dirname(APP_PATH)) . '/core/');

/**
 * Define el PUBLIC_PATH
 *
 * PUBLIC_PATH:
 * - Path para genera la Url en los links a acciones y controladores
 * - Esta ruta la utiliza Kumbia como base para generar las Urls para acceder de lado de
 *   cliente (con el navegador web) y es relativa al DOCUMENT_ROOT del servidor web
 */
if ($_SERVER['QUERY_STRING']) {
    define('PUBLIC_PATH', substr(urldecode($_SERVER['REQUEST_URI']), 0, - strlen(urldecode($_SERVER['QUERY_STRING'])) + 6));
} else {
    define('PUBLIC_PATH', $_SERVER['REQUEST_URI']);
}

/**
 * Obtiene la url
 */
$url = isset($_GET['_url']) ? $_GET['_url'] : '/';

/**
 * Define el VENDOR_PATH
 */
define('VENDOR_PATH', CORE_PATH . '../vendor/');

/**
 * Cargar las librerias de composer
 */
require VENDOR_PATH . 'autoload.php';


/**
 * Carga el gestor de arranque
 * Por defecto el bootstrap del core
 *
 * @see Bootstrap
 */
//require APP_PATH . 'libs/bootstrap.php'; //bootstrap de app
require CORE_PATH . 'kumbia/bootstrap.php'; //bootstrap del core 
