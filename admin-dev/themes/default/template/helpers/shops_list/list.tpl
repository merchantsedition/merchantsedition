{**
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
 *}

{strip}
<a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">
    {$current_shop_name} <i class="icon-caret-down"></i>
</a>
<ul class="dropdown-menu">
    <li{if !isset($current_shop_value) || $current_shop_value == ''} class="active"{/if}><a href="{$url|escape:'html':'UTF-8'}">{l s='All shops'}</a></li>
    {foreach key=group_id item=group_data from=$tree}
        {if !isset($multishop_context) || $is_group_context}
            <li class="group{if $current_shop_value == 'g-'|cat:$group_id} active{/if}{if $multishop_context_group == false} disabled{/if}">
                <a href="{$url|escape:'html':'UTF-8'}g-{$group_id}">
                    {l s='%s group' sprintf=[$group_data['name']|escape:'html':'UTF-8']}
                </a>
            </li>
        {else}
            <ul class="group {if $multishop_context_group == false} disabled{/if}">{l s='%s group' sprintf=[$group_data['name']|escape:'html':'UTF-8']}
        {/if}

        {if !isset($multishop_context) || $is_shop_context}
            {foreach key=shop_id item=shop_data from=$group_data['shops']}
                {if ($shop_data['active'])}
                    <li class="shop{if $current_shop_value == 's-'|cat:$shop_id} active{/if}">
                        <a href="{$url|escape:'html':'UTF-8'}s-{$shop_id}">
                            {if $multishop_context_group == false}
                                {$group_data['name']|escape:'html':'UTF-8'|cat:' - ':$shop_data['name']}
                            {else}
                                {$shop_data['name']}
                            {/if}
                        </a>
                    </li>
                {/if}
            {/foreach}
        {/if}

        {if !(!isset($multishop_context) || $is_group_context)}
            </ul>
        {/if}
    {/foreach}
</ul>
{/strip}
