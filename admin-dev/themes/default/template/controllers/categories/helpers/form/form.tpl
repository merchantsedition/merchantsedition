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

{extends file="helpers/form/form.tpl"}

{block name="script"}
	var ps_force_friendly_product = false;
{/block}

{block name="input"}
	{if $input.name == "link_rewrite"}
		<script type="text/javascript">
		{if isset($PS_ALLOW_ACCENTED_CHARS_URL) && $PS_ALLOW_ACCENTED_CHARS_URL}
			var PS_ALLOW_ACCENTED_CHARS_URL = 1;
		{else}
			var PS_ALLOW_ACCENTED_CHARS_URL = 0;
		{/if}
		</script>
		{$smarty.block.parent}
	{else}
		{$smarty.block.parent}
	{/if}
	{if in_array($input.name, ['image', 'thumb'])}
		<div class="col-lg-6">
			<div class="help-block">{l s='Recommended dimensions (for the default theme): %1spx x %2spx' sprintf=[$input.format.width, $input.format.height]}
			</div>
		</div>
	{/if}
{/block}
{block name="description"}
	{$smarty.block.parent}
	{if ($input.name == 'groupBox')}
		<div class="alert alert-info">
			<h4>{$input.info_introduction}</h4>
			<p>{$input.unidentified}<br />
			{$input.guest}<br />
			{$input.customer}</p>
		</div>
	{/if}
{/block}
{block name="input_row"}
	{$smarty.block.parent}
	{if ($input.name == 'thumb')}
	{$displayBackOfficeCategory}
	{/if}
{/block}
