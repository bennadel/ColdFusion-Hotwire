
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			Be generous with people!
		</p>

		<p>
			<a href="/index.cfm?event=tip.add">Add a Tip</a>
		</p>

		<p>
			<a href="/index.cfm?event=tip.view&id=101">Christmas 2022 &rarr; Misti (Postal Carrier)</a>
		</p>

	</cfoutput>
</cfsavecontent>
