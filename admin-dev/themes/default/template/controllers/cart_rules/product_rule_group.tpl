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

<tr id="product_rule_group_{$product_rule_group_id|intval}_tr">
	<td>
		<a class="btn btn-default" href="javascript:removeProductRuleGroup({$product_rule_group_id|intval});">
			<i class="icon-remove text-danger"></i>
		</a>
	</td>
	<td>


		<div class="form-group">
			<label class="control-label col-lg-4">{l s='The cart must contain at least'}</label>
			<div class="col-lg-1">
				<input type="hidden" name="product_rule_group[]" value="{$product_rule_group_id|intval}" />
				<input class="form-control" type="text" name="product_rule_group_{$product_rule_group_id|intval}_quantity" value="{$product_rule_group_quantity|intval}" />
			</div>
			<div class="col-lg-7">
				<label  class="control-label pull-left">{l s='product(s) matching the following rules:'}</label>
			</div>
		</div>



		<div class="form-group">

			<label class="control-label col-lg-4">{l s='Add a rule concerning'}</label>
			<div class="col-lg-4">
				<select class="form-control" id="product_rule_type_{$product_rule_group_id|intval}">
					<option value="">{l s='-- Choose --'}</option>
					<option value="products">{l s='Products'}</option>
					<option value="attributes">{l s='Attributes'}</option>
					<option value="categories">{l s='Categories'}</option>
					<option value="manufacturers">{l s='Manufacturers'}</option>
					<option value="suppliers">{l s='Suppliers'}</option>
				</select>
			</div>
			<div class="col-lg-4">
				<a class="btn btn-default" href="javascript:addProductRule({$product_rule_group_id|intval});">
					<i class="icon-plus-sign"></i>
					{l s="Add"}
				</a>
			</div>

		</div>

		{l s='The product(s) are matching one of these:'}
		<table id="product_rule_table_{$product_rule_group_id|intval}" class="table table-bordered">
			{if isset($product_rules) && $product_rules|@count}
				{foreach from=$product_rules item='product_rule'}
					{$product_rule}
				{/foreach}
			{/if}
		</table>

	</td>
</tr>
