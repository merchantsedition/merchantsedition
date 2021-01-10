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
 * Class AbstractLoggerCore
 */
abstract class AbstractLoggerCore
{
    // @codingStandardsIgnoreStart
    public $level;
    protected $level_value = [
        0 => 'DEBUG',
        1 => 'INFO',
        2 => 'WARNING',
        3 => 'ERROR',
    ];
    // @codingStandardsIgnoreEnd

    const DEBUG = 0;
    const INFO = 1;
    const WARNING = 2;
    const ERROR = 3;

    /**
     * AbstractLoggerCore constructor.
     *
     * @param int $level
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function __construct($level = self::INFO)
    {
        if (array_key_exists((int) $level, $this->level_value)) {
            $this->level = $level;
        } else {
            $this->level = static::INFO;
        }
    }

    /**
     * Check the level and log the message if needed
     *
     * @param string $message
     * @param int    $level
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function log($message, $level = self::DEBUG)
    {
        if ($level >= $this->level) {
            $this->logMessage($message, $level);
        }
    }

    /**
    * Log a debug message
    *
    * @param string $message
    *
    * @since 1.0.0
    * @version 1.0.0 Initial version
    */
    public function logDebug($message)
    {
        $this->log($message, static::DEBUG);
    }

    /**
    * Log an info message
    *
    * @param string $message
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
    */
    public function logInfo($message)
    {
        $this->log($message, static::INFO);
    }

    /**
    * Log a warning message
    *
    * @param string $message
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
    */
    public function logWarning($message)
    {
        $this->log($message, static::WARNING);
    }

    /**
    * Log an error message
    *
    * @param string $message
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
    */
    public function logError($message)
    {
        $this->log($message, static::ERROR);
    }

    /**
     * Log the message
     *
     * @param string message
     * @param level
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    abstract protected function logMessage($message, $level);
}
