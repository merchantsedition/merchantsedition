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
 * Class CMSRoleCore
 *
 * @since 1.0.0
 */
class CMSRoleCore extends ObjectModel
{
    // @codingStandardsIgnoreStart
    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table'   => 'cms_role',
        'primary' => 'id_cms_role',
        'fields'  => [
            'name'   => ['type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'size' => 50, 'unique' => true, 'dbNullable' => false],
            'id_cms' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedInt', 'dbNullable' => false],
        ],
        'keys' => [
            'cms_role' => [
                'primary' => ['type' => ObjectModel::PRIMARY_KEY, 'columns' => ['id_cms_role', 'id_cms']],
            ],
            'cms_role_lang' => [
                'primary' => ['type' => ObjectModel::PRIMARY_KEY, 'columns' => ['id_cms_role', 'id_lang', 'id_shop']],
            ],
        ],
        'charset' => ['utf8mb4', 'utf8mb4_general_ci'],
    ];
    /** @var string name */
    public $name;
    // @codingStandarsIgnoreEnd
    /** @var integer id_cms */
    public $id_cms;

    /**
     * @return string
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function getRepositoryClassName()
    {
        return 'Core_Business_CMS_CMSRoleRepository';
    }
}
