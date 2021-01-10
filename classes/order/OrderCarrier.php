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
 * Class OrderCarrierCore
 *
 * @since 1.0.0
 */
class OrderCarrierCore extends ObjectModel
{
    // @codingStandardsIgnoreStart
    /** @var int */
    public $id_order_carrier;

    /** @var int */
    public $id_order;

    /** @var int */
    public $id_carrier;

    /** @var int */
    public $id_order_invoice;

    /** @var float */
    public $weight;

    /** @var float */
    public $shipping_cost_tax_excl;

    /** @var float */
    public $shipping_cost_tax_incl;

    /** @var int */
    public $tracking_number;

    /** @var string Object creation date */
    public $date_add;
    // @codingStandardsIgnoreEnd

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table'   => 'order_carrier',
        'primary' => 'id_order_carrier',
        'primaryKeyDbType' => 'int(11)',
        'fields'  => [
            'id_order'               => ['type' => self::TYPE_INT,    'validate' => 'isUnsignedId',     'required' => true],
            'id_carrier'             => ['type' => self::TYPE_INT,    'validate' => 'isUnsignedId',     'required' => true],
            'id_order_invoice'       => ['type' => self::TYPE_INT,    'validate' => 'isUnsignedId'                        ],
            'weight'                 => ['type' => self::TYPE_FLOAT,  'validate' => 'isFloat'                             ],
            'shipping_cost_tax_excl' => ['type' => self::TYPE_PRICE,  'validate' => 'isPrice'                             ],
            'shipping_cost_tax_incl' => ['type' => self::TYPE_PRICE,  'validate' => 'isPrice'                             ],
            'tracking_number'        => ['type' => self::TYPE_STRING, 'validate' => 'isTrackingNumber', 'size' => 64],
            'date_add'               => ['type' => self::TYPE_DATE,   'validate' => 'isDate', 'dbNullable' => false],
        ],
        'keys' => [
            'order_carrier' => [
                'id_carrier'       => ['type' => ObjectModel::KEY, 'columns' => ['id_carrier']],
                'id_order'         => ['type' => ObjectModel::KEY, 'columns' => ['id_order']],
                'id_order_invoice' => ['type' => ObjectModel::KEY, 'columns' => ['id_order_invoice']],
            ],
        ],
    ];

    protected $webserviceParameters = [
        'fields' => [
            'id_order'   => ['xlink_resource' => 'orders'  ],
            'id_carrier' => ['xlink_resource' => 'carriers'],
        ],
    ];
}
