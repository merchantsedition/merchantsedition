<?php
/**
 * Copyright (C) 2021 Merchant's Edition GbR
 * Copyright (C) 2017-2018 thirty bees
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
 * @copyright 2021 Merchant's Edition GbR
 * @copyright 2017-2018 thirty bees
 * @license   Open Software License (OSL 3.0)
 */

// Here you can initialize variables that will be available to your tests
require_once __DIR__.'/../../vendor/autoload.php';

/**
 * Turn any notice/warning/error into a full error, causing the Travis CI
 * build to fail. Else it won't get noticed in day to day operations.
 */
function errorHandlerThirty($errno, $errstr, $errfile, $errline)
{
  trigger_error(
      'Original error: '.$errstr.' in '.$errfile.':'.$errline,
      E_USER_ERROR
  );

  return true;
}

$kernel = AspectMock\Kernel::getInstance();
$kernel->init([
    'appDir' => __DIR__,
    'cacheDir' => rtrim(sys_get_temp_dir(), DIRECTORY_SEPARATOR).DIRECTORY_SEPARATOR.'mocks',
    'includePaths' => [
        __DIR__.'/../../classes',
        __DIR__.'/../../Core',
        __DIR__.'/../../Adapter',
        __DIR__.'/../_support/override',
    ],
]);

require_once __DIR__.'/../../config/defines.inc.php';
require_once __DIR__.'/../../config/settings.inc.php';

$oldErrorHandler = set_error_handler('errorHandlerThirty');
require_once __DIR__.'/../_support/unitloadclasses.php';
set_error_handler($oldErrorHandler);

require_once __DIR__.'/../../config/alias.php';
