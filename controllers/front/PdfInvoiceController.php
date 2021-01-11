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
 * Class PdfInvoiceControllerCore
 *
 * @since 1.0.0
 */
class PdfInvoiceControllerCore extends FrontController
{
    // @codingStandardsIgnoreStart
    /** @var string $php_self */
    public $php_self = 'pdf-invoice';
    /** @var bool $content_only */
    public $content_only = true;
    /** @var string $filename */
    public $filename;
    /** @var bool $display_header */
    protected $display_header = false;
    /** @var bool $display_footer */
    protected $display_footer = false;
    /** @var string $template */
    protected $template;
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
        if (!$this->context->customer->isLogged() && !Tools::getValue('secure_key')) {
            Tools::redirect('index.php?controller=authentication&back=pdf-invoice');
        }

        if (!(int) Configuration::get('PS_INVOICE')) {
            die(Tools::displayError('Invoices are disabled in this shop.'));
        }

        $idOrder = (int) Tools::getValue('id_order');
        if (Validate::isUnsignedId($idOrder)) {
            $order = new Order((int) $idOrder);
        }

        if (!isset($order) || !Validate::isLoadedObject($order)) {
            die(Tools::displayError('The invoice was not found.'));
        }

        if ((isset($this->context->customer->id) && $order->id_customer != $this->context->customer->id) || (Tools::isSubmit('secure_key') && $order->secure_key != Tools::getValue('secure_key'))) {
            die(Tools::displayError('The invoice was not found.'));
        }

        if (!OrderState::invoiceAvailable($order->getCurrentState()) && !$order->invoice_number) {
            die(Tools::displayError('No invoice is available.'));
        }

        $this->order = $order;
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
        $orderInvoiceList = $this->order->getInvoicesCollection();
        Hook::exec('actionPDFInvoiceRender', ['order_invoice_list' => $orderInvoiceList]);

        $pdf = new PDF($orderInvoiceList, PDF::TEMPLATE_INVOICE, $this->context->smarty);
        $pdf->render();
    }
}
