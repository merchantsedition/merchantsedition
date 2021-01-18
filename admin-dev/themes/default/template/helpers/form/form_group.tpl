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

{if count($groups) && isset($groups)}
<div class="row">
	<div class="col-lg-6">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th class="fixed-width-xs">
						<span class="title_box">
							<input type="checkbox" name="checkme" id="checkme" onclick="checkDelBoxes(this.form, 'groupBox[]', this.checked)" />
						</span>
					</th>
					<th class="fixed-width-xs"><span class="title_box">{l s='ID'}</span></th>
					<th>
						<span class="title_box">
							{l s='Group name'}
						</span>
					</th>
				</tr>
			</thead>
			<tbody>
			{foreach $groups as $key => $group}
				<tr>
					<td>
						{assign var=id_checkbox value=groupBox|cat:'_'|cat:$group['id_group']}
						<input type="checkbox" name="groupBox[]" class="groupBox" id="{$id_checkbox}" value="{$group['id_group']}" {if $fields_value[$id_checkbox]}checked="checked"{/if} />
					</td>
					<td>{$group['id_group']}</td>
					<td>
						<label for="{$id_checkbox}">{$group['name']}</label>
					</td>
				</tr>
			{/foreach}
			</tbody>
		</table>
	</div>
</div>
{else}
<p>
	{l s='No group created'}
</p>
{/if}
