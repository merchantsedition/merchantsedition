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
 * Class WebserviceSpecificManagementSearchCore
 *
 * @since 1.0.0
 */
class WebserviceSpecificManagementSearchCore implements WebserviceSpecificManagementInterface
{
    /** @var WebserviceOutputBuilder */
    protected $objOutput;
    protected $output;

    /** @var WebserviceRequest */
    protected $wsObject;

    /* ------------------------------------------------
     * GETTERS & SETTERS
     * ------------------------------------------------ */

    /**
     * @param WebserviceOutputBuilderCore $obj
     *
     * @return WebserviceSpecificManagementInterface
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function setObjectOutput(WebserviceOutputBuilderCore $obj)
    {
        $this->objOutput = $obj;

        return $this;
    }

    /**
     * @param WebserviceRequestCore $obj
     *
     * @return $this
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function setWsObject(WebserviceRequestCore $obj)
    {
        $this->wsObject = $obj;

        return $this;
    }

    /**
     * @return WebserviceRequest
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getWsObject()
    {
        return $this->wsObject;
    }

    /**
     * @return WebserviceOutputBuilder
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getObjectOutput()
    {
        return $this->objOutput;
    }

    /**
     * @param $segments
     *
     * @return $this
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function setUrlSegment($segments)
    {
        $this->urlSegment = $segments;

        return $this;
    }

    /**
     * @return mixed
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getUrlSegment()
    {
        return $this->urlSegment;
    }

    /**
     * Management of search
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function manage()
    {
        if (!isset($this->wsObject->urlFragments['query']) || !isset($this->wsObject->urlFragments['language'])) {
            throw new WebserviceException('You have to set both the \'language\' and \'query\' parameters to get a result', [100, 400]);
        }
        $objectsProducts = [];
        $objectsCategories = [];
        $objectsProducts['empty'] = new Product();
        $objectsCategories['empty'] = new Category();

        $this->_resourceConfiguration = $objectsProducts['empty']->getWebserviceParameters();

        if (!$this->wsObject->setFieldsToDisplay()) {
            return false;
        }

        $results = Search::find($this->wsObject->urlFragments['language'], $this->wsObject->urlFragments['query'], 1, 1, 'position', 'desc', true, false);
        $categories = [];
        foreach ($results as $result) {
            $current = new Product($result['id_product']);
            $objectsProducts[] = $current;
            $categoriesResult = $current->getWsCategories();
            foreach ($categoriesResult as $category_result) {
                foreach ($category_result as $id) {
                    $categories[] = $id;
                }
            }
        }
        $categories = array_unique($categories);
        foreach ($categories as $id) {
            $objectsCategories[] = new Category($id);
        }

        $this->output .= $this->objOutput->getContent($objectsProducts, null, $this->wsObject->fieldsToDisplay, $this->wsObject->depth, WebserviceOutputBuilder::VIEW_LIST, false);
        // @todo allow fields of type category and product
        // $this->_resourceConfiguration = $objects_categories['empty']->getWebserviceParameters();
        // if (!$this->setFieldsToDisplay())
        // return false;

        $this->output .= $this->objOutput->getContent($objectsCategories, null, $this->wsObject->fieldsToDisplay, $this->wsObject->depth, WebserviceOutputBuilder::VIEW_LIST, false);
    }

    /**
     * This must be return a string with specific values as WebserviceRequest expects.
     *
     * @return string
     *
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function getContent()
    {
        return $this->objOutput->getObjectRender()->overrideContent($this->output);
    }
}
