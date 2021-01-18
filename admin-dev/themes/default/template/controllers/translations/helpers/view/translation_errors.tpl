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
  {if $mod_security_warning}
    <div class="alert alert-warning">
      {l s='Apache mod_security is activated on your server. This could result in some Bad Request errors'}
    </div>
  {/if}
  <div class="panel">
    <p>{l s='Expressions to translate:'} <span class="badge">{l s='%d' sprintf=$count}</span></p>
    <p>{l s='Total missing expressions:'} <span class="badge">{l s='%d' sprintf=$missing_translations|array_sum}</p>
  </div>

  <script type="text/javascript">
    $(document).ready(function(){
      $('a.useSpecialSyntax').click(function(){
        var syntax = $(this).find('img').attr('alt');
        $('#BoxUseSpecialSyntax .syntax span').html(syntax+".");
      });
    });
  </script>

  <div id="BoxUseSpecialSyntax">
    <div class="alert alert-warning">
      <p>
        {l s='Some of these expressions use this special syntax: %s.' sprintf='%d'}
        <br />
        {l s='You MUST use this syntax in your translations. Here are a few examples:'}
      </p>
      <ul>
        <li>"{l s='There are [1]%d[/1] products' tags=['<strong>']}": {l s='"%s" will be replaced by a number.' sprintf='%d'}</li>
        <li>"{l s='List of pages in [1]%s[/1]' tags=['<strong>']}": {l s='"%s" will be replaced by a string.' sprintf='%s'}</li>
        <li>"{l s='Feature: [1]%1$s[/1] ([1]%2$d[/1] values)' tags=['<strong>']}": {l s='The numbers enable you to reorder the variables when necessary.'}</li>
      </ul>
    </div>
  </div>

  <form method="post" id="{$table}_form" action="{$url_submit|escape:'html':'UTF-8'}" class="form-horizontal">
    <div class="panel">
      <input type="hidden" name="lang" value="{$lang}" />
      <input type="hidden" name="type" value="{$type}" />
      <input type="hidden" name="theme" value="{$theme}" />

      <table class="table">
        {foreach $errorsArray as $key => $value}
          <tr {if empty($value.trad)}style="background-color:#FBB"{else}{cycle values='class="alt_row",'}{/if}>
            <td width="40%">{$key|stripslashes}</td>
            <td width="40%">
              <input type="text" name="{$key|md5}" value="{$value.trad|regex_replace:'#"#':'&quot;'|stripslashes}"' style="width: 450px{if empty($value.trad)};background:#FBB{/if}">
            </td>
            <td width="18%">
              {if isset($value.use_sprintf) && $value.use_sprintf}
                <a class="useSpecialSyntax" title="{l s='This expression uses a special syntax:'} {$value.use_sprintf}" style="cursor:pointer">
                  <img src="{$smarty.const._PS_IMG_}admin/error.png" alt="{$value.use_sprintf}" />
                </a>
              {/if}
            </td>
          </tr>
        {/foreach}
      </table>
      <div class="panel-footer">
        <a name="submitTranslations{$type|ucfirst}" href="{$cancel_url|escape:'html':'UTF-8'}" class="btn btn-default"><i class="process-icon-cancel"></i> {l s='Cancel'}</a>
        <button type="submit" id="{$table}_form_submit_btn" name="submitTranslations{$type|ucfirst}" class="btn btn-default pull-right"><i class="process-icon-save"></i> {l s='Save'}</button>
        <button type="submit" name="submitTranslations{$type|ucfirst}AndStay" class="btn btn-default pull-right"><i class="process-icon-save"></i> {l s='Save and stay'}</button>
      </div>
    </div>
  </form>
{/block}
