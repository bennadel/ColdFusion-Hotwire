
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			All of the tips associated with this event will be automatically created and
			associated with the new, duplicate event.
		</p>

		<cfif errorMessage.len()>
			<p>
				<strong>#encodeForHtml( errorMessage )#</strong>
			</p>
		</cfif>

		<form method="post" action="/index.htm">
			<input type="hidden" name="event" value="event.duplicate" />
			<input type="hidden" name="id" value="#encodeForHtmlAttribute( event.id )#" />
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
					Duplicate Event
				</button>

				<a href="/index.htm?event=event.view&id=#encodeForUrl( event.id )#">Cancel</a>
			</p>
		</form>

	</cfoutput>
</cfsavecontent>
