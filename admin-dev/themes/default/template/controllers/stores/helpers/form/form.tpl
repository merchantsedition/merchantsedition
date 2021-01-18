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

{extends file="helpers/form/form.tpl"}

{block name=script}
	$(document).ready(function() {
		$('#latitude, #longitude').keyup(function() {
			$(this).val($(this).val().replace(/,/g, '.'));
		});
	});
{/block}

{block name="input"}
	{if $input.type == 'latitude'}
	<div class="row">
		<div class="col-lg-3">
			<input type="text"
				{if isset($input.size)}size="{$input.size}"{/if}
				{if isset($input.maxlength)}maxlength="{$input.maxlength}"{/if}
				name="latitude"
				id="latitude"
				value="{$fields_value[$input.name]|escape:'html':'UTF-8'}" />
		</div>
		<div class="col-lg-1">
			<div class="form-control-static text-center"> / </div>
		</div>
		<div class="col-lg-3">
			<input type="text"
				{if isset($input.size)}size="{$input.size}"{/if}
				{if isset($input.maxlength)}maxlength="{$input.maxlength}"{/if}
				name="longitude"
				id="longitude"
				value="{$fields_value['longitude']|escape:'html':'UTF-8'}" />
		</div>
	</div>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="other_input"}
	{if $key == 'hours'}
			<div class="form-group">
				<label class="control-label col-lg-3">{l s='Hours:'}</label>
				<div class="col-lg-9"><p class="form-control-static">{l s='e.g. 10:00AM - 9:30PM'}</p></div>
			</div>
			{foreach $fields_value.days as $k => $value}
			<div class="form-group">
				<label class="control-label col-lg-3">{$value}</label>
				<div class="col-lg-9"><input type="text" size="25" name="hours_{$k}" value="{if isset($fields_value.hours[$k-1])}{$fields_value.hours[$k-1]|escape:'html':'UTF-8'}{/if}" /></div>
			</div>
			{/foreach}
	{/if}
{/block}
