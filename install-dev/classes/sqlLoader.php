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
 * Class InstallSqlLoader
 *
 * @since 1.0.0
 */
class InstallSqlLoader
{
    /**
     * @var Db
     */
    protected $db;

    /**
     * @var array List of keywords which will be replaced in queries
     */
    protected $metadata = [];

    /**
     * @var array List of errors during last parsing
     */
    protected $errors = [];

    /**
     * InstallSqlLoader constructor.
     *
     * @param Db|null $db
     *
     * @since 1.0.0
     */
    public function __construct(Db $db = null)
    {
        if (is_null($db)) {
            $db = Db::getInstance();
        }
        $this->db = $db;
    }

    /**
     * Set a list of keywords which will be replaced in queries
     *
     * @param array $data
     *
     * @since 1.0.0
     */
    public function setMetaData(array $data)
    {
        foreach ($data as $k => $v) {
            $this->metadata[$k] = $v;
        }
    }

    /**
     * Parse a SQL file and immediately executes the query
     *
     * @param string $filename
     * @param bool $stopWhenFail
     *
     * @return bool
     * @throws PrestashopInstallerException
     * @throws PrestaShopException
     *
     * @since 1.0.0
     */
    public function parseFile($filename, $stopWhenFail = true)
    {
        if (!file_exists($filename)) {
            throw new PrestashopInstallerException("File $filename not found");
        }

        return $this->parse(file_get_contents($filename), $stopWhenFail);
    }

    /**
     * Parse and execute a list of SQL queries
     *
     * @param string $content
     * @param bool $stopWhenFail
     *
     * @return bool
     * @throws PrestaShopException
     */
    public function parse($content, $stopWhenFail = true)
    {
        $this->errors = [];

        $content = str_replace(array_keys($this->metadata), array_values($this->metadata), $content);
        $queries = preg_split('#;\s*[\r\n]+#', $content);
        foreach ($queries as $query) {
            $query = trim($query);
            if (!$query) {
                continue;
            }

            if (!$this->db->execute($query)) {
                $this->errors[] = [
                    'errno' => $this->db->getNumberError(),
                    'error' => $this->db->getMsgError(),
                    'query' => $query,
                ];

                if ($stopWhenFail) {
                    return false;
                }
            }
        }

        return count($this->errors) ? false : true;
    }

    /**
     * Get list of errors from last parsing
     *
     * @return array
     *
     * @since 1.0.0
     */
    public function getErrors()
    {
        return $this->errors;
    }
}
