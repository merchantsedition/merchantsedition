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
 * Interface ITreeToolbarButtonCore
 *
 * @since 1.0.0
 */
interface ITreeToolbarButtonCore
{
    public function __toString();
    public function setAttribute($name, $value);
    public function getAttribute($name);
    public function setAttributes($value);
    public function getAttributes();
    public function setClass($value);
    public function getClass();
    public function setContext($value);
    public function getContext();
    public function setId($value);
    public function getId();
    public function setLabel($value);
    public function getLabel();
    public function setName($value);
    public function getName();
    public function setTemplate($value);
    public function getTemplate();
    public function setTemplateDirectory($value);
    public function getTemplateDirectory();
    public function hasAttribute($name);
    public function render();
}
