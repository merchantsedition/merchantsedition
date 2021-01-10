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
 * Class WarehouseProductLocationCore
 *
 * @since 1.0.0
 */
class WarehouseProductLocationCore extends ObjectModel
{
    // @codingStandardsIgnoreStart
    /**
     * @var int product ID
     * */
    public $id_product;

    /**
     * @var int product attribute ID
     * */
    public $id_product_attribute;

    /**
     * @var int warehouse ID
     * */
    public $id_warehouse;

    /**
     * @var string location of the product
     * */
    public $location;
    // @codingStandardsIgnoreEnd

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table'   => 'warehouse_product_location',
        'primary' => 'id_warehouse_product_location',
        'fields'  => [
            'id_product'           => ['type' => self::TYPE_INT,    'validate' => 'isUnsignedId',                'required' => true],
            'id_product_attribute' => ['type' => self::TYPE_INT,    'validate' => 'isUnsignedId',                'required' => true],
            'id_warehouse'         => ['type' => self::TYPE_INT,    'validate' => 'isUnsignedId',                'required' => true],
            'location'             => ['type' => self::TYPE_STRING, 'validate' => 'isReference',  'size' => 64                     ],
        ],
        'keys' => [
            'warehouse_product_location' => [
                'id_product' => ['type' => ObjectModel::UNIQUE_KEY, 'columns' => ['id_product', 'id_product_attribute', 'id_warehouse']],
            ],
        ],

    ];

    /**
     * @see ObjectModel::$webserviceParameters
     */
    protected $webserviceParameters = [
        'fields'        => [
            'id_product'           => ['xlink_resource' => 'products'],
            'id_product_attribute' => ['xlink_resource' => 'combinations'],
            'id_warehouse'         => ['xlink_resource' => 'warehouses'],
        ],
        'hidden_fields' => [],
    ];

    /**
     * For a given product and warehouse, gets the location
     *
     * @param int $idProduct          product ID
     * @param int $idProductAttribute product attribute ID
     * @param int $idWarehouse        warehouse ID
     *
     * @return string $location Location of the product
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     * @throws PrestaShopException
     */
    public static function getProductLocation($idProduct, $idProductAttribute, $idWarehouse)
    {
        // build query
        $query = new DbQuery();
        $query->select('wpl.location');
        $query->from('warehouse_product_location', 'wpl');
        $query->where(
            'wpl.id_product = '.(int) $idProduct.'
			AND wpl.id_product_attribute = '.(int) $idProductAttribute.'
			AND wpl.id_warehouse = '.(int) $idWarehouse
        );

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue($query);
    }

    /**
     * For a given product and warehouse, gets the WarehouseProductLocation corresponding ID
     *
     * @param int $idProduct
     * @param int $idProductAttribute
     * @param int $id_supplier
     *
     * @return int $id_warehouse_product_location ID of the WarehouseProductLocation
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     * @throws PrestaShopException
     */
    public static function getIdByProductAndWarehouse($idProduct, $idProductAttribute, $idWarehouse)
    {
        // build query
        $query = new DbQuery();
        $query->select('wpl.id_warehouse_product_location');
        $query->from('warehouse_product_location', 'wpl');
        $query->where(
            'wpl.id_product = '.(int) $idProduct.'
			AND wpl.id_product_attribute = '.(int) $idProductAttribute.'
			AND wpl.id_warehouse = '.(int) $idWarehouse
        );

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue($query);
    }

    /**
     * For a given product, gets its warehouses
     *
     * @param int $idProduct
     *
     * @return PrestaShopCollection The type of the collection is WarehouseProductLocation
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     * @throws PrestaShopException
     */
    public static function getCollection($idProduct)
    {
        $collection = new PrestaShopCollection('WarehouseProductLocation');
        $collection->where('id_product', '=', (int) $idProduct);

        return $collection;
    }

    /**
     * @param $idWarehouse
     *
     * @return array|false|mysqli_result|null|PDOStatement|resource
     *
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function getProducts($idWarehouse)
    {
        return Db::getInstance()->executeS('SELECT DISTINCT id_product FROM '._DB_PREFIX_.'warehouse_product_location WHERE id_warehouse='.(int) $idWarehouse);
    }
}
