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
 * Class OrderCartRuleCore
 *
 * @since 1.0.0
 */
class OrderCartRuleCore extends ObjectModel
{
    // @codingStandardsIgnoreStart
    /** @var int */
    public $id_order_cart_rule;

    /** @var int */
    public $id_order;

    /** @var int */
    public $id_cart_rule;

    /** @var int */
    public $id_order_invoice;

    /** @var string */
    public $name;

    /** @var float value (tax incl.) of voucher */
    public $value;

    /** @var float value (tax excl.) of voucher */
    public $value_tax_excl;

    /** @var bool value : voucher gives free shipping or not */
    public $free_shipping;
    // @codingStandardsIgnoreEnd

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table'   => 'order_cart_rule',
        'primary' => 'id_order_cart_rule',
        'fields'  => [
            'id_order'         => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true],
            'id_cart_rule'     => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true],
            'id_order_invoice' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'dbDefault' => '0', 'dbNullable' => true],
            'name'             => ['type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => true, 'size' => 254],
            'value'            => ['type' => self::TYPE_PRICE, 'validate' => 'isPrice', 'required' => true, 'dbDefault' => '0.000000'],
            'value_tax_excl'   => ['type' => self::TYPE_PRICE, 'validate' => 'isPrice', 'required' => true, 'dbDefault' => '0.000000'],
            'free_shipping'    => ['type' => self::TYPE_BOOL, 'validate' => 'isBool', 'dbType' => 'tinyint(1)', 'dbDefault' => '0'],
        ],
        'keys' => [
            'order_cart_rule' => [
                'id_cart_rule' => ['type' => ObjectModel::KEY, 'columns' => ['id_cart_rule']],
                'id_order'     => ['type' => ObjectModel::KEY, 'columns' => ['id_order']],
            ],
        ],
    ];

    protected $webserviceParameters = [
        'fields' => [
            'id_order' => ['xlink_resource' => 'orders'],
        ],
    ];
}
