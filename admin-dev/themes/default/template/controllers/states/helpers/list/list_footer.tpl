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

</table>
</div>
<div class="row">
  <div class="col-lg-6">
    {if $bulk_actions && $has_bulk_actions}
      <div class="btn-group bulk-actions dropup">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
          {l s='Bulk actions'} <span class="caret"></span>
        </button>
        <ul class="dropdown-menu">
          <li>
            <a href="#" onclick="javascript:checkDelBoxes($(this).closest('form').get(0), '{$list_id}Box[]', true);return false;">
              <i class="icon-check-sign"></i>&nbsp;{l s='Select all'}
            </a>
          </li>
          <li>
            <a href="#" onclick="javascript:checkDelBoxes($(this).closest('form').get(0), '{$list_id}Box[]', false);return false;">
              <i class="icon-check-empty"></i>&nbsp;{l s='Unselect all'}
            </a>
          </li>
          <li class="divider"></li>
          {foreach $bulk_actions as $key => $params}
            {if $key !== 'affectzone'}
              <li{if $params.text == 'divider'} class="divider"{/if}>
                {if $params.text != 'divider'}
                  <a href="#" onclick="{if isset($params.confirm)}if (confirm('{$params.confirm}')){/if}sendBulkAction($(this).closest('form').get(0), 'submitBulk{$key}{$table}');">
                    {if isset($params.icon)}<i class="{$params.icon}"></i>{/if}&nbsp;{$params.text}
                  </a>
                {/if}
              </li>
            {/if}
          {/foreach}
        </ul>
      </div>
      {foreach $bulk_actions as $key => $params}
        {if $key === 'affectzone'}
          <div class="form-group bulk-actions">
            <div class="col-lg-6">
              {if $key === 'affectzone'}
                <select id="zone_to_affect" name="zone_to_affect">
                  {$zones = Zone::getZones()}
                  {foreach $zones as $z}
                    <option value="{$z['id_zone']}">{$z['name']}</option>
                  {/foreach}
                </select>
              {/if}
            </div>
            <div class="col-lg-6">
              <input type="submit" class="btn btn-default" name="submitBulk{$key}{$table}" value="{$params.text}" {if isset($params.confirm)}onclick="return confirm('{$params.confirm}');"{/if} />
            </div>
          </div>
        {/if}
      {/foreach}

    {/if}
  </div>
  {if !$simple_header && $list_total > 20}
    <div class="col-lg-4">
      {* Choose number of results per page *}
      <div class="pagination">
        {l s='Display'}
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
          {$selected_pagination}
          <i class="icon-caret-down"></i>
        </button>
        <ul class="dropdown-menu">
          {foreach $pagination AS $value}
            <li>
              <a href="javascript:void(0);" class="pagination-items-page" data-items="{$value|intval}">{$value}</a>
            </li>
          {/foreach}
        </ul>
        / {$list_total} {l s='result(s)'}
        <input type="hidden" id="pagination-items-page" name="{$table}_pagination" value="{$selected_pagination|intval}"/>
      </div>
      <script type="text/javascript">
        $('.pagination-items-page').on('click', function (e) {
          e.preventDefault();
          $('#pagination-items-page').val($(this).data("items")).closest("form").submit();
        });
      </script>
      <ul class="pagination pull-right">
        <li {if $page <= 1}class="disabled"{/if}>
          <a href="javascript:void(0);" class="pagination-link" data-page="1">
            <i class="icon-double-angle-left"></i>
          </a>
        </li>
        <li {if $page <= 1}class="disabled"{/if}>
          <a href="javascript:void(0);" class="pagination-link" data-page="{$page - 1}">
            <i class="icon-angle-left"></i>
          </a>
        </li>
        {assign p 0}
        {while $p++ < $total_pages}
          {if $p < $page-2}
            <li class="disabled">
              <a href="javascript:void(0);">&hellip;</a>
            </li>
            {assign p $page-3}
          {elseif $p > $page+2}
            <li class="disabled">
              <a href="javascript:void(0);">&hellip;</a>
            </li>
            {assign p $total_pages}
          {else}
            <li {if $p == $page}class="active"{/if}>
              <a href="javascript:void(0);" class="pagination-link" data-page="{$p}">{$p}</a>
            </li>
          {/if}
        {/while}
        <li {if $page > $total_pages}class="disabled"{/if}>
          <a href="javascript:void(0);" class="pagination-link" data-page="{$page + 1}">
            <i class="icon-angle-right"></i>
          </a>
        </li>
        <li {if $page > $total_pages}class="disabled"{/if}>
          <a href="javascript:void(0);" class="pagination-link" data-page="{$total_pages}">
            <i class="icon-double-angle-right"></i>
          </a>
        </li>
      </ul>
      <script type="text/javascript">
        $('.pagination-link').on('click', function (e) {
          e.preventDefault();
          $('#submitFilter' + '{$table}').val($(this).data("page")).closest("form").submit();
        });
      </script>
    </div>
  {/if}
</div>
</div>

<input type="hidden" name="token" value="{$token|escape:'html':'UTF-8'}"/>
</form>

<script type="text/javascript">
  $(document).ready(function () {
    {if $bulk_actions|count > 1}
    $('#submitBulk').click(function () {
      if ($('#select_submitBulk option:selected').data('confirm') !== undefined)
        return confirm($('#select_submitBulk option:selected').data('confirm'));
      else
        return true;
    });
    $('#select_submitBulk').change(function () {
      if ($(this).val() == 'affectzone')
        loadZones();
      else if (loaded)
        $('#zone_to_affect').fadeOut('slow');
    });
    {/if}
  });
  var loaded = false;
  function loadZones() {
    if (!loaded) {
      $.ajax({
        type: 'POST',
        url: 'ajax.php',
        data: 'getZones=true&token={$token|escape:'html':'UTF-8'}',
        async: true,
        cache: false,
        dataType: 'json',
        success: function (data) {
          var html = $(data.data);
          html.hide();
          $('#select_submitBulk').after(html);
          html.fadeIn('slow');
        }
      });
      loaded = true;
    }
    else {
      $('#zone_to_affect').fadeIn('slow');
    }
  }
</script>
