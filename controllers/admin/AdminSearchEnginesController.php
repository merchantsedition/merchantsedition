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
 * Class AdminSearchEnginesControllerCore
 *
 * @since 1.0.0
 */
class AdminSearchEnginesControllerCore extends AdminController
{
    /**
     * AdminSearchEnginesControllerCore constructor.
     *
     * @since 1.0.0
     */
    public function __construct()
    {
        $this->bootstrap = true;
        $this->table = 'search_engine';
        $this->className = 'SearchEngine';
        $this->lang = false;

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
            'id_search_engine' => ['title' => $this->l('ID'), 'width' => 25],
            'server'           => ['title' => $this->l('Server')],
            'getvar'           => ['title' => $this->l('GET variable'), 'width' => 100],
        ];

        $this->fields_form = [
            'legend' => [
                'title' => $this->l('Referrer'),
            ],
            'input'  => [
                [
                    'type'     => 'text',
                    'label'    => $this->l('Server'),
                    'name'     => 'server',
                    'size'     => 20,
                    'required' => true,
                ],
                [
                    'type'     => 'text',
                    'label'    => $this->l('$_GET variable'),
                    'name'     => 'getvar',
                    'size'     => 40,
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
     * @since 1.0.0
     */
    public function initPageHeaderToolbar()
    {
        if (empty($this->display)) {
            $this->page_header_toolbar_btn['new_search_engine'] = [
                'href' => static::$currentIndex.'&addsearch_engine&token='.$this->token,
                'desc' => $this->l('Add new search engine', null, null, false),
                'icon' => 'process-icon-new',
            ];
        }

        $this->identifier_name = 'server';

        parent::initPageHeaderToolbar();
    }
}
