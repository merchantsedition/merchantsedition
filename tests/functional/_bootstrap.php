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

require_once __DIR__.'/../../config/config.inc.php';

// Disable mails
Configuration::updateValue('PS_MAIL_METHOD', 3);

// Disable Friendly URLs
Configuration::updateValue('PS_REWRITING_SETTINGS', 0);

// Enable Smarty cache
Configuration::updateValue('PS_SMARTY_CACHE', 1);
Configuration::updateValue('PS_SMARTY_FORCE_COMPILE', 1);
