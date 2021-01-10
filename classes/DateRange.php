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
 * Class DateRangeCore
 *
 * @since 1.0.0
 */
class DateRangeCore extends ObjectModel
{
    // @codingStandardsIgnoreStart
    /** @var string $time_start */
    public $time_start;
    /** @var string $time_end */
    public $time_end;
    // @codingStandardsIgnoreEnd
    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table'   => 'date_range',
        'primary' => 'id_date_range',
        'fields'  => [
            'time_start' => ['type' => self::TYPE_DATE, 'validate' => 'isDate', 'required' => true],
            'time_end'   => ['type' => self::TYPE_DATE, 'validate' => 'isDate', 'required' => true],
        ],
    ];

    /**
     * @return mixed
     *
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function getCurrentRange()
    {
        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow(
            (new DbQuery())
                ->select('`id_date_range`, `time_end`')
                ->from('date_range')
                ->where('`time_end` = (SELECT MAX(`time_end`) FROM `'._DB_PREFIX_.'date_range`)')
        );
        if (!$result['id_date_range'] || strtotime($result['time_end']) < strtotime(date('Y-m-d H:i:s'))) {
            // The default range is set to 1 day less 1 second (in seconds)
            $rangeSize = 86399;
            $dateRange = new static();
            $dateRange->time_start = date('Y-m-d');
            $dateRange->time_end = strftime('%Y-%m-%d %H:%M:%S', strtotime($dateRange->time_start) + $rangeSize);
            $dateRange->add();

            return $dateRange->id;
        }

        return $result['id_date_range'];
    }
}
