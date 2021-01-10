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
 * Class WebserviceExceptionCore
 *
 * @since 1.0.0
 */
class WebserviceExceptionCore extends Exception
{
    // @codingStandardsIgnoreStart
    protected $status;
    protected $wrong_value;
    protected $available_values;
    protected $type;

    const SIMPLE = 0;
    const DID_YOU_MEAN = 1;
    // @codingStandardsIgnoreEnd

    /**
     * WebserviceExceptionCore constructor.
     *
     * @param string $message
     * @param int|int[] $code
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function __construct($message, $code)
    {
        $exceptionCode = $code;
        if (is_array($code)) {
            $exceptionCode = $code[0];
            $this->setStatus($code[1]);
        }
        parent::__construct($message, $exceptionCode);
        $this->type = static::SIMPLE;
    }

    /**
     * @return int
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * @param $type
     *
     * @return $this
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function setType($type)
    {
        $this->type = $type;

        return $this;
    }

    /**
     * @param $status
     *
     * @return $this
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function setStatus($status)
    {
        if (Validate::isInt($status)) {
            $this->status = $status;
        }

        return $this;
    }

    /**
     * @return mixed
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * @return mixed
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getWrongValue()
    {
        return $this->wrong_value;
    }

    /**
     * @param $wrongValue
     * @param $availableValues
     *
     * @return $this
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function setDidYouMean($wrongValue, $availableValues)
    {
        $this->type = static::DID_YOU_MEAN;
        $this->wrong_value = $wrongValue;
        $this->available_values = $availableValues;

        return $this;
    }

    /**
     * @return mixed
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getAvailableValues()
    {
        return $this->available_values;
    }
}
