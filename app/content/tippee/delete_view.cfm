
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
			<input type="hidden" name="event" value="tippee.delete" />
			<input type="hidden" name="id" value="#encodeForHtmlAttribute( tippee.id )#" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				Deleting the tippee will delete both the tippee and all tips that have
				been recorded for this tippee. Do you with to proceed?<br />

				<label>
					<input
						type="checkbox"
						name="isAgree"
						value="true"
					/>
					I understand and I would like to proceed.
				</label>
			</p>

			<p>
				<button type="submit">
					Delete Tippee
				</button>

				<a href="/index.htm?event=tippee.view&id=#encodeForUrl( tippee.id )#">Cancel</a>
			</p>
		</form>

	</cfoutput>
</cfsavecontent>
