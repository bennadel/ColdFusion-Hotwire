
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<cfif errorMessage.len()>
			<p>
				<strong>#encodeForHtml( errorMessage )#</strong>
			</p>
		</cfif>

		<form method="post" action="/index.cfm">
			<input type="hidden" name="event" value="tippee.edit" />
			<input type="hidden" name="id" value="#encodeForHtmlAttribute( tippee.id )#" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				Name:<br />
				<input
					type="text"
					name="name"
					value="#encodeForHtmlAttribute( request.context.name )#"
					size="50"
					maxlength="50"
				/>
			</p>

			<p>
				Occupation (optional):<br />
				<input
					type="text"
					name="occupation"
					value="#encodeForHtmlAttribute( request.context.occupation )#"
					size="50"
					maxlength="50"
				/>
			</p>

			<p>
				Notes (optional):<br />
				<textarea
					name="notes"
					rows="4"
					cols="50"
					maxlength="300"
				>#encodeForHtml( request.context.notes )#</textarea>
			</p>

			<p>
				<button type="submit">
					Update Tippee
				</button>

				<a href="/index.cfm?event=tippee.view&id=#encodeForUrl( tippee.id )#">Cancel</a>
			</p>
		</form>

	</cfoutput>
</cfsavecontent>
