
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			The people who are receiving tips.
		</p>

		<p>
			<a href="/index.cfm?event=tippee.add">Add a Tippee</a>
		</p>

		<p>
			<a href="/index.cfm?event=tippee.view&id=101">Misti (Postal Carrier)</a>
		</p>

	</cfoutput>
</cfsavecontent>
