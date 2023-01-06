
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
			<input type="hidden" name="event" value="event.add" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				Name:<br />
				<input
					type="text"
					name="name"
					value="#encodeForHtmlAttribute( request.context.name )#"
					size="50"
					maxlength="100"
				/>
			</p>

			<p>
				Date:<br />
				<input
					type="text"
					name="occurredAt"
					value="#encodeForHtmlAttribute( request.context.occurredAt )#"
					placeholder="yyyy-mm-dd"
					size="20"
					maxlength="20"
				/>
			</p>

			<p>
				<button type="submit">
					Add Event
				</button>

				<a href="/index.htm?event=event">Cancel</a>
			</p>
		</form>

	</cfoutput>
</cfsavecontent>
