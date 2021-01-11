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

class ModuleTest extends \Codeception\Test\Unit
{
    public function _before()
    {
        parent::setUpBeforeClass();
        Module::updateTranslationsAfterInstall(false);

        // Some modules create a back office menu item (tab), which needs an
        // employee to be defined. Employee with ID 1 is the one created at
        // installation time.
        $employee = new Employee(1);
        Context::getContext()->employee = $employee;
    }

    public function listModulesOnDisk()
    {
        $modules = array();
        foreach (scandir(_PS_MODULE_DIR_) as $entry) {
            if ($entry[0] !== '.') {
                if (file_exists(_PS_MODULE_DIR_.$entry.DIRECTORY_SEPARATOR.$entry.'.php')) {
                    $modules[$entry] = [ $entry ];
                }
            }
        }

        return $modules;
    }

    /**
     * @dataProvider listModulesOnDisk
     * @group slow
     */
    public function testInstallationAndUninstallation($moduleName)
    {
        $module = ModuleCore::getInstanceByName($moduleName);

        if (Module::isInstalled($moduleName)) {
            $this->assertTrue((bool)$module->uninstall(), 'Module uninstall failed : '.$moduleName);
            $this->assertTrue((bool)$module->install(), 'Module install failed : '.$moduleName);
        } else {
            $this->assertTrue((bool)$module->install(), 'Module install failed : '.$moduleName);
            $this->assertTrue((bool)$module->uninstall(), 'Module uninstall failed : '.$moduleName);
        }
    }

    public function testValidModuleNameIsEnabled()
    {
        $this->assertTrue(Module::isEnabled("coreupdater"));
    }

    public function testValidModuleNameGetModuleId() {
        $this->assertTrue(!!Module::getModuleIdByName("coreupdater"));
    }

    public function testBackwardCompatibilityModuleNameIsEnabled()
    {
        $this->assertTrue(Module::isEnabled("CoreUpdater"));
    }

    public function testBackwardCompatibilityModuleNameGetModuleId() {
        $this->assertTrue(!!Module::getModuleIdByName("CoreUpdater"));
    }

    public function testMultipleInstantiation() {
        $this->assertTrue(!!Module::getInstanceByName("coreupdater"));
        $this->assertTrue(!!Module::getInstanceByName("CoreUpdater"));
    }

}
