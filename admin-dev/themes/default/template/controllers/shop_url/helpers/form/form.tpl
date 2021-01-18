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

{block name=script}
	$(document).ready(function(){
		fillShopUrl();
		checkMainUrlInfo();
		$('#domain, #physical_uri, #virtual_uri').keyup(fillShopUrl);

		var change_domain_value = false;
		$('#domain').keydown(function()
		{
			if (!$('#domain_ssl').val() || $('#domain_ssl').val() == $('#domain').val())
				change_domain_value = true;
		});

		$('#domain_ssl').keydown(function()
		{
			change_domain_value = false;
		});

		$('#domain').blur(function()
		{
			if (change_domain_value)
			{
				change_domain_value = false;
				$('#domain_ssl').val($(this).val().replace(/ /g, '-'));
			}
		});

		$('#domain, #domain_ssl, #physical_uri, #virtual_uri').blur(function()
		{
			$(this).val($.trim($(this).val().replace(/ /g, '-')));
		});

	});

	var shopUrl = {$js_shop_url};

	function fillShopUrl()
	{
		var domain = $('#domain').val();
		var physical = $('#physical_uri').val();
		var virtual = $('#virtual_uri').val();
		url = ((domain) ? domain : '???');
		if (physical)
		url += '/'+physical;
		if (virtual)
			url += '/'+virtual+'/';
		url = url.replace(/\/+/g, "/");
		$('#final_url').val('http://' + url.replace(/ /g, '-'));
	};

	function checkMainUrlInfo(shopID)
	{
		if (!shopID)
			if ($('#shop_id').length)
				shopID = $('#shop_id').val();
			else
				shopID = $('#id_shop').val();

		if (!shopUrl[shopID])
		{
			$('#main_off').attr('disabled', true);
			$('#main_on').attr('checked', true);
			$('#mainUrlInfo').css('display', 'block');
			$('#mainUrlInfoExplain').css('display', 'none');
		}
		else
		{
			$('#main_off').attr('disabled', false);
			$('#mainUrlInfo').css('display', 'none');
			$('#mainUrlInfoExplain').css('display', 'block');
		}
	}
{/block}
