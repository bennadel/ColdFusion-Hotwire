
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			TODO: Delete tip...
		</p>

		<p>
			<a href="/index.cfm?event=tip.view&id=101">Cancel</a>
		</p>

	</cfoutput>
</cfsavecontent>
