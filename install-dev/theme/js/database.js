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
	// Check rewrite engine availability
	$.ajax({
		url: 'sandbox/anything.php',
		success: function(value) {
			$('#rewrite_engine').val(1);
		}
	});

	// Check database configuration
	$('#btTestDB').click(function()
	{
		$("#dbResultCheck")
			.removeClass('errorBlock')
			.removeClass('okBlock')
			.addClass('waitBlock')
			.html('&nbsp;')
			.slideDown('slow');
		$.ajax({
			url: 'index.php',
			data: {
                'checkDb': 'true',
                'dbServer': $('#dbServer').val(),
                'dbName': $('#dbName').val(),
                'dbLogin': $('#dbLogin').val(),
                'dbPassword': $('#dbPassword').val(),
                'dbEngine': $('#dbEngine').val(),
                'db_prefix': $('#db_prefix').val(),
                'clear': $('#db_clear').prop('checked') ? '1' : '0'
            },
			dataType: 'json',
			cache: false,
			success: function(json)
			{
				$("#dbResultCheck")
					.addClass((json.success) ? 'okBlock' : 'errorBlock')
					.removeClass('waitBlock')
					.removeClass((json.success) ? 'errorBlock' : 'okBlock')
					.html(json.message)
			},
            error: function(xhr)
            {
            	var re = /<([a-z]+)(.*?>.*?<\/\1>|.*?\/>)/img;
            	var str = xhr.responseText;
            	var m;

            	while ((m = re.exec(str)) != null) {
				    if (m.index === re.lastIndex) {
				        re.lastIndex++;
				    }
				    if (m)
				    	var html = true;
				}

                $("#dbResultCheck")
                    .addClass('errorBlock')
					.removeClass('waitBlock')
                    .removeClass('okBlock')
                    .html('An error occurred:<br /><br />' + (html ? 'Can you please reload the page' : xhr.responseText))
            }
		});
	});
});

function bindCreateDB()
{
	// Attempt to create the database
	$('#btCreateDB').click(function()
	{
		$("#dbResultCheck").slideUp('fast');
		$.ajax({
			url: 'index.php',
			data: {
                'createDb': 'true',
                'dbServer': $('#dbServer').val(),
                'dbName': $('#dbName').val(),
                'dbLogin': $('#dbLogin').val(),
                'dbPassword': $('#dbPassword').val()
            },
			dataType: 'json',
			cache: false,
			success: function(json)
			{
				$("#dbResultCheck")
					.addClass((json.success) ? 'okBlock' : 'errorBlock')
					.removeClass((json.success) ? 'errorBlock' : 'okBlock')
					.html(json.message)
					.slideDown('slow');
			},
            error: function(xhr)
            {
                $("#dbResultCheck")
                    .addClass('errorBlock')
                    .removeClass('okBlock')
                    .html('An error occurred:<br /><br />' + xhr.responseText)
                    .slideDown('slow');
            }
		});
	});
}
