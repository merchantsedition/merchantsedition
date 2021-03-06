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
 * Class QuickAccessCore
 *
 * @since 1.0.0
 */
class QuickAccessCore extends ObjectModel
{
    // @codingStandardsIgnoreStart
    /** @var string|string[] Name */
    public $name;
    /** @var string Link */
    public $link;
    /** @var bool New windows or not */
    public $new_window;
    // @codingStandardsIgnoreEnd

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table'     => 'quick_access',
        'primary'   => 'id_quick_access',
        'multilang' => true,
        'fields'    => [
            'new_window' => ['type' => self::TYPE_BOOL, 'validate' => 'isBool', 'required' => true, 'dbType' => 'tinyint(1)', 'dbDefault' => '0'],
            'link'       => ['type' => self::TYPE_STRING, 'validate' => 'isUrl', 'required' => true, 'size' => 255],
            /* Lang fields */
            'name'       => ['type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCleanHtml', 'required' => true, 'size' => 32],
        ],
    ];

    /**
     * Get all available quick_accesses
     *
     * @param int $idLang
     *
     * @return array QuickAccesses
     *
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function getQuickAccesses($idLang)
    {
        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS(
            (new DbQuery())
                ->select('*')
                ->from(bqSQL(static::$definition['table']), 'qa')
                ->leftJoin(bqSQL(static::$definition['table']).'_lang', 'qal', 'qa.`'.bqSQL(static::$definition['primary']).'` = qal.`'.bqSQL(static::$definition['primary']).'`')
                ->orderBy('`name` ASC')
                ->where('qal.`id_lang` = '.(int) $idLang)
        );
    }

    /**
     * @return bool
     * @throws PrestaShopException
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function toggleNewWindow()
    {
        if (!array_key_exists('new_window', $this)) {
            throw new PrestaShopException('property "new_window" is missing in object '.get_class($this));
        }

        $this->setFieldsToUpdate(['new_window' => true]);

        $this->new_window = !(int) $this->new_window;

        return $this->update(false);
    }
}
