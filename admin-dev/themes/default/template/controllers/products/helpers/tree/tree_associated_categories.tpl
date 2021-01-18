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

<div class="panel">
	{if isset($header)}{$header}{/if}
	{if isset($nodes)}
	<ul id="{$id|escape:'html':'UTF-8'}" class="cattree tree">
		{$nodes}
	</ul>
	{/if}
</div>
<script type="text/javascript">
	var currentToken="{$token|@addslashes}";
	var treeClickFunc = function() {
		var newURL = window.location.protocol + "//" + window.location.host + window.location.pathname;
		var queryString = window.location.search.replace(/&id_category=[0-9]*/, "") + "&id_category=" + $(this).val();
		location.href = newURL+queryString; // hash part is dropped: window.location.hash
	};
	function addDefaultCategory(elem)
	{
		$('select#id_category_default').append('<option value="' + elem.val()+'">' + (elem.val() !=1 ? elem.parent().find('label').html() : home) + '</option>');
		if ($('select#id_category_default option').length > 0)
		{
			$('select#id_category_default').closest('.form-group').show();
			$('#no_default_category').hide();
		}
	}

	{if isset($use_checkbox) && $use_checkbox == true}
		function checkAllAssociatedCategories($tree)
		{
			$tree.find(':input[type=checkbox]').each(function(){
				$(this).prop('checked', true);

				addDefaultCategory($(this));
				$(this).parent().addClass('tree-selected');
			});
		}

		function uncheckAllAssociatedCategories($tree)
		{
			$tree.find(':input[type=checkbox]').each(function(){
				$(this).prop('checked', false);

				$('select#id_category_default option[value='+$(this).val()+']').remove();
				if ($('select#id_category_default option').length == 0)
				{
					$('select#id_category_default').closest('.form-group').hide();
					$('#no_default_category').show();
				}

				$(this).parent().removeClass('tree-selected');
			});
		}
	{/if}
	{if isset($use_search) && $use_search == true}
		$('#{$id|escape:'html':'UTF-8'}-categories-search').bind('typeahead:selected', function(obj, datum){
			var match = $('#{$id|escape:'html':'UTF-8'}').find(':input[value="'+datum.id_category+'"]').first();
			if (match.length)
			{
				match.each(function(){
						$(this).prop("checked", true);
						$(this).parent().addClass("tree-selected");
						$(this).parents('ul.tree').each(function(){
							$(this).show();
							$(this).prev().find('.icon-folder-close').removeClass('icon-folder-close').addClass('icon-folder-open');
						});
						addDefaultCategory($(this));
					}
				);
			}
			else
			{
				var selected = [];
				that = this;
				$('#{$id|escape:'html':'UTF-8'}').find('.tree-selected input').each(
					function()
					{
						selected.push($(this).val());
					}
				);
				{literal}
				$.get(
					'ajax-tab.php',
					{controller:'AdminProducts',token:currentToken,action:'getCategoryTree', fullTree:1, selected:selected},
					function(content) {
				{/literal}
						$('#{$id|escape:'html':'UTF-8'}').html(content);
						$('#{$id|escape:'html':'UTF-8'}').tree('init');
						$('#{$id|escape:'html':'UTF-8'}').find(':input[value="'+datum.id_category+'"]').each(function(){
								$(this).prop("checked", true);
								$(this).parent().addClass("tree-selected");
								$(this).parents('ul.tree').each(function(){
									$(this).show();
									$(this).prev().find('.icon-folder-close').removeClass('icon-folder-close').addClass('icon-folder-open');
								});
								full_loaded = true;
							}
						);
					}
				);
			}
		});
	{/if}
	function startTree() {
		if (typeof $.fn.tree === 'undefined') {
			setTimeout(startTree, 100);
			return;
		}

		$('#{$id|escape:'html':'UTF-8'}').tree('collapseAll');
		$('#{$id|escape:'html':'UTF-8'}').find(':input[type=radio]').click(treeClickFunc);

		{if isset($selected_categories)}
			$('#no_default_category').hide();
			{assign var=imploded_selected_categories value='","'|implode:$selected_categories}
			var selected_categories = new Array("{$imploded_selected_categories}");

			if (selected_categories.length > 1)
				$('#expand-all-{$id|escape:'html':'UTF-8'}').hide();
			else
				$('#collapse-all-{$id|escape:'html':'UTF-8'}').hide();

			$('#{$id|escape:'html':'UTF-8'}').find(':input').each(function(){
				if ($.inArray($(this).val(), selected_categories) != -1)
				{
					$(this).prop("checked", true);
					$(this).parent().addClass("tree-selected");
					$(this).parents('ul.tree').each(function(){
						$(this).show();
						$(this).prev().find('.icon-folder-close').removeClass('icon-folder-close').addClass('icon-folder-open');
					});
				}
			});
		{else}
			$('#collapse-all-{$id|escape:'html':'UTF-8'}').hide();
		{/if}
	}
	startTree();
</script>
