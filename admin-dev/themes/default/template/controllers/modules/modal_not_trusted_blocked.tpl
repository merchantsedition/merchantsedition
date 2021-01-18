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

<div class="modal-body">
	<div class="alert alert-warning">
		<h3>{l s='This module could not be verified by thirty bees.'}</h3>

		<p>{l s="This generally happens when the module isn't distributed through our official marketplace, thirty bees Addons - or when your server failed to communicate with thirty bees Addons."}</p>
	</div>

	<div class="row">
		<div class="col-sm-2" style="text-align: center;">
			<img id="untrusted-module-logo" class="" src="" alt="">
		</div>
		<div class="col-sm-10">
			<table class="table">
				<tr>
					<td>{l s='Module'}</td>
					<td><strong><span class="module-display-name-placeholder"></span></strong></td>
				</tr>
				<tr>
					<td>{l s='Author'}</td>
					<td><strong><span class="author-name-placeholder"></span></strong></td>
				</tr>
			</table>
		</div>

		<div class="col-sm-12" style="text-align: center; padding-top: 12px;">
			<button type="button" class="btn btn-default" data-dismiss="modal">{l s='Back to modules list'}</button>
		</div>
	</div>
</div>

<div class="modal-footer">
	<div class="alert alert-info">
		<p>{l s='Since you may not have installed this module from thirty bees Addons, we cannot assert that the module is complying with our safety requirements (e.g. that it is not adding some undisclosed functionalities such as ads, hidden links, spam, etc...).'}</p>

		<p>{l s='You can search for similar modules on the official marketplace.'}</p>

		<p>{l s="[1]Click here to browse our catalog on thirty bees Addons[/1]." tags=['<a class="catalog-link" href="#">']}
	</div>
</div>
