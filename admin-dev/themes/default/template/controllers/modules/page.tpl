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

{$kpis}
{if $add_permission eq '1'}
  <div id="module_install"
    class="panel"
    style="{if !isset($smarty.post.downloadflag)}display: none;{/if}"
  >
    <form
      class="form-horizontal"
      action="{$currentIndex|escape:'html':'UTF-8'}&amp;token={$token|escape:'html':'UTF-8'}"
      method="post"
      enctype="multipart/form-data"
    >
      <div class="panel-heading">{l s='Add a new module'}</div>
      <div class="alert alert-info">
        {l s='The module must either be a Zip file (.zip) or a tarball file (.tar, .tar.gz, .tgz).'}
      </div>
      <div class="form-group">
        <label for="file" class="control-label col-lg-3">
          {l s='Module archive file'}
        </label>
        <div class="col-lg-9">
          <div class="input-group">
            <span class="input-group-addon"><i class="icon-file"></i></span>
            <input id="file-name" type="text" class="disabled" name="filename" readonly/>
            <span class="input-group-btn">
              <input id="file" type="file" name="file" class="hide"/>
              <button id="file-selectbutton" type="button" name="submitAddAttachments" class="btn btn-default">
                <i class="icon-folder-open"></i> {l s='Choose a file'}
              </button>
            </span>
          </div>
        </div>
      </div>
      <div class="form-group">
        <div class="col-lg-9 col-lg-push-3">
          <button class="btn btn-default" type="submit" name="download">
            <i class="icon-upload-alt"></i>
            {l s='Upload this module'}
          </button>
        </div>
      </div>
    </form>
  </div>
{/if}
{if isset($upgrade_available) && $upgrade_available|@count}
  <div class="alert alert-info">
    {l s='An upgrade is available for some of your modules!'}
    <ul>
      {foreach from=$upgrade_available item='module'}
        <li>
          <a href="{$currentIndex|escape:'html':'UTF-8'}&amp;token={$token|escape:'html':'UTF-8'}&amp;anchor={$module.anchor|escape:'html':'UTF-8'}"><b>{$module.displayName|escape:'html':'UTF-8'}</b></a>
        </li>
      {/foreach}
    </ul>
  </div>
{/if}
<div class="panel">
  <div class="panel-heading">
    <i class="icon-list-ul"></i>
    {l s='Modules list'}
  </div>
  <!--start sidebar module-->
  <div class="row">
    <div class="categoriesTitle col-md-3">
      <div class="list-group">
        <form id="filternameForm" method="post" class="list-group-item form-horizontal">
          <div class="input-group">
            <span class="input-group-addon">
              <i class="icon-search"></i>
            </span>
            <input class="form-control" placeholder="{l s='Search'}" type="text" value="" name="moduleQuicksearch"
                   id="moduleQuicksearch" autocomplete="off"/>
          </div>
        </form>
        <a class="categoryModuleFilterLink list-group-item {if isset($categoryFiltered.favorites)}active{/if}"
           href="{$currentIndex|escape:'html':'UTF-8'}&amp;token={$token|escape:'html':'UTF-8'}&amp;filterCategory=favorites"
           id="filter_favorite">
          {l s='Favorites'} <span id="favorite-count" class="badge pull-right">{$nb_modules_favorites}</span>
        </a>
        <a class="categoryModuleFilterLink list-group-item {if count($categoryFiltered) lte 0}active{/if}"
           href="{$currentIndex|escape:'html':'UTF-8'}&amp;token={$token|escape:'html':'UTF-8'}&amp;unfilterCategory=yes"
           id="filter_all">
          {l s='All'} <span class="badge pull-right">{$nb_modules}</span>
        </a>
        {foreach from=$list_modules_categories item=module_category key=module_category_key}
          <a class="categoryModuleFilterLink list-group-item {if isset($categoryFiltered[$module_category_key])}active{/if}"
             href="{$currentIndex|escape:'html':'UTF-8'}&amp;token={$token|escape:'html':'UTF-8'}&amp;{if isset($categoryFiltered[$module_category_key])}un{/if}filterCategory={$module_category_key}"
             id="filter_{$module_category_key}">
            {$module_category.name} <span class="badge pull-right">{$module_category.nb}</span>
          </a>
        {/foreach}
      </div>
    </div>
    <div id="moduleContainer" class="col-md-9">
      {include file='controllers/modules/list.tpl'}
    </div>
  </div>
</div>
<script type="text/javascript">
  $(document).ready(function () {
    $('#file-selectbutton').click(function (e) {
      $('#file').trigger('click');
    });
    $('#file-name').click(function (e) {
      $('#file').trigger('click');
    });
    $('#file').change(function (e) {
      var val = $(this).val();
      var file = val.split(/[\\/]/);
      $('#file-name').val(file[file.length - 1]);
    });
  });
</script>
