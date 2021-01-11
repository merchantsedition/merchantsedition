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

class InstallSimplexmlElement extends SimpleXMLElement
{
    /**
     * Can add SimpleXMLElement values in XML tree
     *
     * @see SimpleXMLElement::addChild()
     *
     * @param string $name
     * @param null   $value
     * @param null   $namespace
     *
     * @return SimpleXMLElement
     */
    public function addChild($name, $value = null, $namespace = null)
    {
        if ($value instanceof SimplexmlElement) {
            $content = trim((string) $value);
            if (strlen($content) > 0) {
                $newElement = parent::addChild($name, str_replace('&', '&amp;', $content), $namespace);
            } else {
                $newElement = parent::addChild($name);
                foreach ($value->attributes() as $k => $v) {
                    $newElement->addAttribute($k, $v);
                }
            }

            foreach ($value->children() as $child) {
                $newElement->addChild($child->getName(), $child);
            }

            return $newElement;
        } else {
            return parent::addChild($name, str_replace('&', '&amp;', $value), $namespace);
        }
    }

    /**
     * Generate nice and sweet XML
     *
     * @see   SimpleXMLElement::asXML()
     *
     * @since 1.0.0
     *
     * @param null $filename
     *
     * @return bool|mixed|string
     */
    public function asXML($filename = null)
    {
        $dom = new DOMDocument('1.0');
        $dom->preserveWhiteSpace = false;
        $dom->formatOutput = true;
        $dom->loadXML(parent::asXML());

        if ($filename) {
            return (bool) file_put_contents($filename, $dom->saveXML());
        }

        return $dom->saveXML();
    }
}
