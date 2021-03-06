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
 * Class SupplyOrderReceiptHistoryCore
 *
 * @since 1.0.0
 */
class SupplyOrderReceiptHistoryCore extends ObjectModel
{
    // @codingStandardsIgnoreStart
    /**
     * @var int Detail of the supply order (i.e. One particular product)
     */
    public $id_supply_order_detail;

    /**
     * @var int Employee
     */
    public $id_employee;

    /**
     * @var string The first name of the employee responsible of the movement
     */
    public $employee_firstname;

    /**
     * @var string The last name of the employee responsible of the movement
     */
    public $employee_lastname;

    /**
     * @var int State
     */
    public $id_supply_order_state;

    /**
     * @var int Quantity delivered
     */
    public $quantity;

    /**
     * @var string Date of delivery
     */
    public $date_add;
    // @codingStandardsIgnoreEnd

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table'   => 'supply_order_receipt_history',
        'primary' => 'id_supply_order_receipt_history',
        'fields'  => [
            'id_supply_order_detail' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true],
            'id_employee'            => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true],
            'employee_lastname'      => ['type' => self::TYPE_STRING, 'validate' => 'isName', 'size' => 32, 'dbDefault' => '', 'dbNullable' => true],
            'employee_firstname'     => ['type' => self::TYPE_STRING, 'validate' => 'isName', 'size' => 32, 'dbDefault' => '', 'dbNullable' => true],
            'id_supply_order_state'  => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true],
            'quantity'               => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedInt', 'required' => true],
            'date_add'               => ['type' => self::TYPE_DATE, 'validate' => 'isDate', 'dbNullable' => false],
        ],
        'keys' => [
            'supply_order_receipt_history' => [
                'id_supply_order_detail' => ['type' => ObjectModel::KEY, 'columns' => ['id_supply_order_detail']],
                'id_supply_order_state'  => ['type' => ObjectModel::KEY, 'columns' => ['id_supply_order_state']],
            ],
        ],
    ];

    /**
     * @see ObjectModel::$webserviceParameters
     */
    protected $webserviceParameters = [
        'objectsNodeName' => 'supply_order_receipt_histories',
        'objectNodeName'  => 'supply_order_receipt_history',
        'fields'          => [
            'id_supply_order_detail' => ['xlink_resource' => 'supply_order_details'],
            'id_employee'            => ['xlink_resource' => 'employees'],
            'id_supply_order_state'  => ['xlink_resource' => 'supply_order_states'],
        ],
    ];
}
