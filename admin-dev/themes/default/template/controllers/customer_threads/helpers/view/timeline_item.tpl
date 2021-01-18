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

<article class="timeline-item{if isset($timeline_item.alt)} alt{/if}">
	<div class="timeline-caption">
		<div class="timeline-panel arrow arrow-{$timeline_item.arrow}">
			<span class="timeline-icon" style="background-color:{$timeline_item.background_color|escape:'html':'UTF-8'};">
				<i class="{$timeline_item.icon}"></i>
			</span>
			<span class="timeline-date"><i class="icon-calendar"></i> {dateFormat date=$timeline_item.date full=0} - <i class="icon-time"></i> {$timeline_item.date|substr:11:5}</span>
			{if isset($timeline_item.id_order)}<a class="badge" href="#">{l s="Order #"}{$timeline_item.id_order|intval}</a><br/>{/if}
			<span>{$timeline_item.content|truncate:220|nl2br}</span>
			{if isset($timeline_item.see_more_link)}
				<br/><br/><a href="{$timeline_item.see_more_link|escape:'html':'UTF-8'}" class="btn btn-default _blank">{l s="See more"}</a>
			{/if}
		</div>
	</div>
</article>
