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

{block name="input_row"}
	{if $input.type == 'color' || $input.name == 'texture' || $input.name == 'current_texture'}
		<div class="colorAttributeProperties"{if !$colorAttributeProperties} style="display: none;"{/if}>
	{/if}
	{$smarty.block.parent}
	{if $input.type == 'color' || $input.name == 'texture' || $input.name == 'current_texture'}
		</div>
	{/if}
	{if $input.name == 'name'}
		{hook h="displayAttributeForm" id_attribute=$form_id}
	{/if}
{/block}

{block name="field"}
	{if $input.name == 'current_texture'}
		<div class="col-lg-9">
			{if isset($imageTextureExists) && $imageTextureExists}
				<img src="{$imageTexture}" alt="{l s='Texture'}" class="img-thumbnail" />
			{else}
				<p class="form-control-static">{l s='None'}</p>
			{/if}
		</div>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="script"}
	var attributesGroups = {ldelim}{$strAttributesGroups}{rdelim};

	var displayColorFieldsOption = function() {
		var val = $('#id_attribute_group').val();
		if (attributesGroups[val])
			$('.colorAttributeProperties').show();
		else
			$('.colorAttributeProperties').hide();
	};

	displayColorFieldsOption();

	$('#id_attribute_group').change(displayColorFieldsOption);

	var shop_associations = {$fields[0]['form']['shop_associations']};
	var changeAssociationGroup = function()
	{
		var id_attribute_group = $('#id_attribute_group').val();
		$('.input_shop').each(function(k, item)
		{
			var id_shop = $(item).attr('shop_id');
			if (typeof shop_associations[id_attribute_group] != 'undefined' && $.inArray(id_shop, shop_associations[id_attribute_group]) > -1)
				$(item).attr('disabled', false);
			else
			{
				$(item).attr('disabled', true);
				$(item).attr('checked', false);
			}
		});
	};
	$('#id_attribute_group').change(changeAssociationGroup);
	changeAssociationGroup();
{/block}
