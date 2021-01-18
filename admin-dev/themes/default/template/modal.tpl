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

<div class="modal fade" id="{$modal_id}" tabindex="-1">
	<div class="modal-dialog {if isset($modal_class)}{$modal_class}{/if}">
		<div class="modal-content">
			{if isset($modal_title)}
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">{$modal_title}</h4>
			</div>
			{/if}

			{$modal_content}

			{if isset($modal_actions)}
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">{l s='Close'}</button>
				{foreach $modal_actions as $action}
					{if $action.type == 'link'}
						<a href="{$action.href}" class="btn {$action.class}">{$action.label}</a>
					{elseif $action.type == 'button'}
						<button type="button" value="{$action.value}" class="btn {$action.class}">
							{$action.label}
						</button>
					{/if}
				{/foreach}
			</div>
			{/if}
		</div>
	</div>
</div>
