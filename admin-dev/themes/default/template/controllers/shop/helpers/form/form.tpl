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
	{if $input.type == 'theme'}
		{foreach $input.values as $theme}
			<div class="col-lg-3 select_theme {if $theme->id == $fields_value.id_theme_checked}select_theme_choice{/if}" onclick="$(this).find('input').attr('checked', true); $('.select_theme').removeClass('select_theme_choice'); $(this).toggleClass('select_theme_choice');">
				<div class="radio">
					<label>
						<input type="radio" name="id_theme" value="{$theme->id|intval}"{if $theme->id == $fields_value.id_theme_checked} checked="checked"{/if} /> {$theme->name|escape:'html':'UTF-8'}
					</label>
				</div>
				<div class="theme-container">
					<img class="thumbnail" src="../themes/{$theme->directory}/preview.jpg" alt="{$theme->directory}" />
				</div>
			</div>
		{/foreach}
		<div class="clear">&nbsp;</div>
	{elseif $input.type == 'textShopGroup'}
		<p style="color: #000000; padding: 0px; font-size: 12px; margin-top: 4px;">{$input.value}</p>
	{else}
		{if $input.type == 'select' && $input.name == 'id_category'}
			<script type="text/javascript">
				$(document).ready(function(){
					$('#id_category').change(function(){
						doAdminAjax(
							{
							ajax: '1',
							id_category : $(this).val(),
							use_shop_context : 0,
							action : 'getCategoriesFromRootCategory',
							controller: 'AdminShop',
							token : '{$token|escape:'html':'UTF-8'}',
							},
							function(res)
							{
								$('#categories-tree').parent().parent().html(res);
							}
						);
					});
					$('#id_category').trigger('change');
				});
			</script>
		{/if}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="other_fieldsets"}
	{if isset($form_import)}
	<div class="panel">
		<h3><i class="icon-cloud-download"></i> {l s='Import data from another shop'}</h3>
		{foreach $form_import as $key => $field}
		<div class="form-group">
		{if $key == 'radio'}
			<label class="control-label col-lg-3">{$field.label}</label>
			<div class="col-lg-2">
				<span class="switch prestashop-switch">
					<input type="radio" name="{$field.name}" id="{$field.name}_on" value="1" {if $field.value } checked="checked" {/if} />
					<label for="{$field.name}_on">
						{l s='Yes'}
					</label>
					<input type="radio" name="{$field.name}" id="{$field.name}_off" value="0"  {if !$field.value } checked="checked" {/if} />
					<label for="{$field.name}_off">
						{l s='No'}
					</label>
					<a class="slide-button btn"></a>
				</span>
			</div>
		{elseif $key == 'select'}
			<div id="shop_list" {if !$checked}display:none{/if}>
				<label class="control-label col-lg-3">{$field.label}</label>
				<div class="col-lg-9">
					<select name="{$field.name}" id="{$field.name}" >
						{foreach $field.options.query AS $key => $option}
							<option value="{$key}" {if $key == $defaultShop}selected="selected"{/if}>
								{$option.name}
							</option>
						{/foreach}
					</select>
				</div>
			</div>
		{elseif $key == 'allcheckbox'}
			<div id="data_list" {if !$checked}display:none{/if}>
				<label class="control-label col-lg-3">{$field.label}</label>
				<div class="col-lg-9">
				{foreach $field.values as $key => $label}
					<p class="checkbox"><input type="checkbox" name="importData[{$key}]" checked="checked" /> {$label}</p>
				{/foreach}
				</div>
			</div>
		{elseif $key == 'submit'}
			<div class="col-lg-9">
				<input type="submit" value="{$field.title}" name="submitAdd{$table}" class="btn btn-default{if isset($field.class)} {$field.class}{/if}" />
			</div>
		{/if}
		</div>
		{/foreach}
		<div class="panel-footer">
			<button type="submit" value="1" id="shop_form_submit_btn" name="submitAddshop" class="btn btn-default pull-right">
				<i class="process-icon-save"></i> {l s='Save'}
			</button>
			<a href="{$currentIndex|escape:'html':'UTF-8'}&amp;id_shop_group=0&amp;token={$token|escape:'html':'UTF-8'}" class="btn btn-default" onclick="window.history.back();">
				<i class="process-icon-cancel"></i> {l s='Cancel'}
			</a>
		</div>
	</div>
	{/if}
{/block}

{block name="script"}
	var ids_category = new Array();
	{foreach $ids_category as $key => $id_category}
		ids_category[{$key}] = {$id_category};
	{/foreach}
	$(document).ready(function() {
		$('input[name=useImportData]').click(function()	{
			if ($(this).attr('id') == 'useImportData_on')
			{
				$('input[name^="importData["]').prop('checked', true);
				$('#shop_list, #data_list').slideDown('slow');
			}
			else
			{
				$('input[name^="importData["]').prop('checked', false);
				$('#shop_list, #data_list').slideUp('slow');
			}
		});
		$('#id_category, #importFromShop').change(function(){
			shop_id = $('#importFromShop').val();
			category_id = $('#id_category').val();
			if (ids_category[shop_id] != category_id)
				disableProductsDuplication();
			else
				enableProductsDuplication();
		});
	});
	function disableProductsDuplication()
	{
		$('input[name="importData[product_attribute]"], input[name="importData[image]"], input[name="importData[product]"], input[name="importData[stock_available]"], input[name="importData[discount]"]').removeAttr('checked').attr('disabled', 'disabled');
	}
	function enableProductsDuplication()
	{
		$('input[name="importData[product_attribute]"], input[name="importData[image]"], input[name="importData[product]"], input[name="importData[stock_available]"], input[name="importData[discount]"]').removeAttr('disabled').attr('checked', 'checked');
	}
{/block}
