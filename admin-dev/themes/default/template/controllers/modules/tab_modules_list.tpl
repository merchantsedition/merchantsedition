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

{if isset($tab_modules_list) && !empty($tab_modules_list)}
	<div class="row row-margin-bottom">
		<div class="col-lg-12">
			<ul class="nav nav-pills">
				{if count($tab_modules_list.not_installed)}
					<li class="active">
						<a href="#tab_modules_list_not_installed" data-toggle="tab">
							{l s='Not Installed'}
						</a>
					</li>
				{/if}
				{if count($tab_modules_list.installed)}
					<li {if count($tab_modules_list.not_installed) == 0}class="active"{/if}>
						<a href="#tab_modules_list_installed" data-toggle="tab">
							{l s='Installed'}
						</a>
					</li>
				{/if}
			</ul>
		</div>
	</div>
	<div id="modules_list_container_content" class="tab-content modal-content-overflow">
		{if count($tab_modules_list.not_installed)}
		<div class="tab-pane active" id="tab_modules_list_not_installed">
			<table id="tab_modules_list_not_installed" class="table">
				{foreach from=$tab_modules_list.not_installed item=module}
					{include file='controllers/modules/tab_module_line.tpl' class_row={cycle values=",rowalt"}}
				{/foreach}
			</table>
		</div>
		{/if}
		{if count($tab_modules_list.installed)}
		<div class="tab-pane {if count($tab_modules_list.not_installed) == 0}active{/if}" id="tab_modules_list_installed">
			<table id="tab_modules_list_installed" class="table">
				{foreach from=$tab_modules_list.installed item=module}
					{include file='controllers/modules/tab_module_line.tpl' class_row={cycle values=",rowalt"}}
				{/foreach}
			</table>
		</div>
		{/if}
	</div>
{/if}
