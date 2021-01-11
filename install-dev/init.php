<?php
/**
 * Copyright (C) 2021 Merchant's Edition GbR
 * Copyright (C) 2017-2018 thirty bees
 * Copyright (C) 2007-2016 PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to contact@merchantsedition.com so we can send you a copy immediately.
 *
 * @author    Merchant's Edition <contact@merchantsedition.com>
 * @author    thirty bees <contact@thirtybees.com>
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2021 Merchant's Edition GbR
 * @copyright 2017-2018 thirty bees
 * @copyright 2007-2016 PrestaShop SA
 * @license   Open Software License (OSL 3.0)
 * PrestaShop is an internationally registered trademark of PrestaShop SA.
 * thirty bees is an extension to the PrestaShop software by PrestaShop SA.
 */

ob_start();

// Check PHP version
if (version_compare(PHP_VERSION, '5.6', '<')) {
    die('You need at least PHP 5.6 to run thirty bees. Your current PHP version is '.PHP_VERSION);
}

// we check if theses constants are defined in order to use init.php
if (!defined('__PS_BASE_URI__')) {
    define('__PS_BASE_URI__', substr($_SERVER['REQUEST_URI'], 0, -1 * (strlen($_SERVER['REQUEST_URI']) - strrpos($_SERVER['REQUEST_URI'], '/')) - strlen(substr(dirname($_SERVER['REQUEST_URI']), strrpos(dirname($_SERVER['REQUEST_URI']), '/') + 1))));
}

if (!defined('_PS_CORE_DIR_')) {
    define('_PS_CORE_DIR_', realpath(dirname(__FILE__).'/..'));
}

if (!defined('_THEME_NAME_')) {
    // '_THEME_DIR_' would be a better name for this definition.
    define('_THEME_NAME_', 'niara');
}

if (!defined('_PS_DEBUG_SQL_')) {
    define('_PS_DEBUG_SQL_', true);
}

require_once(_PS_CORE_DIR_.'/config/defines.inc.php');
require_once(_PS_CORE_DIR_.'/config/autoload.php');
require_once(_PS_CORE_DIR_.'/config/bootstrap.php');
require_once(_PS_CORE_DIR_.'/config/defines_uri.inc.php');
require_once(_PS_CORE_DIR_.'/config/default_modules.php');

// Generate common constants
define('TB_INSTALLATION_IN_PROGRESS', true);
define('_TB_INSTALL_PATH_', dirname(__FILE__).'/');
define('_PS_INSTALL_DATA_PATH_', _TB_INSTALL_PATH_.'data/');
define('_PS_INSTALL_CONTROLLERS_PATH_', _TB_INSTALL_PATH_.'controllers/');
define('_PS_INSTALL_MODELS_PATH_', _TB_INSTALL_PATH_.'models/');
define('_PS_INSTALL_LANGS_PATH_', _TB_INSTALL_PATH_.'langs/');
define('_PS_INSTALL_FIXTURES_PATH_', _TB_INSTALL_PATH_.'fixtures/');
define('_PS_PRICE_DISPLAY_PRECISION_', 2);
// For retrocompatibility with PS 1.6.1 (which messed up in this area).
define('_PS_PRICE_COMPUTE_PRECISION_', _PS_PRICE_DISPLAY_PRECISION_);

require_once(_TB_INSTALL_PATH_.'install_version.php');

// thirty bees autoload is used to load some helpfull classes like Tools.
// Add classes used by installer bellow.

require_once(_PS_CORE_DIR_.'/config/alias.php');
require_once(_TB_INSTALL_PATH_.'classes/exception.php');
require_once(_TB_INSTALL_PATH_.'classes/languages.php');
require_once(_TB_INSTALL_PATH_.'classes/language.php');
require_once(_TB_INSTALL_PATH_.'classes/model.php');
require_once(_TB_INSTALL_PATH_.'classes/session.php');
require_once(_TB_INSTALL_PATH_.'classes/sqlLoader.php');
require_once(_TB_INSTALL_PATH_.'classes/xmlLoader.php');
require_once(_TB_INSTALL_PATH_.'classes/simplexml.php');

@set_time_limit(0);
if (!@ini_get('date.timezone')) {
    @date_default_timezone_set('UTC');
}

// disable displaying errors in standard output
@ini_set('display_errors', 'off');
