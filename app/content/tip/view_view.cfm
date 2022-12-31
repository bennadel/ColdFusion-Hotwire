
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			TODO: Tip detail...
		</p>

		<p>
			<a href="/index.cfm?event=tip">Back to list</a>
		</p>

		<p>
			<a href="/index.cfm?event=tip.edit&id=101">Edit</a> &mdash;
			<a href="/index.cfm?event=tip.delete&id=101">Delete</a>
		</p>

	</cfoutput>
</cfsavecontent>
