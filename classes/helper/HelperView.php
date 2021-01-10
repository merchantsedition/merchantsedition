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
 * Class HelperViewCore
 *
 * @since 1.0.0
 */
class HelperViewCore extends Helper
{
    public $id;
    public $toolbar = true;
    public $table;
    public $token;

    /** @var string|null If not null, a title will be added on that list */
    public $title = null;

    /**
     * HelperViewCore constructor.
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function __construct()
    {
        $this->base_folder = 'helpers/view/';
        $this->base_tpl = 'view.tpl';
        parent::__construct();
    }

    /**
     * @return string
     *
     * @throws Exception
     * @throws SmartyException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function generateView()
    {
        $this->tpl = $this->createTemplate($this->base_tpl);

        $this->tpl->assign(
            [
                'title'          => $this->title,
                'current'        => $this->currentIndex,
                'token'          => $this->token,
                'table'          => $this->table,
                'show_toolbar'   => $this->show_toolbar,
                'toolbar_scroll' => $this->toolbar_scroll,
                'toolbar_btn'    => $this->toolbar_btn,
                'link'           => $this->context->link,
            ]
        );

        return parent::generate();
    }
}
