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
 * Class PrestaShopDatabaseExceptionCore
 *
 * @since 1.0.0
 */
class PrestaShopDatabaseExceptionCore extends PrestaShopException
{
    /**
     * @var string|null contains sql statement associated with error
     */
    private $sql = null;

    public function __construct($message = '', $sql = null)
    {
        parent::__construct($message);

        if ($sql instanceof DbQuery) {
            $this->sql = $sql->build();
        } else {
            $this->sql = $sql;
        }

        if ($this->trace) {
            // we want to report on different
            foreach ($this->trace as $row) {
                if (strpos($row['file'], 'classes/db/Db.php') === false) {
                    array_unshift($this->trace, [
                        'file' => $this->file,
                        'line' => $this->line,
                    ]);
                    $this->file = $row['file'];
                    $this->line = $row['line'];
                    return;
                }
            }
        }
    }

    /**
     * @return mixed
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function __toString()
    {
        return $this->message;
    }

    /**
     * Display additional SQL section on error message page
     *
     * @return array describing sections
     */
    protected function getExtraSections()
    {
        $sections = [];
        if ($this->sql) {
          $sections [] = [
              'label' => 'SQL',
              'content' => '<pre>' . $this->sql . '</pre>'
          ]   ;
        }
        return $sections;

    }
}
