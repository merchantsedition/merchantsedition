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

/**
 * Interface WebserviceOutputInterface
 *
 * @since 1.0.0
 */
interface WebserviceOutputInterface
{
    public function __construct($languages = []);
    public function setWsUrl($url);
    public function getWsUrl();
    public function getContentType();
    public function setSchemaToDisplay($schema);
    public function getSchemaToDisplay();
    public function renderField($field);
    public function renderNodeHeader($obj, $params, $moreAttr = null);
    public function renderNodeFooter($obj, $params);
    public function renderAssociationHeader($obj, $params, $assocName);
    public function renderAssociationFooter($obj, $params, $assocName);
    public function overrideContent($content);
    public function renderErrorsHeader();
    public function renderErrorsFooter();
    public function renderErrors($message, $code = null);
}
