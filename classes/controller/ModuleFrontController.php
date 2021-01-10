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
 * Class ModuleFrontControllerCore
 *
 * @since 1.0.0
 */
class ModuleFrontControllerCore extends FrontController
{
    /** @var Module $module */
    public $module;

    /**
     * ModuleFrontControllerCore constructor.
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function __construct()
    {
        $this->module = Module::getInstanceByName(Tools::getValue('module'));
        if (!$this->module->active) {
            Tools::redirect('index');
        }

        $this->page_name = 'module-'.$this->module->name.'-'.Dispatcher::getInstance()->getController();

        parent::__construct();

        $this->controller_type = 'modulefront';

        $inBase = isset($this->page_name) && is_object($this->context->theme) && $this->context->theme->hasColumnsSettings($this->page_name);

        $tmp = isset($this->display_column_left) ? (bool) $this->display_column_left : true;
        $this->display_column_left = $inBase ? $this->context->theme->hasLeftColumn($this->page_name) : $tmp;

        $tmp = isset($this->display_column_right) ? (bool) $this->display_column_right : true;
        $this->display_column_right = $inBase ? $this->context->theme->hasRightColumn($this->page_name) : $tmp;
    }

    /**
     * Assigns module template for page content
     *
     * @param string $template Template filename
     *
     * @throws PrestaShopException
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function setTemplate($template)
    {
        if (!$path = $this->getTemplatePath($template)) {
            throw new PrestaShopException("Template '$template' not found");
        }

        $this->template = $path;
    }

    /**
     * Finds and returns module front template that take the highest precedence
     *
     * @param string $template Template filename
     *
     * @return string|false
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function getTemplatePath($template)
    {
        if (file_exists(_PS_THEME_DIR_.'modules/'.$this->module->name.'/'.$template)) {
            return _PS_THEME_DIR_.'modules/'.$this->module->name.'/'.$template;
        } elseif (file_exists(_PS_THEME_DIR_.'modules/'.$this->module->name.'/views/templates/front/'.$template)) {
            return _PS_THEME_DIR_.'modules/'.$this->module->name.'/views/templates/front/'.$template;
        } elseif (file_exists(_PS_MODULE_DIR_.$this->module->name.'/views/templates/front/'.$template)) {
            return _PS_MODULE_DIR_.$this->module->name.'/views/templates/front/'.$template;
        }

        return false;
    }

    /**
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function initContent()
    {
        if (Tools::isSubmit('module') && Tools::getValue('controller') == 'payment') {
            $currency = Currency::getCurrency((int) $this->context->cart->id_currency);
            $minimalPurchase = Tools::convertPrice((float) Configuration::get('PS_PURCHASE_MINIMUM'), $currency);
            if ($this->context->cart->getOrderTotal(false, Cart::ONLY_PRODUCTS) < $minimalPurchase) {
                Tools::redirect('index.php?controller=order&step=1');
            }
        }
        parent::initContent();
    }
}
