
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
			<input type="hidden" name="event" value="tip.edit" />
			<input type="hidden" name="id" value="#encodeForHtmlAttribute( tip.id )#" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				Existing Tippee:<br />
				<select name="tippeeID">
					<option value="0">&mdash;</option>

					<cfloop item="tippee" array="#tippees#">
						<option
							value="#encodeForHtmlAttribute( tippee.id )#"
							#view.encodeBooleanAttribute( "selected", ( tippee.id == request.context.tippeeID ) )#>
							#encodeForHtml( tippee.name )#
							<cfif tippee.occupation.len()>
								- #encodeForHtml( tippee.occupation )#
							</cfif>
						</option>
					</cfloop>
				</select>
			</p>

			<p style="margin-left: 30px ;">
				Or, create a new Tippee:<br />
				<input
					type="text"
					name="tippeeName"
					value="#encodeForHtmlAttribute( request.context.tippeeName )#"
					placeholder="Name..."
					size="50"
					maxlength="50"
				/>
				<input
					type="text"
					name="tippeeOccupation"
					value="#encodeForHtmlAttribute( request.context.tippeeOccupation )#"
					placeholder="Occupation (optional)..."
					size="20"
					maxlength="50"
				/>
			</p>

			<p>
				Existing Event:<br />
				<select name="eventID">
					<option value="0">&mdash;</option>

					<cfloop item="event" array="#events#">
						<option
							value="#encodeForHtmlAttribute( event.id )#"
							#view.encodeBooleanAttribute( "selected", ( event.id == request.context.eventID ) )#>
							#encodeForHtml( event.name )# -
							#dateFormat( event.occurredAt, "mmmm d, yyyy" )#
						</option>
					</cfloop>
				</select>
			</p>

			<p style="margin-left: 30px ;">
				Or, create a new Event:<br />
				<input
					type="text"
					name="eventName"
					value="#encodeForHtmlAttribute( request.context.eventName )#"
					placeholder="Name..."
					size="50"
					maxlength="50"
				/>
				<input
					type="text"
					name="eventOccurredAt"
					value="#encodeForHtmlAttribute( request.context.eventOccurredAt )#"
					placeholder="Date (yyyy-mm-dd)..."
					size="20"
					maxlength="20"
				/>
			</p>

			<p>
				Amount (In Dollars):<br />
				<input
					type="text"
					name="amountInDollars"
					value="#encodeForHtmlAttribute( request.context.amountInDollars )#"
					placeholder="100..."
					size="10"
					maxlength="5"
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
					Update Tip
				</button>

				<a href="/index.htm?event=tip.view&id=#encodeForUrl( tip.id )#">Cancel</a>
			</p>
		</form>

	</cfoutput>
</cfsavecontent>
