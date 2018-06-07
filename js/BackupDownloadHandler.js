/**
 * @file js/BackupDownloadHandler.js
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2000-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @package plugins.generic.backup
 * @class BackupDownloadHandler
 *
 * @brief Backup download handler.
 */
(function($) {

	/** @type {Object} */
	$.pkp.plugins.backup =
		$.pkp.plugins.backup ||
		{ js: { } };

	/**
	 * @constructor
	 */
	$.pkp.plugins.backup.js.BackupDownloadHandler =
		function() {
		$('ul#downloadLinks a').click(function(e) {
			e.preventDefault();
			var errorMessage = $(this).closest('ul').data('message');
			var url = $(this).attr('href');
			var req = fetch(url, {credentials: "same-origin"})
				.then(function(response) {
					if (!response.ok) { throw Error(response.statusText); }
					return response.blob(); 
				})
				.then(function(blob) {
					window.open(
						URL.createObjectURL(
							new Blob([blob], {
								type: "application/octet-stream"
							})
						),
						"_self"
					)
				})
				.catch(function(err) {
					alert(errorMessage);
				});
		});
	};
}(jQuery));
