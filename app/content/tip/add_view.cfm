
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
			<input type="hidden" name="event" value="tip.add" />
			<input type="hidden" name="submitted" value="true" />

			<p>
				Existing Tippee:<br />
				<select name="tippeeID">
					<option value="0">&mdash;</option>
				</select>
			</p>

			<p>
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
					size="50"
					maxlength="50"
				/>
			</p>

			<p>
				Existing Event:<br />
				<select name="eventID">
					<option value="0">&mdash;</option>
				</select>
			</p>

			<p>
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
					placeholder="100"
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
					Add Tip
				</button>

				<a href="/index.cfm?event=tip">Cancel</a>
			</p>
		</form>

	</cfoutput>
</cfsavecontent>
