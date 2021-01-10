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
 * Class StockManagerFactoryCore
 *
 * @since 1.0.0
 */
class StockManagerFactoryCore
{
    // @codingStandardsIgnoreStart
    /** @var $stock_manager : instance of the current StockManager. */
    protected static $stock_manager;
    // @codingStandardsIgnoreEnd

    /**
     * Returns a StockManager
     *
     * @return StockManagerInterface
     *
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function getManager()
    {
        if (!isset(StockManagerFactory::$stock_manager)) {
            $stockManager = StockManagerFactory::execHookStockManagerFactory();
            if (!($stockManager instanceof StockManagerInterface)) {
                $stockManager = new StockManager();
            }
            StockManagerFactory::$stock_manager = $stockManager;
        }
        return StockManagerFactory::$stock_manager;
    }

    /**
     * Looks for a StockManager in the modules list.
     *
     * @return StockManagerInterface
     *
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function execHookStockManagerFactory()
    {
        $modulesInfos = Hook::getModulesFromHook(Hook::getIdByName('stockManager'));
        $stockManager = false;

        foreach ($modulesInfos as $moduleInfos) {
            $moduleInstance = Module::getInstanceByName($moduleInfos['name']);

            if (is_callable([$moduleInstance, 'hookStockManager'])) {
                $stockManager = $moduleInstance->hookStockManager();
            }

            if ($stockManager) {
                break;
            }
        }

        return $stockManager;
    }
}
