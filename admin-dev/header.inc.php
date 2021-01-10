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

$con = new AdminController();
$tab = new Tab((int)Tab::getIdFromClassName(Tools::getValue('controller')));
$con->id = $tab->id;
$con->init();
$con->initToolbar();
$con->initPageHeaderToolbar();
$con->setMedia();
$con->initHeader();
$con->initFooter();

$title = [$tab->getFieldByLang('name')];

Context::getContext()->smarty->assign(
    [
    'navigationPipe', Configuration::get('PS_NAVIGATION_PIPE'),
    'meta_title' => implode(' '.Configuration::get('PS_NAVIGATION_PIPE').' ', $title),
    'display_header' => true,
    'display_header_javascript' => true,
    'display_footer' => true,
    ]
);
$dir = Context::getContext()->smarty->getTemplateDir(0).'controllers'.DIRECTORY_SEPARATOR.trim($con->override_folder, '\\/').DIRECTORY_SEPARATOR;
$header_tpl = file_exists($dir.'header.tpl') ? $dir.'header.tpl' : 'header.tpl';
$tool_tpl = file_exists($dir.'page_header_toolbar.tpl') ? $dir.'page_header_toolbar.tpl' : 'page_header_toolbar.tpl';
Context::getContext()->smarty->assign(
    [
    'show_page_header_toolbar' => true,
    'title' => implode(' '.Configuration::get('PS_NAVIGATION_PIPE').' ', $title),
    'toolbar_btn' => []
    ]
);
echo Context::getContext()->smarty->fetch($header_tpl);
echo Context::getContext()->smarty->fetch($tool_tpl);
