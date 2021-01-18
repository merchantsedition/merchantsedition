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

{extends file="helpers/options/options.tpl"}
{block name="field"}
	{if $field['type'] == 'checkbox_table'}
		{*TODO : overflow*}
		<div class="well margin-form" style="height: 300px; overflow-y: auto;">
			<table class="table" style="border-spacing : 0; border-collapse : collapse;">
				<thead>
					<tr>
						<th><input type="checkbox" name="checkAll" onclick="checkDelBoxes(this.form, 'countries[]', this.checked)" /></th>
						<th>{l s='Name'}</th>
					</tr>
				</thead>
				<tbody>
					{foreach $field['list'] as $country}
						<tr>
							<td><input type="checkbox" name="countries[]" value="{$country[$field['identifier']]}" {if in_array(strtoupper($country['iso_code']), $allowed_countries)}checked="checked"{/if} /></td>
							<td>{$country['name']|escape:'html':'UTF-8'}</td>
						</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="input"}
	{if $field['type'] == 'textarea_newlines'}
		<div class="col-lg-9">
			<textarea name={$key} cols="{$field['cols']}" rows="{$field['rows']}">{$field['value']|replace:';':"\n"|escape:'html':'UTF-8'}</textarea>
		</div>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}
