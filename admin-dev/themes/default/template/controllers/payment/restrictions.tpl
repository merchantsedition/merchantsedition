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

<form action="{$url_submit|escape:'html':'UTF-8'}" method="post" id="form_{$list['name_id']}" class="form-horizontal">
	<div class="panel">
		<h3>
			<i class="{$list['icon']}"></i>
			{$list['title']}
		</h3>
		<p class="help-block">{$list['desc']}</p>
		<div class="row table-responsive clearfix ">
			<div class="overflow-y">
				<table class="table">
					<thead>
						<tr>
							<th style="width:40%"><span class="title_box">{$list['title']}</span></th>
							{foreach $payment_modules as $module}
								{if $module->active}
									<th class="text-center">
										{if $list['name_id'] != 'currency' || $module->currencies_mode == 'checkbox'}
											<input type="hidden" id="checkedBox_{$list['name_id']}_{$module->name}" value="checked"/>
											<a href="javascript:checkPaymentBoxes('{$list['name_id']}', '{$module->name}')">
										{/if}
										{$module->displayName}
										{if $list['name_id'] != 'currency' || $module->currencies_mode == 'checkbox'}
											</a>
										{/if}
									</th>
								{/if}
							{/foreach}
						</tr>
					</thead>
					<tbody>
					{foreach $list['items'] as $item}
						<tr>
							<td>
								<span>{$item['name']}</span>
							</td>
							{foreach $payment_modules as $key_module => $module}
								{if $module->active}
									<td class="text-center">
										{assign var='type' value='null'}
										{if !$item['check_list'][$key_module]}
											{* Keep $type to null *}
										{elseif $list['name_id'] === 'currency'}
											{if $module->currencies && $module->currencies_mode == 'checkbox'}
												{$type = 'checkbox'}
											{elseif $module->currencies && $module->currencies_mode == 'radio'}
												{$type = 'radio'}
											{/if}
										{else}
											{$type = 'checkbox'}
										{/if}
										{if $type != 'null'}
											<input type="{$type}" name="{$module->name}_{$list['name_id']}[]" value="{$item[$list['identifier']]}" {if $item['check_list'][$key_module] == 'checked'}checked="checked"{/if}/>
										{else}
											<input type="hidden" name="{$module->name}_{$list['name_id']}[]" value="{$item[$list['identifier']]}"/>--
										{/if}
									</td>
								{/if}
							{/foreach}
						</tr>
					{/foreach}
					{if $list['name_id'] === 'currency'}
						<tr>
							<td>
								<span>{l s='Customer currency'}</span>
							</td>
							{foreach $payment_modules as $module}
								{if $module->active}
									<td class="text-center">
										{if $module->currencies && $module->currencies_mode == 'radio'}
											<input type="radio" name="{$module->name}_{$list['name_id']}[]" value="-1"{if in_array(-1, $module->$list['name_id'])} checked="checked"
										{/if} />
										{else}
											--
										{/if}
									</td>
								{/if}
							{/foreach}
						</tr>
						<tr>
							<td>
								<span>{l s='Shop default currency'}</span>
							</td>
							{foreach $payment_modules as $module}
								{if $module->active}
									<td class="text-center">
										{if $module->currencies && $module->currencies_mode == 'radio'}
											<input type="radio" name="{$module->name}_{$list['name_id']}[]" value="-2"{if in_array(-2, $module->$list['name_id'])} checked="checked"
										{/if}
											/>
										{else}
											--
										{/if}
									</td>
								{/if}
							{/foreach}
						</tr>
					{/if}
					</tbody>
				</table>
			</div>
		</div>
		<div class="panel-footer">
			<button type="submit" class="btn btn-default pull-right" name="submitModule{$list['name_id']}">
				<i class="process-icon-save"></i> {l s='Save restrictions'}
			</button>
		</div>
	</div>
</form>
