
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			Events be happening.
		</p>

		<p>
			<a href="/index.cfm?event=event.add">Add an Event</a>
		</p>

		<p>
			<a href="/index.cfm?event=event.view&id=101">Christmas 2022</a>
		</p>

	</cfoutput>
</cfsavecontent>
