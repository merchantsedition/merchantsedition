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

{extends file="helpers/view/view.tpl"}
{block name="override_tpl"}
	{if !$shop_context}
		<div class="alert alert-warning">{l s='You have more than one shop and must select one to configure payment.'}</div>
	{else}
		{if isset($modules_list)}
			{$modules_list}
		{/if}
		<div class="alert alert-info">
			{l s='This is where you decide what payment modules are available for different variations like your customers\' currency, group, and country.'}
			<br />
			{l s='A check mark indicates you want the payment module available.'}
			{l s='If it is not checked then this means that the payment module is disabled.'}
			<br />
			{l s='Please make sure to click Save for each section.'}
		</div>
		{if $display_restrictions}
			{foreach $lists as $list}
				{include file='controllers/payment/restrictions.tpl'}
			{/foreach}
		{else}
			<div class="alert alert-warning">{l s='No payment module installed'}</div>
		{/if}
	{/if}
{/block}
