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
 * Class Adapter_ProductPriceCalculator
 */
// @codingStandardIgnoreStart
class Adapter_ProductPriceCalculator
{
    // @codingStandardIgnoreEnd

    /**
     * @param int          $idProduct
     * @param bool         $usetax
     * @param null         $idProductAttribute
     * @param int          $decimals
     * @param null         $divisor
     * @param bool         $onlyReduc
     * @param bool         $usereduc
     * @param int          $quantity
     * @param bool         $forceAssociatedTax
     * @param null         $idCustomer
     * @param null         $idCart
     * @param null         $idAddress
     * @param null         $specificPriceOutput
     * @param bool         $withEcotax
     * @param bool         $useGroupReduction
     * @param Context|null $context
     * @param bool         $useCustomerPrice
     *
     * @return float
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function getProductPrice(
        $idProduct,
        $usetax = true,
        $idProductAttribute = null,
        $decimals = _TB_PRICE_DATABASE_PRECISION_,
        $divisor = null,
        $onlyReduc = false,
        $usereduc = true,
        $quantity = 1,
        $forceAssociatedTax = false,
        $idCustomer = null,
        $idCart = null,
        $idAddress = null,
        &$specificPriceOutput = null,
        $withEcotax = true,
        $useGroupReduction = true,
        Context $context = null,
        $useCustomerPrice = true
    ) {
        return Product::getPriceStatic(
            $idProduct,
            $usetax,
            $idProductAttribute,
            $decimals,
            $divisor,
            $onlyReduc,
            $usereduc,
            $quantity,
            $forceAssociatedTax,
            $idCustomer,
            $idCart,
            $idAddress,
            $specificPriceOutput,
            $withEcotax,
            $useGroupReduction,
            $context,
            $useCustomerPrice
        );
    }
}
