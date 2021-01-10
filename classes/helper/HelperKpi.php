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
 * Class HelperKpiCore
 *
 * @since 1.0.0
 */
class HelperKpiCore extends Helper
{
    // @codingStandardsIgnoreStart
    /** @var string $base_folder */
    public $base_folder = 'helpers/kpi/';
    /** @var string $base_tpl */
    public $base_tpl = 'kpi.tpl';
    /** @var int $id */
    public $id;
    public $icon;
    public $chart;
    public $color;
    public $title;
    public $subtitle;
    public $value;
    public $data;
    public $source;
    public $refresh = true;
    public $href;
    public $tooltip;
    // @codingStandardsIgnoreEnd

    /**
     * @return mixed
     *
     * @throws Exception
     * @throws SmartyException
     * @since   1.0.0
     * @version 1.0.0 Initial version
     */
    public function generate()
    {
        $this->tpl = $this->createTemplate($this->base_tpl);

        $this->tpl->assign(
            [
                'id'       => $this->id,
                'icon'     => $this->icon,
                'chart'    => (bool) $this->chart,
                'color'    => $this->color,
                'title'    => $this->title,
                'subtitle' => $this->subtitle,
                'value'    => $this->value,
                'data'     => $this->data,
                'source'   => $this->source,
                'refresh'  => $this->refresh,
                'href'     => $this->href,
                'tooltip'  => $this->tooltip,
            ]
        );

        return $this->tpl->fetch();
    }
}
