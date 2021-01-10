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
 * Class TaxManagerFactoryCore
 *
 * @since   1.0.0
 */
class TaxManagerFactoryCore
{
    protected static $cache_tax_manager;

    /**
     * Returns a tax manager able to handle this address
     *
     * @param Address $address
     * @param string  $type
     *
     * @return TaxManagerInterface
     *
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function getManager(Address $address, $type)
    {
        $cacheId = TaxManagerFactory::getCacheKey($address).'-'.$type;
        if (!isset(TaxManagerFactory::$cache_tax_manager[$cacheId])) {
            $taxManager = TaxManagerFactory::execHookTaxManagerFactory($address, $type);
            if (!($taxManager instanceof TaxManagerInterface)) {
                $taxManager = new TaxRulesTaxManager($address, $type);
            }

            TaxManagerFactory::$cache_tax_manager[$cacheId] = $taxManager;
        }

        return TaxManagerFactory::$cache_tax_manager[$cacheId];
    }

    /**
     * Check for a tax manager able to handle this type of address in the module list
     *
     * @param Address $address
     * @param string  $type
     *
     * @return TaxManagerInterface|false
     *
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function execHookTaxManagerFactory(Address $address, $type)
    {
        $modulesInfos = Hook::getModulesFromHook(Hook::getIdByName('taxManager'));
        $taxManager = false;

        foreach ($modulesInfos as $moduleInfos) {
            $moduleInstance = Module::getInstanceByName($moduleInfos['name']);
            if (is_callable([$moduleInstance, 'hookTaxManager'])) {
                $taxManager = $moduleInstance->hookTaxManager(
                    [
                        'address' => $address,
                        'params'  => $type,
                    ]
                );
            }

            if ($taxManager) {
                break;
            }
        }

        return $taxManager;
    }

    /**
     * Create a unique identifier for the address
     *
     * @param Address
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     * @return string
     */
    protected static function getCacheKey(Address $address)
    {
        return $address->id_country.'-'
            .(int) $address->id_state.'-'
            .$address->postcode.'-'
            .$address->vat_number.'-'
            .$address->dni;
    }
}
