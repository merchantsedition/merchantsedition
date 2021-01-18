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
{block name='override_header'}
{if $submit_form_ajax}
	<script type="text/javascript">
		$('#customer', window.parent.document).val('{$new_customer->email|escape:'html':'UTF-8'}');
		parent.setupCustomer({$new_customer->id|intval});
		parent.$.fancybox.close();
	</script>
{/if}
{/block}
{block name=leadin}
	{if isset($delete_customer) && $delete_customer}
		<form action="{$REQUEST_URI|escape:'html':'UTF-8'}" method="post">
			<div class="alert alert-warning">
				<h4>{l s='How do you want to delete the selected customers?'}</h4>
				<p>{l s='There are two ways of deleting a customer. Please choose your preferred method.'}</p>
				<br>
				<ul class="listForm list-unstyled">
					<li>
						<label for="deleteMode_real" class="control-label">
							<input type="radio" name="deleteMode" value="real" id="deleteMode_real" />
							{l s='I want my customers to be able to register again with the same email address. All data will be removed from the database.'}
						</label>
					</li>
					<li>
						<label for="deleteMode_deleted" class="control-label">
							<input type="radio" name="deleteMode" value="deleted" id="deleteMode_deleted" />
							{l s='I do not want my customer(s) to register again with the same email address. All selected customer(s) will be removed from this list but their corresponding data will be kept in the database.'}
						</label>
					</li>
				</ul>
				{foreach $POST as $key => $value}
					{if is_array($value)}
						{foreach $value as $val}
							<input type="hidden" name="{$key|escape:'html':'UTF-8'}[]" value="{$val|escape:'html':'UTF-8'}" />
						{/foreach}
					{else}
						<input type="hidden" name="{$key|escape:'html':'UTF-8'}" value="{$value|escape:'html':'UTF-8'}" />
					{/if}
				{/foreach}
				<input type="submit" class="btn btn-default" value="{l s='Delete'}" />
			</div>
		</form>
		<script>
			$(document).ready(function() {
				$('table[name=\'list_table\']').hide();
			});
		</script>
	{/if}
{/block}
