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
 * Simple class to output CSV data
 * Uses CollectionCore
 *
 * @since 1.0.0
 */
class CSVCore
{
    // @codingStandardsIgnoreStart
    public $filename;
    public $collection;
    public $delimiter;
    // @codingStandardsIgnoreEnd

    /**
    * Loads objects, filename and optionnaly a delimiter.
    * @param array|Iterator $collection Collection of objects / arrays (of non-objects)
    * @param string $filename : used later to save the file
    * @param string $delimiter Optional : delimiter used
    */
    public function __construct($collection, $filename, $delimiter = ';')
    {
        $this->filename = $filename;
        $this->delimiter = $delimiter;
        $this->collection = $collection;
    }

    /**
     * Main function
     * Adds headers
     * Outputs
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function export()
    {
        $this->headers();

        $headerLine = false;

        foreach ($this->collection as $object) {
            $vars = get_object_vars($object);
            if (!$headerLine) {
                $this->output(array_keys($vars));
                $headerLine = true;
            }

            // outputs values
            $this->output($vars);
            unset($vars);
        }
    }

    /**
     * Wraps data and echoes
     * Uses defined delimiter
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function output($data)
    {
        $wrappedData = array_map(['CSVCore', 'wrap'], $data);
        echo sprintf("%s\n", implode($this->delimiter, $wrappedData));
    }

    /**
     * Escapes data
     * @param string $data
     * @return string $data
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public static function wrap($data)
    {
        $data = str_replace(['"', ';'], '', $data);

        return sprintf('"%s"', $data);
    }

    /**
    * Adds headers
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
    */
    public function headers()
    {
        header('Content-type: text/csv');
        header('Content-Type: application/force-download; charset=UTF-8');
        header('Cache-Control: no-store, no-cache');
        header('Content-disposition: attachment; filename="'.$this->filename.'.csv"');
    }
}
