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

{*
		<form action="{$smarty.server.REQUEST_URI|escape}" method="post" id="settings_form" name="settings_form" class="form-horizontal">
			<h3><i class="icon-cog"></i> {l s='Settings'}</h3>

			<div class="form-group">
				<label for="engine_stats_render">{l s='Graph engine'} </label>
				{if count($array_graph_engines)}
					<select name="PS_STATS_RENDER" id="engine_stats_render">
						{foreach $array_graph_engines as $k => $value}
							<option value="{$k}" {if $k == $graph_engine}selected="selected"{/if}>{$value[0]}</option>
						{/foreach}
					</select>
				{else}
					{l s='No graph engine module has been installed.'}
				{/if}
			</div>

			<div class="form-group">
				<label for="engine_grid_render">{l s='Grid engine'} </label>
				{if count($array_grid_engines)}
					<select name="PS_STATS_GRID_RENDER" id="engine_grid_render">
						{foreach $array_grid_engines as $k => $value}
							<option value="{$k}" {if $k == $grid_engine}selected="selected"{/if}>{$value[0]}</option>
						{/foreach}
					</select>
				{else}
					{l s='No grid engine module has been installed.'}
				{/if}
			</div>

			<div class="form-group">
				<label for="engine_auto_clean">{l s='Auto-clean period'}</label>
				<select name="PS_STATS_OLD_CONNECT_AUTO_CLEAN" id="engine_auto_clean">
					{foreach $array_auto_clean as $k => $value}
						<option value="{$k}" {if $k == $auto_clean}selected="selected"{/if}>{$value}</option>
					{/foreach}
				</select>
			</div>

			<p>
				<input type="submit" value="{l s='Save'}" name="submitSettings" id="submitSettings" class="btn btn-default" />
			</p>
		</form>
*}
