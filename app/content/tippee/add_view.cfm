
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			TODO: Add tippee...
		</p>

		<p>
			<a href="/index.cfm?event=tippee">Cancel</a>
		</p>

	</cfoutput>
</cfsavecontent>
