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
 * Class PdfOrderReturnControllerCore
 *
 * @since 1.0.0
 */
class PdfOrderReturnControllerCore extends FrontController
{
    // @codingStandardsIgnoreStart
    /** @var string $php_self */
    public $php_self = 'pdf-order-return';
    /** @var bool $display_header */
    protected $display_header = false;
    /** @var bool $display_footer */
    protected $display_footer = false;
    // @codingStandardsIgnoreEnd

    /**
     * Post processing
     *
     * @return void
     *
     * @since 1.0.0
     */
    public function postProcess()
    {
        $fromAdmin = (Tools::getValue('adtoken') == Tools::getAdminToken('AdminReturn'.(int) Tab::getIdFromClassName('AdminReturn').(int) Tools::getValue('id_employee')));

        if (!$fromAdmin && !$this->context->customer->isLogged()) {
            Tools::redirect('index.php?controller=authentication&back=order-follow');
        }

        if (Tools::getValue('id_order_return') && Validate::isUnsignedId(Tools::getValue('id_order_return'))) {
            $this->orderReturn = new OrderReturn(Tools::getValue('id_order_return'));
        }

        if (!isset($this->orderReturn) || !Validate::isLoadedObject($this->orderReturn)) {
            die(Tools::displayError('Order return not found.'));
        } elseif (!$fromAdmin && $this->orderReturn->id_customer != $this->context->customer->id) {
            die(Tools::displayError('Order return not found.'));
        } elseif ($this->orderReturn->state < 2) {
            die(Tools::displayError('Order return not confirmed.'));
        }
    }

    /**
     * Display
     *
     * @return void
     *
     * @since 1.0.0
     */
    public function display()
    {
        $pdf = new PDF($this->orderReturn, PDF::TEMPLATE_ORDER_RETURN, $this->context->smarty);
        $pdf->render();
    }
}
