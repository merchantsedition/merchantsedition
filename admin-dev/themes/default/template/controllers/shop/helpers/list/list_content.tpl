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

{extends file="helpers/list/list_content.tpl"}

{block name="open_td"}
	{if $key == 'url'}
		<td{if isset($params.position)} id="td_{if !empty($position_group_identifier)}{$position_group_identifier}{else}0{/if}_{$tr.$identifier}{if $smarty.capture.tr_count > 1}_{($smarty.capture.tr_count - 1)|intval}{/if}"{/if} class="{if !$no_link}pointer{/if}{if isset($params.class)} {$params.class}{/if}{if isset($params.align)} {$params.align}{/if}">
	{else}
		<td class="pointer" onclick="document.location = '{$current_index|escape:'html':'UTF-8'}&amp;shop_id={$tr.$identifier|escape:'html':'UTF-8'}{if $view}&amp;view{else}&amp;update{/if}{$table|escape:'html':'UTF-8'}&amp;token={$token|escape:'html':'UTF-8'}'">
	{/if}
{/block}

{block name="td_content"}
	{if $key == 'url'}
		{if isset($tr.$key)}
			<a href="{$tr.$key}" onmouseover="$(this).css('text-decoration', 'underline')" onmouseout="$(this).css('text-decoration', 'none')" class="_blank">{$tr.$key}</a>
		{else}
			<a href="{$link->getAdminLink('AdminShopUrl')|escape:'html':'UTF-8'}&amp;shop_id={$tr.$identifier|intval}&amp;addshop_url" class="multishop_warning">{l s='Click here to set a URL for this shop.'}</a>
		{/if}
	{else}
		{$smarty.block.parent}
	{/if}
{/block}
