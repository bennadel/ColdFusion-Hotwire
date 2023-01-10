
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<cfif errorMessage.len()>
			<p style="background: red ; color: white ;">
				<strong>#encodeForHtml( errorMessage )#</strong>
			</p>
		</cfif>

		<form method="post" action="/index.htm">
			<input type="hidden" name="event" value="tip.delete" />
			<input type="hidden" name="id" value="#encodeForHtmlAttribute( tip.id )#" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				Delete this tip? The associated tippee and event will be unaffected.
			</p>

			<p>
				<button type="submit">
					Delete Tip
				</button>

				<a href="/index.htm?event=tip.view&id=#encodeForUrl( tip.id )#">Cancel</a>
			</p>
		</form>

	</cfoutput>
</cfsavecontent>
