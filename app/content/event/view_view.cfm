
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			TODO: Event detail...
		</p>

		<p>
			<a href="/index.cfm?event=event">Back to list</a>
		</p>

		<p>
			<a href="/index.cfm?event=event.edit&id=101">Edit</a> &mdash;
			<a href="/index.cfm?event=event.duplicate&id=101">Duplicate</a> &mdash;
			<a href="/index.cfm?event=event.delete&id=101">Delete</a>
		</p>

	</cfoutput>
</cfsavecontent>
