
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			TODO: Add tip...
		</p>

		<p>
			<a href="/index.cfm?event=tip">Cancel</a>
		</p>

	</cfoutput>
</cfsavecontent>
