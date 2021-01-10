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

use Defuse\Crypto\Crypto;
use Defuse\Crypto\Key;

/**
 * Class PhpEncryptionCore
 *
 * @since 1.0.0
 */
class PhpEncryptionCore
{
    protected $key;

    /**
     * PhpEncryptionCore constructor.
     *
     * @param string $asciiKey
     *
     * @throws \Defuse\Crypto\Exception\BadFormatException
     * @throws \Defuse\Crypto\Exception\EnvironmentIsBrokenException
     * @since 1.0.0
     */
    public function __construct($asciiKey)
    {
        $this->key = Key::loadFromAsciiSafeString($asciiKey);
    }

    /**
     * @param string $plaintext
     *
     * @return string Ciphertext
     * @throws \Defuse\Crypto\Exception\EnvironmentIsBrokenException
     */
    public function encrypt($plaintext)
    {
        return Crypto::encrypt($plaintext, $this->key);
    }

    /**
     * @param string $ciphertext
     *
     * @return string|null Plaintext
     */
    public function decrypt($ciphertext)
    {
        if (! is_string($ciphertext)) {
            return null;
        }

        try {
            return Crypto::decrypt($ciphertext, $this->key);
        } catch (Exception $exception) {
            return null;
        }
    }
}
