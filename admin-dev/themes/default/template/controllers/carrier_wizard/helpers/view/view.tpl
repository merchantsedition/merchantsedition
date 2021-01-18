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
<script>
	var labelNext = '{$labels.next|addslashes}';
	var labelPrevious = '{$labels.previous|addslashes}';
	var	labelFinish = '{$labels.finish|addslashes}';
	var	labelDelete = '{l s='Delete' js=1}';
	var	labelValidate = '{l s='Validate' js=1}';
	var validate_url = '{$validate_url|addslashes}';
	var carrierlist_url = '{$carrierlist_url|addslashes}';
	var nbr_steps = {$wizard_steps.steps|count};
	var enableAllSteps = {if $enableAllSteps|intval == 1}true{else}false{/if};
	var delete_range_confirm = '{l s='Are you sure to delete this range ?' js=1}';
	var currency_sign = '{$currency_sign}';
	var currency_iso_code = '{$currency_iso_code}';
	var PS_WEIGHT_UNIT = '{$PS_WEIGHT_UNIT}';
	var invalid_value = '{l s='One of the entered values is not valid' js=1}';
	var negative_range = '{l s='At least one range is of zero size or negative' js=1}';
	var overlapping_range = '{l s='Gaps or overlappings between ranges' js=1}';
	var select_at_least_one_zone = '{l s='Please select at least one zone' js=1}';
	var multistore_enable = '{$multistore_enable}';
</script>

<div class="row">
	<div class="col-sm-2">
		{$logo_content}
	</div>
	<div class="col-sm-10">
		<div id="carrier_wizard" class="panel swMain">
			<ul class="steps nbr_steps_{$wizard_steps.steps|count}">
			{foreach from=$wizard_steps.steps key=step_nbr item=step}
				<li>
					<a href="#step-{$step_nbr + 1}">
						<span class="stepNumber">{$step_nbr + 1}</span>
						<span class="stepDesc">
							{$step.title}<br />
							{if isset($step.desc)}<small>{$step.desc}</small>{/if}
						</span>
						<span class="chevron"></span>
					</a>
				</li>
			{/foreach}
			</ul>
			{foreach from=$wizard_contents.contents key=step_nbr item=content}
				<div id="step-{$step_nbr + 1}" class="step_container">
					{$content}
				</div>
			{/foreach}
		</div>
	</div>
</div>
{/block}
