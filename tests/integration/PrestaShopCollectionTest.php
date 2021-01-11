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

class PrestaShopCollectionTest extends \Codeception\Test\Unit
{

    /**
     * This tests verifies that all defined associations can be queried
     *
     * @dataProvider getAssociations
     * @throws PrestaShopException
     */
    public function testAssociations($class, $association, $assocDef)
    {
        $col = new PrestaShopCollection($class);
        $targetClass = (isset($assocDef['object'])) ? $assocDef['object'] : Tools::toCamelCase($association, true);
        $targetDefinition = ObjectModel::getDefinition($targetClass);
        $col->where($association . '.' .$targetDefinition['primary'], '=', '');
        $col->getAll();
    }

    /**
     * @return array
     * @throws ReflectionException
     */
    public function getAssociations()
    {
        $directory = new RecursiveDirectoryIterator(_PS_ROOT_DIR_ . DIRECTORY_SEPARATOR . 'classes');
        $iterator = new RecursiveIteratorIterator($directory);
        $ret = [];
        foreach ($iterator as $path) {
            $file = basename($path);
            if (preg_match("/^.+\.php$/i", $file)) {
                $className = str_replace(".php", "", $file);
                if ($className !== "index") {
                    if (! class_exists($className)) {
                        require_once($path);
                    }
                    if (class_exists($className)) {
                        $reflection = new ReflectionClass($className);
                        if ($reflection->isSubclassOf('ObjectModelCore') && !$reflection->isAbstract()) {
                            $definition = ObjectModel::getDefinition($className);
                            if ($definition && isset($definition['associations'])) {
                                foreach ($definition['associations'] as $key => $assoc) {
                                   if ($key !== PrestaShopCollection::LANG_ALIAS)  {
                                       $ret[$className.':'.$key] = [$className, $key, $assoc];
                                   }
                                }
                            }
                        }
                    }
                }
            }
        }
        return $ret;
    }
}
