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

if (!defined('_PS_ADMIN_DIR_')) {
    define('_PS_ADMIN_DIR_', getcwd());
}
include(_PS_ADMIN_DIR_.'/../config/config.inc.php');

/**
 * @deprecated 1.5.0
 * This file is deprecated, please use AdminPdfController instead
 */
Tools::displayFileAsDeprecated();

if (!Context::getContext()->employee->id) {
    Tools::redirectAdmin('index.php?controller=AdminLogin');
}

$function_array = [
    'pdf' => 'generateInvoicePDF',
    'id_order_slip' => 'generateOrderSlipPDF',
    'id_delivery' => 'generateDeliverySlipPDF',
    'delivery' => 'generateDeliverySlipPDF',
    'invoices' => 'generateInvoicesPDF',
    'invoices2' => 'generateInvoicesPDF2',
    'slips' => 'generateOrderSlipsPDF',
    'deliveryslips' => 'generateDeliverySlipsPDF',
    'id_supply_order' => 'generateSupplyOrderFormPDF'
];

$pdf_controller = new AdminPdfController();
foreach ($function_array as $var => $function) {
    if (isset($_GET[$var])) {
        $pdf_controller->{'process'.$function}();
        exit;
    }
}

exit;
