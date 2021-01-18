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
{if isset($warehouses) && count($warehouses) > 0 && isset($filter_status)}
<div class="panel">
	<h3><i class="icon-cogs"></i> {l s='Filters'}</h3>
	<div class="filter-stock-extended">
		<form id="supply_orders" method="get" class="form-horizontal">
			<input type="hidden" name="controller" value="AdminSupplyOrders" />
			<input type="hidden" name="token" value="{$token|escape:'html':'UTF-8'}" />
			<div class="form-group">
				<label for="id_warehouse" class="control-label col-lg-3">{l s='Filter by warehouse:'}</label>
				<div class="col-lg-9">
					<select id="id_warehouse" name="id_warehouse" onchange="$('#supply_orders').submit();">
					{foreach from=$warehouses key=k item=i}
						<option {if $i.id_warehouse == $current_warehouse} selected="selected"{/if} value="{$i.id_warehouse}">{$i.name}</option>
					{/foreach}
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="checkbox col-lg-9 col-lg-push-3">
					<label for="filter_status">
						<input id="filter_status" type="checkbox" name="filter_status" class="noborder" onchange="$('#supply_orders').submit();" {if $filter_status == 1}value="on" checked{/if} /> {l s='Choose not to display completed/canceled orders:'}
					</label>
				</div>
			</div>
		</form>
	</div>
</div>
{/if}
{/block}
