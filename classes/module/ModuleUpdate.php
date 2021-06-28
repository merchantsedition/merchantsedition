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
    const API_BASE_URL = 'https://api.merchantsedition.com/update/';

    /**
     * List JSONs providing module updates here. Order of entries defines
     * preference, like-named modules coming from JSONs of later entries
     * overwrite these in earlier ones.
     *
     * Supporting only one API server is intentional and a privacy feature.
     * Fetching from multiple servers would leave behind access log traces on
     * each of them.
     */
    const MODULE_LISTS = [
        [
            'name'        => 'PrestaShop',
            'remoteFile'  => 'modules-prestashop.json',
        ],
        [
            'name'        => 'thirty bees',
            'remoteFile'  => 'modules-thirtybees.json',
        ],
        [
            'name'        => 'Merchant\'s Edition',
            'remoteFile'  => 'modules.json',
        ],
    ];

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
        if (static::checkForUpdates()) {
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
     * @return bool|string Boolean true on success, error/warning string on
     *                     failure or partial failure.
     *
     * @version 1.9.3 Moved here from module 'tbupdater', stripped down from
     *                TbUpdater->checkForUpdates().
     */
    public static function checkForUpdates($force = false)
    {
        $error = false;
        $lastCheck = (int) Configuration::get('ME_MODULE_UPDATE_LAST_CHECK');

        if ($force
            || $lastCheck < (time() - static::CHECK_INTERVAL)
            || ! file_exists(static::CACHE_PATH)
        ) {
            $promises = [];
            $allModules = [];

            $guzzle = new \GuzzleHttp\Client([
                'base_uri'  => static::API_BASE_URL,
                'verify'    => _PS_TOOL_DIR_.'cacert.pem',
                'timeout'   => 20,
            ]);
            foreach (static::MODULE_LISTS as $list) {
                $promises[] = $guzzle->getAsync($list['remoteFile']);
            }

            $results = \GuzzleHttp\Promise\Utils::settle($promises)->wait();

            foreach ($results as $index => $result) {
                if ($result['state'] !== 'fulfilled') {
                    // Yes, this overwrites previous errors. Still it should be
                    // sufficient to give a meaningful hint to the merchant.
                    $error =
                        'Module updater failed to fetch list for '
                        .static::MODULE_LISTS[$index]['name']
                        .' modules, got status \''.$result['state'].'\'.';
                    continue;
                }

                $modules = json_decode($result['value']->getBody(), true);
                if ( ! $modules || ! is_array($modules)) {
                    $error =
                        'Module updater fetched empty JSON for '
                        .static::MODULE_LISTS[$index]['name']
                        .' modules.';
                    continue;
                }

                foreach ($modules as $moduleName => $module) {
                    // As the source comes from a Merchant's Edition server,
                    // trust it to be accurate and complete.
                    $versions = $module['versions'];
                    $versionOut = false;
                    foreach ($versions as $version => $description) {
                        $compatibility = $description['compatibility'];
                        if (version_compare(
                                _TB_VERSION_, $compatibility['from'], '>='
                            ) && (
                                ! isset($compatibility['to'])
                                || version_compare(
                                    _TB_VERSION_, $compatibility['to'], '<='
                                )
                            )
                        ) {
                            // Higher versions overwrite lower versions.
                            $versionOut = $version;
                        }
                    }

                    if ($versionOut) {
                        unset($module['versions']);
                        $module['version'] = $versionOut;
                        $module['binary'] = $versions[$versionOut]['binary'];
                        $allModules[$moduleName] = $module;
                    }
                }
            }

            // Always update LAST_CHECK for low server load on failures.
            Configuration::updateGlobalValue(
                'ME_MODULE_UPDATE_LAST_CHECK',
                time()
            );

            if ($allModules) {
                file_put_contents(static::CACHE_PATH, json_encode(
                    $allModules,
                    JSON_PRETTY_PRINT + JSON_UNESCAPED_SLASHES
                ));
            } // else $error should contain a message already.
        }

        if ($error) {
            Logger::addLog($error, 2);
        }

        return $error ? $error : true;
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
