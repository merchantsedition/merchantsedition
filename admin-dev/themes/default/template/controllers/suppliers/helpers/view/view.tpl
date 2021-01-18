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
<div class="panel">
	<div class="panel-heading">{$supplier->name} - {l s='Number of products:'} {count($products)}</div>
	<table class="table">
		<thead>
			<tr>
				<th><span class="title_box">{l s='Product name'}</span></th>
				<th><span class="title_box">{l s='Attribute name'}</span></th>
				<th><span class="title_box">{l s='Supplier Reference'}</span></th>
				<th><span class="title_box">{l s='Wholesale price'}</span></th>
				<th><span class="title_box">{l s='Reference'}</span></th>
				<th><span class="title_box">{l s='EAN13'}</span></th>
				<th><span class="title_box">{l s='UPC'}</span></th>
				{if $stock_management && $shopContext != Shop::CONTEXT_ALL}<th class="right"><span class="title_box">{l s='Available Quantity'}</span></th>{/if}
			</tr>
		</thead>
		<tbody>
		{foreach $products AS $product}
			{if !$product->hasAttributes()}
				<tr>
					<td><a class="btn btn-link" href="?tab=AdminProducts&amp;id_product={$product->id}&amp;updateproduct&amp;token={getAdminToken tab='AdminProducts'}">{$product->name}</a></td>
					<td>{l s='N/A'}</td>
					<td>{if empty($product->product_supplier_reference)}{l s='N/A'}{else}{$product->product_supplier_reference}{/if}</td>
					<td>{if empty($product->product_supplier_price_te)}0{else}{$product->product_supplier_price_te}{/if}</td>
					<td>{if empty($product->reference)}{l s='N/A'}{else}{$product->reference}{/if}</td>
					<td>{if empty($product->ean13)}{l s='N/A'}{else}{$product->ean13}{/if}</td>
					<td>{if empty($product->upc)}{l s='N/A'}{else}{$product->upc}{/if}</td>
					{if $stock_management && $shopContext != Shop::CONTEXT_ALL}<td class="right" width="150">{$product->quantity}</td>{/if}
				</tr>
			{else}
				{foreach $product->combination AS $id_product_attribute => $product_attribute}
					<tr {if $id_product_attribute %2}class="alt_row"{/if} >
						<td><a class="btn btn-link" href="?tab=AdminProducts&amp;id_product={$product->id}&amp;updateproduct&amp;token={getAdminToken tab='AdminProducts'}">{$product->name}</a></td>
						<td>{if empty($product_attribute.attributes)}{l s='N/A'}{else}{$product_attribute.attributes}{/if}</td>
						<td>{if empty($product_attribute.product_supplier_reference)}{l s='N/A'}{else}{$product_attribute.product_supplier_reference}{/if}</td>
						<td>{if empty($product_attribute.product_supplier_price_te)}0{else}{$product_attribute.product_supplier_price_te}{/if}</td>
						<td>{if empty($product_attribute.reference)}{l s='N/A'}{else}{$product_attribute.reference}{/if}</td>
						<td>{if empty($product_attribute.ean13)}{l s='N/A'}{else}{$product_attribute.ean13}{/if}</td>
						<td>{if empty($product_attribute.upc)}{l s='N/A'}{else}{$product_attribute.upc}{/if}</td>
						{if $stock_management && $shopContext != Shop::CONTEXT_ALL}<td class="right">{$product_attribute.quantity}</td>{/if}
					</tr>
				{/foreach}
			{/if}
		{/foreach}
		</tbody>
	</table>
</div>
{/block}

