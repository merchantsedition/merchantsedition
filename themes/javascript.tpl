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

{if isset($js_def) && is_array($js_def) && $js_def|@count}
<script type="text/javascript">
{foreach from=$js_def key=k item=def}
{if !empty($k) && is_string($k)}
{if is_bool($def)}
var {$k} = {$def|var_export:true};
{elseif is_int($def)}
var {$k} = {$def|intval};
{elseif is_float($def)}
var {$k} = {$def|floatval|replace:',':'.'};
{elseif is_string($def)}
var {$k} = '{$def|strval}';
{elseif is_array($def) || is_object($def)}
var {$k} = {$def|json_encode};
{elseif is_null($def)}
var {$k} = null;
{else}
var {$k} = '{$def|@addcslashes:'\''}';
{/if}
{/if}
{/foreach}
</script>
{/if}
{if isset($js_files) && $js_files|@count}
{foreach from=$js_files key=k item=js_uri}
<script type="text/javascript" src="{$js_uri}"></script>
{/foreach}
{/if}
{if isset($js_inline) && $js_inline|@count}
<script type="text/javascript">
{foreach from=$js_inline key=k item=inline}
{$inline}
{/foreach}
</script>
{/if}
