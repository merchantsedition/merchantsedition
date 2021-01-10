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
 * Class StockManagerModuleCore
 *
 * @since 1.0.0
 */
abstract class StockManagerModuleCore extends Module
{
    // @codingStandardsIgnoreStart
    public $stock_manager_class;
    // @codingStandardsIgnoreEnd

    /**
     * @return bool
     *
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function install()
    {
        return (parent::install() && $this->registerHook('stockManager'));
    }

    /**
     * @return bool
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function hookStockManager()
    {
        $classFile = _PS_MODULE_DIR_.'/'.$this->name.'/'.$this->stock_manager_class.'.php';

        if (!isset($this->stock_manager_class) || !file_exists($classFile)) {
            die(sprintf(Tools::displayError('Incorrect Stock Manager class [%s]'), $this->stock_manager_class));
        }

        require_once($classFile);

        if (!class_exists($this->stock_manager_class)) {
            die(sprintf(Tools::displayError('Stock Manager class not found [%s]'), $this->stock_manager_class));
        }

        $class = $this->stock_manager_class;
        if (call_user_func([$class, 'isAvailable'])) {
            return new $class();
        }

        return false;
    }
}
