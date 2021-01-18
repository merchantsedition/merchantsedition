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

{if isset($display_multishop_checkboxes) && $display_multishop_checkboxes}
	<div class="panel clearfix">
		<label class="control-label col-lg-3">
			<i class="icon-sitemap"></i> {l s='Multistore'}
		</label>
		<div class="col-lg-9">
			<div class="row">
				<div class="col-lg-4">
					<span class="switch prestashop-switch">
						<input type="radio" name="multishop_{$product_tab}" id="multishop_{$product_tab}_on" value="1" onclick="$('#product-tab-content-{$product_tab} input[name^=\'multishop_check[\']').attr('checked', true); ProductMultishop.checkAll{$product_tab}()">
						<label for="multishop_{$product_tab}_on">
							{l s='Yes'}
						</label>
						<input type="radio" name="multishop_{$product_tab}" id="multishop_{$product_tab}_off" value="0" checked="checked" onclick="$('#product-tab-content-{$product_tab} input[name^=\'multishop_check[\']').attr('checked', false); ProductMultishop.checkAll{$product_tab}()">
						<label for="multishop_{$product_tab}_off">
							{l s='No'}
						</label>
						<a class="slide-button btn"></a>
					</span>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<p class="help-block">
						<strong>{l s='Check / Uncheck all'}</strong> {l s='(If you are editing this page for several shops, some fields may be disabled. If you need to edit them, you will need to check the box for each field)'}
					</p>
				</div>
			</div>
		</div>
	</div>
{/if}
