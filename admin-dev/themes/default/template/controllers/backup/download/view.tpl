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
	<div class="panel">
		<h3>
			<i class="icon-download"></i>
			{l s='Download'}
		</h3>
		<p>
			<a class="btn btn-default" href="{$backup_url}">
				<i class="icon-download"></i>
				{l s='Download the backup file (%s MB)' sprintf=$backup_weight}
			</a>
		</p>
		<p>{l s='Tip: You can also download this file from your FTP server. Backup files are located in the "/adminXXXX/backups" directory.'}</p>
	</div>

	<div class="row">
		<div class="alert alert-warning">
			<button data-dismiss="alert" class="close" type="button">×</button>
			<p>{l s='Disclaimer before creating a new backup'}</p>
			<ol>
				<li>{l s='thirty bees is not responsible for your database, its backups and/or recovery.'}</li>
				<li>{l s='thirty bees is open-source software. You are using it at your own risk under the license agreement.'}</li>
				<li>{l s='You should back up your data on a regular basis (both files and database).'}</li>
				<li>{l s='This function only backs up your database, not your files.'}</li>
				<li>{l s='By default, your existing database tables will be dropped during the backup recovery (see "Backup options" below).'}</li>
				<li>{l s='Always verify the quality and integrity of your backup files!'}</li>
				<li>{l s='Always verify that your backup files are complete, up-to-date and valid, even if you had a success message appear during the backup process.'}</li>
				<li>{l s='Always check your data.'}</li>
				<li>{l s='Never restore a backup on a live site.'}</li>
			</ol>
			<form action="{$currentIndex|escape:'html':'UTF-8'}&amp;add{$table}&amp;token={$token|escape:'html':'UTF-8'}" method="post" class="form-horizontal">
				<button type="submit" class="btn btn-default">
					<i class="icon-save"></i>
					{l s='I have read the disclaimer. Please create a new backup.'}
				</button>
			</form>
		</div>
	</div>

	<div class="row">
		<div class="alert alert-info">
			<p>{l s='How to restore a database backup in 10 easy steps:'}</p>
			<ol>
				<li>{l s='Set "Enable Shop" to "No" in the "Maintenance" page under the "Preferences" menu.'}</li>
				<li>{l s='Download the backup from the list below or from your FTP server (in the folder "admin/backups").'}</li>
				<li>{l s='Check the backup integrity: Look for errors, incomplete file, etc... Be sure to verify all of your data.'}</li>
				<li>{l s='Please ask your hosting provider for "phpMyAdmin" access to your database.'}</li>
				<li>{l s='Connect to "phpMyAdmin" and select your current database.'}</li>
				<li>{l s='Unless you enabled the "Drop existing tables" option, you must delete all tables from your current database.'}</li>
				<li>{l s='At the top of the screen, please select the "Import" tab'}</li>
				<li>{l s='Click on the "Browse" button and select the backup file from your hard drive.'}</li>
				<li>{l s='Check the maximum filesize allowed (e.g. Max: 16MB)'}<br />{l s='If your backup file exceeds this limit, contact your hosting provider for assistance. '}</li>
				<li>{l s='Click on the "Go" button and please wait patiently for the import process to conclude. This may take several minutes.'}</li>
			</ol>
		</div>
	</div>
{/block}
