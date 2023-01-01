
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			TODO: Add event....
		</p>

		<p>
			<a href="/index.cfm?event=event">Cancel</a>
		</p>

	</cfoutput>
</cfsavecontent>
