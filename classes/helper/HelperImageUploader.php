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
 * Class HelperImageUploaderCore
 *
 * @since 1.0.0
 */
class HelperImageUploaderCore extends HelperUploader
{
    /**
     * @return int
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getMaxSize()
    {
        return (int) Tools::getMaxUploadSize();
    }

    /**
     * @return string
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function getSavePath()
    {
        return $this->_normalizeDirectory(_PS_TMP_IMG_DIR_);
    }

    /**
     * @param null $fileName
     *
     * @return string
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    public function getFilePath($fileName = null)
    {
        //Force file path
        return tempnam($this->getSavePath(), $this->getUniqueFileName());
    }

    /**
     * @param $file
     *
     * @return bool
     *
     * @since 1.0.0
     * @version 1.0.0 Initial version
     */
    protected function validate(&$file)
    {
        $file['error'] = $this->checkUploadError($file['error']);

        if ($file['error']) {
            return false;
        }

        $postMaxSize = Tools::convertBytes(ini_get('post_max_size'));

        $uploadMaxFilesize = Tools::convertBytes(ini_get('upload_max_filesize'));

        if ($postMaxSize && ($this->_getServerVars('CONTENT_LENGTH') > $postMaxSize)) {
            $file['error'] = Tools::displayError('The uploaded file exceeds the post_max_size directive in php.ini');

            return false;
        }

        if ($uploadMaxFilesize && ($this->_getServerVars('CONTENT_LENGTH') > $uploadMaxFilesize)) {
            $file['error'] = Tools::displayError('The uploaded file exceeds the upload_max_filesize directive in php.ini');

            return false;
        }

        if ($error = ImageManager::validateUpload($file, Tools::getMaxUploadSize($this->getMaxSize()), $this->getAcceptTypes())) {
            $file['error'] = $error;

            return false;
        }

        if ($file['size'] > $this->getMaxSize()) {
            $file['error'] = sprintf(Tools::displayError('File (size : %1s) is too big (max : %2s)'), $file['size'], $this->getMaxSize());

            return false;
        }

        return true;
    }
}
