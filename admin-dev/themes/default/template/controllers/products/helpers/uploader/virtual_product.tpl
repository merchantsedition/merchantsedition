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

{if isset($files) && $files|count > 0}
  {assign var='show_thumbnail' value=false}
  {foreach $files as $file}
    {if isset($file.image) && $file.type == 'image'}
      {assign var='show_thumbnail' value=true}
    {/if}
  {/foreach}
  {if $show_thumbnail}
    <div class="form-group">
      <div class="col-lg-12" id="{$id|escape:'html':'UTF-8'}-images-thumbnails">
        {foreach $files as $file}
          {if isset($file.image) && $file.type == 'image'}
            <div class="img-thumbnail text-center">
              <p>{$file.image}</p>
              {if isset($file.size)}<p>{l s='File size'} {$file.size}kb</p>{/if}
              {if isset($file.delete_url)}
                <p>
                  <a class="btn btn-default" href="{$file.delete_url}">
                    <i class="icon-trash"></i> {l s='Delete'}
                  </a>
                </p>
              {/if}
            </div>
          {/if}
        {/foreach}
      </div>
    </div>
  {/if}
{/if}
{if isset($max_files) && $files|count >= $max_files}
  <div class="row">
    <div class="alert alert-warning">{l s='You have reached the limit (%s) of files to upload, please remove files to continue uploading' sprintf=$max_files}</div>
  </div>
{else}
  <div class="form-group">
    <div class="col-lg-12">
      {if !ini_get('file_uploads')}
        <div class="alert alert-danger">{l s='File uploads have been turned off. Please ask your webhost to enable file uploads (%s).' sprintf=['<code>file_uploads = on</code>']}</div>
      {else}
        <input id="{$id|escape:'html':'UTF-8'}"
               type="file"
               name="{$name|escape:'html':'UTF-8'}"
               {if isset($multiple) && $multiple} multiple="multiple"{/if}
               class="hide"/>
        <div class="dummyfile input-group">
          <span class="input-group-addon"><i class="icon-file"></i></span>
          <input id="{$id|escape:'html':'UTF-8'}-name" type="text" name="filename" readonly/>
          <span class="input-group-btn">
          <button id="{$id|escape:'html':'UTF-8'}-selectbutton" type="button" name="submitAddAttachments" class="btn btn-default">
            <i class="icon-folder-open"></i> {if isset($multiple) && $multiple}{l s='Add files'}{else}{l s='Add file'}{/if}
          </button>
            {if (!isset($multiple) || !$multiple) && isset($files) && $files|count == 1 && isset($files[0].download_url)}
              <a href="{$files[0].download_url|escape:'html':'UTF-8'}" class="btn btn-default">
              <i class="icon-cloud-download"></i>
                {if isset($size)}{l s='Download current file (%skb)' sprintf=$size}{else}{l s='Download current file'}{/if}
            </a>
            {/if}
        </span>
        </div>
      {/if}
    </div>
  </div>
  <script type="text/javascript">
    {if isset($multiple) && isset($max_files)}
    var {$id|escape:'html':'UTF-8'}_max_files = {$max_files - $files|count};
    {/if}

    $(document).ready(function () {
      $('#{$id|escape:'html':'UTF-8'}-selectbutton').click(function (e) {
        $('#{$id|escape:'html':'UTF-8'}').trigger('click');
      });

      $('#{$id|escape:'html':'UTF-8'}-name').click(function (e) {
        $('#{$id|escape:'html':'UTF-8'}').trigger('click');
      });

      $('#{$id|escape:'html':'UTF-8'}-name').on('dragenter', function (e) {
        e.stopPropagation();
        e.preventDefault();
      });

      $('#{$id|escape:'html':'UTF-8'}-name').on('dragover', function (e) {
        e.stopPropagation();
        e.preventDefault();
      });

      $('#{$id|escape:'html':'UTF-8'}-name').on('drop', function (e) {
        e.preventDefault();
        var files = e.originalEvent.dataTransfer.files;
        $('#{$id|escape:'html':'UTF-8'}')[0].files = files;
        $(this).val(files[0].name);
      });

      $('#{$id|escape:'html':'UTF-8'}').change(function (e) {
        if ($(this)[0].files !== undefined) {
          var files = $(this)[0].files;
          var name = '';

          $.each(files, function (index, value) {
            name += value.name + ', ';
          });

          $('#{$id|escape:'html':'UTF-8'}-name').val(name.slice(0, -2));
          $('#virtual_product_name').val(name.slice(0, -2));
        }
        else // Internet Explorer 9 Compatibility
        {
          var name = $(this).val().split(/[\\/]/);
          $('#{$id|escape:'html':'UTF-8'}-name').val(name[name.length - 1]);
          $('#virtual_product_name').val(name[name.length - 1]);
        }
      });

      if (typeof {$id|escape:'html':'UTF-8'}_max_files !== 'undefined') {
        $('#{$id|escape:'html':'UTF-8'}').closest('form').on('submit', function (e) {
          if ($('#{$id|escape:'html':'UTF-8'}')[0].files.length > {$id|escape:'html':'UTF-8'}_max_files) {
            e.preventDefault();
            alert('{l s='You can upload a maximum of %s files'|sprintf:$max_files}');
          }
        });
      }
    });
  </script>
{/if}
