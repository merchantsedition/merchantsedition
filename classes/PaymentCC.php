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
 *
 * @deprecated 1.5.0.1
 * @see OrderPaymentCore
 *
 */
class PaymentCCCore extends OrderPayment
{
    // @codingStandardsIgnoreStart
    /** @var int $id_order */
    public $id_order;
    /** @var int $id_currency */
    public $id_currency;
    /** @var float $amount */
    public $amount;
    /** @var string $transaction_id */
    public $transaction_id;
    /** @var string $card_number */
    public $card_number;
    /** @var string $card_brand */
    public $card_brand;
    /** @var string $card_expiration */
    public $card_expiration;
    /** @var string $card_holder*/
    public $card_holder;
    /** @var string $date_add */
    public $date_add;
    protected $fieldsRequired = ['id_currency', 'amount'];
    protected $fieldsSize = ['transaction_id' => 254, 'card_number' => 254, 'card_brand' => 254, 'card_expiration' => 254, 'card_holder' => 254];
    protected $fieldsValidate = [
        'id_order' => 'isUnsignedId', 'id_currency' => 'isUnsignedId', 'amount' => 'isPrice',
        'transaction_id' => 'isAnything', 'card_number' => 'isAnything', 'card_brand' => 'isAnything', 'card_expiration' => 'isAnything', 'card_holder' => 'isAnything'
    ];
    public static $definition = [];
    // @codingStandardsIgnoreEnd

    /**
     * @deprecated 1.5.0.2
     * @see        OrderPaymentCore
     *
     * @param bool $autoDate
     * @param bool $nullValues
     *
     * @return bool
     */
    public function add($autoDate = true, $nullValues = false)
    {
        Tools::displayAsDeprecated();

        return parent::add($autoDate, $nullValues);
    }

    /**
     * Get the detailed payment of an order
     *
     * @param int $idOrder
     *
     * @return array
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @deprecated 1.5.0.1
     * @see        OrderPaymentCore
     */
    public static function getByOrderId($idOrder)
    {
        Tools::displayAsDeprecated();
        $order = new Order($idOrder);

        return OrderPayment::getByOrderReference($order->reference);
    }
}
