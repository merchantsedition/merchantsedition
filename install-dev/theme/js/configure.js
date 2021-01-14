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
	checkTimeZone($('#infosCountry'));
	// When a country is changed
	$('#infosCountry').change(function()
	{
		checkTimeZone(this);
	});
});

function checkTimeZone(elt)
{
	var iso = $(elt).val();

	// Get timezone by iso
	$.ajax({
		url: 'index.php',
		data: 'timezoneByIso=true&iso='+iso,
		dataType: 'json',
		cache: true,
		success: function(json) {
			if (json.success) {
				$('#infosTimezone').val(json.message).trigger("liszt:updated");
				if (in_array(iso, ['br','us','ca','ru','me','au','id']))
				{
					if ($('#infosTimezone:visible').length == 0 && $('#infosTimezone_chosen').length == 0)
					{
						$('#infosTimezone:hidden').show();
						$('#timezone_div').show();
						$('#infosTimezone').chosen();
					}
					$('#timezone_div').show();
				}
				else
					$('#timezone_div').hide();
			}
		}
	});
}

function in_array(needle, haystack) {
    var length = haystack.length;
    for (var i = 0; i < length; i++) {
        if (haystack[i] == needle)
			return true;
    }
    return false;
}
