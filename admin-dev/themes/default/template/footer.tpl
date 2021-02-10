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

	</div>
</div>
{if $display_footer}
<div id="footer" class="bootstrap hide">

	<div class="col-sm-3 hidden-xs">
		<a href="http://www.thirtybees.com/" class="_blank">thirty bees&trade;</a>
		-
		<span id="footer-load-time"><i class="icon-time" title="{l s='Load time: '}"></i> {number_format(microtime(true) - $timer_start, 3, '.', '')}s</span>
	</div>

	<div class="col-sm-6">
		<div class="footer-contact">
			<a href="https://thirtybees.com/contact/?utm_source=back-office&amp;utm_medium=footer&amp;utm_campaign=back-office-{$lang_iso|upper}&amp;utm_content=download" class="footer_link _blank">
				<i class="icon-envelope"></i>
				{l s='Contact'}
			</a>
			/&nbsp;
			<a href="https://forum.thirtybees.com/category/10/bug-reports/?utm_source=back-office&amp;utm_medium=footer&amp;utm_campaign=back-office-{$lang_iso|upper}&amp;utm_content=download" class="footer_link _blank">
				<i class="icon-bug"></i>
				{l s='Bug Tracker'}
			</a>
			/&nbsp;
			<a href="https://forum.thirtybees.com/?utm_source=back-office&amp;utm_medium=footer&amp;utm_campaign=back-office-{$lang_iso|upper}&amp;utm_content=download" class="footer_link _blank">
				<i class="icon-comments"></i>
				{l s='Forum'}
			</a>
		</div>
	</div>

	<div class="col-sm-3">
		{hook h="displayBackOfficeFooter"}
	</div>

	<div id="go-top" class="hide"><i class="icon-arrow-up"></i></div>
</div>
{/if}
{if isset($php_errors)}
	{include file="error.tpl"}
{/if}

{if isset($modals)}
<div class="bootstrap">
	{$modals}
</div>
{/if}

</body>
</html>
