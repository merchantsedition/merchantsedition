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
	{if !$host_mode}
	<script type="text/javascript">
		$(document).ready(function()
		{
			$.ajax({
				type: 'GET',
				url: '{$link->getAdminLink('AdminInformation')|addslashes}',
				data: {
					'action': 'checkFiles',
					'ajax': 1
				},
				dataType: 'json',
				success: function(json)
				{
					var tab = {
						'missing': '{l s='Missing files'}',
            'updated': '{l s='Updated files'}',
            'obsolete': '{l s='Obsolete files'}'
					};

          if (json.missing.length || json.updated.length
              || json.obsolete.length || json.listMissing) {
            var text = '<div class="alert alert-warning">';
            if (json.isDevelopment) {
              text += '{l s='This is a development installation, so the following is not unexpected: '}';
            }
            if (json.listMissing) {
              text += '{l s='File @s1 missing, can\'t check any files.'}'.replace('@s1', json.listMissing);
            } else {
              text += '{l s='Changed/missing/obsolete files have been detected.'}';
            }
            text += '</div>';
            $('#changedFiles').html(text);
          } else {
						$('#changedFiles').html('<div class="alert alert-success">{l s='No change has been detected in your files.'}</div>');
          }

					$.each(tab, function(key, lang)
					{
						if (json[key].length)
						{
							var html = $('<ul>').attr('id', key+'_files');
							$(json[key]).each(function(key, file)
							{
								html.append($('<li>').html(file))
							});
							$('#changedFiles')
								.append($('<h4>').html(lang+' ('+json[key].length+')'))
								.append(html);
						}
					});
				}
			});
		});
	</script>
	{/if}
	<div class="row">
		<div class="col-lg-6">
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Configuration information'}
				</h3>
				<p>{l s='This information must be provided when you report an issue on our bug tracker or forum.'}</p>
			</div>
			{if !$host_mode}
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Server information'}
				</h3>
				{if $uname}
				<p>
					<strong>{l s='Server information:'}</strong> {$uname|escape:'html':'UTF-8'}
				</p>
				{/if}
				<p>
					<strong>{l s='Server software version:'}</strong> {$version.server|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='PHP version:'}</strong> {$version.php|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Memory limit:'}</strong> {$version.memory_limit|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Max execution time:'}</strong> {$version.max_execution_time|escape:'html':'UTF-8'}
				</p>
				{if $apache_instaweb}
					<p>{l s='PageSpeed module for Apache installed (mod_instaweb)'}</p>
				{/if}
			</div>
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Database information'}
				</h3>
				<p>
					<strong>{l s='MySQL version:'}</strong> {$database.version|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='MySQL server:'}</strong> {$database.server|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='MySQL name:'}</strong> {$database.name|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='MySQL user:'}</strong> {$database.user|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Tables prefix:'}</strong> {$database.prefix|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='MySQL engine:'}</strong> {$database.engine|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='MySQL driver:'}</strong> {$database.driver|escape:'html':'UTF-8'}
				</p>
			</div>
		</div>
		{/if}
		<div class="col-lg-6">
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Store information'}
				</h3>
				<p>
					<strong>{l s='thirty bees version:'}</strong> {$shop.ps|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Shop URL:'}</strong> {$shop.url|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='Current theme in use:'}</strong> {$shop.theme|escape:'html':'UTF-8'}
				</p>
			</div>
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Mail configuration'}
				</h3>
				<p>
					<strong>{l s='Mail method:'}</strong>

			{if $mail}
				{l s='You are using the PHP mail() function.'}</p>
			{else}
				{l s='You are using your own SMTP parameters.'}</p>
				<p>
					<strong>{l s='SMTP server'}:</strong> {$smtp.server|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='SMTP username'}:</strong>
					{if $smtp.user neq ''}
						{l s='Defined'}
					{else}
						<span style="color:red;">{l s='Not defined'}</span>
					{/if}
				</p>
				<p>
					<strong>{l s='SMTP password'}:</strong>
					{if $smtp.password neq ''}
						{l s='Defined'}
					{else}
						<span style="color:red;">{l s='Not defined'}</span>
					{/if}
				</p>
				<p>
					<strong>{l s='Encryption:'}</strong> {$smtp.encryption|escape:'html':'UTF-8'}
				</p>
				<p>
					<strong>{l s='SMTP port:'}</strong> {$smtp.port|escape:'html':'UTF-8'}
				</p>
			{/if}
			</div>
			<div class="panel">
				<h3>
					<i class="icon-info"></i>
					{l s='Your information'}
				</h3>
				<p>
					<strong>{l s='Your web browser:'}</strong> {$user_agent|escape:'html':'UTF-8'}
				</p>
			</div>

			<div class="panel" id="checkConfiguration">
				<h3>
					<i class="icon-info"></i>
					{l s='Check your configuration'}
				</h3>
				<p>
					<strong>{l s='Required parameters:'}</strong>
				{if !$failRequired}
					<span class="text-success">{l s='OK'}</span>
				</p>
				{else}
					<span class="text-danger">{l s='Please fix the following error(s)'}</span>
				</p>
				<ul>
					{foreach from=$testsRequired item='value' key='key'}
						{if $value eq 'fail' && isset($testsErrors[$key])}
							<li>{$testsErrors[$key]}</li>
						{/if}
					{/foreach}
				</ul>
				{/if}
				{if isset($failOptional)}
					<p>
						<strong>{l s='Optional parameters:'}</strong>
					{if !$failOptional}
						<span class="text-success">{l s='OK'}</span>
					</p>
					{else}
						<span class="text-danger">{l s='Please fix the following error(s)'}</span>
					</p>
					<ul>
						{foreach from=$testsOptional item='value' key='key'}
							{if $value eq 'fail' && isset($testsErrors[$key])}
								<li>{$testsErrors[$key]}</li>
							{/if}
						{/foreach}
					</ul>
					{/if}
				{/if}
			</div>
		</div>
	</div>
	{if !$host_mode}
	<div class="panel">
		<h3>
			<i class="icon-info"></i>
			{l s='List of changed files'}
		</h3>
		<div id="changedFiles"><i class="icon-spin icon-refresh"></i> {l s='Checking files...'}</div>
	</div>
	{/if}
{/block}
