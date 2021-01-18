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

<div class="col-lg-12 bootstrap">
	<div class="col-lg-6">
		{l s='Unselected'}
		<select multiple size="10" id="product_rule_select_{$product_rule_group_id|intval}_{$product_rule_id|intval}_1">
			{foreach from=$product_rule_itemlist.unselected item='item'}
				<option value="{$item.id|intval}" title="{$item.name}">&nbsp;{$item.name}</option>
			{/foreach}
		</select>
		<div class="clearfix">&nbsp;</div>
		<a id="product_rule_select_{$product_rule_group_id|intval}_{$product_rule_id|intval}_add" class="btn btn-default btn-block" >
			{l s='Add'}
			<i class="icon-arrow-right"></i>
		</a>
	</div>
	<div class="col-lg-6">
		{l s='Selected'}
		<select multiple size="10" name="product_rule_select_{$product_rule_group_id|intval}_{$product_rule_id|intval}[]" id="product_rule_select_{$product_rule_group_id|intval}_{$product_rule_id|intval}_2" class="product_rule_toselect" >
			{foreach from=$product_rule_itemlist.selected item='item'}
				<option value="{$item.id|intval}" title="{$item.name}">&nbsp;{$item.name}</option>
			{/foreach}
		</select>
		<div class="clearfix">&nbsp;</div>
		<a id="product_rule_select_{$product_rule_group_id}_{$product_rule_id}_remove" class="btn btn-default btn-block" >
			<i class="icon-arrow-left"></i>
			{l s='Remove'}
		</a>
	</div>
</div>

<script type="text/javascript">
	$('#product_rule_select_{$product_rule_group_id|intval}_{$product_rule_id|intval}_remove').click(function() { removeCartRuleOption(this); updateProductRuleShortDescription(this); });
	$('#product_rule_select_{$product_rule_group_id|intval}_{$product_rule_id|intval}_add').click(function() { addCartRuleOption(this); updateProductRuleShortDescription(this); });
	$(document).ready(function() { updateProductRuleShortDescription($('#product_rule_select_{$product_rule_group_id|intval}_{$product_rule_id|intval}_add')); });
</script>
