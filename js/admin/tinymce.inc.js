/**
 * Copyright (C) 2021 Merchant's Edition GbR
 * Copyright (C) 2017-2019 thirty bees
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
 * @copyright 2017-2019 thirty bees
 * @copyright 2007-2016 PrestaShop SA
 * @license   Open Software License (OSL 3.0)
 * PrestaShop is an internationally registered trademark of PrestaShop SA.
 * thirty bees is an extension to the PrestaShop software by PrestaShop SA.
 */

/* global jQuery, $, window, showSuccessMessage, showErrorMessage, tinyMCE */

function tinySetup(config) {
  if (typeof tinyMCE === 'undefined') {
    setTimeout(function () {
      tinySetup(config);
    }, 100);
    return;
  }

  if (!config) {
    config = {};
  }

  if (typeof config.editor_selector !== 'undefined') {
    config.selector = '.' + config.editor_selector;
  }

  window.default_config = {
    selector: ".rte",
    plugins: "colorpicker link image paste pagebreak table contextmenu filemanager table code media autoresize textcolor anchor directionality",
    browser_spellcheck: true,
    toolbar1: "code,|,bold,italic,underline,strikethrough,|,alignleft,aligncenter,alignright,alignfull,rtl,ltr,formatselect,|,blockquote,colorpicker,pasteword,|,bullist,numlist,|,outdent,indent,|,link,unlink,|,anchor,|,media,image",
    toolbar2: "",
    external_filemanager_path: ad + "/filemanager/",
    filemanager_title: "File manager",
    external_plugins: { "filemanager": ad + "/filemanager/plugin.min.js" },
    language: iso,
    skin: "prestashop",
    statusbar: false,
    relative_urls: false,
    convert_urls: false,
    entity_encoding: "raw",
    extended_valid_elements: "em[class|name|id]",
    valid_children: "+*[*]",
    valid_elements: "*[*]",
    menu: {
      edit: { title: 'Edit', items: 'undo redo | cut copy paste | selectall' },
      insert: { title: 'Insert', items: 'media image link | pagebreak' },
      view: { title: 'View', items: 'visualaid' },
      format: {
        title: 'Format',
        items: 'bold italic underline strikethrough superscript subscript | formats | removeformat'
      },
      table: { title: 'Table', items: 'inserttable tableprops deletetable | cell row column' },
      tools: { title: 'Tools', items: 'code' }
    }
  };

  $.each(window.default_config, function (index, el) {
    if (typeof config[index] === 'undefined') {
      config[index] = el;
    }
  });

  tinyMCE.init(config);
}
