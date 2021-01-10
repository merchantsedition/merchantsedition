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

if (!defined('_PS_ADMIN_DIR_')) {
    define('_PS_ADMIN_DIR_', getcwd());
}
include_once(_PS_ADMIN_DIR_.'/../config/config.inc.php');

$module = Tools::getValue('module');
$type = Tools::getValue('type');
$option = Tools::getValue('option');
$layers = Tools::getValue('layers');
$width = Tools::getValue('width');
$height = Tools::getValue('height');
$id_employee = Tools::getValue('id_employee');
$id_lang = Tools::getValue('id_lang');

if (!isset($cookie->id_employee) || !$cookie->id_employee || $cookie->id_employee != $id_employee) {
    die(Tools::displayError());
}

if (!Validate::isModuleName($module)) {
    die(Tools::displayError());
}

$statsModuleInstance = Module::getInstanceByName('statsmodule');

if ($statsModuleInstance->active && in_array($module, $statsModuleInstance->modules)) {
    $module_path = _PS_ROOT_DIR_.'/modules/statsmodule/stats/'.$module.'.php';
} else {
    if (!file_exists($module_path = _PS_ROOT_DIR_.'/modules/'.$module.'/'.$module.'.php')) {
        die(Tools::displayError());
    }
}


$shop_id = '';
Shop::setContext(Shop::CONTEXT_ALL);
if (Context::getContext()->cookie->shopContext) {
    $split = explode('-', Context::getContext()->cookie->shopContext);
    if (count($split) == 2) {
        if ($split[0] == 'g') {
            if (Context::getContext()->employee->hasAuthOnShopGroup($split[1])) {
                Shop::setContext(Shop::CONTEXT_GROUP, $split[1]);
            } else {
                $shop_id = Context::getContext()->employee->getDefaultShopID();
                Shop::setContext(Shop::CONTEXT_SHOP, $shop_id);
            }
        } elseif (Shop::getShop($split[1]) && Context::getContext()->employee->hasAuthOnShop($split[1])) {
            $shop_id = $split[1];
            Shop::setContext(Shop::CONTEXT_SHOP, $shop_id);
        } else {
            $shop_id = Context::getContext()->employee->getDefaultShopID();
            Shop::setContext(Shop::CONTEXT_SHOP, $shop_id);
        }
    }
}

// Check multishop context and set right context if need
if (Shop::getContext()) {
    if (Shop::getContext() == Shop::CONTEXT_SHOP && !Shop::CONTEXT_SHOP) {
        Shop::setContext(Shop::CONTEXT_GROUP, Shop::getContextShopGroupID());
    }
    if (Shop::getContext() == Shop::CONTEXT_GROUP && !Shop::CONTEXT_GROUP) {
        Shop::setContext(Shop::CONTEXT_ALL);
    }
}

// Replace existing shop if necessary
if (!$shop_id) {
    Context::getContext()->shop = new Shop(Configuration::get('PS_SHOP_DEFAULT'));
} elseif (Context::getContext()->shop->id != $shop_id) {
    Context::getContext()->shop = new Shop($shop_id);
}

require_once($module_path);

$graph = new $module();
$graph->setEmployee($id_employee);
$graph->setLang($id_lang);
if ($option) {
    $graph->setOption($option, $layers);
}
$graph->createGraph(null, $type, $width, $height, $layers);
$graph->draw();
