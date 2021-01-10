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
 * Class NewProductsControllerCore
 *
 * @since 1.0.0
 */
class NewProductsControllerCore extends FrontController
{
    // @codingStandardsIgnoreStart
    /** @var string $php_self */
    public $php_self = 'new-products';
    // @codingStandardsIgnoreEnd

    /**
     * Set media
     *
     * @return void
     *
     * @since 1.0.0
     */
    public function setMedia()
    {
        parent::setMedia();
        $this->addCSS(_THEME_CSS_DIR_.'product_list.css');
    }

    /**
     * Assign template vars related to page content
     *
     * @see   FrontController::initContent()
     *
     * @return void
     *
     * @since 1.0.0
     */
    public function initContent()
    {
        parent::initContent();

        $this->productSort();

        // Override default configuration values: cause the new products page must display latest products first.
        if (!Tools::getIsset('orderway') || !Tools::getIsset('orderby')) {
            $this->orderBy = 'date_add';
            $this->orderWay = 'DESC';
        }

        $nbProducts = (int) Product::getNewProducts(
            $this->context->language->id,
            (isset($this->p) ? (int) $this->p - 1 : null),
            (isset($this->n) ? (int) $this->n : null),
            true
        );

        $this->pagination($nbProducts);

        $products = Product::getNewProducts($this->context->language->id, (int) $this->p - 1, (int) $this->n, false, $this->orderBy, $this->orderWay);
        $this->addColorsToProductList($products);

        $this->context->smarty->assign(
            [
                'products'            => $products,
                'add_prod_display'    => Configuration::get('PS_ATTRIBUTE_CATEGORY_DISPLAY'),
                'nbProducts'          => (int) $nbProducts,
                'homeSize'            => Image::getSize(ImageType::getFormatedName('home')),
                'comparator_max_item' => Configuration::get('PS_COMPARATOR_MAX_ITEM'),
            ]
        );

        $this->setTemplate(_PS_THEME_DIR_.'new-products.tpl');
    }
}
