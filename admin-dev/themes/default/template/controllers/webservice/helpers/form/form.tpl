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

{block name="input"}
	{if $input.type == 'resources'}
		<div class="alert alert-info">{l s='Set the resource permissions for this key:'}</div>
		<table class="table accesses">
			<thead>
				<tr>
					<th><span class="title_box">{l s='Resource'}</span></th>
					<th class="center fixed-width-xs"><span class="title_box">{l s='All'}</span></th>
					<th class="center fixed-width-xs"><span class="title_box">{l s='View (GET)'}</span></th>
					<th class="center fixed-width-xs"><span class="title_box">{l s='Modify (PUT)'}</span></th>
					<th class="center fixed-width-xs"><span class="title_box">{l s='Add (POST)'}</span></th>
					<th class="center fixed-width-xs"><span class="title_box">{l s='Delete (DELETE)'}</span></th>
					<th class="center fixed-width-xs"><span class="title_box">{l s='Fast view (HEAD)'}</span></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th></th>
					<th></th>
					<th class="center"><input type="checkbox" class="all_get get " /></th>
					<th class="center"><input type="checkbox" class="all_put put " /></th>
					<th class="center"><input type="checkbox" class="all_post post " /></th>
					<th class="center"><input type="checkbox" class="all_delete delete" /></th>
					<th class="center"><input type="checkbox" class="all_head head" /></th>
				</tr>
				{foreach $ressources as $resource_name => $resource}
					<tr>
						<td>{$resource_name}</td>
						<td class="center"><input type="checkbox" class="all"/></td>
						<td class="center"><input type="checkbox" {if isset($ressources[$resource_name]['forbidden_method']) && in_array('GET', $ressources[$resource_name]['forbidden_method'])}disabled="disabled"{/if} class="get" name="resources[{$resource_name}][GET]" {if isset($permissions[$resource_name]) && in_array('GET', $permissions[$resource_name])}checked="checked"{/if} /></td>
						<td class="center"><input type="checkbox" {if isset($ressources[$resource_name]['forbidden_method']) && in_array('PUT', $ressources[$resource_name]['forbidden_method'])}disabled="disabled"{/if} class="put" name="resources[{$resource_name}][PUT]" {if isset($permissions[$resource_name]) && in_array('PUT', $permissions[$resource_name])}checked="checked"{/if}/></td>
						<td class="center"><input type="checkbox" {if isset($ressources[$resource_name]['forbidden_method']) && in_array('POST', $ressources[$resource_name]['forbidden_method'])}disabled="disabled"{/if} class="post" name="resources[{$resource_name}][POST]" {if isset($permissions[$resource_name]) && in_array('POST', $permissions[$resource_name])}checked="checked"{/if}/></td>
						<td class="center"><input type="checkbox" {if isset($ressources[$resource_name]['forbidden_method']) && in_array('DELETE', $ressources[$resource_name]['forbidden_method'])}disabled="disabled"{/if} class="delete" name="resources[{$resource_name}][DELETE]" {if isset($permissions[$resource_name]) && in_array('DELETE', $permissions[$resource_name])}checked="checked"{/if}/></td>
						<td class="center"><input type="checkbox" {if isset($ressources[$resource_name]['forbidden_method']) && in_array('HEAD', $ressources[$resource_name]['forbidden_method'])}disabled="disabled"{/if} class="head" name="resources[{$resource_name}][HEAD]" {if isset($permissions[$resource_name]) && in_array('HEAD', $permissions[$resource_name])}checked="checked"{/if}/></td>
					</tr>
				{/foreach}
			</tbody>
		</table>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="script"}
	$(function() {
		$('table.accesses input.all').click(function() {
			if($(this).is(':checked'))
				$(this).parent().parent().find('input.get:not(:checked), input.put:not(:checked), input.post:not(:checked), input.delete:not(:checked), input.head:not(:checked)').click();
			else
				$(this).parent().parent().find('input.get:checked, input.put:checked, input.post:checked, input.delete:checked, input.head:checked').click();
		});
		$('table.accesses .all_get').click(function() {
			if($(this).is(':checked'))
				$(this).parent().parent().parent().find('input.get:not(:checked)').click();
			else
				$(this).parent().parent().parent().find('input.get:checked').click();
		});
		$('table.accesses .all_put').click(function() {
			if($(this).is(':checked'))
				$(this).parent().parent().parent().find('input.put:not(:checked)').click();
			else
				$(this).parent().parent().parent().find('input.put:checked').click();
		});
		$('table.accesses .all_post').click(function() {
			if($(this).is(':checked'))
				$(this).parent().parent().parent().find('input.post:not(:checked)').click();
			else
				$(this).parent().parent().parent().find('input.post:checked').click();
		});
		$('table.accesses .all_delete').click(function() {
			if($(this).is(':checked'))
				$(this).parent().parent().parent().find('input.delete:not(:checked)').click();
			else
				$(this).parent().parent().parent().find('input.delete:checked').click();
		});
		$('table.accesses .all_head').click(function() {
			if($(this).is(':checked'))
				$(this).parent().parent().parent().find('input.head:not(:checked)').click();
			else
				$(this).parent().parent().parent().find('input.head:checked').click();
		});
	});
{/block}
