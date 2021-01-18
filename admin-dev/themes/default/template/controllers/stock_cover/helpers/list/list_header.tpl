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

{extends file="helpers/list/list_header.tpl"}
{block name=override_header}
{if isset($show_filter) && $show_filter}
<div class="panel">
	<h3><i class="icon-cogs"></i> {l s='Filters'}</h3>
	<div class="filter-stock-extended">
		<form id="stock_cover" method="get" class="form-horizontal">
			<input type="hidden" name="controller" value="AdminStockCover" />
			<input type="hidden" name="token" value="{$token|escape:'html':'UTF-8'}" />
			{if count($stock_cover_periods) > 1}
			<div class="form-group">
				<label for="coverage_period" class="control-label col-lg-3">{l s='Filter by period:'}</label>
				<div class="col-lg-9">
					<select id="coverage_period" name="coverage_period" onchange="$('#stock_cover').submit();">
						{foreach from=$stock_cover_periods key=k item=i}
							<option {if $i == $stock_cover_cur_period} selected="selected"{/if} value="{$i}">{$k}</option>
						{/foreach}
					</select>
				</div>
			</div>
			{/if}
			{if count($stock_cover_warehouses) > 0}
			<div class="form-group">
				<label for="id_warehouse" class="control-label col-lg-3">{l s='Filter by warehouse:'}</label>
				<div class="col-lg-9">
					<select id="id_warehouse" name="id_warehouse" onchange="$('#stock_cover').submit();">
						{foreach from=$stock_cover_warehouses key=k item=i}
							<option {if $i.id_warehouse == $stock_cover_cur_warehouse} selected="selected"{/if} value="{$i.id_warehouse}">{$i.name}</option>
						{/foreach}
					</select>
				</div>
			</div>
			{/if}
			<div class="form-group">
				<label for="warn_days" class="control-label col-lg-3">{l s='Highlight when coverage (in days) is less than:'}</label>
				<div class="col-lg-9">
					<input id="warn_days" name="warn_days" type="text" size="3" onchange="$('#stock_cover').submit();" value="{if isset($stock_cover_warn_days)}{$stock_cover_warn_days}{/if}" />
				</div>
			</div>
		</form>
	</div>
</div>
{/if}
{/block}
