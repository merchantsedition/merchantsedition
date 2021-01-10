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
 * Class Adapter_ServiceLocator
 */
// @codingStandardsIgnoreStart
class Adapter_ServiceLocator
{
    // @codingStandardsIgnoreEnd

    /**
     * Set a service container Instance
     * @var Core_Foundation_IoC_Container
     */
    protected static $serviceContainer;

    /**
     * @param Core_Foundation_IoC_Container $container
     */
    public static function setServiceContainerInstance(Core_Foundation_IoC_Container $container)
    {
        self::$serviceContainer = $container;
    }

    /**
     * Get a service depending on its given $serviceName
     *
     * @param string $serviceName
     *
     * @return mixed|object
     * @throws Adapter_Exception
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public static function get($serviceName)
    {
        if (empty(self::$serviceContainer) || is_null(self::$serviceContainer)) {
            throw new Adapter_Exception('Service container is not set.');
        }

        return self::$serviceContainer->make($serviceName);
    }
}
