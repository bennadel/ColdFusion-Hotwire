
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			You're so close! Only a few more tips to go!
		</p>

	</cfoutput>
</cfsavecontent>
