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

{if isset($json)}
{strip}
{
{if isset($status) && is_string($status) && trim($status) != ''}{assign 'hasresult' 'ok'}"status" : "{$status}"{/if}
{if isset($confirmations) && $confirmations|count > 0}{if $hasresult == 'ok'},{/if}{assign 'hasresult' 'ok'}"confirmations" : {$confirmations}{/if}
{if isset($informations) && $informations|count > 0}{if $hasresult == 'ok'},{/if}{assign 'hasresult' 'ok'}"informations" : {$informations}{/if}
{if isset($errors) && $errors|count > 0}{if $hasresult == 'ok'},{/if}{assign 'hasresult' 'ok'}"error" : {$errors}{/if}
{if isset($warnings) && $warnings|count > 0}{if $hasresult == 'ok'},{/if}{assign 'hasresult' 'ok'}"warnings" : {$warnings}{/if}
{if $hasresult == 'ok'},{/if}{assign 'hasresult' 'ok'}"content" : {$page}
}
{/strip}
{else}
	{if isset($conf)}
		<div class="alert alert-success">
			{$conf}
		</div>
	{/if}

	{if count($errors)} {* @todo what is ??? AND $this->_includeContainer *}
		<div class="alert alert-danger">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			{if count($errors) == 1}
				{$errors[0]}
			{else}
				{l s='%d errors' sprintf=$errors|count}
				<br/>
				<ul>
					{foreach $errors AS $error}
						<li>{$error}</li>
					{/foreach}
				</ul>
			{/if}
		</div>
	{/if}

	{if isset($informations) && count($informations) && $informations}
		<div class="alert alert-info" style="display:block;">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			{foreach $informations as $info}
				{$info}<br/>
			{/foreach}
		</div>
	{/if}

	{if isset($confirmations) && count($confirmations) && $confirmations}
		<div class="alert alert-success" style="display:block;">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			{foreach $confirmations as $confirm}
				{$confirm}<br />
			{/foreach}
		</div>
	{/if}

	{if count($warnings)}
		<div class="alert alert-warning">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			{if count($warnings) > 1}
				{l s='There are %d warnings.' sprintf=count($warnings)}
				<span style="margin-left:20px;" id="labelSeeMore">
					<a id="linkSeeMore" href="#" style="text-decoration:underline">{l s='Click here to see more'}</a>
					<a id="linkHide" href="#" style="text-decoration:underline;display:none">{l s='Hide warning'}</a>
				</span>
			{else}
				{l s='There is %d warning.' sprintf=count($warnings)}
			{/if}
			<ul style="display:{if count($warnings) > 1}none{else}block{/if};" id="seeMore">
			{foreach $warnings as $warning}
				<li>{$warning}</li>
			{/foreach}
			</ul>
		</div>
	{/if}
	{$page}
{/if}
