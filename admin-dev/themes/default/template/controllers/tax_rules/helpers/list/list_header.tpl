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

{hook h='displayAdminListBefore'}
{if isset($name_controller)}
	{capture name=hookName assign=hookName}display{$name_controller|ucfirst}ListBefore{/capture}
	{hook h=$hookName}
{elseif isset($smarty.get.controller)}
	{capture name=hookName assign=hookName}display{$smarty.get.controller|ucfirst|htmlentities}ListBefore{/capture}
	{hook h=$hookName}
{/if}

<form method="post" action="{$currentIndex|escape:'html':'UTF-8'}&amp;{$identifier}&amp;token={$token|escape:'html':'UTF-8'}&amp;id_tax_rules_group={$id_tax_rules_group}&amp;updatetax_rules_group#{$table}" class="form">
	<div class="panel">
		<input type="hidden" id="submitFilter{$list_id}" name="submitFilter{$list_id}" value="0"/>
		<div class="table-responsive clearfix">
			<table{if $table_id} id="table-{$table_id}"{/if} class="table{if $table_dnd} tableDnD{/if} {$list_id}">
				{if $bulk_actions && $has_bulk_actions}
				<col style="width: 10px;" />
				{/if}
				{foreach $fields_display AS $key => $params}
					<col{if isset($params.width) && $params.width != 'auto'} width="{$params.width}px"{/if}/>
				{/foreach}
				{if $shop_link_type}
					<col style="width: 80px;"/>
				{/if}
				{if $has_actions}
					<col style="width: 52px;" />
				{/if}
				<thead>
					<tr class="nodrag nodrop">
						{if $bulk_actions && $has_bulk_actions}
							<th class="center"></th>
						{/if}
						{foreach $fields_display AS $key => $params}
							<th{if isset($params.align)} align="{$params.align}"{/if}{if isset($params.class)} class="{$params.class}"{/if}>
								{if isset($params.hint)}<span class="hint" name="help_box">{$params.hint}<span class="hint-pointer">&nbsp;</span></span>{/if}
								<span class="title_box">
									{$params.title}
								</span>
							</th>
						{/foreach}
						{if $shop_link_type}
							<th>
								{if $shop_link_type == 'shop'}
									{l s='Shop'}
								{else}
									{l s='Shop group'}
								{/if}
							</th>
						{/if}
						{if $has_actions && $filters_has_value}
							<th class="actions text-right"><button type="submit" name="submitReset{$list_id}" class="btn btn-warning">
									<i class="icon-eraser"></i> {l s='Reset'}
								</button>
							</th>
						{else}
							<th class="actions text-right"></th>
						{/if}
					</tr>
				</thead>
