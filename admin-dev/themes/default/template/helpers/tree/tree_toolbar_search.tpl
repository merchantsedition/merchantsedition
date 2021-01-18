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

<!-- <label for="node-search">{l s=$label}</label> -->
<div class="pull-right">
	<input type="text"
		{if isset($id)}id="{$id|escape:'html':'UTF-8'}"{/if}
		{if isset($name)}name="{$name|escape:'html':'UTF-8'}"{/if}
		class="search-field{if isset($class)} {$class|escape:'html':'UTF-8'}{/if}"
		placeholder="{l s='search...'}" />
</div>

{if isset($typeahead_source) && isset($id)}

<script type="text/javascript">
	$(function() {

		function startTypeahead() {
			if (typeof $.fn.typeahead === 'undefined') {
				setTimeout(startTypeahead, 100);
				return;
			}
			$("#{$id|escape:'html':'UTF-8'}").typeahead(
			{
				name: "{$name|escape:'html':'UTF-8'}",
				valueKey: 'name',
				local: [{$typeahead_source}]
			});

			$("#{$id|escape:'html':'UTF-8'}").keypress(function (event) {
				if (event.which == 13) {
					event.stopPropagation();
				}
			});
		}

		startTypeahead();
	});
</script>
{/if}
