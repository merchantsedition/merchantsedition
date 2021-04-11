<?php
/**
 * Copyright (C) 2021 Merchant's Edition GbR
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
 * @copyright 2021 Merchant's Edition GbR
 * @license   Open Software License (OSL 3.0)
 */

/**
 * Class ModuleUpdateCore
 *
 * @since 1.9.3
 */
class ModuleUpdateCore
{
    /**
     * Get infos about all modules.
     *
     * @param string|null $locale IETF Locale
     *                            If the locale does not exist it will
     *                            fall back onto en-us
     *
     * @return array|bool
     *
     * @version 1.9.3 Moved here from module 'tbupdater',
     *                TbUpdater->getCachedModulesInfo().
     */
    public static function getModulesInfo($locale = null)
    {
        // Temporary dependency, this will go away soon.
        $tbupdater = Module::getInstanceByName('tbupdater');

        $modules = json_decode(@file_get_contents(_PS_CACHE_DIR_.'modules.json'), true);
        if ( ! $modules && Validate::isLoadedObject($tbupdater)) {
            $modules = $tbupdater->checkForUpdates(true);
        }
        if ( ! $modules) {
            return false;
        }

        if ($locale) {
            foreach ($modules as &$module) {
                if (isset($module['displayName'][Tools::strtolower($locale)])) {
                    $module['displayName'] = $module['displayName'][Tools::strtolower($locale)];
                } elseif (isset($module['displayName']['en-us'])) {
                    $module['displayName'] = $module['displayName']['en-us'];
                } else {
                    // Broken feed
                    continue;
                }
                if (isset($module['description'][Tools::strtolower($locale)])) {
                    $module['description'] = $module['description'][Tools::strtolower($locale)];
                } elseif (isset($module['description']['en-us'])) {
                    $module['description'] = $module['description']['en-us'];
                } else {
                    // Broken feed
                    continue;
                }
            }
        }

        return $modules;
    }
}
