
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
			<input type="hidden" name="event" value="event.delete" />
			<input type="hidden" name="id" value="#encodeForHtmlAttribute( event.id )#" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				When deleting the event, you can choose to delete all of the tips
				associated with this event; or, you can choose to keep the tips in place
				and simply disassociate them from this event.<br />
				<label>
					<input
						type="radio"
						name="isCascade"
						value="true"
						#view.encodeBooleanAttribute( "checked", request.context.isCascade )#
					/>
					Delete tips
				</label>
				<br />
				<label>
					<input
						type="radio"
						name="isCascade"
						value="false"
						#view.encodeBooleanAttribute( "checked", ! request.context.isCascade )#
					/>
					Disassociate tips
				</label>
			</p>

			<p>
				Do you understand the selection you have made?<br />
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
					Delete Event
				</button>

				<a href="/index.cfm?event=event.view&id=#encodeForUrl( event.id )#">Cancel</a>
			</p>
		</form>

	</cfoutput>
</cfsavecontent>
