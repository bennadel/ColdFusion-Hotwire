
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

		<form method="post" action="/index.htm">
			<input type="hidden" name="event" value="tippee.add" />
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
					Add Tippee
				</button>

				<a href="/index.htm?event=tippee">Cancel</a>
			</p>
		</form>

	</cfoutput>
</cfsavecontent>
