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
    const CACHE_PATH = _PS_CACHE_DIR_.'modules.json';
    const CHECK_INTERVAL = 86400; // 1 day
    const API_BASE_URL = 'https://api.thirtybees.com/updates/modules/';
    const API_JSON = 'all.json';

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
        $modules = false;
        if (static::checkForUpdates(true)) {
            $modules = json_decode(file_get_contents(static::CACHE_PATH), true);
        }

        if ($modules && $locale) {
            $locale = mb_strtolower($locale, 'utf-8');
            foreach ($modules as &$module) {
                if (isset($module['displayName'][$locale])) {
                    $module['displayName'] = $module['displayName'][$locale];
                } elseif (isset($module['displayName']['en-us'])) {
                    $module['displayName'] = $module['displayName']['en-us'];
                }
                if (isset($module['description'][$locale])) {
                    $module['description'] = $module['description'][$locale];
                } elseif (isset($module['description']['en-us'])) {
                    $module['description'] = $module['description']['en-us'];
                }
            }
        }

        return $modules;
    }

    /**
     * Get info about a single module.
     *
     * @param string $moduleName Name of the module.
     *
     * @return array|bool Info array, or boolean false on error.
     *
     * @version 1.9.3 Moved here from module 'tbupdater',
     *                TbUpdater->getModuleInfo().
     */
    public static function getModuleInfo($moduleName)
    {
        $modules = static::getModulesInfo();
        if ( ! is_array($modules)
            || ! in_array($moduleName, array_keys($modules))
        ) {
            return false;
        }

        return $modules[$moduleName];
    }

    /**
     * Unpack and install a module by name. An eventually previously existing
     * module gets replaced.
     *
     * @param string $moduleName Name of the module.
     *
     * @return bool|string Boolean true on success. Error string on failure.
     *
     * @version 1.9.3 Moved here from module 'tbupdater', inspired by
     *                TbUpdater->installModule().
     */
    public static function installModule($moduleName)
    {
        $success = static::updateModule($moduleName);

        if ($success === true) {
            $module = Module::getInstanceByName($moduleName);
            if ( ! $module) {
                $success = sprintf(
                    'Failed get instance for module %s.',
                    $moduleName
                );
            }
        }

        if ($success === true) {
            $result = $module->install();
            if ( ! $result) {
                $success = sprintf(
                    'Installation procedure of module %s failed.',
                    $moduleName
                );
            }
        }

        return $success;
    }

    /**
     * Update a module by name. An eventually previously existing module gets
     * replaced.
     *
     * @param string $moduleName Name of the module.
     *
     * @return bool|string Boolean true on success. Error string on failure.
     *
     * @version 1.9.3 Moved here from module 'tbupdater', inspired by
     *                TbUpdater->updateModule().
     */
    public static function updateModule($moduleName)
    {
        $success = static::downloadModuleArchive($moduleName);

        if ($success === true) {
            $success = static::unpackModule($moduleName);
        }

        return $success;
    }

    /**
     * Check for module updates and populate ModuleUpdate::CACHE_PATH.
     *
     * This uses Logger::addLog() for error reporting, because this method
     * usually runs in the background, unrelated to the content displayed.
     *
     * @param bool $force Force check.
     *
     * @return bool Success.
     *
     * @version 1.9.3 Moved here from module 'tbupdater', stripped down from
     *                TbUpdater->checkForUpdates().
     */
    public static function checkForUpdates($force = false)
    {
        $lastCheck = (int) Configuration::get('ME_MODULE_UPDATE_LAST_CHECK');

        if ($force
            || $lastCheck < (time() - static::CHECK_INTERVAL)
            || ! file_exists(static::CACHE_PATH)
        ) {
            $guzzle = new \GuzzleHttp\Client([
                'base_uri'  => static::API_BASE_URL,
                'verify'    => _PS_TOOL_DIR_.'cacert.pem',
                'timeout'   => 20,
            ]);
            try {
                $results = $guzzle->get(static::API_JSON)->getBody();
            } catch (Exception $e) {
                Logger::addLog('Error: module updater fetch failed.');

                return false;
            }

            $modules = json_decode($results, true);
            if ( ! $modules || ! is_array($modules)) {
                // Update LAST_CHECK for low server load on failures.
                Configuration::updateGlobalValue(
                    'ME_MODULE_UPDATE_LAST_CHECK',
                    time()
                );
                Logger::addLog('Error: module updater fetched empty JSON.');

                return false;
            }

            $channel = 'stable';
            foreach ($modules as $moduleName => &$module) {
                if ( ! isset($module['versions'][$channel])) {
                    unset($modules[$moduleName]);
                    continue;
                }

                // Find highest compatible version.
                $versions = $module['versions'][$channel];
                $highestVersion = '0.0.0';
                foreach ($versions as $version => $description) {
                    $compat = explode(' ', $description['compatibility']);
                    if (version_compare($version, $highestVersion, '>=')
                        && version_compare(_TB_VERSION_, $compat[1], $compat[0])
                    ) {
                        $highestVersion = $version;
                    }
                }

                if ($highestVersion != '0.0.0') {
                    unset($module['versions']);
                    $module['version'] = $highestVersion;
                    $module['binary'] = $versions[$highestVersion]['binary'];
                } else {
                    unset($modules[$moduleName]);
                }
            }

            // Always update LAST_CHECK for low server load on failures.
            Configuration::updateGlobalValue(
                'ME_MODULE_UPDATE_LAST_CHECK',
                time()
            );

            if (is_array($modules) && $modules) {
                file_put_contents(static::CACHE_PATH, json_encode(
                    $modules,
                    JSON_PRETTY_PRINT + JSON_UNESCAPED_SLASHES
                ));
            } else {
                Logger::addLog(sprintf(
                    'Error: module updater did\'t understand this feed: %s',
                    $results
                ));
            }
        }

        return true;
    }

    /**
     * Download a module by name.
     *
     * @param string $moduleName Name of the module.
     *
     * @return bool|string Boolean true on success. Error string on failure.
     *
     *                     On success, the downloaded module archive is
     *                     located at _PS_MODULE_DIR_.$moduleName.'.zip',
     *                     ready to be used by ModuleUpdater::unpackModule().
     *
     * @version 1.9.3 Moved here from module 'tbupdater', inspired by
     *                TbUpdater->updateModule().
     */
    public static function downloadModuleArchive($moduleName)
    {
        $success = true;
        $zipLocation = _PS_MODULE_DIR_.$moduleName.'.zip';

        $moduleInfo = static::getModuleInfo($moduleName);
        if ( ! $moduleInfo || ! isset($moduleInfo['binary'])) {
            $success = sprintf('Insufficient info for module %s.', $moduleName);
        }

        if ($success === true) {
            @unlink($zipLocation);
            $result = Tools::copy($moduleInfo['binary'], $zipLocation);
            if ( ! $result) {
                $success = sprintf(
                    'Could not download archive for module %s.',
                    $moduleName
                );
                @unlink($zipLocation);
            }
        }

        return $success;
    }

    /**
     * Unpack a module by name. Module archive to extract is expected to
     * already exist at _PS_MODULE_DIR_.$moduleName.'.zip'.
     *
     * An eventually previously existing module gets replaced, which makes this
     * method the appropriate method to update a module.
     *
     * @param string $moduleName Name of the module.
     *
     * @return bool|string Boolean true on success. Error string on failure.
     *
     *                     Also always deletes the module archive.
     *
     * @version 1.9.3 Moved here from module 'tbupdater', inspired by
     *                TbUpdater->updateModule().
     */
    public static function unpackModule($moduleName)
    {
        $success = true;
        $moduleDir = _PS_MODULE_DIR_.$moduleName;
        $zipLocation = $moduleDir.'.zip';
        $tmpDir = $moduleDir.md5(time());

        if ( ! is_readable($zipLocation)) {
            throw new PrestaShopException(
                'Archive for module '.$moduleName.' doesn\'t exist.'
            );
        }

        $result = Tools::ZipExtract($zipLocation, $tmpDir);
        if ( ! $result) {
            $success = sprintf('Archive for module %s invalid.', $moduleName);
        }

        if ($success === true) {
            // A basic check whether it's a real module.
            $testFile = $tmpDir.'/'.$moduleName.'/'.$moduleName.'.php';
            if ( ! is_readable($testFile)) {
                $success = sprintf(
                    'Module in archive for module %s is not a valid module.',
                    $moduleName
                );
            }
        }

        if ($success === true && file_exists($moduleDir)) {
            $result = Tools::deleteDirectory($moduleDir);
            if ( ! $result) {
                $success = sprintf(
                    'Could not remove old module %s.',
                    $moduleName
                );
            }
        }

        if ($success === true) {
            $result = rename($tmpDir.'/'.$moduleName, $moduleDir);
            if ( ! $result) {
                $success = sprintf(
                    'Could not move module %s into its place.',
                    $moduleName
                );
            }
        }

        Tools::deleteDirectory($tmpDir);
        @unlink($zipLocation);

        return $success;
    }
}
