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
$timerStart = microtime(true);

//	$_GET['tab'] = $_GET['controller'];
//	$_POST['tab'] = $_POST['controller'];
//	$_REQUEST['tab'] = $_REQUEST['controller'];
try {
    $context = Context::getContext();
    if (isset($_GET['logout'])) {
        $context->employee->logout();
    }

    if (!isset($context->employee) || !$context->employee->isLoggedBack()) {
        Tools::redirectAdmin('index.php?controller=AdminLogin&redirect='.$_SERVER['REQUEST_URI']);
    }

    // Set current index
    // @deprecated global
    global $currentIndex; // retrocompatibility;
    $currentIndex = $_SERVER['SCRIPT_NAME'].(($controller = Tools::getValue('controller')) ? '?controller='.$controller: '');

    if ($back = Tools::getValue('back')) {
        $currentIndex .= '&back='.urlencode($back);
    }
    AdminTab::$currentIndex = $currentIndex;

    $iso = $context->language->iso_code;
    if (file_exists(_PS_TRANSLATIONS_DIR_.$iso.'/errors.php')) {
        include(_PS_TRANSLATIONS_DIR_.$iso.'/errors.php');
    }
    if (file_exists(_PS_TRANSLATIONS_DIR_.$iso.'/fields.php')) {
        include(_PS_TRANSLATIONS_DIR_.$iso.'/fields.php');
    }
    if (file_exists(_PS_TRANSLATIONS_DIR_.$iso.'/admin.php')) {
        include(_PS_TRANSLATIONS_DIR_.$iso.'/admin.php');
    }

    /* Server Params */
    $protocolLink = (Configuration::get('PS_SSL_ENABLED')) ? 'https://' : 'http://';
    $protocolContent = (isset($useSSL) and $useSSL and Configuration::get('PS_SSL_ENABLED')) ? 'https://' : 'http://';
    $link = new Link($protocolLink, $protocolContent);
    $context->link = $link;
    if (!defined('_PS_BASE_URL_')) {
        define('_PS_BASE_URL_', Tools::getShopDomain(true));
    }
    if (!defined('_PS_BASE_URL_SSL_')) {
        define('_PS_BASE_URL_SSL_', Tools::getShopDomainSsl(true));
    }

    $path = dirname(__FILE__).'/themes/';
    // if the current employee theme is not valid (check layout.tpl presence),
    // reset to default theme
    if (empty($context->employee->bo_theme) ||
        !file_exists($path.$context->employee->bo_theme.'/template/layout.tpl')) {
        // default admin theme is "default".
        $context->employee->bo_theme = '';
        if (file_exists($path.'default/template/layout.tpl')) {
            $context->employee->bo_theme = 'default';
        } else {
            // if default theme doesn't exists, try to find one, otherwise throw exception
            foreach (scandir($path) as $theme) {
                if ($theme[0] != '.' && file_exists($path.$theme.'/template/layout.tpl')) {
                    $context->employee->bo_theme = $theme;
                    break;
                }
            }
            // if no theme is found, admin can't work.
            if (empty($context->employee->bo_theme)) {
                throw new PrestaShopException('Unable to load theme for employee, and no valid theme found');
            }
        }
        $context->employee->update();
    }

    // Change shop context ?
    if (Shop::isFeatureActive() && Tools::getValue('setShopContext') !== false) {
        $context->cookie->shopContext = Tools::getValue('setShopContext');
        $url = parse_url($_SERVER['REQUEST_URI']);
        $query = (isset($url['query'])) ? $url['query'] : '';
        parse_str($query, $parseQuery);
        unset($parseQuery['setShopContext']);
        Tools::redirectAdmin($url['path'] . '?' . http_build_query($parseQuery, '', '&'));
    }

    $context->currency = new Currency(Configuration::get('PS_CURRENCY_DEFAULT'));


    if ($context->employee->isLoggedBack()) {
        $shop_id = '';
        Shop::setContext(Shop::CONTEXT_ALL);
        if ($context->cookie->shopContext) {
            $split = explode('-', $context->cookie->shopContext);
            if (count($split) == 2) {
                if ($split[0] == 'g') {
                    if ($context->employee->hasAuthOnShopGroup($split[1])) {
                        Shop::setContext(Shop::CONTEXT_GROUP, $split[1]);
                    } else {
                        $shop_id = $context->employee->getDefaultShopID();
                        Shop::setContext(Shop::CONTEXT_SHOP, $shop_id);
                    }
                } elseif ($context->employee->hasAuthOnShop($split[1])) {
                    $shop_id = $split[1];
                    Shop::setContext(Shop::CONTEXT_SHOP, $shop_id);
                } else {
                    $shop_id = $context->employee->getDefaultShopID();
                    Shop::setContext(Shop::CONTEXT_SHOP, $shop_id);
                }
            }
        }

        // Replace existing shop if necessary
        if (!$shop_id) {
            $context->shop = new Shop(Configuration::get('PS_SHOP_DEFAULT'));
        } elseif ($context->shop->id != $shop_id) {
            $context->shop = new Shop($shop_id);
        }
    }
} catch (PrestaShopException $e) {
    $e->displayMessage();
}
