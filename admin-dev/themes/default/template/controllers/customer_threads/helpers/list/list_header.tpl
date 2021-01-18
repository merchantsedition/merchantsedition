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

{extends file="helpers/list/list_header.tpl"}

{block name="leadin"}
	<div id="CustomerThreadContacts" class="row">
		{assign var=nb_categories value=count($categories)}
		{foreach $categories as $key => $val}

			{assign var=total_thread value=0}
			{assign var=id_customer_thread value=0}

			{foreach $contacts as $tmp => $tmp2}
				{if $val.id_contact == $tmp2.id_contact}
					{assign var=total_thread value=$tmp2.total}
					{assign var=id_customer_thread value=$tmp2.id_customer_thread}
				{/if}
			{/foreach}
			<div class="col-lg-3">
				<div class="panel">
					<div class="panel-heading">
						{$val.name}
					</div>
					{if $nb_categories < 6}
						<p>{$val.description}</p>
					{/if}
					{if $total_thread == 0}
						<span class="message-mail">{l s='No new messages'}</span>
					{else}
						<a href="{$currentIndex|escape:'html':'UTF-8'}&amp;token={$token|escape:'html':'UTF-8'}&amp;id_customer_thread={$id_customer_thread}&amp;viewcustomer_thread" class="button">
							{$total_thread}
							{if $total_thread > 1}{l s='New messages'}{else}{l s='New message'}{/if}
						</a>
					{/if}
				</div>
			</div>
		{/foreach}
		<div class="col-lg-3">
			<div id="MeaningStatus" class="panel">
				<div class="panel-heading">
					{l s='Meaning of status'}
				</div>
				<ul class="list-unstyled">
					<li class="text-success"><i class="icon-circle"></i> {l s='Open'}</li>
					<li class="text-danger"><i class="icon-circle"></i> {l s='Closed'}</li>
					<li class="text-warning"><i class="icon-circle"></i> {l s='Pending 1'}</li>
					<li class="text-warning"><i class="icon-circle"></i> {l s='Pending 2'}</li>
				</ul>
			</div>
		</div>
		<div class="col-lg-3">
			<div id="CustomerService" class="panel">
				<div class="panel-heading">
					{l s='Statistics'}
				</div>
				<ul class="list-unstyled">
					{assign var=count value=0}
					{foreach $params as $key => $val}
						{assign var=count value=$count+1}
						<li>{$key} <span class="badge">{$val}</span></li>
					{/foreach}
				</ul>
			</div>
		</div>
	</div>
{/block}
