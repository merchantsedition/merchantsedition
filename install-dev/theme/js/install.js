/**
 * Copyright (C) 2021 Merchant's Edition GbR
 * Copyright (C) 2017-2019 thirty bees
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
 * @copyright 2017-2019 thirty bees
 * @copyright 2007-2016 PrestaShop SA
 * @license   Open Software License (OSL 3.0)
 * PrestaShop is an internationally registered trademark of PrestaShop SA.
 * thirty bees is an extension to the PrestaShop software by PrestaShop SA.
 */

$(document).ready(function()
{
	$('#mainForm').submit(function() {
		$('#btNext').hide();
	});

	// Ajax animation
	$("#loaderSpace").ajaxStart(function()
	{
		$(this).fadeIn('slow');
		$(this).children('div').fadeIn('slow');
	});

	$("#loaderSpace").ajaxComplete(function(e, xhr, settings)
	{
		$(this).fadeOut('slow');
		$(this).children('div').fadeOut('slow');
	});

	$('select.chosen').not('.no-chosen').chosen();
});

function tbinstall_twitter_click(message) {
	window.open('https://twitter.com/intent/tweet?button_hashtag=thirtybees&text=' + message, 'sharertwt', 'toolbar=0,status=0,width=640,height=445');
}

function tbinstall_facebook_click() {
	window.open('http://www.facebook.com/sharer.php?u=https://thirtybees.com/', 'sharerfacebook', 'toolbar=0,status=0,width=660,height=445');
}

function tbinstall_pinterest_click() {
}

function tbinstall_linkedin_click() {
	window.open('https://www.linkedin.com/shareArticle?title=thirty bees&url=https://thirtybees.com/download', 'sharerlinkedin', 'toolbar=0,status=0,width=600,height=450');
}
