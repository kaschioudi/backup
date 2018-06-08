{**
 * plugins/generic/backup/templates/index.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2000-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List of operations this plugin can perform
 *}

<script type="text/javascript">
$('ul#downloadLinks a').click(function(e) {ldelim}
	e.preventDefault();
	var errorMessage = $(this).closest('ul').data('message');
	var url = $(this).attr('href');
	var req = fetch(url, {ldelim}credentials: "same-origin"{rdelim})
		.then(function(response) {ldelim}
			if (!response.ok) {ldelim} throw Error(response.statusText); {rdelim}
			return response.blob(); 
		{rdelim})
		.then(function(blob) {ldelim}
			window.open(
				URL.createObjectURL(
					new Blob([blob], {ldelim}
						type: "application/octet-stream"
					{rdelim})
				),
				"_self"
			)
		{rdelim})
		.catch(function(err) {ldelim}
			alert(errorMessage);
		{rdelim});
{rdelim});
</script>

{fbvFormSection description="plugins.generic.backup.longdescription" class="notice"}{/fbvFormSection}

{assign var=footNoteNum value=1}
<ul id="downloadLinks" data-message="{$errorMessage}">
	<li>
		{if $isDumpConfigured}
			<a href="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="db"}">
		{/if}
			{translate key="plugins.generic.backup.db"}
		{if $isDumpConfigured}
			</a>
		{else}
			<sup>{$footNoteNum}{assign var=dumpFootNote value=$footNoteNum}{assign var=footNoteNum value=$footNoteNum+1}</sup>
		{/if}
	</li>
	<li>
		{if $isTarConfigured}
			<a href="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="files"}">
		{/if}
			{translate key="plugins.generic.backup.files"}
		{if $isTarConfigured}
			</a>
		{else}
			<sup>{$footNoteNum}{assign var=tarFootNote value=$footNoteNum}{assign var=footNoteNum value=$footNoteNum+1}</sup>
		{/if}
	</li>
	<li>
		{if $isTarConfigured}
			<a href="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="code"}">
		{/if}
			{translate key="plugins.generic.backup.code"}
		{if $isTarConfigured}
			</a>
		{else}
			<sup>{$tarFootNote}</sup>
		{/if}
	</li>
</ul>

{if $dumpFootNote}{translate key="plugins.generic.backup.db.config" footNoteNum=$dumpFootNote}{/if}
{if $tarFootNote}{translate key="plugins.generic.backup.tar.config" footNoteNum=$tarFootNote}{/if}
