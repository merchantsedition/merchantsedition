<?php
/**
 * Copyright (C) 2021 Merchant's Edition GbR
 * Copyright (C) 2017-2018 thirty bees
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
 * @copyright 2021 Merchant's Edition GbR
 * @copyright 2017-2018 thirty bees
 * @license   Open Software License (OSL 3.0)
 */

class MyAccountAcceptanceCest
{
    public function _before(AcceptanceTester $I)
    {
        $I->resizeWindow(1920, 1080);
    }

    public function _after(AcceptanceTester $I)
    {
    }

    public function createAccountFormIsVisible(AcceptanceTester $I)
    {
        $I->amOnPage('/index.php');
        $I->click(['css' => '.login']);
        $I->seeElement(['css' => '#create-account_form']);
        $I->withoutErrors();
    }
}
