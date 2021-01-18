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

{assign var=module_name value='<strong><span class="module-display-name-placeholder"></span></strong>'}

<div class="modal-body">
	<div class="alert alert-warning">
		<h4>{l s='You are about to install "%s", a module which is not compatible with your country.' sprintf=$module_name}</h4>
		<p>
			{l s='This module was not verified by thirty bees hence we cannot certify that it works well in your country and that it complies with our quality requirements.'}
			<strong>{l s='Use at your own risk.'}</strong>
		</p>
	</div>
	<h3>{l s='What Should I Do?'}</h3>
	<p>
		{l s='If you are unsure about this, you should contact the Customer Service of %s to ask them to make the module compatible with your country.' sprintf=$module_name}<br />
		{l s='Moreover, we recommend that you use an equivalent module: compatible modules for your country are listed in the "Modules" tab of your back office.'}
	</p>
</div>

<div class="modal-footer">
	<div class="row">
		<div class="col-sm-12 text-center">
			<a id="proceed-install-anyway" href="#" class="btn btn-warning">{l s='Proceed with the installation'}</a>
			<button type="button" class="btn btn-default" data-dismiss="modal">{l s='Back to modules list'}</button>
		</div>
	</div>
</div>
