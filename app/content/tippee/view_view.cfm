
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			TODO: Tippee detail...
		</p>

		<p>
			<a href="/index.cfm?event=tippee">Back to list</a>
		</p>

		<p>
			<a href="/index.cfm?event=tippee.edit&id=101">Edit</a> &mdash;
			<a href="/index.cfm?event=tippee.delete&id=101">Delete</a>
		</p>

	</cfoutput>
</cfsavecontent>
