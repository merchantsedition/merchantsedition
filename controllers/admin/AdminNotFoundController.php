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
 * Class AdminNotFoundControllerCore
 *
 * @since 1.0.0
 */
class AdminNotFoundControllerCore extends AdminController
{
    /**
     * AdminNotFoundControllerCore constructor.
     *
     * @since 1.0.0
     */
    public function __construct()
    {
        $this->bootstrap = true;

        parent::__construct();
    }

    /**
     * Check accesss
     *
     * Always returns true to make it always available
     *
     * @return true
     *
     * @since 1.0.0
     */
    public function checkAccess()
    {
        return true;
    }

    /**
     * Has view access
     *
     * Always returns true to make it always available
     *
     * @param bool $disable
     *
     * @return true
     */
    public function viewAccess($disable = false)
    {
        return true;
    }

    /**
     * Initialize content
     *
     * @return void
     *
     * @since 1.0.0
     */
    public function initContent()
    {
        $this->errors[] = Tools::displayError('Controller not found');
        $tplVars['controller'] = Tools::getvalue('controllerUri', Tools::getvalue('controller'));
        $this->context->smarty->assign($tplVars);

        parent::initContent();
    }
}
