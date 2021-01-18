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

<table class="product" width="100%" cellpadding="4" cellspacing="0">
	<tr>
		<th class="header small left" valign="middle">{l s='If the following conditions are not met, we reserve the right to refuse your package and/or refund:' pdf='true'}</th>
	</tr>
	<tr>
		<td class="center small white">
			<ul class="left">
				<li>{l s='Please include this return reference on your return package:' pdf='true'} {$order_return->id}</li>
				<li>{l s='All products must be returned in their original package and condition, unused and without damage.' pdf='true'}</li>
				<li>{l s='Please print out this document and slip it into your package.' pdf='true'}</li>
				<li>{l s='The package should be sent to the following address:' pdf='true'}</li>
			</ul>
			<span style="margin-left: 20px;">{$shop_address}</span>
		</td>
	</tr>
</table>
<br/>
{l s='Upon receiving your package, we will notify you by e-mail. We will then begin processing the refund, if applicable. Let us know if you have any questions' pdf='true'}
