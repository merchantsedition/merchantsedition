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
 * @since 1.0.0
 */
class GenderCore extends ObjectModel
{
    // @codingStandardsIgnoreStart
    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table'     => 'gender',
        'primary'   => 'id_gender',
        'primaryKeyDbType' => 'int(11)',
        'multilang' => true,
        'fields'    => [
            'type' => ['type' => self::TYPE_INT, 'required' => true, 'dbType' => 'tinyint(1)'],

            /* Lang fields */
            'name' => ['type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isString', 'required' => true, 'size' => 20],
        ],
        'keys' => [
            'gender_lang' => [
                'id_gender' => ['type' => ObjectModel::KEY, 'columns' => ['id_gender']],
            ],
        ],
    ];
    public $id_gender;
    public $name;
    // @codingStandardsIgnoreEnd
    public $type;

    /**
     * GenderCore constructor.
     *
     * @param int|null $id
     * @param int|null $idLang
     * @param int|null $idShop
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function __construct($id = null, $idLang = null, $idShop = null)
    {
        parent::__construct($id, $idLang, $idShop);

        $this->image_dir = _PS_GENDERS_DIR_;
    }

    /**
     * @param null $idLang
     *
     * @return PrestaShopCollection
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function getGenders($idLang = null)
    {
        if (is_null($idLang)) {
            $idLang = Context::getContext()->language->id;
        }

        $genders = new PrestaShopCollection('Gender', $idLang);

        return $genders;
    }

    /**
     * @param bool $useUnknown
     *
     * @return string
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getImage($useUnknown = false)
    {
        if (!isset($this->id) || empty($this->id) || !file_exists(_PS_GENDERS_DIR_.$this->id.'.jpg')) {
            return _THEME_GENDERS_DIR_.'Unknown.jpg';
        }

        return _THEME_GENDERS_DIR_.$this->id.'.jpg';
    }
}
