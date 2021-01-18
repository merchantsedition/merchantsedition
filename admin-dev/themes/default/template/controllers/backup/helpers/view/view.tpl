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

{extends file="helpers/view/view.tpl"}

{block name="override_tpl"}
	{if !isset($errors) || $errors|count == 0}
	<div class="panel">
		<h3><i class="icon-download"></i> {l s='Download'}</h3>
		<div class="alert alert-success">{l s='Beginning the download ...'}</div>
		<p>{l s='Backup files should automatically start downloading.'}</p>
		<p>{l s='If not,'} <b><a href="{$url_backup}" class="btn btn-default"><i class="icon-download"></i> {l s='please click here!'}</a></b></p>
		<iframe  style="width:0px; height:0px; overflow:hidden; border:none;" src="{$url_backup}"></iframe>
	</div>
	{/if}
{/block}
