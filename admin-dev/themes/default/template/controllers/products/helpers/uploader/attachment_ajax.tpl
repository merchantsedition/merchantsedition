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

<div class="col-lg-8">
	<input id="{$id|escape:'html':'UTF-8'}" type="file" name="{$name|escape:'html':'UTF-8'}"{if isset($url)} data-url="{$url|escape:'html':'UTF-8'}"{/if} class="hide" />
	<button class="btn btn-default" data-style="expand-right" data-size="s" type="button" id="{$id|escape:'html':'UTF-8'}-add-button">
		<i class="icon-plus-sign"></i> {l s='Add file'}
	</button>
</div>

<script type="text/javascript">
	$( document ).ready(function() {
		var {$id|escape:'html':'UTF-8'}_add_button = Ladda.create( document.querySelector('#{$id|escape:'html':'UTF-8'}-add-button' ));
		var {$id|escape:'html':'UTF-8'}_total_files = 0;
		var success_message = '{l s='Upload successful' js=1}';

		$('#{$id|escape:'html':'UTF-8'}').fileupload({
			dataType: 'json',
			autoUpload: true,
			singleFileUploads: true,
			maxFileSize: {$post_max_size},
			start: function (e) {
				{$id|escape:'html':'UTF-8'}_add_button.start();
			},
			fail: function (e, data) {
				showErrorMessage(data.errorThrown.message);
			},
			done: function (e, data) {
				if (data.result) {
					if (typeof data.result.attachment_file !== 'undefined') {
						if (typeof data.result.attachment_file.error !== 'undefined' && data.result.attachment_file.error.length > 0)
							$.each(data.result.attachment_file.error, function(index, error) {
								showErrorMessage(data.result.attachment_file.name + ' : ' + error);
							});
						else {
							showSuccessMessage(success_message);
							$('#selectAttachment2').append('<option value="'+data.result.attachment_file.id_attachment+'">'+data.result.attachment_file.filename+'</option>');
						}
					}
				}
			},
		}).on('fileuploadalways', function (e, data) {
			{$id|escape:'html':'UTF-8'}_add_button.stop();
		}).on('fileuploadsubmit', function (e, data) {
			var params = new Object();

			$('input[id^="attachment_name_"]').each(function()
			{
				id = $(this).prop("id").replace("attachment_name_", "attachment_name[") + "]";
				params[id] = $(this).val();
			});

			$('textarea[id^="attachment_description_"]').each(function()
			{
				id = $(this).prop("id").replace("attachment_description_", "attachment_description[") + "]";
				params[id] = $(this).val();
			});

			data.formData = params;
		});

		$('#{$id|escape:'html':'UTF-8'}-add-button').on('click', function() {
			{$id|escape:'html':'UTF-8'}_total_files = 0;
			$('#{$id|escape:'html':'UTF-8'}').trigger('click');
		});
	});
</script>
