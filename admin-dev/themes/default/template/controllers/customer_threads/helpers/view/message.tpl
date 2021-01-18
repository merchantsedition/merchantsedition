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

{if !$message.id_employee}
	{assign var="type" value="customer"}
{else}
	{assign var="type" value="employee"}
{/if}

<div class="message-item{if $initial}-initial-body{/if}">
{if !$initial}
	<div class="message-avatar">
		<div class="avatar-md">
			{if $type == 'customer'}
				<i class="icon-user icon-3x"></i>
			{else}
				{if isset($current_employee->firstname)}<img src="{$message.employee_image}" alt="{$current_employee->firstname|escape:'html':'UTF-8'}" />{/if}
			{/if}
		</div>
	</div>
{/if}
	<div class="message-body">
		{if !$initial}
			<h4 class="message-item-heading">
				<i class="icon-mail-reply text-muted"></i>
					{if $type == 'customer'}
						{$message.customer_name|escape:'html':'UTF-8'}
					{else}
						{$message.employee_name|escape:'html':'UTF-8'}
					{/if}
			</h4>
		{/if}
		<span class="message-date">&nbsp;<i class="icon-calendar"></i> - {dateFormat date=$message.date_add full=0} - <i class="icon-time"></i> {$message.date_add|substr:11:5}</span>
		{if isset($message.file_name)} <span class="message-product">&nbsp;<i class="icon-link"></i> <a href="{$message.file_name|escape:'html':'UTF-8'}" class="_blank">{l s="Attachment"}</a></span>{/if}
		{if isset($message.product_name)} <span class="message-attachment">&nbsp;<i class="icon-book"></i> <a href="{$message.product_link|escape:'html':'UTF-8'}" class="_blank">{l s="Product:"} {$message.product_name|escape:'html':'UTF-8'} </a></span>{/if}
		<p class="message-item-text">{$message.message|escape:'html':'UTF-8'|nl2br}</p>
	</div>
</div>
