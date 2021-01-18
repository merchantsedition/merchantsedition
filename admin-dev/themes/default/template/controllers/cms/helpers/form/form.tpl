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
{/block}
{block name="script"}
	$(document).ready(function() {
		$('#active_on').bind('click', function(){
			toggleDraftWarning(false);
		});
		$('#active_off').bind('click', function(){
			toggleDraftWarning(true);
		});
	});
{/block}

{block name="leadin"}
	<div style="{if $active}display:none{/if}">
		<p class="alert alert-warning">
			{l s='Your CMS page will be saved as a draft'}
		</p>
	</div>
{/block}

{block name="input"}
	{if $input.type == 'select_category'}
		<select name="{$input.name}">
			{$input.options.html}
		</select>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

