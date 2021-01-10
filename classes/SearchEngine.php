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
 * Class SearchEngineCore
 *
 * @since 1.0.0
 */
class SearchEngineCore extends ObjectModel
{
    public $server;
    public $getvar;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table'   => 'search_engine',
        'primary' => 'id_search_engine',
        'fields'  => [
            'server' => ['type' => self::TYPE_STRING, 'validate' => 'isUrl', 'required' => true, 'size' => 64],
            'getvar' => ['type' => self::TYPE_STRING, 'validate' => 'isModuleName', 'required' => true, 'size' => 16],
        ],
    ];

    /**
     * @param string $url
     *
     * @return bool|string
     *
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function getKeywords($url)
    {
        $parsedUrl = @parse_url($url);
        if (!isset($parsedUrl['host']) || !isset($parsedUrl['query'])) {
            return false;
        }
        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('SELECT `server`, `getvar` FROM `'._DB_PREFIX_.'search_engine`');
        foreach ($result as $row) {
            $host = &$row['server'];
            $varname = &$row['getvar'];
            if (strstr($parsedUrl['host'], $host)) {
                $array = [];
                preg_match('/[^a-z]'.$varname.'=.+\&/U', $parsedUrl['query'], $array);
                if (empty($array[0])) {
                    preg_match('/[^a-z]'.$varname.'=.+$/', $parsedUrl['query'], $array);
                }
                if (empty($array[0])) {
                    return false;
                }
                $str = urldecode(str_replace('+', ' ', ltrim(substr(rtrim($array[0], '&'), strlen($varname) + 1), '=')));
                if (!Validate::isMessage($str)) {
                    return false;
                }

                return $str;
            }
        }
    }
}
