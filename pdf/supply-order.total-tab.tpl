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

{l s='Summary:' pdf='true'}<br/>

<table id="total-tab" width="100%">

	<tr class="bold">
		<td class="grey" width="70%">{l s='Total TE' pdf='true'} <br /> {l s='(Before discount)' pdf='true'}</td>
		<td class="white" width="30%">
			{$currency->prefix} {$supply_order->total_te} {$currency->suffix}
		</td>
	</tr>
	<tr class="bold">
		<td class="grey" width="70%">{l s='Order Discount' pdf='true'}</td>
		<td class="white" width="30%">
			{$currency->prefix} {$supply_order->discount_value_te} {$currency->suffix}
		</td>
	</tr>
	<tr class="bold">
		<td class="grey" width="70%">{l s='Total TE' pdf='true'} <br /> {l s='(After discount)' pdf='true'}</td>
		<td class="white" width="30%">
			{$currency->prefix} {$supply_order->total_with_discount_te} {$currency->suffix}
		</td>
	</tr>
	<tr class="bold">
		<td class="grey" width="70%">{l s='Tax value' pdf='true'}</td>
		<td class="white" width="30%">
			{$currency->prefix} {$supply_order->total_tax} {$currency->suffix}
		</td>
	</tr>
	<tr class="bold">
		<td class="grey" width="70%">{l s='Total TI' pdf='true'}</td>
		<td class="white" width="30%">
			{$currency->prefix} {$supply_order->total_ti} {$currency->suffix}
		</td>
	</tr>
	<tr class="bold">
		<td class="grey" width="70%">{l s='Total to pay' pdf='true'}</td>
		<td class="white" width="30%">
			{$currency->prefix} {$supply_order->total_ti} {$currency->suffix}
		</td>
	</tr>

</table>
