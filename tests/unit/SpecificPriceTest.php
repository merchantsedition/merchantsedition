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

use AspectMock\Test as test;

class SpecificPriceTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    protected function _before()
    {
    }

    protected function _after()
    {
        \AspectMock\Test::clean();
    }

    public function testScoreQuery()
    {
        // Mock the static function SpecificPrice::getPriority
        test::double(
            'SpecificPrice',
            [
                'getPriority' => [
                    'id_customer',
                    'id_shop',
                    'id_currency',
                    'id_country',
                    'id_group',
                ],
            ]
        );

        // Call protected static function SpecificPrice::_getScoreQuery
        $this->assertEquals(
            '( IF (`id_group` = 1, 2, 0) +  IF (`id_country` = 1, 4, 0) +  IF (`id_currency` = 1, 8, 0) +  IF (`id_shop` = 1, 16, 0) +  IF (`id_customer` = 1, 32, 0)) AS `score`',
            $this->tester->invokeStaticMethod('SpecificPrice', '_getScoreQuery', [1, 1, 1, 1, 1, 1])
        );
    }
}
