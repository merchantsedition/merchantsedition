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

{foreach from=$languages item=language}
	{if $languages|count > 1}
		<div class="translatable-field row lang-{$language.id_lang}">
			<div class="col-lg-9">
	{/if}
	{if isset($maxchar) && $maxchar}
				<div class="input-group">
					<span id="{if isset($input_id)}{$input_id}_{$language.id_lang}{else}{$input_name}_{$language.id_lang}{/if}_counter" class="input-group-addon">
						<span class="text-count-down">{$maxchar|intval}</span>
					</span>
	{/if}
					<textarea id="{$input_name}_{$language.id_lang}" name="{$input_name}_{$language.id_lang}" class="{if isset($class)}{$class}{else}textarea-autosize{/if}"{if isset($maxlength) && $maxlength} maxlength="{$maxlength|intval}"{/if}{if isset($maxchar) && $maxchar} data-maxchar="{$maxchar|intval}"{/if}>{if isset($input_value[$language.id_lang])}{$input_value[$language.id_lang]|htmlentitiesUTF8}{/if}</textarea>
					<span class="counter" data-max="{if isset($max)}{$max|intval}{/if}{if isset($maxlength)}{$maxlength|intval}{/if}{if !isset($max) && !isset($maxlength)}none{/if}"></span>
			{if isset($maxchar) && $maxchar}
				</div>
			{/if}
	{if $languages|count > 1}
			</div>
			<div class="col-lg-2">
				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					{$language.iso_code}
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					{foreach from=$languages item=language}
					<li><a href="javascript:tabs_manager.allow_hide_other_languages = false;hideOtherLanguage({$language.id_lang});">{$language.name}</a></li>
					{/foreach}
				</ul>
			</div>
		</div>
	{/if}
{/foreach}
<script type="text/javascript">
	{if isset($maxchar) && $maxchar}
		$(document).ready(function(){
		{foreach from=$languages item=language}
			countDown($("#{$input_name}_{$language.id_lang}"), $("#{$input_name}_{$language.id_lang}_counter"));
		{/foreach}
		});
	{/if}
	$(".textarea-autosize").autosize();
</script>

