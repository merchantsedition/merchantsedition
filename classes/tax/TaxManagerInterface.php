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
* A TaxManager define a way to retrieve tax.
 *
 * @since 1.0.0
*/
interface TaxManagerInterface
{
    /**
    * This method determine if the tax manager is available for the specified address.
    *
    * @param Address $address
    *
    * @return bool
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
    */
    public static function isAvailableForThisAddress(Address $address);

    /**
    * Return the tax calculator associated to this address
    *
    * @return TaxCalculator
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
    */
    public function getTaxCalculator();
}
