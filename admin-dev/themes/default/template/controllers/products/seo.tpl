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

<div id="product-seo" class="panel product-tab">
	<input type="hidden" name="submitted_tabs[]" value="Seo" />
	<h3>{l s='SEO'}</h3>
	{include file="controllers/products/multishop/check_fields.tpl" product_tab="Seo"}
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="meta_title" type="default" multilang="true"}</span></div>
		<label class="control-label col-lg-2" for="meta_title_{$id_lang}">
			<span class="label-tooltip" data-toggle="tooltip"
				title="{l s='Public title for the product\'s page, and for search engines. Leave blank to use the product name.'} {l s='The number of remaining characters is displayed to the left of the field.'}">
				{l s='Meta title'}
			</span>
		</label>
		<div class="col-lg-8">
			{include file="controllers/products/input_text_lang.tpl"
				languages=$languages
				input_name='meta_title'
				input_value=$product->meta_title
				maxchar=70
			}
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="meta_description" type="default" multilang="true"}</span></div>
		<label class="control-label col-lg-2" for="meta_description_{$id_lang}">
			<span class="label-tooltip" data-toggle="tooltip"
				title="{l s='This description will appear in search engines. You need a single sentence, shorter than 160 characters (including spaces).'}">
				{l s='Meta description'}
			</span>
		</label>
		<div class="col-lg-8">
			{include file="controllers/products/textarea_lang.tpl"
				languages=$languages
				input_name='meta_description'
				input_value=$product->meta_description
				maxchar=160
			}
		</div>
	</div>
	{* Removed for simplicity *}
	<div class="form-group hide">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="meta_keywords" type="default" multilang="true"}</span></div>
		<label class="control-label col-lg-2" for="meta_keywords_{$id_lang}">
			<span class="label-tooltip" data-toggle="tooltip"
				title="{l s='Keywords for search engines, separated by commas.'}">
				{l s='Meta keywords'}
			</span>
		</label>
		<div class="col-lg-8">
			{include file="controllers/products/input_text_lang.tpl" languages=$languages
				input_value=$product->meta_keywords
				input_name='meta_keywords'}
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-1"><span class="pull-right">{include file="controllers/products/multishop/checkbox.tpl" field="link_rewrite" type="seo_friendly_url" multilang="true"}</span></div>
		<label class="control-label col-lg-2" for="link_rewrite_{$id_lang}">
			<span class="label-tooltip" data-toggle="tooltip"
				title="{l s='This is the human-readable URL, as generated from the product\'s name. You can change it if you want.'}">
				{l s='Friendly URL:'}
			</span>

		</label>
		<div class="col-lg-6">
				{include file="controllers/products/input_text_lang.tpl"
					languages=$languages
					input_value=$product->link_rewrite
					input_name='link_rewrite'}
		</div>
		<div class="col-lg-2">
			<button type="button" class="btn btn-default" id="generate-friendly-url" onmousedown="updateFriendlyURLByName();"><i class="icon-random"></i> {l s='Generate'}</button>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-9 col-lg-offset-3">
			{foreach from=$languages item=language}
			<div class="alert alert-warning translatable-field lang-{$language.id_lang}">
				<i class="icon-link"></i> {l s='The product link will look like this:'}<br/>
				<strong>{if isset($rewritten_links[$language.id_lang][0])}{$rewritten_links[$language.id_lang][0]|escape:'html':'UTF-8'}{/if}<span id="friendly-url_{$language.id_lang}">{$product->link_rewrite[$language.id_lang]|escape:'html':'UTF-8'}</span>{if isset($rewritten_links[$language.id_lang][1])}{$rewritten_links[$language.id_lang][1]|escape:'html':'UTF-8'}{/if}</strong>
			</div>
			{/foreach}
		</div>
	</div>
	<div class="panel-footer">
		<a href="{$link->getAdminLink('AdminProducts')|escape:'html':'UTF-8'}{if isset($smarty.request.page) && $smarty.request.page > 1}&amp;submitFilterproduct={$smarty.request.page|intval}{/if}" class="btn btn-default"><i class="process-icon-cancel"></i> {l s='Cancel'}</a>
		<button type="submit" name="submitAddproduct" class="btn btn-default pull-right" disabled="disabled"><i class="process-icon-loading"></i> {l s='Save'}</button>
		<button type="submit" name="submitAddproductAndStay" class="btn btn-default pull-right" disabled="disabled"><i class="process-icon-loading"></i> {l s='Save and stay'}</button>
	</div>
</div>
<script type="text/javascript">
	if (tabs_manager.allow_hide_other_languages)
		hideOtherLanguage({$default_form_language});
</script>
