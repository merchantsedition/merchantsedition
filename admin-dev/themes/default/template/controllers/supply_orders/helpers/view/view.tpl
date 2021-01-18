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

<div class="row">
	<div class="col-lg-6">
		<div class="panel">
			<h3>
				<i class="icon-info"></i>
				{if isset($is_template) && $is_template == 1} {l s='Template'} {/if}{l s='General information'}
			</h3>
			<table class="table">
				<tr>
					<td>{l s='Creation date:'}</td>
					<td>{$supply_order_creation_date}</td>
				</tr>
				<tr>
					<td>{l s='Supplier:'}</td>
					<td>{$supply_order_supplier_name}</td>
				</tr>
				<tr>
					<td>{l s='Last update:'}</td>
					<td>{$supply_order_last_update}</td>
				</tr>
				<tr>
					<td>{l s='Delivery expected:'}</td>
					<td>{$supply_order_expected}</td>
				</tr>
				<tr>
					<td>{l s='Warehouse:'}</td>
					<td>{$supply_order_warehouse}</td>
				</tr>
				<tr>
					<td>{l s='Currency:'}</td>
					<td>{$supply_order_currency->name}</td>
				</tr>
				<tr>
					<td>{l s='Global discount rate:'}</td>
					<td>{$supply_order_discount_rate} %</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="col-lg-6">
		<div class="panel">
			<h3>
				<i class="icon-th-list"></i>
				{if isset($is_template) && $is_template == 1} {l s='Template'} {/if}{l s='Summary'}
			</h3>
			<table class="table">
				<thead>
					<tr>
						<th><span class="title_box">{l s='Designation'}</span></th>
						<th><span class="title_box">{l s='Value'}</span></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>{l s='Total (tax excl.)'}</td>
						<td>{$supply_order_total_te}</td>
					</tr>
					<tr>
						<td>{l s='Discount'}</td>
						<td>{$supply_order_discount_value_te}</td>
					</tr>
					<tr>
						<td>{l s='Total with discount (tax excl.)'}</td>
						<td>{$supply_order_total_with_discount_te}</td>
					</tr>
					<tr>
						<td>{l s='Total Tax'}</td>
						<td>{$supply_order_total_tax}</td>
					</tr>
					<tr>
						<td>{l s='Total (tax incl.)'}</td>
						<td>{$supply_order_total_ti}</td>
					</tr>
					<tr>
						<td>{l s='Total to pay.'}</td>
						<td>{$supply_order_total_ti}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
{$supply_order_detail_content}
{/block}
