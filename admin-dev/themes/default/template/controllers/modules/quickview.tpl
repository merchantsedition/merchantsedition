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

<div class="bootstrap">
	<div class="col-lg-2">
		<img src="{$image}" alt="{$displayName}" class="img-thumbnail" />
		{if isset($badges)}
			{foreach $badges as $badge}
				{if is_array($badge)}
					{foreach $badge as $_badge}
						<img src="{$_badge}" alt="" class="clearfix quickview-badge" />
					{/foreach}
				{else}
					<img src="{$badge}" alt="" class="clearfix quickview-badge" />
				{/if}
			{/foreach}
		{/if}
	</div>
	<div class="col-lg-10">
		<h1>{$displayName}</h1>
		<div class="row">
			<div class="col-sm-6">
				{if (int)$nb_rates > 0}
				<span class="rating">
					<span class="star{if $avg_rate == 5} active{/if}"></span>
					<span class="star{if $avg_rate == 4} active{/if}"></span>
					<span class="star{if $avg_rate == 3} active{/if}"></span>
					<span class="star{if $avg_rate == 2} active{/if}"></span>
					<span class="star{if $avg_rate == 1} active{/if}"></span>
				</span>
				<p class="small">{if (int)$nb_rates > 1}{l s="(%s votes)" sprintf=$nb_rates}{else}{l s="(%s vote)" sprintf=$nb_rates}{/if}</p>
			{/if}
			</div>
			<div class="col-sm-6">
				{if (int)$price}
					<div class="quickview-price">
						{displayPrice price=$price currency=$id_currency}
					</div>
				{/if}
			</div>
		</div>
		<hr />
		<h3>{l s="Description"}</h3>
		<p class="text-justify">{$description_full}</p>
		{if isset($additional_description) && trim($additional_description) != ''}
			<hr />
			<h3>{l s="Merchant benefits"}</h3>
			<p class="text-justify">{$additional_description}</p>
		{/if}
		<hr />
		{if $is_addons_partner}
			<a class="btn btn-success btn-lg pull-right" href="{$url}">{l s='Install module'}</a>
		{else}
			<a class="btn btn-success btn-lg pull-right" href="{$url}" onclick="return !window.open(this.href);">{l s='View on thirty bees Addons'}</a>
		{/if}
	</div>
</div>
