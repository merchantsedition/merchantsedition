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
 * Class FaviconControllerCore
 *
 * @since 1.0.4
 */
class FaviconControllerCore extends FrontController
{
    // @codingStandardsIgnoreStart
    /** @var string $php_self */
    public $php_self = 'favicon';
    // @codingStandardsIgnoreEnd

    /**
     * Initialize content
     *
     * @return void
     *
     * @since 1.0.4
     */
    public function init()
    {
        if (Tools::getValue('icon') === 'apple-touch-icon') {
            if (Tools::getIsset('width') && Tools::getIsset('height')) {
                $width = Tools::getValue('width');
                $height = Tools::getValue('height');

                header('Content-Type: image/png');
                readfile(_PS_IMG_DIR_."favicon/favicon_{$this->context->shop->id}_{$width}_{$height}.png");
                exit;
            }

            header('Content-Type: image/png');
            readfile(_PS_IMG_DIR_."favicon/favicon_{$this->context->shop->id}_180_180.png");
            exit;
        }

        header('Content-Type: image/x-icon');
        readfile(_PS_IMG_DIR_."favicon-{$this->context->shop->id}.ico");
        exit;
    }
}
