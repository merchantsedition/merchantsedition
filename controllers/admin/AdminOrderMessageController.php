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
 * Class AdminOrderMessageControllerCore
 *
 * @since 1.0.0
 */
class AdminOrderMessageControllerCore extends AdminController
{
    /**
     * AdminOrderMessageControllerCore constructor.
     *
     * @since 1.0.0
     */
    public function __construct()
    {
        $this->bootstrap = true;
        $this->table = 'order_message';
        $this->className = 'OrderMessage';
        $this->lang = true;

        $this->addRowAction('edit');
        $this->addRowAction('delete');

        $this->context = Context::getContext();

        if (!Tools::getValue('realedit')) {
            $this->deleted = false;
        }

        $this->bulk_actions = [
            'delete' => [
                'text'    => $this->l('Delete selected'),
                'confirm' => $this->l('Delete selected items?'),
                'icon'    => 'icon-trash',
            ],
        ];

        $this->fields_list = [
            'id_order_message' => [
                'title' => $this->l('ID'),
                'align' => 'center',
            ],
            'name'             => [
                'title' => $this->l('Name'),
            ],
            'message'          => [
                'title'     => $this->l('Message'),
                'maxlength' => 300,
            ],
        ];

        $this->fields_form = [
            'legend' => [
                'title' => $this->l('Order messages'),
                'icon'  => 'icon-mail',
            ],
            'input'  => [
                [
                    'type'     => 'text',
                    'lang'     => true,
                    'label'    => $this->l('Name'),
                    'name'     => 'name',
                    'size'     => 53,
                    'required' => true,
                ],
                [
                    'type'     => 'textarea',
                    'lang'     => true,
                    'label'    => $this->l('Message'),
                    'name'     => 'message',
                    'required' => true,
                ],
            ],
            'submit' => [
                'title' => $this->l('Save'),
            ],
        ];

        parent::__construct();
    }

    /**
     * Initialize page header toolbar
     *
     * @return void
     *
     * @since 1.0.0
     */
    public function initPageHeaderToolbar()
    {
        if (empty($this->display)) {
            $this->page_header_toolbar_btn['new_order_message'] = [
                'href' => static::$currentIndex.'&addorder_message&token='.$this->token,
                'desc' => $this->l('Add new order message'),
                'icon' => 'process-icon-new',
            ];
        }

        parent::initPageHeaderToolbar();
    }
}
