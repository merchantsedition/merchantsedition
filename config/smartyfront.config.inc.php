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

global $smarty;
$smarty->setTemplateDir(_PS_THEME_DIR_.'tpl');

if (Configuration::get('PS_JS_HTML_THEME_COMPRESSION')) {
    $smarty->registerFilter('output', 'smartyPackJSinHTML');
}

function smartyTranslate($params, $smarty)
{
    if (!isset($params['js'])) {
        $params['js'] = false;
    }
    if (!isset($params['pdf'])) {
        $params['pdf'] = false;
    }
    if (!isset($params['mod'])) {
        $params['mod'] = false;
    }
    if (!isset($params['sprintf'])) {
        $params['sprintf'] = null;
    }

    $filename = ((!isset($smarty->compiler_object) || !is_object($smarty->compiler_object->template)) ? $smarty->template_resource : $smarty->compiler_object->template->getTemplateFilepath());
    $basename = basename($filename, '.tpl');

    if ($params['mod']) {
        return Translate::postProcessTranslation(Translate::getModuleTranslation($params['mod'], $params['s'], $basename, $params['sprintf'], $params['js']), $params);
    } elseif ($params['pdf']) {
        return Translate::postProcessTranslation(Translate::getPdfTranslation($params['s'], $params['sprintf']), $params);
    }

    if (isset($smarty->source) && (strpos($smarty->source->filepath, DIRECTORY_SEPARATOR.'override'.DIRECTORY_SEPARATOR) !== false)) {
        $basename = 'override_' . $basename;
    }
    return Translate::postProcessTranslation(Translate::getFrontTranslation($params['s'], $basename, $params['sprintf'], $params['js']), $params);
}
